Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF5C47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 13:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B02064A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxEZAPw4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJMxKm82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3J0JWiRlExRaCyt1sL4q5D3kK0ZHLxWzioR6MEc2xDQ=; b=FxEZAPw4w6Qgl+
	5zc18ln2YwszdSag9k+XLMSdqVoQIRNIi5GpEWWA5RBhGmFr7MDQxqAUx/V0RXmLn3eJHROnYmb5T
	RCzid4CY3wUdUz378vuBJB7tQv8b2ZiVT7snl4XooYlS9B7JFLPfcMhYm9jWGMyb/Wo/GV4uwrqWd
	vzNV7RgFbfe2V1AD19sb27JPvnioiwu5feMFNPerOXrdugS48dgx37QYC2AeYKdO+1HTzAYvOO4Nr
	R0rXpQLjlC0pH75GwCK721GpHm3autMLpA6PU5pejcxYENBMJ03VL3lr/dTkAHj+VOMQH0aUXYR1t
	puFF8MsOQwY6B0yauRMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHT8Y-0003RE-5S; Mon, 07 Oct 2019 13:33:18 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHT8W-0003Qf-09
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 13:33:17 +0000
Received: by mail-wm1-x341.google.com with SMTP id 5so12728103wmg.0
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFU4OIs9F/yLqrMYUVlxWw6pgEIiuopLhBmOu5Fuqow=;
 b=qJMxKm82zJH+izlm+bErCorazyH1pDxROWehENDXYJsBxpKfVXoeRMjyYMJIWTw/h2
 dr5lB9uPCcgKTUIUAS7DsHnkSEtOmxvZO2d2e1h0G5TucMvzRwyxw27miVm+49ezInn8
 qfwbTJkRNEYI9FJrw7z9fzObSG/m5FBQdKI+QYhUeb20ti7zJiYdtucxhG55VucSADxn
 1MLBccxNr3lLw78Gb9CfUZSRvkMRHtzsF2sCnMfLk8i4GWfVFper5bubQb5vMxugM1+B
 dJP8tukocNAr2lv6tpG8vePoNFpUzUPmlgKPdbJtbPu3BIxwNwQMSRHtquQK9QVUcRvp
 F0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFU4OIs9F/yLqrMYUVlxWw6pgEIiuopLhBmOu5Fuqow=;
 b=nR9D6G6Y2ZP7I2/whCmsu0gPVzF1y6L7JsTrh6iHqIWPrKxST/TQAv25b+5/rW3Rl4
 2BKi9Hi95X6ipizN7Mvxhyb8v6Jarf0b2ykPnxJcTB4CC/2PFnCLWEtFLG+AXDLJFEB6
 Nd9O72iWqQuL2qjZ1JMndG+SKcaqdxoaQOVPIMkJx1xFR8ZgICO/Lm+3pAT5jktn3rRn
 FCek7E3D+SVnvs4T2LXR9AUzOG4fV5zwR/Xk0/8+A7yUnHDa7GIihEo1fY6r43gxum5+
 6yKeVG1WJQRpyCfSD6VcAtQ8EFiHy4/9T0vffB60BqAW/l0h6qMeAHrHzVf5bqG9s2MU
 LyEQ==
X-Gm-Message-State: APjAAAXkmn9WvY0EgBxbm2VdNvsU+hziQS2tPIdpYeYqWUSnkmQTZdTi
 7S5gwUREQAqMdBsZC3SnFUmpwz4ZL2LKpEHXH+romw==
X-Google-Smtp-Source: APXvYqzncV6XQ6Dd9EawJUjJzIzJE9cfUCSVKW2n6gn77HQ6QKscHpWsEQSHolc4+ze5cvd7EbutVgVZldhCg4lqajM=
X-Received: by 2002:a1c:3cc3:: with SMTP id
 j186mr19449123wma.119.1570455194493; 
 Mon, 07 Oct 2019 06:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191007114253.30735-1-ard.biesheuvel@linaro.org>
 <20191007120721.GA21060@lst.de>
 <CAKv+Gu_mYpopYMCiq=TqHBkzZoRLJD_0Xi8J0GB8+sCHJSmK9A@mail.gmail.com>
 <20191007122738.GA24804@lst.de>
 <CAKv+Gu8cyR6Wcp4bSy4iDs0ALfzvOBwNmqx-_SbiPwwSGSFZVA@mail.gmail.com>
 <20191007124843.GA53339@C02WT3WMHTD6>
 <CAKv+Gu-2yBVx2sh1wZ4d8+eJ8ffc44be86=FNt6K4euh+J1+OA@mail.gmail.com>
 <20191007133227.GA54763@C02WT3WMHTD6>
In-Reply-To: <20191007133227.GA54763@C02WT3WMHTD6>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 7 Oct 2019 15:33:03 +0200
Message-ID: <CAKv+Gu-=a+Rrkg1KSj3jhY=JkHMzKMoJ-hg2bk58i-E4LhKUBQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: retain split access workaround for capability
 reads
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_063316_051630_07635C23 
X-CRM114-Status: GOOD (  15.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 7 Oct 2019 at 15:32, Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Oct 07, 2019 at 03:20:11PM +0200, Ard Biesheuvel wrote:
> > On Mon, 7 Oct 2019 at 14:48, Keith Busch <kbusch@kernel.org> wrote:
> > > If you explain this patch by saying it's to fix a host controller, then the
> > > patch is no longer sufficient on it's own and should be fixed elsewhere,
> > > perhaps by providing a special pci_ops structure for your controller.
> >
> > Fair enough. Any suggestions for the wording of the comment?
>
> Something like this for the changelog:
>
>   Subject: nvme/pci: Split 8-byte reads
>
>   The nvme pci driver had split 8-byte register reads using lo_hi_readq() due to
>   nvme controllers that do not support that sized access. This behavior was
>   inadvertently changed to readq(), which may break those controllers. Restore
>   the previous behavior.
>
>   Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
>
> And the comment:
>
>         /*
>          * Split the 8-byte read into two 4-byte reads since all controllers
>          * support 4 byte register reads, but some do not support the larger
>          * access size.
>          */

Thanks Keith.

I'll respin with that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
