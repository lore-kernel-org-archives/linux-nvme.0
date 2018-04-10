From: mr.nuke.me@gmail.com (Alex G.)
Date: Mon, 9 Apr 2018 19:07:24 -0500
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180409194713.GA6283@localhost.localdomain>
References: <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
 <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>
 <93003ab7-f4a0-7e5d-f107-277df20f5566@gmail.com>
 <20180406180445.GL10098@localhost.localdomain>
 <e1218a86-2183-91c9-5a0a-a1c331b5b5f3@gmail.com>
 <20180406220058.GN10098@localhost.localdomain>
 <64cb047e-aa2b-2693-643a-6dac6eba2487@gmail.com>
 <20180409191109.GP10098@localhost.localdomain>
 <d174522d-60d6-1039-8364-85046db0dba8@gmail.com>
 <20180409194713.GA6283@localhost.localdomain>
Message-ID: <b1678819-0be4-494f-a66f-f3ab9cb6e6e2@gmail.com>

On 04/09/2018 02:47 PM, Keith Busch wrote:
> On Mon, Apr 09, 2018@02:36:30PM -0500, Alex G. wrote:
>> Although I remember a time when I could run these sort of tests without
>> panic(), I don't have a solid base from which I can bisect things.
>> Especially since we've added a few fixes lately that won't be in any base.
>>
>> I'll try a couple of branches, but don't hold your breath.
> 
> This may be a regression.

It is. 4.16-rc7+ (+nsid duplicate and device free patches) does not
crash, or cause kasan to complain. However axboe/linux-block/for-next
exhibits the issue. I'm getting ready to also test for-4.17/block, and
then your AER patches.

> Your panic is triggered through the timeout
> path, which appears to have had recent modifications that are included
> in your kernel. There's at least one issue in this area:
> 
>   https://marc.info/?l=linux-block&m=152325124306821&w=2
> 
> I haven't looked into it enough to know if it's related to this issue,
> though.

Thanks. I'll grab a look tomorrow and see if that fixes the issue.

Alex
