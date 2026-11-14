Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA606A32E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mL3fcnqb;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hd4ZDXdm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aDr2KcAmu5V01wJEvxxKKWI7byA7UpbzUD/kxUAzaUM=; b=mL3fcnqbLx6ZM1TI0onLo4KV9F
	zC+5wCcFUH5SHGeW4LTet9siKN1xKmd7HySRkx6/GEk3Ju8X5zhta9+RBFG4YTM350vtxvbivpNFI
	DAzX75mDOEQqR3pP6Q6vE0gabayCT/zGTNAB+6Yd/oB81+mEfQt5IXxLa6odMZTQMm87M5cajy3cD
	94wUzCGQhff+8lhkA7uxPuFrLQXdvqt+s+9rDvXgX7MXUrhpD/cQLd3ex+5TztdrNuZkt7lrqiH6N
	bDwGgb+P4lZV4X0DEVoX7xA+Ytpyo/p49uXBW3q7FYs6SzdA5RAH5m3/20klLlvuL/gNcoS30ARyJ
	V1+TzQcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4GZ-0000000FEIx-2Sht;
	Sat, 14 Nov 2026 03:17:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4GZ-0000000FEIq-06GP
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:17:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4754461907;
	Sat, 14 Nov 2026 03:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49031F000C4;
	Sat, 14 Nov 2026 03:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626242;
	bh=aDr2KcAmu5V01wJEvxxKKWI7byA7UpbzUD/kxUAzaUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hd4ZDXdmiwZvn0KyUwbPX4E/JZWIRi+N4DJaxQh9Xy9Kwd+oE6S5dnXs31UriwcZs
	 w7QbhGNyGxw48rS6vy6zNdvlzIKsoug10U/zOFncIJ9WvtJHF+vgNHaVregCa+R94O
	 9T9hzEyTcwGW70R6N28G3ikp7JV7cbveoqgp6zGoQqtBPZE3KBX/5Q8+EoRpa6ZzqA
	 LwbU+3qHUvVoydmcottWf+8lM50f6HH5toAUyDJpJsc58MFMPc15HGSNSPjbSoxIXJ
	 g3+Dz1ooQdnshk7aQoCP/7cCSEXei6OueB0IgcyG7U9+AuLb1FSZwaqCK0vGt04wTf
	 6xun/vS336bGA==
Message-ID: <sashiko-outbox-214092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/17] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-2-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:17:21 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvmet: missing TP8028 field overrides in
  nvmet_passthru_override_id_ctrl()
--

commit b07e2fdf2211131fb02142faf21d5cf7328792da
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvmet: Rapid Path Failure Recovery set controller identify fields

This commit adds the TP8028 Rapid Path Failure Recovery fields (ciu, cirn,
and ccrl) to struct nvme_id_ctrl, initializes ciu and cirn on controller
allocation and start, and populates them in the Identify Controller
response for non-discovery subsystems.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index f12d830986446..5710ae53eb83a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -702,6 +702,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet=
_req *req)
>  	id->mdts =3D nvmet_ctrl_mdts(req);
>  	id->cntlid =3D cpu_to_le16(ctrl->cntlid);
>  	id->ver =3D cpu_to_le32(ctrl->subsys->ver);
> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> +		id->ciu =3D ctrl->ciu;
> +		id->cirn =3D cpu_to_le64(ctrl->cirn);
> +		id->ccrl =3D NVMF_CCR_LIMIT;
> +	}

[Severity: Medium]
Should nvmet_passthru_override_id_ctrl() also override id->ciu, id->cirn,
and id->ccrl?

On a passthrough subsystem, Identify Controller runs through
nvmet_passthru_execute_cmd_work() -> nvmet_passthru_override_id_ctrl(),
which overrides id->cntlid and id->ver but leaves id->ciu, id->cirn, and
id->ccrl with whatever the backend controller returned.  Every fabric
controller connected to the passthrough subsystem will report the backend
device's ciu and cirn instead of ctrl->ciu and ctrl->cirn, and if the
backend controller advertises a non-zero ccrl, hosts will issue
Cross-Controller Reset commands that nvmet_parse_passthru_admin_cmd()
rejects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D1

