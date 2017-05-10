From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 10:09:45 -0700
Subject: [PATCH] nvme_fc: correct port role bits
In-Reply-To: <8c2c1c9b-3a61-916b-1fb4-8fc0953b6208@suse.de>
References: <20170505231302.31578-1-jsmart2021@gmail.com>
 <8c2c1c9b-3a61-916b-1fb4-8fc0953b6208@suse.de>
Message-ID: <20170510170945.GD15161@infradead.org>

On Mon, May 08, 2017@01:03:21PM +0200, Johannes Thumshirn wrote:
> On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
> > From: James Smart <jsmart2021 at gmail.com>
> > 
> > FC Port roles is a bit mask, not individual values.
> > Correct nvme definitions to unique bits.
> > 
> > Signed-off-by: James Smart <james.smart at broadcom.com>
> > ---
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> Although it really should be merged into scsi/scsi_transport_fc.h some day.

Agreed.  Maybe we just need a fc_common.h header or so.

But for now I've applied the patch to nvme-4.12
