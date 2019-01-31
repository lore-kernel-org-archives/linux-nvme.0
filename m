From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Jan 2019 09:11:09 -0700
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
Message-ID: <20190131161108.GA20811@localhost.localdomain>

On Thu, Jan 31, 2019@05:13:30PM +0200, Max Gurtovoy wrote:
> +static const char *nvme_trace_admin_get_features(struct trace_seq *p,
> +						 u8 *cdw10)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 fid = cdw10[0];
> +	u8 sel = cdw10[1];
> +	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
> +
> +	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
> +	trace_seq_putc(p, 0);

The 'sel' field is technically 3 bits, so this decoding may have a
forward compatibility problem if the commitee defines the upper bits
to a different field. Of course we'd have to update any trace event if
the spec changes in the future anyway.

So then maybe it would make more sense to *not* decode these things in
the kernel and just print out raw dwords that can be piped to a user
space utility for a more human friendly interpretation. Something like
what blkparse does for block trace events. Does that sound okay, or do
people really prefer having the kernel do this?
