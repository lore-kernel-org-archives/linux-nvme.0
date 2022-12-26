Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F8C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Dec 2022 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nBctsEZLpgk0fs4haMIew4JBms6I8ZKU+t+ZPKxEChE=; b=uvFCf7OwzTumCvhEWYZyn8L9Ul
	wLu9py1Cxdv7qtGsgNRGoYsOvTZYiirMRvknThRybWEGQ0AzzJ7SbNCiAp8hg0PncbDwvx+T8RSJV
	B03O9FFxGhB1gS0tcBifaakYY6h99r6XSOxpRNUbote8EC9F6+j0YeNfD88eaKJ0FfzF2E0eqDZjL
	Vu5KW0OrD1RdjiGo2IcXHNhuZk+XcrzXGaForint0vYIYjxigxniNS5iinrslyT3sklOIiwXKU7HD
	3R0ZvwvzPSh0NXtbqcklE/IRKWM+qHzBAZ1CHP63cMjylgMoXm8dszFkhW5miBlvmsV7yl5SJbNcA
	hLGn707A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9ssy-006afi-8k; Mon, 26 Dec 2022 19:11:44 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9sst-006aao-Oc
	for linux-nvme@lists.infradead.org; Mon, 26 Dec 2022 19:11:41 +0000
Received: by mail-qt1-x836.google.com with SMTP id jr11so9027714qtb.7
        for <linux-nvme@lists.infradead.org>; Mon, 26 Dec 2022 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBctsEZLpgk0fs4haMIew4JBms6I8ZKU+t+ZPKxEChE=;
        b=jFDeeXUuZ+8+aD51uBR9qcze9EJAB0MyZvPamd5k/lSWWYG+MiljcJFneCosq6HKOQ
         3kv2BV0MHGo31Sh7yBnAcTloFCzyUYJp0tGvpwyC+/Xm5yKvwOOy6l3X/F5nGEBG883E
         W7wakf1BVHtGaw8QpfEHIxiBYksAZOnQnShkaHHB8aFYPKnMgEXPDbnJao8HHbUA+eKM
         4jHaVOEvNMhTD83xpvy+oXVE3EgLdP/JXYsRl4UkfadEG+IDsDMLXU0B9IgbTKVv0DM5
         lEYZLal0oCCsd+KYOhVRI4gdIWcmQo2f6fuIDWkAF2O2PCP0iaTqDoecS3t1368nBfna
         XS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBctsEZLpgk0fs4haMIew4JBms6I8ZKU+t+ZPKxEChE=;
        b=DjMAvMVy8zNRPTGX5G2Z70o66IAvNIy2ffegZyLbOkZXlX22ewrPSnYtZ5vzEbypAd
         j5/DVjvrq+FHaAuOf2gUD8ySAKS3QufUfgV8zImkE32loS2YA+UrB3JFgsWYoxyUAolA
         ZbiOwSTLb7bINl4r3AcP5krXBkAXO6t3lmRbtBzlUwJSdfQq8VSHHuWEXhJj2/OKFoX8
         1+aMYZ/DuqXoCI5SuqU7NZOn9AdGCnWHzjACv5ANuEil3+H7jF+axtX95inGWnT0m3Ys
         Np+8grPLfs2qHpzluh+FVsppudZE7CCFw22EubUvUmpADpc/OFjp2MUjjuSFziqM+g6X
         24Qg==
X-Gm-Message-State: AFqh2kpIJKS+DmLZK3HpM+S/WN3E3/0sorareTMcATCWa1xz+/gS0aQJ
	kIYqtN34+2KCCwLAVsSHkZ4/Wg==
X-Google-Smtp-Source: AMrXdXtCOME/yjE82H+CBWAo+4DqKwsqHhzAssMXIZm/Zy/lT367X2i0Q3ZsEkymrcEgWV8KryQsLg==
X-Received: by 2002:ac8:44cf:0:b0:39c:fdb3:a215 with SMTP id b15-20020ac844cf000000b0039cfdb3a215mr6311185qto.6.1672081893017;
        Mon, 26 Dec 2022 11:11:33 -0800 (PST)
Received: from [127.0.0.1] ([216.250.210.0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006cbc6e1478csm8145190qko.57.2022.12.26.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 11:11:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20221225103234.226794-1-hch@lst.de>
References: <20221225103234.226794-1-hch@lst.de>
Subject: Re: (subset) fix nvme sqsize on off regression
Message-Id: <167208189004.23141.7632996379426634411.b4-ty@kernel.dk>
Date: Mon, 26 Dec 2022 12:11:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-05166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221226_111140_093461_F36C3633 
X-CRM114-Status: GOOD (  12.30  )
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


On Sun, 25 Dec 2022 11:32:30 +0100, Christoph Hellwig wrote:
> this series fixes up the sqsize regression that Hugh reported.  The first
> two patches are the real fixes, and it might make sense if Linus just
> picks them directly before -rc1.  The other two just clean things up a
> bit to avoid pitfalls like this in the future.
> 
> Diffstat:
>  apple.c   |    3 +--
>  core.c    |   21 ++++++++++++++++++---
>  fabrics.c |    2 +-
>  fc.c      |   12 ++++++------
>  pci.c     |   27 ++++++++++++---------------
>  rdma.c    |   23 +++++++++++------------
>  tcp.c     |   12 ++++++------
>  7 files changed, 55 insertions(+), 45 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] nvme: fix setting the queue depth in nvme_alloc_io_tag_set
      commit: 33b93727ce90c8db916fb071ed13e90106339754
[2/4] nvme-pci: update sqsize when adjusting the queue depth
      commit: 88d356ca41ba1c3effc2d4208dfbd4392f58cd6d

Best regards,
-- 
Jens Axboe



