From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 6 Nov 2017 11:31:22 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
In-Reply-To: <d1bf1913-115c-fb07-2b4e-1d5322872f2b@mellanox.com>
References: <1509804987-656-1-git-send-email-maxg@mellanox.com>
 <99ae0d5e-5ccf-a4f2-4e1c-d6e1f0e10016@grimberg.me>
 <d1bf1913-115c-fb07-2b4e-1d5322872f2b@mellanox.com>
Message-ID: <88037f7c-0c24-c911-b605-9136d3009277@grimberg.me>

> Do you prefer to point to freed memory ? I can resend it if needed.

Setting it to NULL suggest that we somehow rely on it, I'd prefer not
to do it. Personally I don't think we really need the wrapper function
until we actually need to compound operations when removing an rdma
qp...
