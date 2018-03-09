From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 8 Mar 2018 19:14:10 -0700
Subject: [GIT PULL] nvme fixes for 4.16-rc
In-Reply-To: <20180308231036.GB14765@localhost.localdomain>
References: <20180308231036.GB14765@localhost.localdomain>
Message-ID: <cb2532e2-cde7-cdcc-6242-e83e78bd9cc2@kernel.dk>

On 3/8/18 4:10 PM, Keith Busch wrote:
> Hi Jens,
> 
> A few late fixes for 4.16:
> 
>  * Reverting sysfs slave device links for native nvme multipathing.
>    The hidden disk attributes broke common user tools.
> 
>  * A fix for a PPC pci error handling regression.
> 
>  * Update pci interrupt count to consider the actual IRQ spread, fixing
>    potentially poor initial queue affinity.
> 
>  * Off-by-one errors in nvme-fc queue sizes
> 
>  * A fabrics discovery fix to be more tolerant with user tools.
> 
> Please pull!
> 
> The following changes since commit 468f098734ab095b72d8af26bcd4bcb2ed31a3be:
> 
>   Merge branch 'for-jens' of git://git.infradead.org/nvme into for-linus (2018-02-28 12:18:58 -0700)
> 
> are available in the Git repository at:
> 
>   http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-4.16-rc5 

Your pull request is a bit malformed, but I pulled it in using:

git://git.infradead.org/nvme nvme-4.16-rc5

-- 
Jens Axboe
