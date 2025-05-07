import { getUserOnboardingStatus } from '@/actions/user'
import { redirect } from 'next/navigation'
import React from 'react'

const IndustryInsigtsPage = async() => {
  const {isOnboarded} = await getUserOnboardingStatus()
  if(!isOnboarded){
    redirect("/onboarding")
  }
  return (
    <div>
      IndustryInsigtsPage
    </div>
  )
}

export default IndustryInsigtsPage
