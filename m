From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:42:33 +0200
Subject: [PATCH v1 3/7] nvmet: implement namespace identify descriptor list
In-Reply-To: <d6782789a4c53be2244186588599cc017e3955ea.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <d6782789a4c53be2244186588599cc017e3955ea.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601064233.GC16778@lst.de>

On Wed, May 31, 2017@03:32:13PM +0200, Johannes Thumshirn wrote:
> A NVMe Identify NS command with a CNS value of '3' is expecting a list
> of Namespace Identification Descriptor structures to be returned to
> the host for the namespace requested in the namespace identify
> command.
> 
> This Namespace Identification Descriptor structure consists of the
> type of the namespace identifier, the length of the identifier and the
> actual identifier.
> 
> Valid types are EUI-64, NGUID and UUID which we have saved in our
> nvme_ns structure if they have been configured via configfs. If no
> value has been assigened to one of these we return an "invalid opcode"
> back to the host to maintain backward compatibiliy with older
> implementations without Namespace Identify Descriptor list support.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 63 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h            | 18 ++++++++++++

Can you split all the new structures in nvme.h into a separate patch
at the beginning of the series?

> +	static const int buf_size = SZ_4K;

Please add a NVME_IDENTIFY_DATA_SIZE define to nvme.h (and I'd slighty
prefer to define it to 4096 instead of the odd SZ_4K).  And also replace
all the places where we use a magic 4096 for the identify payload with
it.

> +	nid_list = kzalloc(buf_size, GFP_KERNEL);
> +	if (!nid_list) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_put_ns;
> +	}
> +
> +	p = nid_list;

No need for the dynamic allocation.  Just do a straight nvmet_copy_to_sgl
from the stack for each element.

> +
> +	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
> +		ns_nid = (struct nvme_ns_nid *)p;
> +		ns_nid->nidt = NVME_NIDT_UUID;
> +		ns_nid->nidl = NVME_NIDT_UUID_LEN;
> +		memcpy(&ns_nid->nid, &ns->uuid, sizeof(ns->uuid));
> +		pos += sizeof(struct nvme_ns_nid) + sizeof(ns->uuid);
> +		if (pos > buf_size) {
> +			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +			goto out_free_nid_list;
> +		}
> +		p += pos;
> +	}

E.g. something like

	struct nvme_ns_identifier_hdr nih;

	...

		memset(&nih, 0, sizeof(nih));
		nih.nidt = NVME_NIDT_UUID;
		nih.nidl = NVME_NIDT_UUID_LEN;
		status = nvmet_copy_to_sgl(req, off, &nih, sizeof(nih));
		if (status)
			goto out_put_ns;
		off += sizeof(nih);

		status = nvmet_copy_to_sgl(req, off, &ns->uuid,
				sizeof(ns->uuid));
		if (status)
			goto out_put_ns;
		off += sizeof(ns->uuid);
