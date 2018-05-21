From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 21 May 2018 08:23:06 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <6ca20e7c-0a0a-6dc4-e2d4-012b63a7ad0d@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
 <20180518212849.GB31490@localhost.localdomain>
 <266ee916-b86a-c499-20ff-98cf716059b5@kernel.dk>
 <20180518214857.GC31490@localhost.localdomain>
 <6ca20e7c-0a0a-6dc4-e2d4-012b63a7ad0d@kernel.dk>
Message-ID: <20180521142305.GD5528@localhost.localdomain>

On Mon, May 21, 2018@08:18:05AM -0600, Jens Axboe wrote:
> Shall we get it pushed? Might also not be a bad idea to do an early
> pull for linux-block as well, with two weeks until the merge window
> opens, for greater exposure.

Sounds good, series pushed to nvme-4.18.
