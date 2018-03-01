From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Mar 2018 01:52:20 +0100
Subject: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus()
 to pci_alloc_irq_vectors
In-Reply-To: <20180206121742.29336-6-ming.lei@redhat.com>
References: <20180206121742.29336-1-ming.lei@redhat.com>
 <20180206121742.29336-6-ming.lei@redhat.com>
Message-ID: <20180301005220.GB29500@lst.de>

Looks fine,

and we should pick this up for 4.16 independent of the rest, which
I might need a little more review time for.

Reviewed-by: Christoph Hellwig <hch at lst.de>
