From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Dec 2018 00:06:52 -0800
Subject: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Message-ID: <20181212080652.GA14877@infradead.org>

scatterlist elements longer than 4GB sound odd.  Please submit it
in a series with your actual user so that we can help figuring out
if it really makes sense or if there is a better way to solve your
problem.

As is this patch will massively increase the memory usage for all users
of struct scatterlist, so you better have a really good reason.
