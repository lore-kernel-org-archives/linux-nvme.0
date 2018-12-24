From: amhetre@nvidia.com (Ashish Mhetre)
Date: Mon, 24 Dec 2018 13:37:00 +0530
Subject: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
In-Reply-To: <20181212080652.GA14877@infradead.org>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181212080652.GA14877@infradead.org>
Message-ID: <c7dcdf51-3ade-90b5-aaf6-214e32aecd62@nvidia.com>

We don't have a real use-case for this. Understanding the consequences, 
we are questioning the patch in downstream itself.
Please ignore this patch for now.

On 12/12/18 1:36 PM, Christoph Hellwig wrote:
> scatterlist elements longer than 4GB sound odd.  Please submit it
> in a series with your actual user so that we can help figuring out
> if it really makes sense or if there is a better way to solve your
> problem.
> 
> As is this patch will massively increase the memory usage for all users
> of struct scatterlist, so you better have a really good reason.
> 
