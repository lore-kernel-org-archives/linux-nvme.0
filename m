From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 14 Jul 2015 15:38:16 -0400
Subject: Partitions and end-to-end protection
In-Reply-To: <alpine.LNX.2.00.1507141916210.15930@localhost.lm.intel.com>
 (Keith Busch's message of "Tue, 14 Jul 2015 19:25:53 +0000 (UTC)")
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org>
 <yq1a8uyshso.fsf@sermon.lab.mkp.net>
 <20150714184344.GA29437@infradead.org>
 <yq11tgash12.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1507141916210.15930@localhost.lm.intel.com>
Message-ID: <yq1wpy2r0lz.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> NVMe doesn't provide a way to disable transferring metadata
Keith> per-io.

If you do a READ with PRACT=1 the PI should get stripped at the
controller. That was the intent, anyway.

-- 
Martin K. Petersen	Oracle Linux Engineering
