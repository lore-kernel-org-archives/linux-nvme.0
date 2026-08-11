Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5661CC5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YBebGaS6RXhM61D29WQ4cYFpHJpKzuHDZtJvq1034I=; b=twjbQ75LGDdYS2SaxjQSckbzix
	JZaBAA7i7bxGtlTM8YcforclIC/ATpkTFehfXbLQz3x2DBahlcVL4HGd2GfjZzZCBh4AEhQG8Rjdq
	9yOe57mXITB3vLxAI9tupMs0zqHnUEYQjuGjuspGtyW8WIhzpsbm2LRoyAGgUFBEN+Sg92bR17jYZ
	Nwniz5Wkx4HR4o8CJAVqvyv+25Uxhl/bGK87PHJE47SzChtKP5shVOrZImqENor4Z6NbvgbmF4hga
	8tfpihEJC0wap9LG2Zf2ESGVaI7X4DPQqjN0oPmPUKHZvDkl0Miv/XXtpnKK8b/8WfRmboGfdSugN
	rB2gSinw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqFh-0000000EeTq-2akj;
	Tue, 11 Aug 2026 17:27:01 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqFb-0000000EeSP-2MJ9
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 17:27:00 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so146787a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 10:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469214; cv=none;
        d=google.com; s=arc-20260327;
        b=g2BRc2sy0OTv+zz4LgENOtqC11Uzob2OeX5WcpBBid9Iv6hMZ4/wpIxIEF9bTc476i
         3BCP65WqXadw9OwJ4LUtkw+CXbp578E8gRpgMvzTPfpT3tHv6vdZGp32j5MG1O+5dtrc
         eh3FsQ3I4kzIpa4Hebp2MjkXrgQ/YZU5781kSGGaJrGnq513yzJFfGCNFyFQRlepS+0s
         EGeUwpWQ3BTF8F6veptij8goG+SoqgB0l/y/0kCKnxMDI2+NfA9T5m6z1mNn7Z2FyR73
         Jf2C1IRDQ/BrLrw4MsTHMpHQBSskh6gpEmZRmUUT40j/OOEXIS9YgHHY7u4/nS29hQAN
         Vi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YBebGaS6RXhM61D29WQ4cYFpHJpKzuHDZtJvq1034I=;
        fh=EJJZjXeO4mTvJFbGUyhUl47dTrSHmwx4vV3+AUVKac8=;
        b=ml3nHrsiQ2UgElfZkHazr8Nwuk25Vv47sJAeWUzBcOdlgqiDrH8fXJj1Oi6fntBjGP
         mYvTNv3deur9ikMgfezrt3maN1VZDfN0eukoHnR86/9AkUOv+B1BXk0wdld1iSPic5by
         PBysRurTGCjPmhuV9yXmcn+BRTl0froG0ARyZqhYSo1h+WFliQxm1C6PUNnjdOv581zG
         iadDTPAPzVYSZIMpOj0T7Qao69F8U+hQi3Se1Da4iBENG5g5VedDFMVfI0WBDl8tYOk1
         uIQD9crdD6b8pjPIzf2M6BqIbSQvEXbJzK5jSytch1ukobICC4hquxMuviqa2dQt8Erf
         Ll2g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469214; x=1787074014; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4YBebGaS6RXhM61D29WQ4cYFpHJpKzuHDZtJvq1034I=;
        b=L4/eJsVeRcqyx80z0SZdjHqWQtOryqb1VGUq0BK8tiRq+c/2qkQXyvaBfEL7tCMRPB
         tUDJ8lSL5CSbMxQAogqFC8lpwX9OvtjXcM0sih+IwjYCZlJMxLMfN5WLMB6l/FfMH0bt
         QZ/HydwU3SuiugJ+hNcxtI3lr8J8XDXLXw6QNTDXOkA5QVkOqdg+7voRRjvTSKs7mo/m
         Ti4mFrwNjLyw96qZ2cBbwJjYpgdbiBCzYHfmZCqX0ED6MAwWLAvBogMUOBxYslAcHHla
         XVXD39iu71XY5Rs2sKKFDU6Z07yZ+VaHV3F+wx+XwDuJUzFCsxnOGELbeQq017Bnfm8Y
         4Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469214; x=1787074014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YBebGaS6RXhM61D29WQ4cYFpHJpKzuHDZtJvq1034I=;
        b=XI1aqLxo8pRlC4RnsjuT38qj9W19ow5rvKC3CrbMuCv+s31CN1HImNAHiPPFCzj3sN
         7ubj+t9w69hnYaqYHLj84M/U0SsiauITLZ9oIqKmXK2NkVN1eTty5NoehG/3qfCnPDwn
         NJE3XaEvzKnrXvL6rVsjlbjarE1lJXThyvuyjO3bLh6MrRJaYkeZimt9AlIH15ns3kRJ
         vdb3nYmEA12bw8S0Lj4tGq3Gi6ibw/FWJJzP2KQkw46Z51pYA+eBh5TOlSyMHGsuZWaW
         AmxLAEfsGNyreDQ2i42MAdR729ccXZqu6MbVnQJCnECFxMx5MKVpin9mPIqAsPZ5rjR5
         Hi3A==
