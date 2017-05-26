From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 May 2017 10:52:25 +0200
Subject: [PATCH 1/2] nvme: Wait at least 6000ms before entering the
 deepest idle state
In-Reply-To: <6760ae9459ba19657f8009a9231b97a71114a1e5.1495663545.git.luto@kernel.org>
References: <cover.1495663545.git.luto@kernel.org>
 <6760ae9459ba19657f8009a9231b97a71114a1e5.1495663545.git.luto@kernel.org>
Message-ID: <20170526085225.GA28728@lst.de>

On Wed, May 24, 2017@03:06:30PM -0700, Andy Lutomirski wrote:
> This should at least make vendors less nervous about Linux's APST
> policy.  I'm not aware of any concrete bugs it would fix (although I
> was hoping it would fix the Samsung/Dell quirk).
> 
> Cc: stable at vger.kernel.org # v4.11

Just following a somewhat odd and arbitray policy from another driver
that doesn't fix anything by itself certainly isn't stable material.

And to be honest I'm not sure what applying it will gain us at all.
