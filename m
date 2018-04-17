From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Apr 2018 17:24:52 +0200
Subject: [PATCH 1/2] nvmet: reset keep alive timer in controller enable
In-Reply-To: <20180415084741.4235-1-sagi@grimberg.me>
References: <20180415084741.4235-1-sagi@grimberg.me>
Message-ID: <20180417152452.GC25823@lst.de>

On Sun, Apr 15, 2018@11:47:40AM +0300, Sagi Grimberg wrote:
> From: Max Gurtuvoy <maxg at mellanox.com>
> 
> Controllers that are not yet enabled should not really
> enforce keep alive timeout, but we still want to track
> a timeout and cleanup in case a host died before it enabled
> us. Hence, simply reset the keep alive timer when the controller
> is enabled.

Please move a comment like this into the code (and use all 80 chars
you have available in source files :)).

Otherwise this looks good.
