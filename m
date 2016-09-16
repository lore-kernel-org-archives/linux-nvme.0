From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 16 Sep 2016 16:37:44 -0700
Subject: [PATCH v4 1/3] nvme/scsi: Remove power management support
In-Reply-To: <714df91022b06c6799afb315962769f22b8ab9f4.1474049701.git.luto@kernel.org>
References: <cover.1474049701.git.luto@kernel.org>
 <714df91022b06c6799afb315962769f22b8ab9f4.1474049701.git.luto@kernel.org>
Message-ID: <1474069064.10494.4.camel@linux.intel.com>

On Fri, 2016-09-16@11:16 -0700, Andy Lutomirski wrote:
> As far as I can tell, there is basically nothing correct about this
> code.??It misinterprets npss (off-by-one).??It hardcodes a bunch of
> power states, which is nonsense, because they're all just indices
> into a table that software needs to parse.??It completely ignores
> the distinction between operational and non-operational states.
> And, until 4.8, if all of the above magically succeeded, it would
> dereference a NULL pointer and OOPS.
> 
> Since this code appears to be useless, just delete it.

Acked-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> 
> Signed-off-by: Andy Lutomirski <luto at kernel.org>
> ---
>?
