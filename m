From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 31 Jan 2019 19:01:10 +0200
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <20190131161108.GA20811@localhost.localdomain>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
 <20190131161108.GA20811@localhost.localdomain>
Message-ID: <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>


On 1/31/2019 6:11 PM, Keith Busch wrote:
> On Thu, Jan 31, 2019@05:13:30PM +0200, Max Gurtovoy wrote:
>> +static const char *nvme_trace_admin_get_features(struct trace_seq *p,
>> +						 u8 *cdw10)
>> +{
>> +	const char *ret = trace_seq_buffer_ptr(p);
>> +	u8 fid = cdw10[0];
>> +	u8 sel = cdw10[1];

u8 sel = cdw10[1] & 0x7;


>> +	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
>> +
>> +	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
>> +	trace_seq_putc(p, 0);
> The 'sel' field is technically 3 bits, so this decoding may have a
> forward compatibility problem if the commitee defines the upper bits
> to a different field. Of course we'd have to update any trace event if
> the spec changes in the future anyway.

see above.


>
> So then maybe it would make more sense to *not* decode these things in
> the kernel and just print out raw dwords that can be piped to a user
> space utility for a more human friendly interpretation. Something like
> what blkparse does for block trace events. Does that sound okay, or do
> people really prefer having the kernel do this?

Well, I guess that nvme-cli is the only common tool used by the majority 
of the community.

we can add something like "nvme trace-parse <raw-cmd>".

but this will open a various places to go wrong (and it will happen for 
sure).

Let's see what other guys think..
