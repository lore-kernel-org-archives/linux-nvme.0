From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Dec 2016 00:04:19 -0800
Subject: [PATCH] nvme-cli: fabrics: remove libudev dependency
In-Reply-To: <1481846751-2896-1-git-send-email-keith.busch@intel.com>
References: <1481846751-2896-1-git-send-email-keith.busch@intel.com>
Message-ID: <20161216080419.GA22912@infradead.org>

On Thu, Dec 15, 2016@07:05:51PM -0500, Keith Busch wrote:
> I am getting a lot of complaints about portability of the nvme-cli
> regarding the libudev dependency. This patch removes the dependency from
> the fabrics disconnect command when using the target nqn method. Tested
> on nvme loop target.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> I hadn't tried any of the nvme fabrics or targets before today, and just
> want to say that using the nvme loop device was incredibly pleasent to
> test with nvmetcli.
> 
> Since I'm not involved with the fabrics work, I wanted to send this out
> before pushing. It's a pretty straight foward conversion to get rid of
> the libudev dependency, and I suspect testing on the loop is probably
> good enough, but don't want to break anyone either.
> 
>  Makefile  |   7 ----
>  fabrics.c | 116 +++++++++++++++++++++++++-------------------------------------
>  2 files changed, 46 insertions(+), 77 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 33c7190..13da0b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -6,7 +6,6 @@ DESTDIR =
>  PREFIX ?= /usr/local
>  SYSCONFDIR = /etc
>  SBINDIR = $(PREFIX)/sbin
> -LIBUDEV := $(shell ld -o /dev/null -ludev >/dev/null 2>&1; echo $$?)
>  LIB_DEPENDS =
>  
>  RPMBUILD = rpmbuild
> @@ -15,12 +14,6 @@ RM = rm -f
>  
>  AUTHOR=Keith Busch <keith.busch at intel.com>
>  
> -ifeq ($(LIBUDEV),0)
> -	override LDFLAGS += -ludev
> -	override CFLAGS  += -DLIBUDEV_EXISTS
> -	override LIB_DEPENDS += udev
> -endif
> -
>  default: $(NVME)
>  
>  NVME-VERSION-FILE: FORCE
> diff --git a/fabrics.c b/fabrics.c
> index 2b3caa1..577aa9d 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -26,13 +26,10 @@
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <unistd.h>
> +#include <dirent.h>
>  #include <sys/ioctl.h>
>  #include <asm/byteorder.h>
>  #include <inttypes.h>
> -#ifdef LIBUDEV_EXISTS
> -#include <libudev.h>
> -#endif
> -
>  #include <linux/types.h>
>  
>  #include "parser.h"
> @@ -62,6 +59,7 @@ static struct config {
>  #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
>  #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
>  #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
> +#define SYS_NVME		"/sys/class/nvme"
>  #define MAX_DISC_ARGS		10
>  
>  enum {
> @@ -801,85 +799,63 @@ int connect(const char *desc, int argc, char **argv)
>  	return 0;
>  }
>  
> +static int scan_sys_nvme_filter(const struct dirent *d)
>  {
> +	return !((strcmp(d->d_name, ".") == 0) ||
> +		(strcmp(d->d_name, "..") == 0));
>  }

I find this a bit hard to read. Why not just:

static int scan_sys_nvme_filter(const struct dirent *d)
{
	if (!strcmp(d->d_name, "."))
		return 0;
	if (!strcmp(d->d_name, ".."))
		return 0;
	return 1;
}

>  
> +
>  static int disconnect_by_nqn(char *nqn)
>  {
> +	struct dirent ** devices = NULL;
> +	int i, n, fd, ret = 0;
> +	bool done = false;
> +	char subsysnqn[NVMF_NQN_SIZE] = {};
>  
> +	if (strlen(nqn) > NVMF_NQN_SIZE)
> +		return -EINVAL;
>  
> +	n = scandir(SYS_NVME, &devices, scan_sys_nvme_filter, alphasort);

Needs to handle an error return from scandir.

> +
> +	for (i = 0; i < n; i++) {
> +		char *sysfs_nqn_path;
>  
> +		asprintf(&sysfs_nqn_path, "%s/%s/subsysnqn",
> +			SYS_NVME, devices[i]->d_name);
> +
> +		fd = open(sysfs_nqn_path, O_RDONLY);

> +		if (fd > 0) {
> +			char *sysfs_del_path;
> +
> +			if (read(fd, subsysnqn, NVMF_NQN_SIZE) < 0)
> +				goto next;
> +
> +			subsysnqn[strcspn(subsysnqn, "\n")] = '\0';
> +			if (strcmp(subsysnqn, nqn))
> +				goto next;
> +
> +			asprintf(&sysfs_del_path, "%s/%s/delete_controller",
> +				SYS_NVME, devices[i]->d_name);
> +			ret = remove_ctrl_by_path(sysfs_del_path);
> +
> +			done = true;
> +			free(sysfs_del_path);
> + next:
> +			close(fd);
> +		}
> +
> +		free(sysfs_nqn_path);
> +		if (done)
> +			break;

We can have multiple controllers with the same nqn, and they should all
be deleted with this option.  Also I think factoring the removal code
in the inner block into a separate function would make this a bit more
readable.


Note that the reason why we used udev is that everyone recommends using
it for sysfs iterations, but I think your patch demonstrates that not
using libsysfs might actually make the code better..
