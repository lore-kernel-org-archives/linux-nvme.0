From: hch@lst.de (Christoph Hellwig)
Date: Fri, 4 Jan 2019 19:13:36 +0100
Subject: [PATCH 1/1] nvme-pci: check that sqid match in nvme cqe
In-Reply-To: <1546349838-5126-1-git-send-email-maxg@mellanox.com>
References: <1546349838-5126-1-git-send-email-maxg@mellanox.com>
Message-ID: <20190104181336.GA25593@lst.de>

On Tue, Jan 01, 2019@03:37:18PM +0200, Max Gurtovoy wrote:
> This patch protects against faulty drives (e.g: a drive might send
> the completion on a wrong msix).

Where/how do you see this issue?
