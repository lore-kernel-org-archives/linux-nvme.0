From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 00:13:12 -0700
Subject: [nvme-fabrics]Fabrics over ROCEv2
In-Reply-To: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>
References: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>
Message-ID: <20160624071312.GD4252@infradead.org>

Hi Marta,

we've tested the NVMe over Fabrics code with both Mellanox and Emulex
RoCE cards, although I don't remember if we were using RoCEv2.

But your problem doesn't sound NVMe specific.  Can your first check if a
simple test using ib_send_bw works?
