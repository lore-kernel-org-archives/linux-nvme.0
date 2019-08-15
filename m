From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 15 Aug 2019 10:06:56 -0600
Subject: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
In-Reply-To: <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-9-logang@deltatee.com>
 <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
Message-ID: <a6b9db95-a7f0-d1f6-1fa2-8dc13a6aa29e@deltatee.com>



On 2019-08-15 6:36 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> This patch rejects any new connection to the passthru-ctrl if this
>> controller is already connected to a different host. At the time of
>> allocating the controller we check if the subsys associated with
>> the passthru ctrl is already connected to a host and reject it
>> if the hostnqn differs.
> 
> This is a big limitation.
> 
> Are we plan to enable many front-end ctrl's to connect to the single
> back-end ctrl in the future ?

Honestly, I don't know that it's really necessary, but the limitation
was requested by Sagi the first time this patch-set was submitted[1]
citing unspecified user troubles. If there's consensus to remove the
restriction I certainly can.

Logan

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-April/016588.html
