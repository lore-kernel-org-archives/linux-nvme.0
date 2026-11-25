Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2229606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IsbZV9q6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQOm/1B+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RtXvtqE7iAjCDPXSPm0aWzu0E6+jNU+8+w3Sgi+sjng=; b=IsbZV9q6UKxAlvKgUBKOiaR7Uv
	hkjJnDWmWHk/FqVgGbPOinC/akInRHg9JTNFUed+YQ2/0ujzogK06Z/r1dJF8d4Kkw8QOAtVyO/57
	cPjHXmLu2vAZHsnKuES5TQ4U2cyNe7giiqqvARoh+EBHbiFKUbAjGLwmj0Z3wnEc5Y6fNoV1XPDOs
	hQbtlowK5l8W1CaaCUGfmCq12VtqTgNzAMLJJidO0qsrN8e0xAIyp4E56sVI592nRP5kRQ/+1P0rz
	KNF0eBAsvsKkccjLtckNP0K89OB8hglYunHH7jL3/wYwJ/4ZFDTB/dnzReMuNG29e+p2LPiudf53F
	OJKNBxmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6D2-00000008Wgj-2hrk;
	Wed, 25 Nov 2026 06:10:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6D1-00000008Wgb-1Tqi
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:10:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C919942E7B;
	Wed, 25 Nov 2026 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B1B1F000C0;
	Wed, 25 Nov 2026 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795587021;
	bh=RtXvtqE7iAjCDPXSPm0aWzu0E6+jNU+8+w3Sgi+sjng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQOm/1B+i1rBuPpx/HPR/aBGioHxF1wQvM7qzjGafaB8dSbbdZ2109asMQ0GVGJb8
	 QCXCriS1Ts3KQgBPuEFoTDpo3aRFZ3mSG33hf0gjbcoFoaZ0ZQzkYD5m/xFODR90gC
	 549MjtQOYhKygHT34ZAwLhpl37SoIxb7bOtgeWRlgxpZpdZCgrZ7bE4aQypnEAJqzs
	 djxeOCDf+uJCnx4qBW2kt8WBNnq6GMek0mzNojlVrLne914x48BAtyV5L17NiaPXa+
	 0r5dCURFnLtLmHY0usHTTlUqwxLdfN8KLWU0C/p5e5Ur1Rp0KoOFslplpMcIM+j6dp
	 sV58mqFHjGR4g==
Message-ID: <sashiko-outbox-232646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-multipath: protect ana_log_buf teardown with
 ana_lock
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261125060153.206699-1-kanie@linux.alibaba.com>
References: <20261125060153.206699-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:10:21 +0000
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
- [High] nvme-multipath: NULL deref and uninit read in
  nvme_parse_ana_log()
--

commit d312e34ea57a3e103965fa1cad1dd210a8ca3b3a
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-multipath: protect ana_log_buf teardown with ana_lock

This commit acquires ctrl->ana_lock around freeing and clearing
ctrl->ana_log_buf in nvme_mpath_uninit() to serialize against concurrent
ANA log parsers.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 27facdbb3d4c0..bc0abd1f30274 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1615,7 +1615,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  	 */
>  	cancel_work_sync(&ctrl->ana_work);
> =20
> +	mutex_lock(&ctrl->ana_lock);
>  	kvfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf =3D NULL;
>  	ctrl->ana_log_size =3D 0;
> +	mutex_unlock(&ctrl->ana_lock);
>  }

[Severity: High]
Can a concurrent parser in nvme_mpath_add_disk() still hit a NULL pointer
dereference or read uninitialized memory in nvme_parse_ana_log() when
nvme_mpath_uninit() unlocks ctrl->ana_lock?

In the concurrent nvme_mpath_init_identify() and nvme_mpath_add_disk()
path, nvme_mpath_add_disk() checks nvme_ctrl_use_ana() (which tests
ctrl->ana_log_buf !=3D NULL) before acquiring ctrl->ana_lock, and
nvme_parse_ana_log() unconditionally dereferences
ctrl->ana_log_buf->ngrps:

CPU0                                  CPU1
nvme_mpath_init_identify()            nvme_mpath_add_disk()
                                        if (nvme_ctrl_use_ana(ctrl))
  nvme_mpath_uninit()
    mutex_lock(&ctrl->ana_lock)
    kvfree(ctrl->ana_log_buf)
    ctrl->ana_log_buf =3D NULL
    mutex_unlock(&ctrl->ana_lock)
                                        mutex_lock(&ctrl->ana_lock)
                                        nvme_parse_ana_log()
                                          ctrl->ana_log_buf->ngrps
                                            <-- NULL pointer dereference
  ctrl->ana_log_buf =3D kvmalloc(...)
  nvme_read_ana_log()

Even if CPU1 acquires ctrl->ana_lock after kvmalloc() runs in
nvme_mpath_init_identify(), ctrl->ana_log_buf and ctrl->ana_log_size are
assigned before nvme_read_ana_log() retakes ctrl->ana_lock to populate the
buffer, so nvme_parse_ana_log() can parse uninitialized memory from
kvmalloc().  In addition, while ctrl->ana_log_buf is NULL between
nvme_mpath_uninit() and kvmalloc(), concurrent callers of
nvme_ctrl_use_ana() transiently observe the controller as non-ANA.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125060153.2066=
99-1-kanie@linux.alibaba.com?part=3D1

