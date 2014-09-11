From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Sep 2014 11:20:10 -0600 (MDT)
Subject: [PATCH] NVMe: Add revalidate_disk callback
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9944EAC55@NTXBOIMBX02.micron.com>
References: <1410391274-30070-1-git-send-email-keith.busch@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9944EAC55@NTXBOIMBX02.micron.com>
Message-ID: <alpine.LRH.2.03.1409111117230.4696@AMR>

On Thu, 11 Sep 2014, Sam Bradshaw (sbradshaw) wrote:
>> + free:
>> +	dma_free_coherent(&dev->pci_dev->dev, 4091, id, dma_addr);
>
> 4096, right?

Oops, you're right. Thanks for the catch.
