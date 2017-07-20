From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 20 Jul 2017 11:18:15 +0300
Subject: [PATCH v2 1/2] nvme: add virt boundary per ctrl
In-Reply-To: <20170720002420.26408-2-chaitanya.kulkarni@hgst.com>
References: <20170720002420.26408-1-chaitanya.kulkarni@hgst.com>
 <20170720002420.26408-2-chaitanya.kulkarni@hgst.com>
Message-ID: <d77d86e9-0c75-d592-10e1-a058bfd3ca7e@mellanox.com>



On 7/20/2017 3:24 AM, Chaitanya Kulkarni wrote:
> This patch is reimplementation of the original patch provided by
> Max Gurtovoy <maxg at mellanox.com> :-
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-rdma%2Fmsg48610.html&data=02%7C01%7Cmaxg%40mellanox.com%7C8e2c2130762648af3d4d08d4cf05e0b8%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636361071558824020&sdata=Lga5DwzFYFReOqVHZDV7br0ucuvT0sDmJmnoB5G7VdM%3D&reserved=0
>
> For controllers that can handle arbitrarily sized bios (e.g advanced
> RDMA and PCI ctrls) we can allow the block layer to pass us gaps by
> setting the queue virt_boundary_mask according to each ctrl constraints.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
> ---

hi,
you can add:
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
