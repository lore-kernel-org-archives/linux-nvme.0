From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:31:19 +0200
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170602094536.25775-4-jthumshirn@suse.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de>
Message-ID: <20170605053119.GA19480@lst.de>

What about a little helper like this: ?

static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
		void *id, off_t *off)
{
	struct nvme_ns_identifier_hdr hdr = {
		.nidt	= type,
		.nidl	= len,
	};
	u16 status;

	status = nvmet_copy_to_sgl(req, *off, &hdr, sizeof(hdr));
	if (status)
		return status;
	*off += sizeof(hdr);

	status = nvmet_copy_to_sgl(req, off, id, len);
	if (status)
		return status;
	*off += len;

	return 0;
}
