From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 08:41:53 +0200
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
In-Reply-To: <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-11-hch@lst.de>
 <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
Message-ID: <20190606064153.GD27033@lst.de>

On Thu, Jun 06, 2019@08:02:07AM +0200, Hannes Reinecke wrote:
> >  	scsi_change_queue_depth(sdev, device_qd);
> >  
> What happened to the NOMERGES queue flag?

Quote from the patch description:

"Also remove the bogus nomerges flag, merges do take the virt_boundary
 into account."
