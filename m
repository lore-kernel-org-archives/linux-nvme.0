From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 19 Aug 2015 13:30:56 +0300
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <20150819094003.GB14734@infradead.org>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org>
Message-ID: <55D45AE0.50805@dev.mellanox.co.il>

On 8/19/2015 12:40 PM, Christoph Hellwig wrote:
> On Sun, Jul 19, 2015@06:18:09PM +0300, Sagi Grimberg wrote:
>> I'll centralize the checks. No problem.
>
> Did you get a chance to respin these patches?  It would be
> good to get them in this merge window.
>

Actually I didn't. I started to, but then I noticed that
I was still seeing gaps when using cfq (e.g. non-mq code
path), I assume that this was never tested?

Since I was busy with the iser-target iWARP support with Steve
so I didn't get a chance to get back to it yet...

Sagi.
