Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5C606D815
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K4XbMQdt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUleJuhJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=620L6OpJg0rFunGR+45S2dgQvOTc66Df7fjVGCvW9vA=; b=K4XbMQdtmXhxkITJi9Qtjf9uhP
	erVqBAQabtvWqSt7+UM/Kxziqv5aTW6VPEZveKTdPiK4V2ZborGWKTB5OV54LP4OexkTGfvYqTfaL
	rV/UUj53Sdb4WyO2o785T2nB/9C0bvU8QDdZm/sgu3bU+MTDysP4Qt9o4EU7yzoyX2ppP3+djUS6w
	5oEfnAvJT4dnqc1Ocr7gH5oaF7C0OSFKvbrCKBY3qHW69/lBdW5M6rdRr7qq916UbpJH+FSx+UbSK
	hScSQI0ezUsh8wWTlltPAAIOpG2BJ5MXXHAwz/VnAyVU2JKQpl3tKFgYVdoaRXn4VeYzSY3HB0H+e
	E65DDzLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQ5i-00000000uhX-3Rqd;
	Mon, 09 Nov 2026 14:11:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQ5g-00000000uh5-0rXQ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 14:11:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 676C6614AA;
	Mon,  9 Nov 2026 14:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1F91F0089F;
	Mon,  9 Nov 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794233479;
	bh=620L6OpJg0rFunGR+45S2dgQvOTc66Df7fjVGCvW9vA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MUleJuhJ1LQx4mPzS1b3L+9fHckd9dufyEvBm7HjLq5+J3NgWwmkS/+pNM+xpF7F+
	 ESIaaw7Ys6ibvi2GYLkxtuVkhieH5llXieS9/RJSw+VATX9TRKmNOlC2H3LCYSH+4L
	 Zt/EPmNX/hHR7oWAWD3fWJWUcsW1fguZiLa6sfd3/qNnY8j5fNHLx/kPauN7A+kWfk
	 ulqkt6pTg9YWo1JLdghfEh3UBFB1NtwbUi4KIiUpWf5J8HMDqcFeAcAKxQs8qf7m2e
	 NdeRAKBeXTRGrtrK5GPb7k0kiLeQ6kuHfp0BL85d/tMRWF2CsJNz3kBVb5YPH8KGcH
	 w5RP75XEU2p5Q==
Message-ID: <sashiko-outbox-205062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: reject invalid write-protect feature values
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
References: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:11:18 +0000
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
- [Low] nvmet: missing Fixes trailer for nvmet_set_feat_write_protect()
  regression
--

commit a435e948ad0b0443cd38d58e0a87dcc11c315ea6
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

> nvmet: reject invalid write-protect feature values
>
> The Set Features handler for namespace write protection currently
> accepts unsupported values. The default case in the write-protect
> switch leaves the status unchanged, causing the command to return
> success even though no valid setting was applied.
>
> Return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR for unsupported
> values. This also prevents issuing a namespace-change notification
> for an invalid request.
>
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

[Severity: Low]
Commit 3a1f7c79ae6d ("nvmet: make nvmet_find_namespace() req based") removed
the initial error status assignment in nvmet_set_feat_write_protect(),
leaving status set to 0 after nvmet_req_find_ns() succeeds.  Should this
include:

  Fixes: 3a1f7c79ae6d ("nvmet: make nvmet_find_namespace() req based")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135536.2772=
-1-sreekuttan2156239@gmail.com?part=3D1

