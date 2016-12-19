From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Dec 2016 16:34:15 -0500
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161219213415.GA10634@localhost.localdomain>

On Mon, Dec 19, 2016@12:35:46PM -0700, Scott Bauer wrote:
> This patch implements the necessary logic to bring an Opal
> enabled drive out of a factory-enabled into a working
> Opal state.
> 
> This patch set also enables logic to save a password to
> be replayed during a resume from suspend.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
> ---
>  lib/Makefile            |    2 +-
>  lib/sed-opal.c          | 2376 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/sed-opal_internal.h |  601 ++++++++++++
>  lib/sed.c               |  197 ++++
>  4 files changed, 3175 insertions(+), 1 deletion(-)
>  create mode 100644 lib/sed-opal.c
>  create mode 100644 lib/sed-opal_internal.h
>  create mode 100644 lib/sed.c
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index 50144a3..acb5d82 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -36,7 +36,7 @@ obj-y += bcd.o div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o \
>  	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
>  	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>  	 percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
> -	 once.o
> +	 once.o sed.o sed-opal.o

This seems like an optional library that some environments may wish to
opt-out of building into the kernel. Any reason not to add an entry into
the Kconfig to turn this on/off?
