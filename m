Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B06C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:37:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280DD64F51
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280DD64F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qw7xQxMxm29eGqznmx3G1+KB52JJ8M10IY3fo67jtgg=; b=3CvePLVSBWnNECK1biXRmW24L
	VKPvMFVli6Hjs/hFGng7w90ruDEa5M9jaBlBI42FEr3gJUSR6nwVJaeIlq5o8O2DOD+/o1P0F8xDZ
	nEOPNCToSpfoSpieJIg2Z0ZkewZuqNKovjyILRobQLm3pVfHsHvg7OoJ9x/XVQrTp0By3YqeZCjKG
	BumbG1r/Rj8Kff0wJSP02KLvPCt9J9Dm1VgR+hXJSUADoGlOKi+h6w5XcnnzxxmDnk2EJORgEKf9q
	JKurgPU5eaXy7BW2HDPHB+NmUocZ93Zu+auacNo/1FS/m3RyYoXRq1QbYjX/NZwxp0khz0POdljLO
	ypL+vU5yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7b56-0001fP-Jh; Thu, 04 Feb 2021 09:37:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7b53-0001eV-Nz
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 09:37:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612431460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfNxrGT3uBDfoD9LZwTl7brH1E3Bz24BoJp1FFAnyzA=;
 b=LnybTOmgxUoc14S5vEA6iRTQxGiHMWMmCS0BTIRl/b26560xMAwqoXgBKIJ9KkAiffGdDQ
 sEFYxB1hz3LpIi7TgyNUBHScmxkGoiQGSNE8JWMkAGlRD2Lqp5ntNMadklV7l/mhUtkMyJ
 sKHoTJ0O/oraJUShcMn/zPv7L2rnYtI=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A8578AED2;
 Thu,  4 Feb 2021 09:37:40 +0000 (UTC)
Message-ID: <bca4cd03f4a9a64d36a746c92eb2afb4d7ce4750.camel@suse.com>
Subject: Re: [PATCH 13/35] monitor: disable nvmf-autoconnect udev rules in
 autoconnect mode
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Thu, 04 Feb 2021 10:37:40 +0100
In-Reply-To: <ff1b9621-c01b-7884-1e8f-44a07ac845c1@suse.de>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-14-mwilck@suse.com>
 <ff1b9621-c01b-7884-1e8f-44a07ac845c1@suse.de>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_043742_035820_3B9F9ECD 
X-CRM114-Status: GOOD (  33.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-02-04 at 08:16 +0100, Hannes Reinecke wrote:
> On 1/26/21 9:33 PM, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > If autoconnect is enabled, disable the respective udev rules
> > by symlinking /run/udev/rules.d to /dev/null, in order to avoid
> > the connections being set up by the monitor and the udev workers
> > at the same time. This is probably the preferred mode of operation
> > for the monitor.
> > =

> > Users can override this by copying 70-nvmf-autoconnect.rules
> > from /usr/lib/udev/rules.d to /etc/udev/rules.d (/etc/udev/rules.d
> > takes precedence over /run/udev/rules.d).
> > =

> > If the symlink can't be created for some reason, autoconnect will
> > be disabled. There is=A0 only one exception: If
> > /run/udev/rules.d/70-nvmf-autoconnect.rules already points to
> > /dev/null at startup, autoconnect can be left on, but the symlink
> > isn't removed on exit.
> > =

> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > =A0 monitor.c | 75
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > =A0 1 file changed, 73 insertions(+), 2 deletions(-)
> > =

> > diff --git a/monitor.c b/monitor.c
> > index ecf3be2..2a906db 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -17,14 +17,18 @@
> > =A0 =

> > =A0 #include <stddef.h>
> > =A0 #include <stdio.h>
> > +#include <stdlib.h>
> > =A0 #include <unistd.h>
> > =A0 #include <errno.h>
> > =A0 #include <libudev.h>
> > =A0 #include <signal.h>
> > =A0 #include <time.h>
> > +#include <limits.h>
> > =A0 #include <syslog.h>
> > +#include <sys/stat.h>
> > =A0 #include <sys/epoll.h>
> > =A0 =

> > +#include "common.h"
> > =A0 #include "nvme-status.h"
> > =A0 #include "util/argconfig.h"
> > =A0 #include "monitor.h"
> > @@ -33,6 +37,7 @@
> > =A0 =

> > =A0 static struct monitor_config {
> > =A0=A0=A0=A0=A0=A0=A0=A0bool autoconnect;
> > +=A0=A0=A0=A0=A0=A0=A0bool skip_udev_on_exit;
> > =A0 } mon_cfg;
> > =A0 =

> > =A0 static struct udev *udev;
> > @@ -45,6 +50,8 @@ static void close_ptr(int *p)
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0 }
> > =A0 =

