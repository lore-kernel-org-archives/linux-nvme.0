From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 29 Jan 2015 19:41:43 -0500
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <alpine.LNX.2.00.1501291542270.15481@localhost.lm.intel.com>
 (Keith Busch's message of "Thu, 29 Jan 2015 15:44:41 +0000 (UTC)")
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
 <alpine.LNX.2.00.1501282232380.15481@localhost.lm.intel.com>
 <yq1a912iet4.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501291542270.15481@localhost.lm.intel.com>
Message-ID: <yq1oaphgkvs.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

>> Looks like 594416a72032 inadvertently broke this.

Keith> Good call, reverting that at least addresses my problem.

Yeah, I can't seem to make sense of that commit now that I look at it
again.

Darrick, only the topmost bio should have bio_integrity_process() run on
it. It should never be done to a clone.

My test setup is tied up with a qual cycle right now. I'll take a look
at this once it's done tomorrow morning.

-- 
Martin K. Petersen	Oracle Linux Engineering
