From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Jun 2019 08:29:14 +0200
Subject: [PATCH] nvmet-rdma: move port tsas initialization to rdma code
In-Reply-To: <20190619230006.15715-1-sagi@grimberg.me>
References: <20190619230006.15715-1-sagi@grimberg.me>
Message-ID: <20190620062914.GD20765@lst.de>

On Wed, Jun 19, 2019@04:00:06PM -0700, Sagi Grimberg wrote:
> Also, look at the device transport capability to send
> the correct trtype (ib/roce/rocev2/iwarp). Note that if
> we are listening on addr_any we still return "not specified"
> trtype and the same goes for referrals.

I very much disagree with sending the type.  That whole concept
has been a horrible layering violation in the spec that we should
not support.
