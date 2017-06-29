From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jun 2017 10:57:21 -0400
Subject: [PATCH] nvme: Makefile: remove dead build rule
In-Reply-To: <20170629065907.13132-1-vrothberg@suse.com>
References: <20170629065907.13132-1-vrothberg@suse.com>
Message-ID: <20170629145721.GC3110@localhost.localdomain>

On Thu, Jun 29, 2017@08:59:07AM +0200, Valentin Rothberg wrote:
> Remove dead build rule for drivers/nvme/host/scsi.c which has been
> removed by commit ("nvme: Remove SCSI translations").
> 
> Signed-off-by: Valentin Rothberg <vrothberg at suse.com>

Oops, thanks for the fix.

Reviewed-by: Keith Busch <keith.busch at intel.com>
