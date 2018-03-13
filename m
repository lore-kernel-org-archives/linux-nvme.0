From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 13 Mar 2018 22:31:55 +0000
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
Message-ID: <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>

>> It sounds like you have very tight hardware expectations for this to work
>> at this moment. You also don't want to generalize this code for others and
>> address the shortcomings.
>  No, that's the way the community has pushed this work

Hi Sinan

Thanks for all the input. As Logan has pointed out the switch requirement is something that has evolved over time based on input from the community. You are more than welcome to have an opinion on this (and you have made that opinion clear ;-)). Over time the patchset may evolve from its current requirements but right now we are aligned with the feedback from the community.

Cheers

Stephen
 
