From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Oct 2016 18:16:51 -0400
Subject: [PATCH 0/6] Six NVMeOF-related patches
In-Reply-To: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
Message-ID: <20161018221651.GC25479@localhost.localdomain>

On Tue, Oct 18, 2016@01:09:39PM -0700, Bart Van Assche wrote:
> Hello Keith,
> 
> This patch series is what I came up with while I was using the NVMeOF host
> and target drivers to test my pending block layer and dm-mq patches. It
> would be appreciated if you would consider these patches for inclusion in
> the upstream kernel. The individual patches in this series are:

All look good to me. I'm still mainly focused on PCIe, but since these
are cleaning up code and error handling, I feel safe to review these.

Reviewed-by: Keith Busch <keith.busch at intel.com>
