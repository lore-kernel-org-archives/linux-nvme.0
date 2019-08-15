From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 15 Aug 2019 15:36:02 +0300
Subject: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
In-Reply-To: <20190801234514.7941-9-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-9-logang@deltatee.com>
Message-ID: <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> This patch rejects any new connection to the passthru-ctrl if this
> controller is already connected to a different host. At the time of
> allocating the controller we check if the subsys associated with
> the passthru ctrl is already connected to a host and reject it
> if the hostnqn differs.

This is a big limitation.

Are we plan to enable many front-end ctrl's to connect to the single 
back-end ctrl in the future ?

I guess it can be incremental to this series.
