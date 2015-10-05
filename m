From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Oct 2015 13:44:26 -0400
Subject: [PATCH 0/5] Modify ida_* users to use ida_simple_*
In-Reply-To: <cover.1443723136.git.lduncan@suse.com>
References: <cover.1443723136.git.lduncan@suse.com>
Message-ID: <20151005174426.GB11164@htj.duckdns.org>

On Thu, Oct 01, 2015@11:59:04AM -0700, Lee Duncan wrote:
> The ida index management routines are used in several
> driver modules to manage allocation and release of
> index values. Reviewing the way in which the
> ida routines were called, together with the small
> number of such clients, led to the belief that
> these users should all be able to share a simple
> built-in lock in the ida module by calling the
> ida_simple_*() functions instead of the non-simple
> versions. This means that ida does all the
> required locking so that clients don't have to
> manage that.

The whole series looks good to me.  Please feel free to add

Reviewed-by: Tejun Heo <tj at kernel.org>

Thanks.

-- 
tejun
