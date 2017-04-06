From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Apr 2017 10:38:26 +0200
Subject: [PATCH 4/5] nvme: move the retries count to struct nvme_request
In-Reply-To: <5a5f1f1.8f7d.15b4267e21e.Coremail.liaohengquan1986@163.com>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-5-hch@lst.de>
 <20170405151430.GS20181@localhost.localdomain>
 <5a5f1f1.8f7d.15b4267e21e.Coremail.liaohengquan1986@163.com>
Message-ID: <20170406083826.GA32535@lst.de>

On Thu, Apr 06, 2017@04:35:56PM +0800, ??? wrote:
> Hi, Guys,
>               I want to ask if there is any plan to plant the NVMe driver to Vxworks OS?Thank  you so much.---end quoted text---

The Linux NVMe team has no plans for a Vxworks NVMe driver at the moment.
