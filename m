From: bvanassche@acm.org (Bart Van Assche)
Date: Sun, 14 Jul 2019 08:44:36 -0700
Subject: [PATCH] nvme-vendor: fix c99 declarations in vendor plugins
In-Reply-To: <20190712153457.13877-1-sschricker@suse.de>
References: <20190712153457.13877-1-sschricker@suse.de>
Message-ID: <aa8f0b9d-3e71-ca01-bd55-b54bba94a710@acm.org>

On 7/12/19 8:34 AM, Simon Schricker wrote:
> We can't use c99 declarations with older compilers.

It is very easy to introduce C99 declarations. Should -std=... be added 
to the compiler flags such that no new C99 declarations get introduced?

Thanks,

Bart.
