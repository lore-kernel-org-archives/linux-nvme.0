From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 05 Aug 2019 11:38:48 +0900
Subject: [PATCH] nvmet: fix data units read and written counters in
 SMART log
In-Reply-To: <1564970259-12279-1-git-send-email-tomwu@mellanox.com>
References: <1564970259-12279-1-git-send-email-tomwu@mellanox.com>
 <CGME20190805015817epcas5p2617320fe4cae019ab373710395ca43ed@epcms2p2>
Message-ID: <20190805023848epcms2p2de4d04f6606b26740027fe2a7a023759@epcms2p2>

> -----Original Message-----
> From: Linux-nvme <linux-nvme-bounces at lists.infradead.org> On Behalf Of Tom Wu
> Sent: Monday, August 5, 2019 10:58 AM
> To: Linux-nvme <linux-nvme at lists.infradead.org>; keith.busch at intel.com;
> hch at lst.de; sagi at grimberg.me
> Cc: Shlomi Nimrodi <shlomin at mellanox.com>; Max Gurtovoy
> <maxg at mellanox.com>; Tom Wu <tomwu at mellanox.com>; Israel Rukshin
> <israelr at mellanox.com>
> Subject: [PATCH] nvmet: fix data units read and written counters in SMART log
> 
> In nvme spec 1.3 there is a definition for data write/read counters
> from SMART log. (See section 5.14.1.2):
> 	This value is reported in thousands (i.e., a value of 1
> 	corresponds to 1000 units of 512 bytes read) and is rounded up.
> 
> However, in nvme target where value is reported with actual units,
> but not thousands of units as the spec requires.
> 
> Signed-off-by: Tom Wu <tomwu at mellanox.com>
> Reviewed-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
