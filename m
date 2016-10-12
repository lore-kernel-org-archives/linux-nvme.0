From: axboe@fb.com (Jens Axboe)
Date: Wed, 12 Oct 2016 09:40:16 -0600
Subject: [PATCH] nvme: Stop probing a removed device
In-Reply-To: <20161012154818.GD12429@localhost.localdomain>
References: <1476207118-10113-1-git-send-email-keith.busch@intel.com>
 <01aeea30-b515-6d9d-0676-2fa00743bc32@fb.com>
 <20161012151622.GB12429@localhost.localdomain>
 <14bf2e02-4dfa-7ce4-b93e-8aaf3837074c@fb.com>
 <20161012154818.GD12429@localhost.localdomain>
Message-ID: <f0b0c3ae-0958-0f61-21da-90b7294cd705@fb.com>

On 10/12/2016 09:48 AM, Keith Busch wrote:
> On Wed, Oct 12, 2016@09:26:31AM -0600, Jens Axboe wrote:
>> On 10/12/2016 09:16 AM, Keith Busch wrote:
>>> IO queue deltion fix:
>>>
>>>   https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DOctober_006549.html&d=DQIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=USHj4BTLL7XH6RKDrQcfVaoEtYrs9X7WlWp86a7V7T4&s=g1WSuwsvtlK6IgJlP3yBlW4tiSJXSRgm_rgADvHVYVA&e=
>>
>> Hand applied (last hunk reject).
>>
>>> Double reset fix:
>>>
>>>   https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DOctober_006524.html&d=DQIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=USHj4BTLL7XH6RKDrQcfVaoEtYrs9X7WlWp86a7V7T4&s=Fv5eRNi1aBBJhmPHkNJhteHMxe_yylooeBA5-uJEkQs&e=
>>
>> Applied 1/2 - you mentioned a v2 of 2/2, and it doesn't apply since it
>> actually conflicts with the very patch referenced above.
>
> Sorry, I make this more difficult than it should be, but you have the
> intended result. The "IO queue deletion" link was the final revision of
> 2/2, but sent separately since not related or dependent on 1/2.

I thought so, thanks for confirming.

-- 
Jens Axboe
