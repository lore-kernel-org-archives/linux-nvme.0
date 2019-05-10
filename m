From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 10 May 2019 10:02:49 -0700
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
Message-ID: <20190510170249.GA26907@infradead.org>

I think this fundamentally goes in the wrong direction.  We explicitly
designed the block layer infrastructure around life time hints and
not the not fish not flesh streams interface, which causes all kinds
of problems.

Including the one this model causes on at least some SSDs where you
now statically allocate resources to a stream that is now not globally
available.  All for the little log with very short date lifetime that
any half decent hot/cold partitioning algorithm in the SSD should be
able to detect.
