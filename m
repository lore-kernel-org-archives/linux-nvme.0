Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81823CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86flm9aZ5oPXNsdE6v2ZP8BENVPrlcgYuTR/3Xpva7g=; b=JKJYq+XL8o33XrQuDd5/39XpnV
	LTO0sPrRd3pMOf9t7EYHyQ5nc4bwXFMAZ5uERTlKpxi3mbtz+jZ6TWjlc3l+WJcqKWPwLBbi3DOTX
	CYCISJxbeRtjL5R2SkILm1R9nHebeYC/9zFw4r9mdyRQT3VtOYSmfNpnUJ3Rwl7/2zoFX24T362MA
	HMMZb0xroMcJKsnKH0GTKfz5JMVffvztHbp1vilsnBGCnm8RKleyX19sntuvTWDIh5PNsCGibStlf
	xXWQHOfneqlwldfpynOvVf3VdJ4pi7CGEjGlpeBnVm8989yjcywRpyWr0ghlB/cX8SH3FNwJdc50D
	BvGtMHPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ42y-00000007zYO-2iNR;
	Thu, 21 May 2026 14:06:48 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ42v-00000007zXV-2uWS
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=86flm9aZ5oPXNs
	dE6v2ZP8BENVPrlcgYuTR/3Xpva7g=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=Wlmttyrl8hSVLFM1eFj3RZ/dH8JnEUjNobnSR
	L7MJRkxncKAb/Ad5aVVGOsDU6nnCc5lRSPPYKdmn6zlPgRFXNUAEKZANVhNlKow4p+LLkh
	jLyR+24xBcTNeSOaXXhuWoZIoJgLRlBd0fXzKtUlbedbyBGnvzhPftc8C3vHbf3Df2BDvn
	wx7wsODTsSb3P8f2hKzBSVulZ54QK87S034hzJr5FYAisleFbsgrKzfrtn4oY3yQF/ZAX3
	2jMM+xpJdmu80IRIaQAoqI1eoq/ERKoQF4oULumncL7h5A5E9Qx+XdXxxSmmn6IQk9K6Vf
	BgsDxMsCcwv/MvQeeHGspwP+w==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id b6ba7fe3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 16:06:43 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 16:06:43 +0200
Message-Id: <DIOEVH5LGWMH.CUY2SZ6KPT3Z@arkamax.eu>
Cc: <dwagner@suse.de>, <mkhalfella@purestorage.com>, <hare@kernel.org>,
 <hch@lst.de>, <mlombard@arkamax.eu>, <linux-nvme@lists.infradead.org>,
 <error27@gmail.com>
Subject: Re: [PATCH] nvme-core: fix unsigned comparison warning in
 nvme_wait_freeze_timeout
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260521122941.418049-1-mlombard@redhat.com>
 <ag8QFrW3UpMId4vX@kbusch-mbp>
In-Reply-To: <ag8QFrW3UpMId4vX@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_070646_058887_C80D5C4E 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu May 21, 2026 at 4:00 PM CEST, Keith Busch wrote:
> On Thu, May 21, 2026 at 02:29:40PM +0200, Maurizio Lombardi wrote:
>> The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
>> Checking if it is <=3D 0 triggers a compiler warning because an unsigned
>> variable can never be negative.
>>=20
>> Fix this warning by changing the condition to !timeout.
>>=20
>> blk_mq_freeze_queue_wait_timeout() is a wrapper for
>> wait_event_timeout() and the latter returns 0 or a positive value.
>
> It looks like it returns a signed value, but the conditions for which it
> may be < 0 currently don't apply since we're using the uninterruptable
> state. So looks fine, but I might feel more comfortable if we just used
> a signed type to match the API's return type.

No problem, let me submit a V2

Maurizio

