From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 13:36:22 -0700
Subject: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
In-Reply-To: <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
 <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>
Message-ID: <9331096f-8e5c-d029-e41c-96d5fa8b14fe@broadcom.com>



On 5/31/2018 2:31 AM, Sagi Grimberg wrote:
>
> Question, why isn't tfcp_req embedded in fcpreq? don't they have
> the same lifetime?
>

no they don't.? To properly simulate cable-pulls, etc - the host side 
and controller side effectively have their own "exchange" structure. 
tfcp_req corresponds to the controller side. The lifetimes of the two 
halves can differ.

-- james
