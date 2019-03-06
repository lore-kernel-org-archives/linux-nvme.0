From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 06 Mar 2019 08:15:21 -0800
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
Message-ID: <1551888921.9796.2.camel@acm.org>

On Wed, 2019-03-06@10:48 +0200, Tal Gilboa wrote:
> net_dim.h lib exposes an implementation of the DIM algorithm for dynamically-tuned interrupt
> moderation for networking interfaces.
> 
> We need the same behavior for any block CQ. The main motivation is two benefit from maximized
> completion rate and reduced interrupt overhead that DIM may provide.

What is a "block CQ"? How does net_dim compare to lib/irq_poll? Which approach
results in the best performance and lowest latency?

Thanks,

Bart.
