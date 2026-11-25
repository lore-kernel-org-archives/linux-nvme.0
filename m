Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FDF606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wU2pnCum;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKUE2TiP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V6tcbm/X0GYl5FqZK5lD6wu1qzDg6ygdoGmmoNpdcOs=; b=wU2pnCumNS0oLDmKXdHifPmZC+
	GLvPpryv8PPvbjYAPvRSa83GXdqPiC7vuy/63rROn8dPu/PA+mrkRXi2ggoBy9L4aw6zyZlXmXqdw
	qg9LMKZkcKyjyY1j0xPrvEh2w5TY/BBgUX7dEtOcIOxpXddSe2w/4XMVKAz0SBVkRuWypQ2qSxOqC
	wvyNwPV2/FADgoseU8mBBVWNqgKZIIbUFHWnnTweEB/7SUToitAx7zaGC6knmpD9jaDNXZAUPtXHH
	l9VUWZHE2LgdECDhMbuvZa8R2bcY7hndfOk99A4+cdLqIx+lAk+qvGPOnmZ83ASwW0WbxiQ9FNB0I
	wPSrTDbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE04-0000000AAHe-25Zx;
	Wed, 25 Nov 2026 14:29:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWE03-0000000AAHQ-0YhS
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:29:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F315411CA
	for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 14:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0BB1F000D0;
	Wed, 25 Nov 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616970;
	bh=V6tcbm/X0GYl5FqZK5lD6wu1qzDg6ygdoGmmoNpdcOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKUE2TiPj8nsimtZxV9byIddnUIcT1moSG18nEGuQI54RhoCvXrXcVYhsgUgnuQPh
	 kcUAkSYBTMU1ufyvxVqrbEHGR5wlFjl4QRaZJOQbsoiQz8Z+A+85mjBIfdgNQaSQPg
	 RGof9uT+B+aIbBz9Ho0UnR91IZRpiq5Ev2pRBtM6/Jn6MfKZJijLB+xTDq+HuqVsrY
	 2y/no0b2als3qLszgM78N/Uf8sTttM78+DHI1nPIv7OX08P88N2I1PNaxpw71VrTR0
	 mWywy+RasYZTz6yKkcwDm3oIIPJ+/BdVa/8HsbML0XilI38285mzeY9oooi5xNaC2L
	 5o0QbBnt4XEvw==
Message-ID: <sashiko-outbox-233564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-tcp: use correct network namespace to resolve
 addresses
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261125142033.4889-1-hare@kernel.org>
References: <20261125142033.4889-1-hare@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 14:29:29 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] nvme-tcp: use-after-free in nvme_tcp_alloc_ctrl() [1]
--

commit b5c00449d6f49b9a56a985850da55496bd947e27
Author: Hannes Reinecke <hare@kernel.org>

nvme-tcp: use correct network namespace to resolve addresses

This commit initializes ctrl->net earlier in nvme_tcp_alloc_ctrl() and
uses it instead of init_net when resolving traddr, host_traddr, and
host_iface.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 62a594b8ab9bf..bcc092cdf42b0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -3309,6 +3309,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
>  	ctrl->ctrl.queue_count =3D NVME_TCP_OPT_NR_QUEUES(opts);
>  	ctrl->ctrl.sqsize =3D opts->queue_size - 1;
>  	ctrl->ctrl.kato =3D opts->kato;
> +	ctrl->net =3D get_net(current->nsproxy->net_ns);
> =20
>  	INIT_DELAYED_WORK(&ctrl->connect_work,
>  			nvme_tcp_reconnect_ctrl_work);
> @@ -3325,7 +3326,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
>  		opts->mask |=3D NVMF_OPT_TRSVCID;
>  	}
> =20
> -	ret =3D inet_pton_with_scope(&init_net, AF_UNSPEC,
> +	ret =3D inet_pton_with_scope(ctrl->net, AF_UNSPEC,
>  			opts->traddr, opts->trsvcid, &ctrl->addr);
>  	if (ret) {
>  		pr_err("malformed address passed: %s:%s\n",
> @@ -3334,7 +3335,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
>  	}
> =20
>  	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
> -		ret =3D inet_pton_with_scope(&init_net, AF_UNSPEC,
> +		ret =3D inet_pton_with_scope(ctrl->net, AF_UNSPEC,
>  			opts->host_traddr, NULL, &ctrl->src_addr);
>  		if (ret) {
>  			pr_err("malformed src address passed: %s\n",
> @@ -3344,7 +3345,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
>  	}
> =20
>  	if (opts->mask & NVMF_OPT_HOST_IFACE) {
> -		if (!__dev_get_by_name(current->nsproxy->net_ns,
> +		if (!__dev_get_by_name(ctrl->net,
>  				       opts->host_iface)) {

[Severity: Critical]
This problem wasn't introduced by this patch, but can calling
__dev_get_by_name() without holding rtnl_lock or rcu_read_lock() cause a
use-after-free [1]?

__dev_get_by_name() traverses the net->dev_name_head hash list without
taking any locks.  Concurrent network device registration or
unregistration can modify or free list entries during the traversal,
leading to a use-after-free or an infinite loop.

[1] https://sashiko.dev/#/bug/linux-8edcdd49-7446-4c9f-86a0-f1b1561c3867

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125142033.4889=
-1-hare@kernel.org?part=3D1

