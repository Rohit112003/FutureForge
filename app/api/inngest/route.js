import { serve } from "inngest/next";

import { helloworld } from "@/lib/inngest/function";
// import { generateIndustryInsights } from "@/lib/inngest/function";

export const { GET, POST, PUT } = serve({
  client: inngest,
  functions: [],
});