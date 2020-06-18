Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD130C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEF62100A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dr4nuV+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="hm5PPa7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF62100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NreBQ01UFmwdZfwxQ2rn6M6LHIUy/MWijbGgjgGVHYg=; b=dr4nuV+FXpeB5t
	owJvSOY87LR+f/aMv5Dpph+e6xaH/bwSqvcv5NaULJfiny2le9A3AE1a3Ft9qTz/nn/cZZrJ4gSZ6
	LswkBORQxrnm1SJ0VDLJMGbGw421kk+/H6OQRIsNFcMB2BW9vBldZomcebbEdqsuPAHGWFo0c5PIJ
	FlKWdtNeFSgZYUz1EmAkZQtSUls4yp+vlRT0mdg1Rf9RoEu0FvN+z1MmMsY86n1KOK1Vl8V1JGX4W
	n/KR17N36ElCd1o24m0celAW184rP2cXeiQGzrf9TcHXdXupXqWFN/2LzmFzETgYUXJOVEK//WLfm
	DimHxNA+wb06dkFc0CDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlm66-0002Y9-OE; Thu, 18 Jun 2020 04:24:18 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlm64-0002Xk-6A
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 04:24:17 +0000
Received: by mail-oi1-x243.google.com with SMTP id j189so3871404oih.10
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cOsrVVpLSM50tEJi2S8kutSfV6ieFvtbO8gT5T6dr88=;
 b=hm5PPa7t61uEa4ETyg7rmAQTRPGK9AdbEETgiEil+YMBlym65FfHyT2Gwzv2cUwpWf
 9oPcKTOew1zP9ZLah/CCYWWHxzYJnvzJVP1mtZmorqhFhsCuc1Pa8prBGAzV1Bn9cSj6
 zc2XF7IwvN31Ao4wwOZDNTCM4c7l9qS2YkmuYIhh2DkkgshL43beCK3AQtjBEMgYh2Ur
 WCoBVqBm/dIuCwDoBbpwEB4TJ0UAJogQCSZ0GuF0QJoqjfq1YtbIDtAfnkK5PzEqUSuk
 nDZM6rAIAf+SPM8XLFH/8O1gIoB9XHhxShlwyemp5Ncr0RsUY1n1HUKvkqqnDrtnuWQF
 f2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cOsrVVpLSM50tEJi2S8kutSfV6ieFvtbO8gT5T6dr88=;
 b=bzAMSIurvPkCOtAlotJxqxLnMWhRRAT7fBNkgZ2oqgbxTkuabo8sbFHhsP+CjA2v07
 8dRtjQkui3jzMbzpmijYkTuBAPW4VE7xQPdo6hEPTwVbBtlB23gSmSzNmV0r2B3cm3Wx
 8a8OMKSbjYDRVguwJbjH7a1GgaeFIxi8cExAFIXc4JMoQEN2+uiR0jel+CAeiyFjOGoq
 aP439FODTYG4/y6hBAr6QrcUwqKAGXgpK6ElxW1K4aYsnpJ7AJKKAbIH1veFqLDutt3Z
 B6d7VAXlEOJVuY5GOW4Kodn2omqVLAXk5kO+7WLx8j9MgXwIplzez5q0VzcO+tXwKm0A
 3tVA==
X-Gm-Message-State: AOAM533K2y6yX28fPPGvfTf7LIiUToFcozZg++UE6LHwiYVhlub6MNkn
 /BohCqiUoxnIz1ra/bAFKpdzub3MMz4TPBk3OuObRQ==
X-Google-Smtp-Source: ABdhPJyAROsCPZIxK2iGphL388L2akjXMocUivha9hTp78r5rL5IsXCma76dskLFmk8HFP/iOJIbQd+pbJ62FWZcuCc=
X-Received: by 2002:aca:d15:: with SMTP id 21mr1467624oin.41.1592454254725;
 Wed, 17 Jun 2020 21:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Wed, 17 Jun 2020 21:24:03 -0700
Message-ID: <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_212416_287664_40C95573 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

What is the purpose of making zones larger than the erase block size
of flash? And why are large writes fundamentally unreasonable?

I don't see why it should be a fundamental problem for e.g. RocksDB to
issue single zone-sized writes (whatever the zone size is because
RocksDB needs to cope with it). The write buffer exists as a level in
DRAM anyways and increasing write latency will not matter either.

On Wed, Jun 17, 2020 at 6:55 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Jun 17, 2020 at 04:44:23PM -0700, Heiner Litz wrote:
> > Mandating zone-sized writes would address all problems with ease and
> > reduce request rate and overheads in the kernel.
>
> Yikes, no. Typical zone sizes are much to large for that to be
> reasonable.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
