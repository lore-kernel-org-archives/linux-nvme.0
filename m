Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D6606A32A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aiedm3zw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apjq2JG/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f5xGu54rQz0r5NybvgvaFdtIN9Imw37xQ47oWWlDE/s=; b=aiedm3zwsU229n9pDv5RDgbb5j
	k/jkatJfahRyryT1pqCCz9lKHZyVORuiZCGBLtuZ8NEk5Bw3Rx3rsG8jAdY0uTDiuxOOKDDUHelfO
	Q1FFEWPUTl1zp0lkn9RzzbBVeubkNSj9yvzuOOsjOBQhqehcYtspXS4Xj1yp0H/Q6iW/wSuFz6OKG
	WBDFmPU/ybJsnqLKJai/wrPrnmq2Gxpj1GpvInRYHSIrr5Ze1bbZ7DkgZTdTSrs4DTvFnrGSomY4S
	oiDPHgzcHK6xYCisByEqUqp781oaYpvsMfkCzfnR7k12dGD0xe5rLYjxzDItXL0O+JU+xp7hAP2nn
	J9RDQheA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQFAX-0000000H8Lr-04RR;
	Mon, 09 Nov 2026 02:31:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQFAW-0000000H8LZ-0f7l
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:31:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 806FE4077B;
	Mon,  9 Nov 2026 02:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4605B1F0089F;
	Mon,  9 Nov 2026 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794191495;
	bh=f5xGu54rQz0r5NybvgvaFdtIN9Imw37xQ47oWWlDE/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Apjq2JG/Dn4kr4PWV+k3oLC57+kVurg1yqwIDtcLVnxcHzfG5nWbMJsL2Uf+b2EFk
	 4uoCr4p+9J/9MU/Ayvz1OHwDhHFXmavWchgzpDafDRdKHRXw2+Fa7ovgf8UE5Jye9K
	 P0DQ1mDLHSG8nHX3HMeV+F59MLErXNoAvVZ4ltYoLxeuPwghCwtAymVM3cZKEPisuC
	 mBy7qi5LWLdKOZeIDTOK3TKD+KE8PpfnSVpJZDw+5NKyE8yHURKrIGLlmMtrB5Mii7
	 ga+NrDiHhRFfqEQNB/TJh9+6qSoK8dQ5w3t1U52enkPzSS0D1ddqM+DowfhrEUy+IJ
	 NbpBHgMHScKIA==
Message-ID: <sashiko-outbox-204348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] nvme-auth: fix data race on ctrl->transaction
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109022646.290792-4-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
 <20261109022646.290792-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 02:31:34 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvme-auth: missing Fixes trailer for ctrl->transaction data race
  fix
--

commit 80e147df824d3b130d9f9eca4a6cd6ae6f4b0f78
Author: Guixin Liu <kanie@linux.alibaba.com>

> nvme-auth: fix data race on ctrl->transaction
>
> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
> on nvme-auth-wq without waiting for them, so multiple
> nvme_queue_auth_work() instances run concurrently and all increment
> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
> data race, and the lost updates hand the same transaction id to
> concurrent queues.
>
> The controller side only echoes the transaction id within a queue, so
> the race has no functional impact today, but the increment is still
> unsynchronized and KCSAN reports it. Use atomic_inc_return(); the
> first transaction id is now 1 instead of 0, which is immaterial as
> the controller only echoes the id within a queue.
>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

[Severity: Low]
Since this fixes the unsynchronized increment of ctrl->transaction across
concurrent per-queue authentication work items, should the commit message
include:

  Fixes: f50fff73d620 ("nvme: implement In-Band authentication")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109022646.2907=
92-1-kanie@linux.alibaba.com?part=3D3

