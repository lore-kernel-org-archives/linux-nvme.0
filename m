From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 3 Oct 2017 18:19:34 +0300
Subject: Bug report: ref tag error while running IO > MDTS on nvme device
In-Reply-To: <20171003142515.GA16678@localhost.localdomain>
References: <25030a78-f59b-a9de-b570-e9e05c9f4411@mellanox.com>
 <20171003142515.GA16678@localhost.localdomain>
Message-ID: <c246b05d-767d-a2a8-bdb3-6f7f5a7bf322@mellanox.com>



On 10/3/2017 5:25 PM, Keith Busch wrote:
> Hi Max,

Hi Keith,

> 
> Is this behavior new, or was this always broken?

Good question.
Haven't tried older kernels (only 4.13.0).

> 
> Since you mention MDTS, I wonder if this device is counting the separate
> metadata as part of the transfer and doing the wrong thing as a result?
> We're only supposed to count the metadata size in consideration of MDTS
> if metadata is interleaved.

mdts is 5 (max_hw_sectors_kb is 128) so I guess it's ok from device 
point of view.
