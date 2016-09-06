From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Sep 2016 16:09:26 +0300
Subject: [PATCH] nvme: add back dependency on CONFIG_BLOCK
In-Reply-To: <20160906125827.1595094-1-arnd@arndb.de>
References: <20160906125827.1595094-1-arnd@arndb.de>
Message-ID: <d7099c1b-730f-1617-f683-2447bedd3e6d@grimberg.me>


> A recent change removed the dependency on BLK_DEV_NVME, which implies
> the dependency on PCI and BLOCK. We don't need CONFIG_PCI, but without
> CONFIG_BLOCK we get tons of build errors, e.g.

Thanks Arnd, queued for the next round of rc fixes.

With a slight modification to the component in the subject line
(nvme-rdma).
