From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 28 Jan 2015 17:08:41 -0500
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <54C958D1.3010209@ranbarg.com> (Paul Grabinar's message of "Wed, 
 28 Jan 2015 21:46:57 +0000")
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
 <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
 <54C958D1.3010209@ranbarg.com>
Message-ID: <yq1iofqimmu.fsf@sermon.lab.mkp.net>

>>>>> "Paul" == Paul Grabinar <paul.grabinar at ranbarg.com> writes:

Paul> What happens if you switch on and off meta-data dynamically with
Paul> /sys/block/<bdev>/integrity/write_generate and
Paul> /sys/block/<bdev>/integrity/read_verify?

I think the best way to go about dealing with all this is to set PRACT=1
if no bip is attached to a bio bound for a name space formatted with PI.

That's essentially how it works in SCSI (albeit for entirely different
reasons -- the DIF nexus is independent of the DIX ditto).

In retrospect I wish we had switched the polarity of PRACT so that you'd
have to explicitly request the PI to be passed to the OS.

-- 
Martin K. Petersen	Oracle Linux Engineering
