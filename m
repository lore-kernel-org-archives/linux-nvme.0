From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:49:35 -0800
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <20160212152447.GA24020@localhost.localdomain>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <20160211222848.GA19595@localhost.localdomain>
 <56BD0D4A.60003@fb.com> <20160212083508.GA18432@infradead.org>
 <20160212152447.GA24020@localhost.localdomain>
Message-ID: <20160213094935.GC15318@infradead.org>

On Fri, Feb 12, 2016@03:24:48PM +0000, Keith Busch wrote:
> Fair enough. I know you're busy in many other areas as well, so I
> appreciate the time you've provided.

Sorry for the delay - I planned to get to it thursday afternoon, but
the common cold nocked me out unexpectedly just around that time and
it took a day to recover me into a state where I could carefully
review complicated changes.

I'm actually much happier now with the remaining patches than I initially
thought - my main issue is the namespace removal work item which should
not be nessecary if we apply locking good practices by reducing the
namespace_mutex scope.
