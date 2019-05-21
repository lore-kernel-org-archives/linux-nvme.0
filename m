From: hch@infradead.org ('Christoph Hellwig')
Date: Tue, 21 May 2019 01:28:46 -0700
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <20190521082528.GA17709@quack2.suse.cz>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
Message-ID: <20190521082846.GA11024@infradead.org>

On Tue, May 21, 2019@10:25:28AM +0200, Jan Kara wrote:
> performance benefits for some drives. After all you can just think about it
> like RWH_WRITE_LIFE_JOURNAL type of hint available for the kernel...

Except that it actuallys adds a parallel insfrastructure.  A
RWH_WRITE_LIFE_JOURNAL would be much more palatable, but someone needs
to explain how that is:

 a) different from RWH_WRITE_LIFE_SHORT
 b) would not apply to a log/journal maintained in userspace that works
    exactly the same
