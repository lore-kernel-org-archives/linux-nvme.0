From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 20 Aug 2015 16:41:49 -0400
Subject: Simplify block integrity registration
In-Reply-To: <20150721120102.GB1654@infradead.org>
References: <20150721120102.GB1654@infradead.org>
Message-ID: <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>


Had a couple of requests this week so here is the latest version of the
patch set that removes the dynamic integrity allocation to ease the
registration headaches for nvme and nvdimm.

Mike, I'd appreciate if you could check the DM bits.

-- 
Martin K. Petersen	Oracle Linux Engineering
