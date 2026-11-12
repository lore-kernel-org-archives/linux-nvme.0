Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90319606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JXDFH4AF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUnzB5t0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yFYOtU7CzdnDooEu/EsEIxu97UiTtht9yYO2t5Rtqng=; b=JXDFH4AFZ43DDf02W52soasI6V
	Ju4zcjLWaZOz2o9sIqStxCPqIg1+JKu1556PFmumIFKYpUDeeTboYIE4AiIipjQZnmncRz2J2T8lS
	6yvKgiyejqjfgk6JU6He6iSJqdMHJKj7SRq2u408ZkATbmpM6Bc6t8OoBH4Ynfc+nrDLa4l0ZaB4N
	7H4ved2facnPDV7qeUrz+96EweKvGyPNcwbVCtn5M303uGazHetW4pDnFOf91PDdV8Ra3fPQ3ztTj
	RQab09FR3CKnK8nsMLHqSsGs6BN+oHHdmZT8UZAVO/qfP8SOwtMLvM0VJlzSipViVlCtHiLPceFPP
	knJbwNsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRbE2-0000000B0Hs-3mPa;
	Thu, 12 Nov 2026 20:16:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRbE1-0000000B0Hj-0dhh
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 20:16:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 50D996116E;
	Thu, 12 Nov 2026 20:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87291F000C4;
	Thu, 12 Nov 2026 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514608;
	bh=yFYOtU7CzdnDooEu/EsEIxu97UiTtht9yYO2t5Rtqng=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oUnzB5t0lYpH1YPMGFBkr6UCKYo9EDGrBXfP/aCmiIykHFWIEvPCNuLw88eSvhI/A
	 CJAmwqqpNvV5JL/t2j1n0NElRYyeqoJDbX/v54Z/bMnsX/VGVJhgxjL+jZAltM4Dhg
	 hrWBcTz6eB4Ss+ba0EnDo59U2TPCTmxMCkefx0HyrNqIKNQo8Ix2Frs4g4PvT8eMZA
	 7lIfJx0O0F7gubq1jCvkGfKqLKIdL2Mo5oQAmyLEdPbQeFM6EHpq02PNt9S3kK8sNt
	 tvFgpAY6ISL0hJtY3RJIzWl5xxbt6LSHZi4/rRkJBwEazYQt/DsjINIbCgTsnzEK1/
	 sSJOZN++3hJEw==
Message-ID: <sashiko-outbox-211787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-rdma: add a module parameter to disable T10-PI
 offload
To: "Stephane Thiell" <sthiell@hudson-trading.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261112194838.928882-1-sthiell@hudson-trading.com>
References: <20261112194838.928882-1-sthiell@hudson-trading.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:16:47 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvme-rdma: inaccurate commit message claim on PI namespace
  capacity
--

commit e90985fd114ef929dfa083aabec197dab7d0860a
Author: Stephane Thiell <sthiell@hudson-trading.com>

nvme-rdma: add a module parameter to disable T10-PI offload

This commit adds a pi_enable module parameter to nvme-rdma to allow
disabling T10-PI offload and avoiding integrity MR pool allocations on
RDMA devices that advertise IBK_INTEGRITY_HANDOVER.

>     Add a pi_enable module parameter. With pi_enable=3D0, pi_capable stays
>     false in nvme_rdma_configure_admin_queue() and the controller is set =
up
>     as on a device without integrity handover: max_integrity_segments is 0
>     and no integrity MR pool is allocated. As on such a device, a namespa=
ce
>     formatted with protection information is not usable (the core gives it
>     a capacity of 0).

[Severity: Low]
Is the commit message accurate about PI-formatted namespaces getting a
capacity of 0 when pi_enable=3D0?

nvme_rdma_ctrl_ops.flags sets NVME_F_METADATA_SUPPORTED unconditionally,
so nvme_configure_metadata() still populates head->pi_type and
head->pi_size when ctrl->max_integrity_segments is 0, and only omits
NVME_NS_METADATA_SUPPORTED from head->features:

drivers/nvme/host/core.c:nvme_init_integrity() {
	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
	    !(head->features & NVME_NS_METADATA_SUPPORTED))
		return nvme_ns_has_pi(head);

For a PI-formatted namespace where ms =3D=3D pi_size, nvme_ns_has_pi(head) =
is
true, so nvme_init_integrity() returns true and nvme_update_ns_info_block()
keeps the full namespace capacity (using NVME_RW_PRINFO_PRACT for
controller-side PI insert/strip), only zeroing capacity for metadata
namespaces where !nvme_ns_has_pi(head).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112194838.9288=
82-1-sthiell@hudson-trading.com?part=3D1

