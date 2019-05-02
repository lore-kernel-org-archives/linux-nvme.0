From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu, 02 May 2019 17:20:31 +0300
Subject: [PATCH v2 08/10] nvme/pci: implement the mdev external queue
 allocation interface
In-Reply-To: <20190502114801.23116-9-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-9-mlevitsk@redhat.com>
Message-ID: <be56bf51cebb7f373c279adf3e9a46e6df5dfe76.camel@redhat.com>

On Thu, 2019-05-02@14:47 +0300, Maxim Levitsky wrote:
> Note that currently the number of hw queues reserved for mdev,
> has to be pre determined on module load.
> 
> (I used to allocate the queues dynamicaly on demand, but
> recent changes to allocate polled/read queues made
> this somewhat difficult, so I dropped this for now)
> 
> Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
> ---
>  drivers/nvme/host/pci.c  | 375 ++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/mdev/host.c |  46 ++---
>  drivers/nvme/mdev/io.c   |  46 +++--
>  drivers/nvme/mdev/mmio.c |   3 -
>  4 files changed, 421 insertions(+), 49 deletions(-)

The changes in drivers/nvme/mdev aren't supposed to be here, this was some code
moving around to reduce the diff in the generic block layer support code,
it supposed to go to the main mdev commit.

Best regards,
	Maxim Levitsky
