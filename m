From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 Jun 2016 17:16:13 +0200
Subject: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
In-Reply-To: <5761538D.6060303@linux.vnet.ibm.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <57607D0E.1060907@linux.vnet.ibm.com> <20160615101045.GB16425@lst.de>
 <5761538D.6060303@linux.vnet.ibm.com>
Message-ID: <20160616151613.GA13433@lst.de>

>
> ...but now I'll focus on the common/general case! Thanks for the suggestion 
> Christoph. I guess would be even better to have a generic function that 
> retrieves an optimal mask, something like topology_get_optimal_mask(n, 
> *cpumask), in which we get the best distribution of n CPUs among all cores 
> and return such a mask - interesting case is when n < num_online_cpus. So, 
> this function could be used inside your irq_create_affinity_mask() and 
> maybe in other places it is needed.

Yes, we should probably just plug this in where we're using the current
routines.  Block very much optimizes for the cases of either 1 queue
or enough queues for all cpus at the moments.  It would be good to check
what the network drivers currently do.
