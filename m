Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A15C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HB2opTeCo45isxz0UUguK3ZoXjCTT39LITT/l4XDmTg=; b=PoMZ2E0ko51jy2qfcMVrMFVqFR
	AMhmotNezNe96GioFOoOQ9fhsma8iJFhsc7fPSyb0TeGMIIIt5VafV0zAqllpXjYNAvTquRvp+fJh
	vDU9qBt0+VamdJqXQQ533ZzKw8lALwl0BgirNYUsxWaBDQXjMGjXL7WqrxtGKHsCqw9m/dOYNwrBS
	0mLlfALRPG4U5rjdkOKwiXVbjyh6x7xJ94+W3HFSx1zE4cPzrYpfLl8lMgBci2p7peAd7h2eHOjpb
	yUpg0vHO2y8TtsLIkJV2pNrn5oKbpxd6/AotimhtsBRb1sNvHAoykqGVSV+9fj7QR7EBvWnSBIPqb
	Oi6VkMiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weuB0-000000020z7-0IFz;
	Wed, 01 Jul 2026 12:36:26 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weuAx-000000020y6-0VnC
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 12:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=LyTdOWlsjqz+eF
	l5FgDcdACZaY3BCFiA3W1KLiWUVsU=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=TioxDzs1p0zZvRdEmuCwH8vhmUJgNJEfT8b3g
	SZY8gUdixmpZGgjprjpYFiKrK/bqo82Fr7VpQYtfLbgzpa5wOfVWV+ipZICJ2VVKRJTJSd
	+at5F2xqeAyW5C8SlanAIJNQTL0NQcSlHuA4ilxfUIry0qn/WLrny13FFRSafjq/FstwjF
	7at84cdI0LjrFNWdAItQD85Bw6bBuEqRY0g1Tp8PepFXb/4KoZzA+DuA5e2YBhNvfuejEn
	aEgwCC6QeJ4aGHle82NAo/IYSNLebETIguEKgycuDZJPtE9X/V5QdRIbHk0fBS7T8enHqO
	yT8ohbB96PRBgUm/CajauHATA==
Received: from localhost (<unknown> [94.32.41.112])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id a9602334 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 14:36:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 14:36:15 +0200
Message-Id: <DJN8MK265J48.3QCC1AK34UEKE@arkamax.eu>
Cc: <hch@infradead.org>
Subject: Re: [PATCH] Drop python2 support and the dependency on python-six
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Tomas Hrnciar" <thrnciar@redhat.com>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.21.0
References: <CALkDUM9r6NjVuPM15==o04eAGjhw8AeXeQEtQifksU6gd95V3A@mail.gmail.com>
In-Reply-To: <CALkDUM9r6NjVuPM15==o04eAGjhw8AeXeQEtQifksU6gd95V3A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_053623_800123_2E367172 
X-CRM114-Status: GOOD (  21.29  )
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

Christoph? This patch is intended for nvmetcli.

What do you think about it? Python3 is now the default on all major
distros, AFAIK.

Can we drop the python-six dependency?

Maurizio

On Tue Jun 23, 2026 at 2:24 PM CEST, Tomas Hrnciar wrote:
> Hi,
>
> I'd like to propose a patch which removes support for Python 2 and
> drops the dependency on python-six. Python 2 has been EOL since
> January 2020 and we are trying to remove python-six from distribution.
> This patch drops the remaining six usage.
>
> Thanks,
> Tom=C3=A1=C5=A1 Hrn=C4=8Diar
> ---
>  README                 | 3 ---
>  nvmet/nvme.py          | 7 +++----
>  rpm/nvmetcli.spec.tmpl | 2 +-
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/README b/README
> index 6ebe666..7df25f1 100644
> --- a/README
> +++ b/README
> @@ -14,9 +14,6 @@ using setup.py.
>
>  Common Package Dependencies and Problems
>  -----------------------------------------
> -Both python2 and python3 are supported via use of the 'python-six'
> -package.
> -
>  nvmetcli uses the 'pyparsing' package -- running nvmetcli without this
>  package may produce hard-to-decipher errors.
>
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5..4c63eb1 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -23,7 +23,6 @@ import stat
>  import uuid
>  import json
>  from glob import iglob as glob
> -from six import iteritems, moves
>
>  DEFAULT_SAVE_FILE =3D '/etc/nvmet/config.json'
>
> @@ -220,7 +219,7 @@ class CFSNode(object):
>
>      def _setup_attrs(self, attr_dict, err_func):
>          for group in self.attr_groups:
> -            for name, value in iteritems(attr_dict.get(group, {})):
> +            for name, value in attr_dict.get(group, {}).items():
>                  try:
>                      self.set_attr(group, name, value)
>                  except CFSError as e:
> @@ -556,7 +555,7 @@ class Namespace(CFSNode):
>                  raise CFSError("Need NSID for lookup")
>
>              nsids =3D [n.nsid for n in subsystem.namespaces]
> -            for index in moves.xrange(1, self.MAX_NSID + 1):
> +            for index in range(1, self.MAX_NSID + 1):
>                  if index not in nsids:
>                      nsid =3D index
>                      break
> @@ -816,7 +815,7 @@ class ANAGroup(CFSNode):
>                  raise CFSError("Need grpid for lookup")
>
>              grpids =3D [n.grpid for n in port.ana_groups]
> -            for index in moves.xrange(2, self.MAX_GRPID + 1):
> +            for index in range(2, self.MAX_GRPID + 1):
>                  if index not in grpids:
>                      grpid =3D index
>                      break
> diff --git a/rpm/nvmetcli.spec.tmpl b/rpm/nvmetcli.spec.tmpl
> index f1b5533..ce454a2 100644
> --- a/rpm/nvmetcli.spec.tmpl
> +++ b/rpm/nvmetcli.spec.tmpl
> @@ -9,7 +9,7 @@ Source:         nvmetcli-%{version}.tar.gz
>  BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-rpmroot
>  BuildArch:      noarch
>  BuildRequires:  python-devel python-setuptools systemd-units
> -Requires:    python-configshell python-kmod python-six
> +Requires:    python-configshell python-kmod
>  Requires(post): systemd
>  Requires(preun): systemd
>  Requires(postun): systemd


