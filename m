From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 18:39:06 -0400
Subject: [PATCHv2 1/4] nvme: factor metadata handling out of
 __nvme_submit_user_cmd
In-Reply-To: <d885cc92-38e0-5f61-9b1e-5cd0fdd40d32@mellanox.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-2-git-send-email-keith.busch@intel.com>
 <d885cc92-38e0-5f61-9b1e-5cd0fdd40d32@mellanox.com>
Message-ID: <20170829223906.GF4428@localhost.localdomain>

On Wed, Aug 30, 2017@01:20:11AM +0300, Max Gurtovoy wrote:
> >   	blk_execute_rq(req->q, disk, req, 0);
> >   	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> >   		ret = -EINTR;
> > @@ -779,9 +784,8 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
> >   	if (meta && !ret && !write) {
> >   		if (copy_to_user(meta_buffer, meta, meta_len))
> >   			ret = -EFAULT;
> > +		kfree(meta);
> 
> did we move the kfree(meta) here in porpose ?
> I think we'll leak in the "write" case.

Ah, you're right! That should be freed unconditionally outside the 'if'
(it's okay to send NULL to kfree). I'll resend with the fixup.
 
> In general, I prefer allocating and freeing the meta buffer in the same
> function but maybe it make sense to act otherwise here.

Well, the metadata setup was a long enough section with five indent levels
that having its own function should improve readability.
