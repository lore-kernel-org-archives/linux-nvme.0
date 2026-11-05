Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC1606A336
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IfqEdr2J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1v0baM6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ap+IuNKaV27yTvPU9tyRnSjO/M66H8PyaAZ8nUSldLY=; b=IfqEdr2J36naQQEl3CQjQ2GWDm
	EbLgLbGafyff7IGG8iR3UItx+ail8/0Vw9yBFbGZ2Q0WJbcg20mwEQFpUkn9I1Lwk9hRZzvQZrkqd
	qNpiCQQEVHLY9fkiMrz6QWeYo2btjCC5U4BnuL3Ih3x7dG7waaD2n5BgojibESFGut8Va9caT+bnu
	WAmhvrzsJ0P1RMMEr1H0M1eoDXKn9HBS+OB2F1ooyTLWGJNPiPpqJPXeDfm4ukMdxY1lvFp7bljJv
	Csu9B38vhxPnMaAqA33wit0s7tuXsUJ49PSywVwqz2SzuaBC8PtWVsgUbtCAbW4wsF05pVn4QJL4A
	j5AgyHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP32d-0000000AJeP-3gjP;
	Thu, 05 Nov 2026 19:22:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP32c-0000000AJe8-1HPO
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:22:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC187439FF;
	Thu,  5 Nov 2026 19:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC561F000C1;
	Thu,  5 Nov 2026 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906549;
	bh=ap+IuNKaV27yTvPU9tyRnSjO/M66H8PyaAZ8nUSldLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=V1v0baM6V0JpIKN5PRm0nfTeyBsovrDFzOEsoo0uuDU7JIBfDKVvd5qX+iYI6tvnT
	 5ROziPiolrjnRMBEwQk8Hjr4oZEEePJ1QBartajR8U1YySsH3Tod0T3mPdaUoCfMCp
	 e/pGb2iah/QjNEyUBOCUFrdSmYM2PFER7xGXaE3D1JxAXc7Aol0bAqj+ret86PGYy1
	 WL+n4fkHPUVS070pMUSKteWcrOYPvcj4pFIZ3s5T0ddvgTZHD5IJnJoC/XorlCZhX4
	 odmecUHQU+PN6wCZqeTtfCQC16L37JAX7SB3z6oc5sa33hHdIRNke7HV7zK5UfzKwd
	 w5yE7lEsOglFQ==
Date: Thu, 5 Nov 2026 13:22:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?5buW54WK?= <liaoxuan@open-hieco.net>
Cc: kbusch <kbusch@kernel.org>, axboe <axboe@kernel.dk>, hch <hch@lst.de>,
	sagi <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	default avatarZheng Tan <tanzheng@kylinos.cn>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVEM=?= =?utf-8?Q?H?= 1/3] nvme: Add
 adaptive PCIe link rate switching function
Message-ID: <20261105192228.GA1550766@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5453bf57-fd19-458b-a723-bc7ab99c2479.liaoxuan@open-hieco.net>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 02:30:13PM +0800, 廖煊 wrote:
> Hi Bjorn,
> Thank you for the review and for the question.
> 
> The reason for restricting this feature to Hygon platforms is that the
> PCIe link retraining time varies across different CPU platforms.
> 
> In this patch, the I/O threshold for downgrading/upgrading the link rate
> is derived based on this retraining time. Currently, it is hardcoded as
> 100us in nvme_calc_speed_threshold(), which is the validated value for
> Hygon. Since we have only verified this timing parameter on Hygon platforms,
> we added the restriction to avoid potential performance regressions on
> other platforms where the retraining time might be different.

Seems suspect to hard-code platform parameters like this, but if you
must, at least add a comment to the effect that this depends on the
platform and the current value is for platform X.

