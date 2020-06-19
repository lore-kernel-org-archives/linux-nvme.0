Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E30C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DDB2073E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ecSQ20Nb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="aIc1plDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DDB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zdd6gMYg2od6RhK4NSBQqoKEPcThj4sYs03eCybDs/U=; b=ecSQ20NbjeL6CZ
	nOJk6YLByz9o28WhECUBqNwmlKf2TvyXYJ2KCVYcB4oclNv1XtOGZFK/m/L5UcSoqeeV97L/GoTA6
	zL9viaY0zokzCdMwL0khahQIceUBg4FBShGJ/D2vX1Tp36nInOnvN5HnjgqzEMSv+GPGHyvwMQYS3
	9DLpF6XdjKCzra/pB+4D8u9lwNkk5oR2WDExNiPrM/WIst4nXte6++6VZMi8uBEF3BHGKM2quhXpf
	NsuZ354TiRmGuUdZo79Pmi6rvb1L1ruI6oG+5MoMqUXf6VKXcgsGUs/l/6YnPz5osithjqvwGzbbF
	I4xVLF2j522abFD88U6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLZk-0000Ic-Jw; Fri, 19 Jun 2020 18:17:16 +0000
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLZi-0000Hs-5a
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:17:15 +0000
Received: by mail-oo1-xc42.google.com with SMTP id q188so2076121ooq.4
 for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2020 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oFpJ6ZnD/Pgv5lWZwwqonXTZ5IkiWh8cE8PCFs48Uzw=;
 b=aIc1plDnrB11OwqyijEs1WraBz2kBavSttIEINgUZfGky3FK/lmwteaWKmLTNOv2qn
 YwxqMKR4c9xJdMo4lidSYkQ2ST2DlLzahgfM9ncPF3/IQ4XJWWCjCxJnH5lfydXJzkIt
 VlOomebMyAqXs+agUDrgNiCYjUzCBE6nVYZAS2XBH9LkNNqfF5LtS2hxwN1OQeFDmE3C
 8Cn/vL0iNJp7UpY80pT/2dIVXN2RkQsUNBP56RzjWaclX/mLZiXq3dCvQooyz6YR7Qi2
 aeAWwUQSzxijHH/u3zL3vS35ihcWrGL9BFhdFP5O60S4fU1ckTr2gfjwabBZFQTwrm6/
 Y4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oFpJ6ZnD/Pgv5lWZwwqonXTZ5IkiWh8cE8PCFs48Uzw=;
 b=JDOPu3AGovkwHQTxWrDE5wXKaN6I7/ms6P6RGqXmCtxqJkyvymV1YbpYbvjzz67cZf
 MZDla6+hr9mVrPBOm96f6xheRmiIMv+5ypzT5iaK4ZvsOMfVBrmKmUAW6C7B2sdS7Nrg
 HHT+bNHzsmmLLvDT21Yvagfhg3Xi8sAdQMNJgBbwAl0+nyaUt5eMhXDzqLhRZU/aHiZq
 j9FZgJNW0H82/jgghOnhv7w/VJ6lH/MgfdPpFnl7iOeBpAR5EM79hXxPjji1xi17sGWD
 Bnm6ThUZGnv92IZ7Pc14CmUhPKbek5NqcKvAneYIo21fA/UmsT5avXUeJIV6b00+4Ek4
 rRoQ==
X-Gm-Message-State: AOAM533URQGtYb+InKVYqeil4KtriBf++5FRLfatygC2PS1QkjNffcQ4
 QYHlPNz0uP7YOhHzliVdxEFs3qcvTS7Xw2HGJ6kcZg==
X-Google-Smtp-Source: ABdhPJxcJwpu/6OGh4CKgU1K4xMWMqts74pwBx+f7gkrBT9pFKaQ4qd/Z3/v4cmksTNvYP5ZhWWjAJyRrpmeqO/LBWE=
X-Received: by 2002:a4a:94d1:: with SMTP id l17mr4382819ooi.88.1592590633144; 
 Fri, 19 Jun 2020 11:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Fri, 19 Jun 2020 11:17:02 -0700
Message-ID: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_111714_208081_38C6D3F4 
X-CRM114-Status: GOOD (  13.03  )
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
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
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

> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > Hi Matias,
> > no, I am rather saying that the Linux kernel has a deficit or at least
> > is not a good fit for ZNS because it cannot enforce in-order delivery.
>
> FYI, the nvme protocol can't even enforce in-order delivery, so calling
> out linux for this is a moot point.

How does it work in SPDK then? I had understood that SPDK supported
QD>1 for ZNS devices.
I am not saying that Linux is the only problem. The fact remains that
out of order delivery is not a good fit for an interface that requires
sequential writes.

>
> > The requirement of sequential writes basically imposes this
> > requirement. Append essentially a Linux specific fix on the ZNS level
> > and that enforcing ordering would be a cleaner way to enable QD>1.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
