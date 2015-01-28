From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jan 2015 22:17:21 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <yq1iofqimmu.fsf@sermon.lab.mkp.net>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
 <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
 <54C958D1.3010209@ranbarg.com> <yq1iofqimmu.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1501282210070.15481@localhost.lm.intel.com>

On Wed, 28 Jan 2015, Martin K. Petersen wrote:
>>>>>> "Paul" == Paul Grabinar <paul.grabinar at ranbarg.com> writes:
>
> Paul> What happens if you switch on and off meta-data dynamically with
> Paul> /sys/block/<bdev>/integrity/write_generate and
> Paul> /sys/block/<bdev>/integrity/read_verify?
>
> I think the best way to go about dealing with all this is to set PRACT=1
> if no bip is attached to a bio bound for a name space formatted with PI.

That's an option for a subset of formats I eluded to before. It will
have the controller generate/strip if the metadata size 8 bytes with
DPS settings, but ignored otherwise. We still need a buffer if metadata
is not used for PI, or if the metadata size more than 8 bytes.
