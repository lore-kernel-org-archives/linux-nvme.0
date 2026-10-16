Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F8CCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPhwcacTaPjDune05SV+eykRhjmxjUg/u1kdGdL24Ok=; b=A0ETkx0zxZ7J3rNZ3VLrr3cNTU
	wKKoIt0jookl1Fs+BosoffGO5g36iLQLeg3jPbrohtHBIDM16Yo8g5lYNFzWXl5GMzm4sgLipBCor
	VR1oOYHxmj9UwZ9RJSBhHubM7uLv3gemaOIRltUEavDtJqhsarcE7OrjiJXO0aZhCMUi+aJMCG7FQ
	SBf2feVpv7BaLVtjBSJx8FxmEnY7fqAleIr7cmI5eDZSfedKxO1jjIg/1uA0GU3rtyx+qkfsrt3YL
	jNnk4HR4ntvtrBAVwbeXeslT0Ru1kRSRXYQQQSEd+5ecS5Ot0KRXxf+gtLDLsolpbu0UlRWgZJdS4
	FikxlGTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkPZ-00000003NtX-2SYb;
	Fri, 16 Oct 2026 16:04:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkPY-00000003NtM-0nj6
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:04:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21CA260018;
	Fri, 16 Oct 2026 16:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B6D1F000C4;
	Fri, 16 Oct 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166638;
	bh=pPhwcacTaPjDune05SV+eykRhjmxjUg/u1kdGdL24Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iP6HJyVNz63bRmQrd+bKXmU8zgVgkHPfYp4bDS1wLEuEYqqSCjteTJ1zKW0ml4CX3
	 PAto6bC/IqzuDBqQHuk1yriJfTGkha2fSBCjLa7j6xZXpcjsFDuaiI5TXcWKS0fP5d
	 5jqJ6bM0xQQgCa85QIPfsCESmvmBkqV9LFSBvmcMYm3lA7OI1C6HmfZ7l/jZY73EXR
	 /UYoT3lBmqnX5rnVCCGpCn3vpVzKdotQWxvNoEPa6GJUhV62W/63jhcVUZuwcbk4pz
	 U2wh3iraPOXylnubZKz7wAi2WsZrTJvnltAqFoftJexhfvdilnqb2iWRbvmB++Wtfm
	 /aQkTYTiasUkw==
Message-ID: <sashiko-outbox-174597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvmet-fc: skip port entry rebinding if already bound
 to a target port
To: "Nguyen Duy Nhat Anh" <neganhat@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261016155947.11018-1-neganhat@gmail.com>
References: <20261016155947.11018-1-neganhat@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:03:58 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-fc: refcount leak of tgtport in nvmet_fc_portentry_rebind_t=
gt()
--

commit 3bf5702b60af10d1adf6131dcac2e5211f8bdb47
Author: Nguyen Duy Nhat Anh <neganhat@gmail.com>

nvmet-fc: skip port entry rebinding if already bound to a target port

In nvmet_fc_portentry_rebind_tgt(), nvmet_fc_tgtlock serializes access to
nvmet_fc_portentry_list, but does not prevent multiple concurrent or
duplicate target port registrations from attempting to rebind to an
already-assigned port entry. This patch skips the entry if it is already
bound to prevent clobbering existing bindings.

Closes: https://syzkaller.appspot.com/bug?extid=3Dbe62d4b375542ecebd17

> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index eecdffefa24fa..ac3194497a1e0 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1324,7 +1324,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtpo=
rt *tgtport)
>  			if (!nvmet_fc_tgtport_get(tgtport))
>  				continue;
> =20
> -			WARN_ON(pe->tgtport);
> +			if (pe->tgtport)
> +				continue;
> +

[Severity: Medium]
Does this code leak the target port reference?

The commit message states "Fix this by checking if pe->tgtport is already s=
et
before acquiring a reference count", but the check is placed immediately af=
ter
nvmet_fc_tgtport_get() rather than before it.

If pe->tgtport is already bound, the continue statement will skip the rest =
of
the loop, leaving the reference count acquired by nvmet_fc_tgtport_get()
permanently elevated.

Could the check be moved before nvmet_fc_tgtport_get() as intended?

>  			tgtport->pe =3D pe;
>  			pe->tgtport =3D tgtport;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016155947.1101=
8-1-neganhat@gmail.com?part=3D1

