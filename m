From: hch@lst.de (Christoph Hellwig)
Date: Fri, 1 Feb 2019 16:51:20 +0100
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
Message-ID: <20190201155120.GA5180@lst.de>

On Fri, Feb 01, 2019@09:46:15PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao at fujitsu.com>
> 
> Fujitsu A64FX processor has a feature to accelerate data transfer of
> internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> address is set to 1.
> 
> This patch introduces this acceleration feature to the NVMe driver to
> enhance NVMe device performance.

This has absolutely no business in a PCIe driver, sorry.
