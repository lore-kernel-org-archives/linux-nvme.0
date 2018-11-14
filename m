From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Nov 2018 06:21:35 -0800
Subject: [PATCH v2 4/4] nvme: disable fabrics SQ flow control when asked
 by the user
In-Reply-To: <20181003081323.7504-5-sagi@grimberg.me>
References: <20181003081323.7504-1-sagi@grimberg.me>
 <20181003081323.7504-5-sagi@grimberg.me>
Message-ID: <20181114142135.GC27204@infradead.org>

On Wed, Oct 03, 2018@01:13:22AM -0700, Sagi Grimberg wrote:
> As for now, we don't care about sq_head pointer updates anyway, so
> at least allow the controller to micro-optimize by omiting this update.
> 
> Note that we will probably need to support it when a controller
> that requires this comes along.

Shouldn't we default to disabling control for any controller that
supports it instead of adding an option?
