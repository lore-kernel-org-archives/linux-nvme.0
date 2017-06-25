From: james.smart@broadcom.com (James Smart)
Date: Sun, 25 Jun 2017 08:48:59 -0700
Subject: Booting from NVMe over Fabrics
In-Reply-To: <20170624071701.GC14580@lst.de>
References: <20170622130600.GK5670@linux-x5ow.site>
 <20170624071701.GC14580@lst.de>
Message-ID: <5d3ef427-45ec-82a1-76d4-059e651b17fd@broadcom.com>

On 6/24/2017 12:17 AM, Christoph Hellwig wrote:
> As long as you don't have weird hardware offloads (which seems rather
> pointless) there is nothing interesting in booting NVMe - yes you'll
> need NVMe-cli, and a working RDMA setup.  But that's not any different
> than SRP or iSER, or NFS over RDMA, so we the distros should do the
> same for NVMe that they do for those technolog?es.
You seem to have left off FC.  FC would like to boot FC-NVME the same as 
it does FC-SCSI/FCP.

The main issue so far is user-level discovery. Swap, kdump, and ensuring 
you have connectivity/can run while low-memory, are severely 
taxed/at-risk by the user-level paradigms.

-- james
