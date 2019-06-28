From: hch@infradead.org ('Christoph Hellwig')
Date: Fri, 28 Jun 2019 00:25:18 -0700
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
 <20190521082846.GA11024@infradead.org>
 <20190522102530.GK17019@quack2.suse.cz>
 <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>
Message-ID: <20190628072518.GA25577@infradead.org>

On Wed, Jun 26, 2019@06:17:29PM +0530, kanchan wrote:
> Christoph, 
> May I know if you have thoughts about what Jan mentioned below? 

As said I fundamentally disagree with exposting the streams mess at
the block layer.  I have no problem with setting a hint on the journal,
but I do object to exposting the streams mess even more.
