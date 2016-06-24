From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Fri, 24 Jun 2016 13:02:21 +0200 (CEST)
Subject: [nvme-fabrics]Fabrics over ROCEv2
In-Reply-To: <20160624071312.GD4252@infradead.org>
References: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>
 <20160624071312.GD4252@infradead.org>
Message-ID: <394543770.53385548.1466766141681.JavaMail.zimbra@kalray.eu>

Hello Christoph,
Thanks for the answer. I do indeed have more general problems with
ROCEv2: ib_send_bw works fine for ROCEv1 but not with ROCEv2. I'm
going to follow with the Mellanox persons as it seems to be mlx4 or
configuration-related.

Marta

----- Le 24 Juin 16, ? 9:13, Christoph Hellwig hch at infradead.org a ?crit :

> Hi Marta,
> 
> we've tested the NVMe over Fabrics code with both Mellanox and Emulex
> RoCE cards, although I don't remember if we were using RoCEv2.
> 
> But your problem doesn't sound NVMe specific.  Can your first check if a
> simple test using ib_send_bw works?

-- 
-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
