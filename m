Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8D606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WcwIbwEz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AineyO17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6FJIyLt8VRakNCAmDd3+eneMPjJv+GXhhUROb2jM6b8=; b=WcwIbwEz48a4kZUPOD7F3kF5CE
	Hwbc5nmZg95TY2dZhQC7RjgnXxtdxE2swNW4x3DOLIHlWlCjrnpvVnSDJkb+PgigUoLF2avlZzmXE
	2q3NPl8h7sQiDZCkmRghJst65wZHgjoppkCYMXPIP8Z65x3ax7kLUJoDKWQOAqPeQLnG7OpVXOoBM
	G1urwbwNQrDi76mA+ciy/6VazCtpEShxPPthMAMocb/TVLQLHRkh71KK/N5+LUHF5qwHgJTYiuYPC
	3HiuZB3WqIdrWXaf08DqFmUxezLsF/oJHyB33n2d3NnfgBLXqrrFxeVJPpOfsiezvA4SBjwxnJuy8
	OSmkTXXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHcb-0000000GXnX-1gif;
	Sat, 14 Nov 2026 17:33:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHca-0000000GXnN-2Rfg
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:33:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AA8FD625D6;
	Sat, 14 Nov 2026 17:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416791F000C4;
	Sat, 14 Nov 2026 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677579;
	bh=6FJIyLt8VRakNCAmDd3+eneMPjJv+GXhhUROb2jM6b8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AineyO174NYDx9MYqnXR58EqT1YVTzfe4jVkL6bKlAo24Ekwz2K9aNN+sZYnkYhqK
	 qmtuPeM8zscaegE9FwDQ6tQjGp1n6HDjilTCqUh7z0NEb5+BtMyFrQn8x4a7DZvxEE
	 fb0dxijiDLmio8nqU/FG2/rEQPC6hEG0Ga9UJcON9yoM8kci8hwz63CjdXD0fMnlnb
	 Ic5KfhUAgXFndDaE0EoiSSMecj9/6LAYwYSpjXrZLIl4PVD+mJnWVcGOiJk55pnOdN
	 hvKbwDTzx6kRTvv5H3RS709igWZBXgZi0Da6+zKSGcTRSf8VWx3TFEIkXnOxdI8zhI
	 HjsOWT8byM8tA==
Message-ID: <sashiko-outbox-214841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: fix the CSTS state iteration in debugfs
To: shao.mingyin@zte.com.cn, linux-nvme@lists.infradead.org
In-Reply-To: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
References: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:32:58 +0000
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
- [Medium] nvmet: data race in nvmet_ctrl_kato_show() [1]
--

commit 7730565aae4019e36ef00daab9fa6f3d654b6597
Author: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet: fix the CSTS state iteration in debugfs

This commit fixes nvmet_ctrl_state_show() to iterate over the 32 bits of
csts instead of the size of csts_state_names[], checking array bounds and
printing unknown bits as unsigned values.

> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8d..905a08c63669e 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -78,18 +78,19 @@ static int nvmet_ctrl_state_show(struct seq_file *m, =
void *p)
>  	bool sep =3D false;
>  	int i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(csts_state_names); i++) {
> -		int state =3D BIT(i);
> +	for (i =3D 0; i < BITS_PER_TYPE(u32); i++) {
> +		u32 state =3D BIT(i);
> =20
>  		if (!(ctrl->csts & state))
>  			continue;

[Severity: Medium]
This problem wasn't introduced by this patch, but can reading ctrl->csts
across loop iterations in nvmet_ctrl_state_show() (as well as ctrl->kato
in nvmet_ctrl_kato_show()) without synchronization or READ_ONCE() cause a
data race [1] when administrative commands or state transitions
concurrently update the controller state, resulting in inconsistent or
torn debugfs output?

[1] https://sashiko.dev/#/bug/linux-2b037cd9-c44c-44de-95f8-41de5f514a0b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115012806699yI=
ujDZo6TywlxuhhSIktO@zte.com.cn?part=3D1

