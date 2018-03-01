From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Mar 2018 10:17:44 -0700
Subject: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus()
 to pci_alloc_irq_vectors
In-Reply-To: <20180301005220.GB29500@lst.de>
References: <20180206121742.29336-1-ming.lei@redhat.com>
 <20180206121742.29336-6-ming.lei@redhat.com>
 <20180301005220.GB29500@lst.de>
Message-ID: <20180301171744.GE14799@localhost.localdomain>

On Thu, Mar 01, 2018@01:52:20AM +0100, Christoph Hellwig wrote:
> Looks fine,
> 
> and we should pick this up for 4.16 independent of the rest, which
> I might need a little more review time for.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Thanks, queued up for 4.16.
