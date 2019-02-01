From: keith.busch@intel.com (Keith Busch)
Date: Fri, 1 Feb 2019 07:54:14 -0700
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
Message-ID: <20190201145414.GA22199@localhost.localdomain>

On Fri, Feb 01, 2019@09:46:15PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao at fujitsu.com>
> 
> Fujitsu A64FX processor has a feature to accelerate data transfer of
> internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> address is set to 1.

Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
