From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 6 May 2019 12:42:39 -0700
Subject: [PATCH] blktests: Use old variable check for Bash <4.2
In-Reply-To: <1556908108-16475-1-git-send-email-jonathan.derrick@intel.com>
References: <1556908108-16475-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20190506194239.GB20450@vader>

On Fri, May 03, 2019@12:28:28PM -0600, Jon Derrick wrote:
> Bash 4.2 and above supports -v variable checks, which returns true for
> set or null. Instead use an older bashism that is compatible with bash
> 4.1 and earlier but only returns true if the variable is set non-null.
> This inherently adds a sanity check in case of null variables.

Bart previous sent a patch for supporting bash 4.1, and according to
him, there were some further changes required:

https://github.com/osandov/blktests/pull/42

Either Bart's list of missing features was too big, or this patch isn't
enough to support 4.1. If it's the latter, then this is a no-go, because
Bart's change was too intrusive to be worth the hassle. If it's the
former, then this change isn't quite as bad, but I'm still not excited
about supporting a 10 year old version of Bash.
