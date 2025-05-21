
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}


-- Enum types (optional but recommended for consistency)

CREATE TYPE cover_letter_status AS ENUM ('draft', 'completed');
CREATE TYPE demand_level AS ENUM ('High', 'Medium', 'Low');
CREATE TYPE market_outlook AS ENUM ('Positive', 'Neutral', 'Negative');

-- Table: IndustryInsight
CREATE TABLE "IndustryInsight" (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  industry TEXT UNIQUE NOT NULL,
  salaryRanges JSONB[],
  growthRate FLOAT NOT NULL,
  demandLevel demand_level NOT NULL,
  topSkills TEXT[],
  marketOutlook market_outlook NOT NULL,
  keyTrends TEXT[],
  recommendedSkills TEXT[],
  lastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  nextUpdate TIMESTAMP NOT NULL
);

-- Table: User
CREATE TABLE "User" (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clerkUserId TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  imageUrl TEXT,
  industry TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  bio TEXT,
  experience INTEGER,
  skills TEXT[],
  CONSTRAINT fk_industry FOREIGN KEY (industry) REFERENCES "IndustryInsight"(industry) ON DELETE SET NULL
);

-- Table: Assessment
CREATE TABLE "Assessment" (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  userId UUID NOT NULL,
  quizScore FLOAT NOT NULL,
  questions JSONB[],
  category TEXT NOT NULL,
  improvementTip TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_assessment_user FOREIGN KEY (userId) REFERENCES "User"(id) ON DELETE CASCADE
);
CREATE INDEX idx_assessment_user ON "Assessment"(userId);

-- Table: Resume
CREATE TABLE "Resume" (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  userId UUID UNIQUE NOT NULL,
  content TEXT NOT NULL,
  atsScore FLOAT,
  feedback TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_resume_user FOREIGN KEY (userId) REFERENCES "User"(id) ON DELETE CASCADE
);

-- Table: CoverLetter
CREATE TABLE "CoverLetter" (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  userId UUID NOT NULL,
  content TEXT NOT NULL,
  jobDescription TEXT,
  companyName TEXT NOT NULL,
  jobTitle TEXT NOT NULL,
  status cover_letter_status DEFAULT 'draft',
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_coverletter_user FOREIGN KEY (userId) REFERENCES "User"(id) ON DELETE CASCADE
);
CREATE INDEX idx_coverletter_user ON "CoverLetter"(userId);
