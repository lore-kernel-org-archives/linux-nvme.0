From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Apr 2017 13:59:26 +0300
Subject: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
In-Reply-To: <1490911959-5146-7-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
Message-ID: <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>


>  u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
>  		size_t len)
>  {
> -	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
> +	bool iomem = req->p2pmem;
> +	size_t ret;
> +
> +	ret = sg_copy_buffer(req->sg, req->sg_cnt, (void *)buf, len, off,
> +			     false, iomem);
> +
> +	if (ret != len)
>  		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
> +
>  	return 0;
>  }

We can never ever get here from an IO command, and that is a good thing
because it would have been broken if we did, regardless of what copy
method we use...

Note that the nvme completion queues are still on the host memory, so
this means we have lost the ordering between data and completions as
they go to different pcie targets.

If at all, this is the place to *emphasize* we must never get here
with p2pmem, and immediately fail if we do.

I'm not sure what will happen with to copy_from_sgl, I guess we
have the same race because the nvme submission queues are also
on the host memory (which is on a different pci target). Maybe
more likely to happen with write-combine enabled?

Anyway I don't think we have a real issue here *currently*, because
we use copy_to_sgl only for admin/fabrics commands emulation and
copy_from_sgl to setup dsm ranges...
