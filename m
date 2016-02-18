From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 Feb 2016 20:09:18 -0800
Subject: [PATCH-4.5-v3 1/5] NVMe: Add controller removing state
In-Reply-To: <1455734215-20396-2-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160218040918.GA12379@infradead.org>

On Wed, Feb 17, 2016@11:36:51AM -0700, Keith Busch wrote:
> The patch is preparing for reducing the scope of the namespace mutex. It
> adds a removing state the namespace scan work uses to know if it is safe
> to proceed. The scan work is flushed after setting the device state so
> the removal path can safely walk the namespace list without locking it.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine, although the flushing / list access magic could relaly
use a comment describing it in the source code.
