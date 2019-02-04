From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 4 Feb 2019 09:23:49 +0100
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
 <20190131161108.GA20811@localhost.localdomain>
 <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>
Message-ID: <bcbfb9ea-88ff-d8c7-22ba-8f1df7104930@suse.de>

On 31/01/2019 18:01, Max Gurtovoy wrote:
> 
> On 1/31/2019 6:11 PM, Keith Busch wrote:
>> On Thu, Jan 31, 2019@05:13:30PM +0200, Max Gurtovoy wrote:
>>> +static const char *nvme_trace_admin_get_features(struct trace_seq *p,
>>> +???????????????????????? u8 *cdw10)
>>> +{
>>> +??? const char *ret = trace_seq_buffer_ptr(p);
>>> +??? u8 fid = cdw10[0];
>>> +??? u8 sel = cdw10[1];
> 
> u8 sel = cdw10[1] & 0x7;

Yup

[...]

> Well, I guess that nvme-cli is the only common tool used by the majority
> of the community.
> 
> we can add something like "nvme trace-parse <raw-cmd>".
> 
> but this will open a various places to go wrong (and it will happen for
> sure).
> 
> Let's see what other guys think..

I'm open for both sides, but we're already decoding a bunch of commands
in the kernel and so does the SCSI tracing, so I don't see a compelling
reason to stop it now.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
