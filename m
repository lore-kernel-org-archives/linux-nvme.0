Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fT4kfHBd0/oRv2uFCKoqenVhcKchfeKcVMd89ZZ/UXk=; b=i4deG8aWYD6X8LC9zUp0+9zxa+
	R28chuaWakJSVFefBMpT205Ta5mUfFfiqYKDtiv9QTNe99PPOz39fI2IMSRGkiMhL0ikwLf9P7yQf
	8L6vcyQwhl4PjSu55mBzkuXpVq6+3Ezwton55qygNWqZsC2o+8UUJCSEA2DtczHaqBHmdJhx1eVbW
	SNmVrLEOFvGIidD8LLEYK2S3EJ69kBP5An0LSn/B+Qd886+kVBHd3JMMwXt7dYo5YmyJvM0MnWxrS
	KRpsnJhCCPxrk9/OKU5mKsR1wF+85qfmkjgX2APgku8OvysE+R5LsAHDjo+BWltiJcwk4E9toTpvA
	ESzZxd8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzDrB-000OGu-4C; Thu, 09 Jun 2022 08:49:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzDca-000HIO-SF
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 08:34:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 434816173A
	for <linux-nvme@lists.infradead.org>; Thu,  9 Jun 2022 08:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D0EC3411E
	for <linux-nvme@lists.infradead.org>; Thu,  9 Jun 2022 08:34:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oS5vlGJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1654763664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fT4kfHBd0/oRv2uFCKoqenVhcKchfeKcVMd89ZZ/UXk=;
	b=oS5vlGJcnsJeIcskWfzosweRKFkVlmspV4/ddozWtEzmxCJVCBcGuGPBxNJCJMybGGyYSA
	OEgAmfNGJpK9pgkeLYvMVWw4PcQo7zkBNrhIVTKlFs189n8270LLPzwv91b2Tq5uE/Y5aX
	R7DQZbE98rrydpJxsRFCiHgwldW8o4g=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 067cde6f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
	for <linux-nvme@lists.infradead.org>;
	Thu, 9 Jun 2022 08:34:24 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id e184so40575816ybf.8
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 01:34:23 -0700 (PDT)
X-Gm-Message-State: AOAM5307CxZ4DlgFAqtuO+6y44Sq+NzenmCkPIKlp1cAZW8983OqrQV4
	B7lo31skP5lxs2NrwKtxmffaUMghPl3Pe4+15iY=
X-Google-Smtp-Source: ABdhPJz3a/TKVZt91DBhUMtZf39JYzLb6AW4mDoaRwyNprXq2pSTTWw2Z7U+Bg3Vly+mCd2t2kb2i1Ht7bFjR931Z2s=
X-Received: by 2002:a25:bf85:0:b0:64a:422c:24e7 with SMTP id
 l5-20020a25bf85000000b0064a422c24e7mr38705591ybk.637.1654763662531; Thu, 09
 Jun 2022 01:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
In-Reply-To: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 9 Jun 2022 10:34:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
Message-ID: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
To: monish.kumar.r@intel.com
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	alan.adamson@oracle.com, LKML <linux-kernel@vger.kernel.org>, 
	Yi Zhang <yi.zhang@redhat.com>, Keith Busch <kbusch@kernel.org>, axboe@fb.com, 
	Christoph Hellwig <hch@lst.de>, abhijeet.rao@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_013429_011096_6516896D 
X-CRM114-Status: GOOD (  13.03  )
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

Hey again,

Figured it out. 2.3 seconds to be exact... It looks like this is caused by:

bc360b0b1611 ("nvme-pci: add quirks for Samsung X5 SSDs")
https://lore.kernel.org/all/20220316075449.18906-1-monish.kumar.r@intel.com/

This commit doesn't have any justification and got applied without
much discussion. Perhaps Monish could supply some more info about why
this is needed here? FTR, I have no issues on my system when reverting
that. Perhaps it should be reverted. (I can send a revert commit for
that if necessary.)

Looking further, however, the PCIe ID is said to be for a "Samsung
X5", which Google says is a portable thunderbolt drive. Is the PCIe ID
correct? On my system, this is the PCIe ID of a Samsung 970 EVO Plus.
Is it possible that Monish copied and pasted the wrong PCIe ID? Or has
Samsung *reused* the same PCIe ID on both devices? In which case, we'd
need some additional data for that quirk to avoid the delay.

Also note that this (potentially errant) commit has been backported to stable.

Jason

