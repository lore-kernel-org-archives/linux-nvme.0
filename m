From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 16:46:07 -0600
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
Message-ID: <69e5d4a3-9751-c2dd-d17e-10485c8f09bb@kernel.dk>

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

Sounds good, thanks Keith.

-- 
Jens Axboe
