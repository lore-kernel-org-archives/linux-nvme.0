Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9495606A31F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KQ3/1JqJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRlnF3zB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kODxZPB2GBs5dTENZE01pUpcHzotbMPd1WnZqc99Ppg=; b=KQ3/1JqJHofK0HbH2oIJbW+DKQ
	654wFollbYdrd3m5yjOLvonyYychrAsjNpkG24rfJCW1KKdYG6jORKFga5vGEj4LReYPIAQQSgQUr
	gTt+mP6Ho36u8Ht/bP6OdTbne4JImxhaf4ZDBvHNgNzzsHJgM48lRp0XTkJC34c9457RUDAPptSbk
	0NjolDwPjveHCD5xfR6uVFP2jzCL8LIK5sUFTzP1NTmLaQXsmlX2X88Z9ClYVv+MNxHD1NI1L4JAK
	XoZ52h8WoXfCdHPc7qqUYJ01ZY1iddQBBdAvz8XQ9OxsrVFoJiq3uyKeB8tzhSLjAJ4vUUjMI+YiR
	8v7TQ+cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdp4-00000004DaH-1De6;
	Tue, 27 Oct 2026 09:50:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdp3-00000004DZd-0VoL
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 09:50:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FC31601F0;
	Tue, 27 Oct 2026 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC9F1F031E0;
	Tue, 27 Oct 2026 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094624;
	bh=kODxZPB2GBs5dTENZE01pUpcHzotbMPd1WnZqc99Ppg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VRlnF3zBNEClXAMwOh5DovzjROTiQmUq3WjRhMNf6VImL5z2OTHMuM1fVowcu9HfZ
	 TTMkdauioL8/X4W70ujX47y+jfNQ/C/ClAhWTyb32PkN/n1+ZWAJzSKIyGKOTvE9ls
	 L86Ib+qJYhFoPkopKmpVcQpC/N+koma/a6fV5KqMZvp3zMuNXghPcAOYICV9TL3XU1
	 j5h1JLrguZ1wxiYZ85EU60LJZ0gHVazRBxBDNtC9jTzt3uk96yUWErPYJGTgYUswlj
	 0Dp6SvPY1NfMAcXm7TycVhs6t2aF8TWII4JG2UQKf4dTRboKR5/ocXh1US83uDGs2x
	 u0tWBgyNV7Qew==
Message-ID: <sashiko-outbox-186336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] nvmet-tcp: validate the TLS handshake timeout
To: "Yingjie Wang" <1075151112@qq.com>, linux-nvme@lists.infradead.org
In-Reply-To: <tencent_39AF670751CA25EA49D4BFD8E76C509F5506@qq.com>
References: <20261027093552.3934437-1-1075151112@qq.com>
 <tencent_39AF670751CA25EA49D4BFD8E76C509F5506@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 09:50:23 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] nvmet-tcp: missing kernel-parameters.txt entry for tls_handshake_ti=
meout
--

commit 88d44e836ad9d55aee22edbc907b852e3d9a66c6
Author: Yingjie Wang <1075151112@qq.com>

nvmet-tcp: validate the TLS handshake timeout

This commit changes the tls_handshake_timeout module parameter from a signed
int to an unsigned int and validates that configured values fit within both
tls_handshake_args::ta_timeout_ms and a valid jiffies delay. It also reads
the timeout once per handshake so the upcall and delayed work use the same
value.

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index c38ea3501ea5d..ba529cfc62577 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c

[ ... ]

> @@ -76,8 +77,24 @@ MODULE_PARM_DESC(idle_poll_period_usecs,
>  /*
>   * TLS handshake timeout
>   */
> -static int tls_handshake_timeout =3D 10;
> -module_param(tls_handshake_timeout, int, 0644);
> +static unsigned int tls_handshake_timeout =3D 10;
> +
> +static int tls_handshake_timeout_set(const char *val,
> +				     const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 0,
> +		min_t(unsigned long, UINT_MAX / MSEC_PER_SEC,
> +		      MAX_JIFFY_OFFSET / HZ));
> +}
> +
> +static const struct kernel_param_ops tls_handshake_timeout_ops =3D {
> +	.set =3D tls_handshake_timeout_set,
> +	.get =3D param_get_uint,
> +};
> +
> +module_param_cb(tls_handshake_timeout, &tls_handshake_timeout_ops,
> +		&tls_handshake_timeout, 0644);
> +__MODULE_PARM_TYPE(tls_handshake_timeout, "uint");

[Severity: Low]
In drivers/nvme/target/tcp.c, this changes the tls_handshake_timeout module
parameter definition from module_param() (int) to module_param_cb() (uint)
with range bounds checked by tls_handshake_timeout_set().

Since nvmet_tcp.tls_handshake_timeout is exposed on the kernel command line
when CONFIG_NVME_TARGET_TCP_TLS is enabled, should an entry also be added to
Documentation/admin-guide/kernel-parameters.txt documenting its format and
valid range?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_39AF670751C=
A25EA49D4BFD8E76C509F5506@qq.com?part=3D1

