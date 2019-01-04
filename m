From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 4 Jan 2019 10:09:58 -0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <19ee67dd-c805-f174-94af-bca3aa498677@oracle.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
 <677bfb90-c328-c707-a042-156f17cb426f@acm.org>
 <19ee67dd-c805-f174-94af-bca3aa498677@oracle.com>
Message-ID: <20190104180958.GB4642@infradead.org>

On Mon, Dec 24, 2018@09:10:41AM +0800, Shan Hai wrote:
> The problem occurs when offlining CPUs aggressively on a system with large
> number of cores,
> 
> for instance offlining 368? out of 384 total cores, the failure of hotplug
> is caused by device irq migration
> 
> on cpu hotplugging, the situation becomes worse when there are multiple NVME
> devices are available

NVMe uses managed interrupts, which should never be migrated.  What
exact kernel version do you see this on?
