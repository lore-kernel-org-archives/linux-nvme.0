From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 16:56:54 -0700
Subject: [PATCH v2 0/2] nvme_fc: add uevent to allow dynamic connects
In-Reply-To: <20170513190559.25484-1-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
Message-ID: <95e4df93-46d8-55b2-a64f-afbf7f730769@gmail.com>

On 5/13/2017 12:05 PM, James Smart wrote:
> These patches add support for generating a uevent which can be
> caugth and converted to a nvme-cli connect-all request for the
> FC initiator and target ports.
>
> The patches were cut on nvme-4.12 after apply the patches contained in
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010156.html
>
> James Smart (2):
>   nvme_fc: create fc class and transport device
>   nvme_fc: add uevent for auto-connect
>
>  drivers/nvme/host/fc.c         | 102 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/nvme-fc-driver.h |   2 +
>  2 files changed, 100 insertions(+), 4 deletions(-)
>


Any comments on this series ?

-- james
