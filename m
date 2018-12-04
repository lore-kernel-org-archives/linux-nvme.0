From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:05:49 -0800
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting
 queues
In-Reply-To: <20181202164628.1116-8-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-8-hch@lst.de>
Message-ID: <e4a23703-6b6e-1c9e-a072-6a5c029e891b@grimberg.me>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
