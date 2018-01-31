From: sbauer@eng.utah.edu (Scotty Bauer)
Date: Wed, 31 Jan 2018 11:43:33 -0700
Subject: [LSF/MM TOPIC] KPTI effect on IO performance
In-Reply-To: <20180131082331.GA25888@ming.t460p>
References: <20180131082331.GA25888@ming.t460p>
Message-ID: <d6729ac299e153de259cb8f8af0c888b@eng.utah.edu>

On 2018-01-31 01:23, Ming Lei wrote:
> Hi All,
> 
> After KPTI is merged, there is extra load introduced to context switch
> between user space and kernel space. It is observed on my laptop that 
> one
> syscall takes extra ~0.15us[1] compared with 'nopti'.
> 
> IO performance is affected too, it is observed that IOPS drops by 32% 
> in
> my test[2] on null_blk compared with 'nopti':
> 
> randread IOPS on latest linus tree:
> -------------------------------------------------
> | randread IOPS     | randread IOPS with 'nopti'|
> ------------------------------------------------
> | 928K              | 1372K                     |
> ------------------------------------------------
> 
> 

Do you know if your CPU has PCID? It would be interesting to see these 
tests on older CPUs or older kernels without PCID support.
