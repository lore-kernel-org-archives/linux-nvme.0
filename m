Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA7606A333
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FQtATIk1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7JYb2lB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3ziH/6Q14bRe014gR//Qc4Al7r+7mN8MHRKIhosdUuk=; b=FQtATIk18FQxv2Yo+6Cv4dFugf
	UBlRVorn7VrWkciwR6lgFVoM2o8271B4tbFaJkHWj7DskuGFSFROPhbZhx4qALWVUZ1rg+FIxR3zn
	oJnRk2U/8rT/RvHCG8HukIdmH2qASQM+lx8/hIJc2hydFpEljP52AS+YKdLsl9UXPaY7R6V6C08VU
	K4Ovc2Z4uAKmrX0Yomrio5QLM9HWX4HcfD0Dq3HwdRrxYn9tnmATMOdZKZDeOfLMLtQ0XQItvRTlP
	TTffNQ6IDwdq41t1/Ssi0CWWvfO700ADHI6c139pNaHWxzd74tDjSGJdVL+OOqNYRuAzu0LY2dJJT
	1nuEajag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpY0-00000006VTq-2RIB;
	Tue, 24 Nov 2026 12:22:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpXz-00000006VTa-2grY
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 12:22:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1EDDB42CEC;
	Tue, 24 Nov 2026 12:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B21F000C0;
	Tue, 24 Nov 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522974;
	bh=3ziH/6Q14bRe014gR//Qc4Al7r+7mN8MHRKIhosdUuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7JYb2lB6ce9AxKBovVZeQVOKreB5k1IQ4cOXTRXFwBRvU8xe2+9Mh2CS37FLuimW
	 K9HIA0Eks+KHXRtnil01+ZmDl5Ua6ftG01rIavaBxVNijeAx/3GUcYF13u0nv9/ISX
	 J3atFMPAH73u1GCow91s5RpRsEAGUcy9ny/Nm0MIdbjU7g7g3r0eBOBQSuRZ6QjVZP
	 4L1ezhC2gpDfDSf55MehTeIcEFrbba7STpNBLGzeyzzIi1VUN2LBEkJdXhAV/PLG9n
	 Loh0VWqrPfRutr9j4Yc+PKsndFhgoceVuCq/CiwYjCCzLXRKo4hYFHR656GqVaBd4a
	 oRPwlMl1PtBFg==
Message-ID: <sashiko-outbox-231129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-multipath: delete the ANATT timer after draining
 ana_work
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261124121349.1861269-1-kanie@linux.alibaba.com>
References: <20261124121349.1861269-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:22:53 +0000
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
- [Critical] nvme-multipath: use-after-free in nvme_parse_ana_log() [1]
--

commit e4ad87877e854ebed2991236e7f5c8c425e05678
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-multipath: delete the ANATT timer after draining ana_work

This commit cancels ana_work before deleting anatt_timer in
nvme_mpath_stop() and also deletes the timer in nvme_mpath_uninit() after
draining ana_work.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 27facdbb3d4c0..40f6cab3db47c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c

[ ... ]

> @@ -1614,6 +1614,7 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  	 * resources.
>  	 */
>  	cancel_work_sync(&ctrl->ana_work);
> +	timer_delete_sync(&ctrl->anatt_timer);
> =20
>  	kvfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf =3D NULL;

[Severity: Critical]
This problem wasn't introduced by this patch, but can freeing
ctrl->ana_log_buf here without holding ctrl->ana_lock cause a
use-after-free in nvme_parse_ana_log() [1]?

When nvme_mpath_init_identify() sees a larger ana_log_size, it calls
nvme_mpath_uninit() to free the old buffer before allocating a new one,
without taking ctrl->ana_lock.  A concurrent namespace scan in
nvme_mpath_add_disk() takes ctrl->ana_lock and reads ctrl->ana_log_buf in
nvme_parse_ana_log():

CPU0                                CPU1
nvme_mpath_init_identify()          nvme_mpath_add_disk()
                                      if (nvme_ctrl_use_ana(ns->ctrl))
                                        mutex_lock(&ns->ctrl->ana_lock)
                                        nvme_parse_ana_log()
                                          base =3D ctrl->ana_log_buf
  nvme_mpath_uninit()
    kvfree(ctrl->ana_log_buf)
                                          /* dereferences freed base */
                                          <-- use-after-free

Taking ctrl->ana_lock around freeing and replacing ctrl->ana_log_buf would
serialize this with concurrent readers.

[1] https://sashiko.dev/#/bug/linux-48603474-5139-4b24-a567-ce7f9706b201

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124121349.1861=
269-1-kanie@linux.alibaba.com?part=3D1

