From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 10:58:52 -0700
Subject: [PATCH rfc v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190712003140.16221-11-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-11-jsmart2021@gmail.com>
Message-ID: <9c08054d-751e-fdc0-4ea1-64cfa388e439@grimberg.me>


> diff --git a/Makefile b/Makefile
> index db594a3..4ea8b41 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,6 +8,10 @@ DESTDIR =
>   PREFIX ?= /usr/local
>   SYSCONFDIR = /etc
>   SBINDIR = $(PREFIX)/sbin
> +LIBDIR ?= /usr/lib
> +SYSTEMDDIR ?= $(LIBDIR)/systemd
> +UDEVDIR ?= $(LIBDIR)/udev

UDEVDIR needs to be built from $(SYSCONFDIR)/udev as LIBDIR might be
/usr/local/lib and udev doesn't look there.
