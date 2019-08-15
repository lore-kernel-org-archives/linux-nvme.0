From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Aug 2019 10:03:33 -0700
Subject: [PATCH] nvmet: read device size in identify-ns command handler
In-Reply-To: <20190813093157.21755-1-m.malygin@yadro.com>
References: <20190813093157.21755-1-m.malygin@yadro.com>
Message-ID: <5fdce872-8e34-f34e-6ae8-e67bc2f935ac@grimberg.me>


> Currently device size is cached in ns->size field on namespace enable, so
> any device size change after that can't bee seen by initiator.
> This patch updates ns->size field in identify-ns command handler,
> so initiator can see new device size after ns-rescan.

What would trigger a ns rescan?
