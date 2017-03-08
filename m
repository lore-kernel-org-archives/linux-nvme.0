From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Mar 2017 16:48:15 +0100
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM
 observed during stress test on reset_controller
In-Reply-To: <20170305081206.GI14379@mtr-leonro.local>
References: <1908657724.31179983.1488539944957.JavaMail.zimbra@redhat.com>
 <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <20170305081206.GI14379@mtr-leonro.local>
Message-ID: <20170308154815.GB24437@lst.de>

Why is that system using swiotlb?  mlx4 really doesn't have any
weird addressing limits, does it?
