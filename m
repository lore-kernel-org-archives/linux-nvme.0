From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Jul 2017 13:55:47 +0200
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
In-Reply-To: <ad43c2ae-c3af-351d-7a58-0f2f35e79d30@grimberg.me>
References: <20170629172624.GA17319@localhost.didichuxing.com>
 <20170712072018.GA5739@lst.de>
 <ad43c2ae-c3af-351d-7a58-0f2f35e79d30@grimberg.me>
Message-ID: <20170712115547.GA11085@lst.de>

On Wed, Jul 12, 2017@01:34:14PM +0300, Sagi Grimberg wrote:
> Not sure whats special about register read/write that they
> deserve a wrapper, but its easy enough to get in before
> my patches if I'll see a review on it.

Mostly because it's a little shorter and we're only going to get
more and more of these calls.  In the end I don't feel strongly
and we can just skip the patch for now and reconsider it once
we have more register read/write calls.
