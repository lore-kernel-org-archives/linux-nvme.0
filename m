From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 01:09:20 -0700
Subject: [PATCH 3/3] nvme: Check if drive is locked using ATA Security
In-Reply-To: <20160619230634.17229-4-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160619230634.17229-4-kernel@jbeekman.nl>
Message-ID: <20160624080920.GB17446@infradead.org>

On Sun, Jun 19, 2016@04:06:34PM -0700, Jethro Beekman wrote:
> Signed-off-by: Jethro Beekman <kernel at jbeekman.nl>
> ---
>  drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index da027ed..0164122 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1389,10 +1389,57 @@ int nvme_security_recv(struct nvme_ctrl *dev, u8 protocol, void *buf,
>  	return nvme_submit_sync_cmd(dev->admin_q, &c, buf, len);
>  }
>  
> +#define OACS_SECURITY (1<<0)
> +#define SCSI_SECURITY_PROTOCOL_ATA_SECURITY 0xef
> +#define ATA_SECURITY_LOCKED 0x4

It would be great to have this out in a header or maybe rather
headers.  OACS_SECURITY should go into nvme.h, we probably should have a
new header for the SCSI security protocols (e.g.
include/scsi/scsi_security.h ?), and I'm not sure what to do with 
ATA_SECURITY_LOCKED - maybe just add it to scsi_security.h for now until
we get a more fully blown ata security implementation that even includes
ATA :))

>  static bool nvme_security_is_locked(struct nvme_ctrl *ctrl,
>  		struct nvme_id_ctrl *id)
>  {
> -	return false;
> +	int err;
> +	unsigned int i;
> +	bool found;
> +	u8 protocols[256+8]; /* 8 byte hdr + max number of possible protocols */

Please define a constant for the length in the new scsi_security.h
header.

> +	/* find ata security protocol */
> +	n = be16_to_cpup((__be16 *)(protocols+6));

Just use get_unaligned_be16 that operates directly on the char
array, similar to how we do in lots of places in the SCSI stack.

> +	for (i = 0; i <= n; i++) {
> +		if (protocols[8+i] == SCSI_SECURITY_PROTOCOL_ATA_SECURITY) {
> +			found = true;
> +			break;
> +		}
> +	}

I wonder if it might be a good idea to change the structure here a bit
to allow for future other protocols and have each protocol in a helper,
e.g. do something like

	for (i = 0; i <= n; i++) {
		switch (protocols[8 + i]) {
		case SCSI_SECURITY_PROTOCOL_ATA_SECURITY:
			locked |= nvme_security_ata_is_locked()
			break;
		default:
			break;
	}

> +	return ata_security[1] == 0xe && (ata_security[9]&ATA_SECURITY_LOCKED);

Can we have a sumbolic name for the 0xe?  Also please always add spaces
around your operators.

But after all this nitpicking the general idea looks fine, thanks a lot
for the patch!
