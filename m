From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jan 2015 00:09:44 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <yq1egqeilpi.fsf@sermon.lab.mkp.net>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
 <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
 <54C958D1.3010209@ranbarg.com> <yq1iofqimmu.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501282210070.15481@localhost.lm.intel.com>
 <yq1egqeilpi.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1501282232380.15481@localhost.lm.intel.com>

On Wed, 28 Jan 2015, Martin K. Petersen wrote:
>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
> Keith> That's an option for a subset of formats I eluded to before. It
> Keith> will have the controller generate/strip if the metadata size 8
> Keith> bytes with DPS settings, but ignored otherwise. We still need a
> Keith> buffer if metadata is not used for PI, or if the metadata size
> Keith> more than 8 bytes.
>
> I agree it's a deficiency in the NVMe spec that there are no explicit
> handling flags for non-PI metadata in split mode.

Yeah, it is pretty bad. Pressing forward though, I'm working on something
that might be suitable, but hitting another problem using integrity
extensions with blk-mq.

Jens,
Integrity verify is broken in here. blk_mq_end_request() calls
blk_update_request(), which moves the bio iterator to the end.
When we get to bio_integrity_process(), there's nothing for it to do,
so verification is skipped.

Should I look into this, or do you have a good idea how to fix that?
