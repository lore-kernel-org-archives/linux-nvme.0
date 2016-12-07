From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Dec 2016 12:40:18 -0500
Subject: [PATCH] nvme/scsi: Remove START STOP emulation
In-Reply-To: <1a075417a8c929924316bb5f9d93370c485c9d0e.1481048041.git.luto@kernel.org>
References: <1a075417a8c929924316bb5f9d93370c485c9d0e.1481048041.git.luto@kernel.org>
Message-ID: <20161207174018.GC29574@localhost.localdomain>

On Tue, Dec 06, 2016@10:14:35AM -0800, Andy Lutomirski wrote:
> Now that the broken power state control is gone, it appears to serve
> no purpose.  Just delete it.  NVME devices don't have a concept of
> started vs stopped anyway.
> 
> Signed-off-by: Andy Lutomirski <luto at kernel.org>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
