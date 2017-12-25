From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Dec 2017 12:11:47 +0200
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
In-Reply-To: <20171221204636.2924-2-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
Message-ID: <8c7c2b8a-7e26-c1a1-4681-8c7721184d39@grimberg.me>


> This is a performance optimization that allows the hardware to work on
> a command in parallel with the kernel's stats and timeout tracking.

Curious to know what does this buy us?
