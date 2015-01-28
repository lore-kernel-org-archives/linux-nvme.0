From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Wed, 28 Jan 2015 21:46:57 +0000
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
 <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
Message-ID: <54C958D1.3010209@ranbarg.com>

On 28/01/15 21:16, Keith Busch wrote:
> I was trying something similar to SCSI, and I think Christoph may
> approve. Instead of all the logic deciding which namespace to attach
> and which to bail, attach all namespaces from NSID 1 to the max, then:
>
>     set_capacity(ns->disk, 0);
>
> Wait to initialize the format in nvme_revalidate_disk. If it's a usable
> format, set capacity and sector accordingly, and leave capacity at 0 if
> not. For metadata formats, leave the capacity at 0 until block integrity
> extensions can be registered, then rescan.

What happens if you switch on and off meta-data dynamically with
/sys/block/<bdev>/integrity/write_generate and
/sys/block/<bdev>/integrity/read_verify?
