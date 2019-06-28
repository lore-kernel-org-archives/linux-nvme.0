From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Jun 2019 09:02:43 +0200
Subject: [PATCH v4 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <20190627143215.27443-3-bvanassche@acm.org>
References: <20190627143215.27443-1-bvanassche@acm.org>
 <20190627143215.27443-3-bvanassche@acm.org>
Message-ID: <20190628070243.GB28268@lst.de>

On Thu, Jun 27, 2019@07:32:14AM -0700, Bart Van Assche wrote:
> +/* Convert a 32-bit number to a 16-bit 0's based number */
> +static __le16 to0based(u32 a)
> +{
> +	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> +}

Maybe lift this to drivers/nvme/target/nvmet.h as an inline as it
might be generally useful for more thing in the future?

> +	/*
> +	 * For NVMe 1.4 and later, bit 4 indicates that the fields NPWG,

I'd drop the NVMe 1.4 as it is a bit pointless.  Also in NVMe you
can generally implement the TPs on older compliance levels (which is in
fact what we do here anyway).

> +void nvmet_file_set_limits(struct file *file, struct nvme_id_ns *id)
> +{
> +	/*
> +	 * Since the file backend uses buffered I/O and since the NVMe spec
> +	 * does not allow to report that atomic commands are not supported by
> +	 * a namespace, do not set any of the namespace specific atomic
> +	 * properties. This will cause the initiator to rely on the atomic
> +	 * properties reported by the controller. To do: discuss whether or
> +	 * not the file backend should use direct I/O instead of buffered I/O.
> +	 */
> +}

This function doesn't seem overly helpful to me.  Can we just skip
that whole function and the comment?
