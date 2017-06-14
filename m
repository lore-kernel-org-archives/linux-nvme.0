From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 17:01:38 +0200
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170614150025.GD26073@localhost.localdomain>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain>
Message-ID: <20170614150138.GA9428@lst.de>

On Wed, Jun 14, 2017@11:00:25AM -0400, Keith Busch wrote:
> On Wed, Jun 14, 2017@08:35:35AM +0200, Christoph Hellwig wrote:
> > TEST UNIT READY wa broken for a year and a half, and FORMAT UNIT and
> > WRITE BUFFER for two years.  Instead of fixing them up remove them - no
> > one should be sending SCSI commands to non-scsi devices anyway.
> 
> This is a step in the right direction, but I don't think it goes far
> enough. Can we remove the whole thing now?

I'd love to.  The only real stumbling block was that some version of
SLES used it for persistent devices names.  So I'd like to sync with
Hannes and Johannes to make sure they've fixed this up and upstream
kernels without the scsi translation will work just fine on SLES.
