From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 23:40:57 +0100
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <ef34b468-8a34-1f6f-b782-2840f8318fcf@grimberg.me>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-5-git-send-email-israelr@mellanox.com>
 <6279e907-06df-34dc-ab63-9c4b9ed94f6b@grimberg.me>
 <ca29c79a-0737-4e90-f2c4-d22d0f054547@mellanox.com>
 <ef34b468-8a34-1f6f-b782-2840f8318fcf@grimberg.me>
Message-ID: <20171204224057.GD19672@lst.de>

> The point is that ->delete_ctrl() is not designed to be safe for
> calling it multiple times (although it might be the case for rdma) and
> the code assumes that (which is wrong).
>
> You need to call it conditionally. See what is done in
> nvmet_ctrl_fatal_error()

Yes.  In fact he should probably just call nvmet_ctrl_fatal_error.
