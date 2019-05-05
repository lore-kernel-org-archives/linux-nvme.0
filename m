From: minwoo.im@samsung.com (Minwoo Im)
Date: Sun, 05 May 2019 13:18:48 +0900
Subject: [PATCH 1/2] nvme/pci: init shadow doorbell after each reset
In-Reply-To: <20190502113134.20835-2-mlevitsk@redhat.com>
References: <20190502113134.20835-2-mlevitsk@redhat.com>
 <20190502113134.20835-1-mlevitsk@redhat.com>
 <CGME20190502113150epcas4p2a4a2a783b46411ed0895978811545c73@epcms2p3>
Message-ID: <20190505041848epcms2p3de08067d150ff7dfb78a80fe4fea5f4d@epcms2p3>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Maxim Levitsky
> Sent: Thursday, May 02, 2019 8:32 PM
> To: linux-nvme at lists.infradead.org
> Subject: [PATCH 1/2] nvme/pci: init shadow doorbell after each reset
> 
> The spec states
> "The settings are not retained across a Controller Level Reset"
> Therefore the driver must enable the shadow doorbell,
> after each reset.
> 
> This was caught while testing the nvme driver over
> upcoming nvme-mdev device
> 
> Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
