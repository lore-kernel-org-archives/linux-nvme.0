From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 21 May 2018 08:18:05 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <20180518214857.GC31490@localhost.localdomain>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
 <20180518212849.GB31490@localhost.localdomain>
 <266ee916-b86a-c499-20ff-98cf716059b5@kernel.dk>
 <20180518214857.GC31490@localhost.localdomain>
Message-ID: <6ca20e7c-0a0a-6dc4-e2d4-012b63a7ad0d@kernel.dk>

On 5/18/18 3:48 PM, Keith Busch wrote:
> On Fri, May 18, 2018@03:31:47PM -0600, Jens Axboe wrote:
>> Alright, folded into that patch. This impacts the two patches after
>> this one too, updated versions all attached. Or find them here:
>>
>> http://git.kernel.dk/cgit/linux-block/log/?h=nvme-4.18
> 
> Cool, everything looks in order here. I've staged in my local repo and
> ready to push, but playing it safe this time for the weekend to see if
> Christoph or anyone else has concerns.

Shall we get it pushed? Might also not be a bad idea to do an early
pull for linux-block as well, with two weeks until the merge window
opens, for greater exposure.

-- 
Jens Axboe
