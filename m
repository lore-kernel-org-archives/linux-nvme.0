Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF2EC36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDwmTkRIn+gi9XSF0Wg1H1gh21NsZqfmRJe+hAYmPDQ=; b=hQ8UiAKA75Nsslp0EBJGDae0XP
	t2KnSMtliQaKHWgf9cVB919UCxIl2X3SgOvtsxFrgjqTyf82+9x97Zwbuyu6h4JWhFBPHOymXCTOJ
	7kC14FbHG0TGZeJ+xd2D07WtItxUd5PMcMsdnhd4AT1R5eZeqMNBrF1N30ri3KtQKWTpwIV1idWw2
	UlmzV3jVxAOO3wnRF9eTIuqfk5Kw5/s/mSgF7sch+dgqFCm/M50QF6W83kSJ3hAg0I+tF9v0j0Kcl
	ualSEjKQCz6xY+t10B+i6qAlkilEbAvn3qGpRhMhxi0OaF0Jowbl0PdaVZCSJTOsqReQSZZx7mR3+
	ZyCST0pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvbf1-0000000EmIs-1FJb;
	Fri, 21 Mar 2025 12:39:39 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvbey-0000000EmIR-37oU
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 12:39:38 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id f1fe976a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Mar 2025 13:39:31 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 13:39:30 +0100
Message-Id: <D8LY8MIVGQLR.3TK8BZGZR9VWJ@bsdbackstore.eu>
Subject: Re: [PATCH] When kmodpy is not available call kmod binary directly
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Michal Suchanek" <msuchanek@suse.de>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <20250321105915.8971-1-msuchanek@suse.de>
In-Reply-To: <20250321105915.8971-1-msuchanek@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_053937_120553_10AFF42C 
X-CRM114-Status: GOOD (  15.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri Mar 21, 2025 at 11:59 AM CET, Michal Suchanek wrote:
> kmodpy is an unmaintained project. Python is not really good at
> backwards compatibility. With the upstream project not keeping up with
> python churn using the library is a maintenance burden.

Well, the original maintainer abandoned it, I did
what I could to make kmod able to run with latest Cython v3

https://lore.kernel.org/target-devel/CAFL455=3Dr4SuND7vL1Sr2vKzLTsgg-KL7GNz=
zJZPe2wDDH-NQyg@mail.gmail.com/

However I think that the fallback is ok and I will do the same
on targetcli too, soon or later.

Maurizio

>
> nvmet does not use the python library in any substantial way, it only
> loads a module once. This can be easily accomplished without any library
> using the modprobe tool directly.
> ---
>  nvmet/nvme.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5b7c1b..397f103abcdb 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -256,9 +256,20 @@ class Root(CFSNode):
>              # Try the ctypes library included with the libkmod itself.
>              try:
>                  import kmod
> -                kmod.Kmod().modprobe(modname)
> -            except Exception as e:
> -                pass
> +
> +                try:
> +                    kmod.Kmod().modprobe(modname)
> +                except Exception as e:
> +                    pass
> +            except ImportError:
> +                # Try the binary specified in /proc
> +                try:
> +                    kmod =3D None
> +                    with open('/proc/sys/kernel/modprobe', 'r') as f:
> +                        kmod =3D f.read().rstrip()
> +                    os.system(kmod + ' ' + modname)
> +                except Exception as e:
> +                    pass
> =20
>      def _list_subsystems(self):
>          self._check_self()


