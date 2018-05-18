From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 15:28:50 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
Message-ID: <20180518212849.GB31490@localhost.localdomain>

On Fri, May 18, 2018@03:22:20PM -0600, Jens Axboe wrote:
> Totally untested, does this work?

Looks like that did the trick. Previously it triggered within 1 or 2
iterations. Haven't seen in about a dozen so far.
