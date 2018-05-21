From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 21 May 2018 08:43:04 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <20180521144000.GF5528@localhost.localdomain>
References: <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
 <20180518212849.GB31490@localhost.localdomain>
 <266ee916-b86a-c499-20ff-98cf716059b5@kernel.dk>
 <20180518214857.GC31490@localhost.localdomain>
 <6ca20e7c-0a0a-6dc4-e2d4-012b63a7ad0d@kernel.dk>
 <20180521142305.GD5528@localhost.localdomain>
 <eb85e457-7f90-fce4-9d1b-bd3471f6b396@kernel.dk>
 <20180521144000.GF5528@localhost.localdomain>
Message-ID: <20180521144304.GG5528@localhost.localdomain>

(resending; experiencing some growing pains after switching to a new
email address)

On Mon, May 21, 2018@08:40:00AM -0600, Keith Busch wrote:
> > Fixes: 5cb525c8315f ("nvme-pci: handle completions outside of the queue lock")
> > Reported-by: Keith Busch <keith.busch at intel.com>
> > Signed-off-by: Jens Axboe <axboe at kernel.dk>
 
Reviewed-by: Keith Busch <keith.busch at intel.com>
Tested-by: Keith Busch <keith.busch at intel.com>