> > +CLEANUP_FUNC(char)
> > +
> > =A0 static void cleanup_monitor(struct udev_monitor **pmon)
> > =A0 {
> > =A0=A0=A0=A0=A0=A0=A0=A0if (*pmon) {
> > @@ -174,12 +181,64 @@ static int monitor_main_loop(struct
> > udev_monitor *monitor)
> > =A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > =A0 }
> > =A0 =

> > +static const char autoconnect_rules[] =3D "/run/udev/rules.d/70-
> > nvmf-autoconnect.rules";
> > +
> > +static int monitor_disable_udev_rules(void)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0CLEANUP(char, path) =3D strdup(autoconnect_rules);
> > +=A0=A0=A0=A0=A0=A0=A0char *s1, *s2;
> > +=A0=A0=A0=A0=A0=A0=A0int rc;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!path)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0s2 =3D strrchr(path, '/');
> > +=A0=A0=A0=A0=A0=A0=A0for (s1 =3D s2 - 1; s1 > path && *s1 !=3D '/'; s1=
--);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0*s2 =3D *s1 =3D '\0';
> > +=A0=A0=A0=A0=A0=A0=A0rc =3D mkdir(path, 0755);
> > +=A0=A0=A0=A0=A0=A0=A0if (rc =3D=3D 0 || errno =3D=3D EEXIST) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*s1 =3D '/';
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rc =3D mkdir(path, 0755);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (rc =3D=3D 0 || errno =
=3D=3D EEXIST) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*=
s2 =3D '/';
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
c =3D symlink("/dev/null", path);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0if (rc) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (errno =3D=3D EEXIST) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
har target[PATH_MAX];
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
f (readlink(path, target, sizeof(target))
> > !=3D -1 &&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 !strcmp(target, "/dev/null")) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0log(LOG_INFO,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "symlink %s -> /dev/null exists
> > already\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 autoconnect_rules);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0return 1;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log(LOG_ERR, "error creat=
ing %s: %m\n",
> > autoconnect_rules);
> > +=A0=A0=A0=A0=A0=A0=A0} else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log(LOG_INFO, "created %s=
\n", autoconnect_rules);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return rc ? (errno ? -errno : -EIO) : 0;
> > +}
> > +
> > +static void monitor_enable_udev_rules(void)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0if (unlink(autoconnect_rules) =3D=3D -1 && errno =
!=3D ENOENT)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log(LOG_ERR, "error remov=
ing %s: %m\n",
> > autoconnect_rules);
> > +=A0=A0=A0=A0=A0=A0=A0else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log(LOG_INFO, "removed %s=
\n", autoconnect_rules);
> > +}
> > +
> > =A0 static int monitor_parse_opts(const char *desc, int argc, char
> > **argv)
> > =A0 {
> > =A0=A0=A0=A0=A0=A0=A0=A0bool quiet =3D false;
> > =A0=A0=A0=A0=A0=A0=A0=A0bool verbose =3D false;
> > =A0=A0=A0=A0=A0=A0=A0=A0bool debug =3D false;
> > -=A0=A0=A0=A0=A0=A0=A0int ret;
> > +=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0OPT_ARGS(opts) =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0OPT_FLAG("autoconnect",=
=A0=A0=A0 'A',
> > &mon_cfg.autoconnect, "automatically connect newly discovered
> > controllers"),
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0OPT_FLAG("silent",=A0=
=A0=A0=A0=A0=A0=A0=A0 'S',
> > &quiet,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "log level: silent"),
> > @@ -198,7 +257,17 @@ static int monitor_parse_opts(const char
> > *desc, int argc, char **argv)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log_level =3D LOG_INFO;
> > =A0=A0=A0=A0=A0=A0=A0=A0if (debug)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0log_level =3D LOG_DEBUG;
> > -
> > +=A0=A0=A0=A0=A0=A0=A0if (mon_cfg.autoconnect) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D monitor_disable_u=
dev_rules();
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret < 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
on_cfg.autoconnect =3D false;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0l=
og(LOG_WARNING, "autoconnect disabled\n");
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
et =3D 0;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else if (ret > 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
on_cfg.skip_udev_on_exit =3D true;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
et =3D 0;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > =A0 }
> > =A0 =

> > @@ -221,6 +290,8 @@ int aen_monitor(const char *desc, int argc,
> > char **argv)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0udev_monitor_unref(moni=
tor);
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0udev =3D udev_unref(udev);
> > +=A0=A0=A0=A0=A0=A0=A0if (mon_cfg.autoconnect && !mon_cfg.skip_udev_on_=
exit)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0monitor_enable_udev_rules=
();
> > =A0 out:
> > =A0=A0=A0=A0=A0=A0=A0=A0return nvme_status_to_errno(ret, true);
> > =A0 }
> > =

> What on earth ...
> =

> No way.
> We should _not_ reference individual files or mess with udev rules
> from =

> a program. If a file needs to be modified, modify it.
> But do not try to modify a file from a program context, unless the =

> program itself has created it.

Sagi said the same, I'll drop this. I thought it was acceptable because
I'd be masking a rule from the same package, and preferable because
making the user responsible for it would be cumbersome and error-prone
on the part of the user.

Thanks,
Martin

> =

> Cheers,
> =

> Hannes



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
