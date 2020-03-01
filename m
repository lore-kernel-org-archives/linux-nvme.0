Return-Path: <SRS0=isN7=4S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16452C3F2CE
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 09:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B380A214DB
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BYXdMZm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PkLoINL8iRUkIvd60VotzcK3be5Iode/O+X7XYhjgas=; b=BYXdMZm9T0AD/O
	QdMujws4DXgps135LjHZpOQOjIIGFX2FQkGIXEDjyQ//Eazs21jr9qgQfDAETXZ1ct/b/Rl2ftd3S
	8+5TaT5krAJrNVR8JbQYk1NuSFT9R1uTRMAV9sedHTPLuonKb7v0JRRFLbnU+pctnTFiaodc2Bq9W
	CqII6mXRl8+H2bZW7KQbPmddhVkHka5WFYv54ylUQmQcOPMYcI8O+/qa8roRxqUJCq1Ys8RstOeCL
	NUm269PaFXm+1ygtZBX/oGNjLP3ck7p9LeUr50GBeXdN+Qq5jXJZXdxG1vbUQQ9fQHtfPK1r9gVHr
	68dROg1o6unIf6x0gaDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8KV3-00045Z-KJ; Sun, 01 Mar 2020 09:03:01 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8KV0-00044x-72
 for linux-nvme@lists.infradead.org; Sun, 01 Mar 2020 09:02:59 +0000
X-Originating-IP: 172.58.43.63
Received: from localhost (unknown [172.58.43.63])
 (Authenticated sender: josh@joshtriplett.org)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9D74920006;
 Sun,  1 Mar 2020 09:02:43 +0000 (UTC)
Date: Sun, 1 Mar 2020 01:02:39 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200301090239.GC216567@localhost>
References: <20200229025228.GA203607@localhost>
 <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_010258_389950_DDFA1220 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 01, 2020 at 02:01:05AM +0000, Chaitanya Kulkarni wrote:
> Nit:- please have a look at the patch subject line and make
> sure it is not exceeding the required length.

Documentation/process/submitting-patches.rst says "no more than 70-75
characters,", and the summary here is 61. Checkpatch similarly says 75.
Is there somewhere I missed that gives a different number?

> One question though, have you seen similar kind of performance 
> improvements when system is booted ?

I tested with nvme compiled in, both with one NVMe device and two NVMe
devices, and in both cases it provided a *substantial* speedup. I didn't
test nvme compiled as a module, but in general I'd expect that if you're
trying to optimize initialization time you'd want to build it in.

> I took some numbers and couldn't see similar benefit. See [1] :-
> 
> Without :-
> 
> 714.532560-714.456099 = .076461
> 721.189886-721.110845 = .079041
> 727.836938-727.765572 = .071366
> 734.589886-734.519779 = .070107
> 741.244296-741.173503 = .070793

With numbers in this range, I don't see how you could be hitting the
100ms msleep at all, even once, which means this patch shouldn't have
any effect on the timing you're measuring.

- Josh Triplett

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
