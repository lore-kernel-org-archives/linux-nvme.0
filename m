Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A0C10F14
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 12:05:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AFB222C2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 12:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uPR614eq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQQ/19UI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AFB222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1TrbGe5zeSoK8kveHHMlfKjmn22keOwSiC+iT1sHbvg=; b=uPR614eq70Mrsm
	uL8iZ0Ia4PSBLiAiLCK8XHIHCL2pmjzh071ROmwpTT5nf35XGDcrRx68uzxftC2BDjlb+aOsHhbhS
	/eAO92ki0/uAr2naPyrMwe9gavudBGLYnSfAFoC8AYxha9AeY4OhL4yAosQq/Iapa+nj77jtAs3D9
	nyda/6vx/JS8IwPW66R0mlMrdK1sZMkALShI6qBNZqt5++8IpC757R6TIwA4k9ew4OsBHsCmxm/m8
	1agGwWC5f7VkkkTVlfoFlpQnDHNsLThGh5XOBwPtGvCMwkWBLnmGyWq5UCzlNo1WMWa45I/hAAODk
	iWQmuBXwNd5Su+1LvVqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFzrQ-0005eu-A4; Thu, 03 Oct 2019 12:05:32 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFzrN-0005eT-Tg
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 12:05:31 +0000
Received: by mail-qk1-x741.google.com with SMTP id w2so2065161qkf.2
 for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2019 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+SA33MEmVikWzqcvO7ZglveqbdC4Bqr+Az02qJrwQpA=;
 b=IQQ/19UIyjQAiNDZK/ziahwgUeYZozpod0rrAA29xe3AW57A8wkk6kuNOdN6gmwPxf
 fQBM67pgtCLIBDYOEMqn953qQRdhxrXMBKKZYnc13gEtxBQ+OoS0kyrpmwsooqwFj+L3
 yPHW5btb7YPhSez38WMhps6BmEoSBcaKtu1373AQB1FHv3I3UQxvHIEUeBFq2Ps2qt+D
 K+v+ZJNUId9g2wzInKjpH/Si0oMS+w4qxqIU1ZdGnNUp2vevgdFUG364+O1rP2qxQXzk
 B6vtcCQkZaQvQgpfdiC7jREFaVW1JIGzUsmLV++SouF4xg8Zd2ZalPtApnUV+Gef8u1o
 bO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+SA33MEmVikWzqcvO7ZglveqbdC4Bqr+Az02qJrwQpA=;
 b=FWDADln1+lvIdECyPkXA6k5Jw3KZMVqUyI9T1DxEdl1ZpSw414t5Dl1WtWq+nqowuj
 KKn670tBm8jdcdylH9JrItSD0A5CrAPzwCJYZKr18aL8RCYrzQN4luO00eWlDPjwiohB
 KAFr912IG93bePxlZ3oshVCFmbDlH5IMOJsNH7KtC5d9ytABBSJZPz+wgkV/YvFbWay5
 5Uzja7CBGpkJUSO6Ci1tlJzdEYBSbuYcIs57tgVhJygYhuAOnKdtQq5zNARBtBYsjaRc
 4IkOELqj6sf4zupKJB93loSQb7x8Q3fDgLY6U0JHkPkflGWYYGi07IVDqRSmOHkMj5hi
 x7rA==
X-Gm-Message-State: APjAAAVF7tWfF/ooEbKqGOnMZKNG0oZTRT5qoaf9vnfL00PvC5hf39ut
 ZyHfY5zbowAaiQCX2ZOHcE02uTnZm2bIBO2/7j2MfQ==
X-Google-Smtp-Source: APXvYqydcu9YazwWY6KkgPb4R9zDLEGYMVBDPu28bXj7TYByTE8QK9Ynqy7V79ePXCjsR6M2TfAyUVZM1o2ACbKNdiU=
X-Received: by 2002:a37:4b43:: with SMTP id y64mr3725372qka.139.1570104328832; 
 Thu, 03 Oct 2019 05:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
 <20191003114901.GA34459@C02WT3WMHTD6.fritz.box>
 <CAKv+Gu_YCRwvtc=QSu0V2i1GESxHv9ndkqe0cyJsDaL6LQATDw@mail.gmail.com>
 <20191003120325.GB34459@C02WT3WMHTD6.fritz.box>
In-Reply-To: <20191003120325.GB34459@C02WT3WMHTD6.fritz.box>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 3 Oct 2019 14:05:17 +0200
Message-ID: <CAKv+Gu_5MWeNVq2NePnTcLcGvYgJS-cZ7BRf11rBt+iLhdW0-w@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: retain split access workaround for capability
 reads
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191003_050529_961806_2E986B22 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 3 Oct 2019 at 14:03, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Oct 03, 2019 at 01:51:03PM +0200, Ard Biesheuvel wrote:
> > On Thu, 3 Oct 2019 at 13:49, Keith Busch <kbusch@kernel.org> wrote:
> > > On Wed, Oct 02, 2019 at 09:36:43AM +0200, Ard Biesheuvel wrote:
> > > > Broken since v5.3, so if this gets fixed one way or the other, please
> > > > add cc: stable.
> > >
> > > Since 5.3?! 'git blame' says the code has been this way since 7fd8930f26be4,
> > > which was from 2015 during the 4.4 development cycle.
> > >
> >
> > That may be true, but the box in question happily boots a v5.2 kernel.
>
> Looks like your observation was introduced with c0f2f45be2976abe.

Indeed. The corrupted read produces a bogus minimum page size, and the
driver gives up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
