From: axboe@fb.com (Jens Axboe)
Date: Wed, 12 Oct 2016 09:26:31 -0600
Subject: [PATCH] nvme: Stop probing a removed device
In-Reply-To: <20161012151622.GB12429@localhost.localdomain>
References: <1476207118-10113-1-git-send-email-keith.busch@intel.com>
 <01aeea30-b515-6d9d-0676-2fa00743bc32@fb.com>
 <20161012151622.GB12429@localhost.localdomain>
Message-ID: <14bf2e02-4dfa-7ce4-b93e-8aaf3837074c@fb.com>

On 10/12/2016 09:16 AM, Keith Busch wrote:
> On Wed, Oct 12, 2016@08:40:57AM -0600, Jens Axboe wrote:
>> On 10/11/2016 11:31 AM, Keith Busch wrote:
>>> There is no reason the nvme controller can ever return all 1's from
>>> reading the CSTS register. This patch returns an error if we observe
>>> that status. Without this, we may incorrectly proceed with controller
>>> initialization and unnecessarilly rely on error handling to clean this.
>>
>> Applied for this series.
>>
>> Due to being away for a bit, I'm currently a bit behind on patches. I'll
>> be going over those today. But if you, or anyone else, have things
>> pending that I haven't picked up yet, do send me a ping.
>
> Thanks! From me, I have two small patches I think are good to go, with
> reviews from Christoph and others:
>
> IO queue deltion fix:
>
>   https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DOctober_006549.html&d=DQIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=USHj4BTLL7XH6RKDrQcfVaoEtYrs9X7WlWp86a7V7T4&s=g1WSuwsvtlK6IgJlP3yBlW4tiSJXSRgm_rgADvHVYVA&e=

Hand applied (last hunk reject).

> Double reset fix:
>
>   https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DOctober_006524.html&d=DQIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=USHj4BTLL7XH6RKDrQcfVaoEtYrs9X7WlWp86a7V7T4&s=Fv5eRNi1aBBJhmPHkNJhteHMxe_yylooeBA5-uJEkQs&e=

Applied 1/2 - you mentioned a v2 of 2/2, and it doesn't apply since it
actually conflicts with the very patch referenced above.

-- 
Jens Axboe
