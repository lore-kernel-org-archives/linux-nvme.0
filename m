From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Jun 2017 11:00:25 -0400
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170614063537.1044-1-hch@lst.de>
References: <20170614063537.1044-1-hch@lst.de>
Message-ID: <20170614150025.GD26073@localhost.localdomain>

On Wed, Jun 14, 2017@08:35:35AM +0200, Christoph Hellwig wrote:
> TEST UNIT READY wa broken for a year and a half, and FORMAT UNIT and
> WRITE BUFFER for two years.  Instead of fixing them up remove them - no
> one should be sending SCSI commands to non-scsi devices anyway.

This is a step in the right direction, but I don't think it goes far
enough. Can we remove the whole thing now?
