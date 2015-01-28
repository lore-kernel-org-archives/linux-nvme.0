From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Wed, 28 Jan 2015 20:50:24 +0000
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
Message-ID: <54C94B90.20805@ranbarg.com>

On 28/01/15 15:11, Keith Busch wrote:
>
> Thanks for the info. NVMe doesn't appear to allow disabling metadata
> per-io except for a subset of formats. If that's correct, this driver
> would have to provide a valid protection buffer for all IO. Checking
> with committee comrades for clarification.
>

It is indeed a shame that they didn't define a null meta-data pointer as
meaning there is no meta-data. Maybe 1.3?

I got around this as follows.

Limit the maximum transfer so that all the meta-data fits into a single
page. As a side note, the protection information from the kernel needs
to be set to a maximum of one page anyway, as there is only a single PRP
entry for the meta-data and I don't think PRP lists are allowed here.

Allocate two 1 page DMA buffers per device, one will be used for reads
and one for writes.
Fill the write buffer with 0xFF, which means no protection information
is available.
When a read occurs and there is no kernel supplied protection
information, set the meta-data pointer to the read buffer.
When a write occurs and there is no kernel supplied protection
information, set the meta-data pointer to the write buffer. This will
write all the meta-data as 0xFF.
