From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 6 Jun 2017 09:17:02 +0200
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170605053119.GA19480@lst.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de> <20170605053119.GA19480@lst.de>
Message-ID: <8b65ecd4-280a-e1a0-266d-c263f5eaba00@suse.de>

On 06/05/2017 07:31 AM, Christoph Hellwig wrote:
> What about a little helper like this: ?
> 
> static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> 		void *id, off_t *off)
> {
> 	struct nvme_ns_identifier_hdr hdr = {
> 		.nidt	= type,
> 		.nidl	= len,
> 	};
> 	u16 status;
> 
> 	status = nvmet_copy_to_sgl(req, *off, &hdr, sizeof(hdr));
> 	if (status)
> 		return status;
> 	*off += sizeof(hdr);
> 
> 	status = nvmet_copy_to_sgl(req, off, id, len);
> 	if (status)
> 		return status;
> 	*off += len;
> 
> 	return 0;
> }
> 

Yep sounds good. Sorry I didn't see this for the v4 submission, I'll
include in (the hopefully final) v5.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