X-Forwarded-Encrypted: i=1; AHgh+RqYgG7Na0/S1ZKWrggdsS3YUC6ngMFd+R52L4JUSgnycTtE33VDbwF02qkJ8DBvkxAZqhgxV+9Tbw5w@lists.infradead.org
X-Gm-Message-State: AOJu0Ywd9th/lX73tY6Cx7yimJ04GoBfnrUQfO7Y0SsxMRAp1IPGv3tl
	pPzE28V+BQulm6G92am+U7gAdBwOzg0aeuIhhYlkgofNC3SMlALvpNKpFY/yAShaY+rMjrL19zA
	RMyD3JBRKWP+S6F+ktvkPb+wcm8aHed4=
X-Gm-Gg: AR+sD11OGazC4uNk8I9AqPX4/rzJrYHoWeNNbvw0vvhbatLazZInGJWuPDhrLQuoKi3
	lsCpMXFAGGKDzBGFPBIcBGB2zqv+kWJ0NYEYamgZ+xno7g7IW/81eiZC+Lo+sAcEXKvJiDU0VfW
	B7hWbYwC18K+nRiUvtHqH2DFkH3cxaFw0Mvh8oOQKdhu4o+g+9i1Cbfs0jS5ZMu5D2lXZMvdjpz
	yfCFx6NBzaVn8fPzmLmfCTEOwr8SLS4Dxt6XT8QkB3Ais9VWomiBEfzmX8Uze66X3aR77T+fZX4
	WolMmBILJa7ZOD9z9egsBFSvtDs7O7saenisMn7SXhKs
X-Received: by 2002:a05:6402:52d5:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a36446fc67mr2635284a12.2.1786469213510; Tue, 11 Aug 2026
 10:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260810220258.1960208-1-coshi036@gmail.com> <antWsjQGe_C7YEi0@kbusch-mbp>
In-Reply-To: <antWsjQGe_C7YEi0@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Tue, 11 Aug 2026 13:26:42 -0400
X-Gm-Features: AUfX_mxPXwpdBNRro4VK-tTxLJfI98dc_or3YlYQm73MgbLoAh5DLqLcDmN5BMs
Message-ID: <CACd_6n0uPdZBiaVSFRGh+HovAR8G+EugNpUkm-BGhWLS3OMiKA@mail.gmail.com>
Subject: Re: [PATCH] nvme: ratelimit the completion-path messages driven by
 device data
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_102655_621347_2A1D3FF0 
X-CRM114-Status: GOOD (  16.66  )
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

Thank you so much! I will take care of the later patch submission; avoid
long lines. Appreciate!

On Tue, Aug 11, 2026 at 1:07=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Aug 10, 2026 at 06:02:58PM -0400, Chao Shi wrote:
> > nvme_find_rq() and nvme_handle_cqe() print an unratelimited message for
> > every completion queue entry whose command id does not resolve to an
> > in-flight request.  Both are reached from the completion interrupt path
> > (nvme_irq() -> nvme_poll_cq() -> nvme_handle_cqe()) and the decision to
> > print is made entirely from device-supplied data, so a controller that
> > posts a stream of bogus command ids drives unbounded printk from hard
> > interrupt context.
>
> Yeah, if a controller is so badly malfunctioning that only garbage is
> getting posted to the completion queues, then we don't really get any
> more information by dumping every single instance compared to rate
> limiting it. So applied to nvme-7.3, but with a minor fix to an overly
> long line.

