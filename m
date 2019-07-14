From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jul 2019 20:36:37 +0900
Subject: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to
 read_queues
In-Reply-To: <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <20190714113637.GE2993@minwoo-desktop>


Hi All,

Could you guys please give some advices for this patch?  I have been
confused for why we need to use write_queues even we have HCTX_TYPE_READ
instead of HCTX_TYPE_WRITE in block layer.

Thanks,
