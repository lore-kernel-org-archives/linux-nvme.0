Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37452C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:15:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BEC610F8
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BEC610F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v8hH6S2t7d9N2pzF0eALiOLCR9zvPqihqW4QjK47dKA=; b=ZwcR5QRZDBlowoW0tUbp6h6Bb
	KGd0N1WGyBB3Taag4M7XYM8Zmw2jZmDH5SrlJCCSwOLyOMIeHNJLcpfn7xrS9VfwJldmcVchoabqV
	RkQa6lJqCblS7/fW7xqId2++ECbXR+C4roqpPxMrtn+dmTlw8WinTsfXA6qSZPDYENxmeIafCNXwR
	DDgrR4N05wssg4Pw8yyormC6laLu/DBrE1XEU4WdVRH2w2vuN6suNAlgtIaaP3d5L/EPvXCPbo/BB
	Bep8UXTlLmwXEA73qWhcBLJw7L+G5cMbScngjiBJa/ZVkl0jUjZi51Ohs1Sd595e6UBTSjmHEjIkk
	5yDnsf46Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTZY-007wbS-L2; Thu, 08 Apr 2021 12:15:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTZU-007waQ-8F
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:15:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B70EE68B05; Thu,  8 Apr 2021 14:15:38 +0200 (CEST)
Date: Thu, 8 Apr 2021 14:15:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408121538.GA12948@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
 <20210311104712.GA16218@lst.de>
 <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
 <20210323083749.r272grolxozf3w2f@mpHalley.local>
 <20210323123121.GA31105@lst.de>
 <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
 <20210408103016.5girhv5ctkucovmd@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408103016.5girhv5ctkucovmd@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_131540_676281_F7A78FD4 
X-CRM114-Status: GOOD (  21.97  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 08, 2021 at 12:30:16PM +0200, Javier Gonz=E1lez wrote:
>>> Aligning to MDTS is our current behavior, although all kernels up to
>>> 5.11 had a bug in the calculation.
>>
>> I see. Let me check internally and see what's going on with
>> write-zeroes on this model.
>
> We still need to confirm, but it seems like MDTS for write-zeroes is
> reported wrong in the FW that Dmitry is using. We can at least reproduce
> it.
>
> Would it be a possibility to add quirk infrastructure to hardcode MDTS
> for FW versions prior TP4040?
>
> Another possibility is to add quirks to the TP4040 support patches to
> enable this - it might also help reduce the list of models currently
> blacklisted for write-zeroes.

I'm not sure I understand you.  Before TP4040 there is only the MDTS,
which only applies to data transfer commands, although we also
"volunarily" apply it to Write Zeroes.  If MDTS is wrong this would
also affect normal I/O, so we really either need a firmware update
or a quirk.  Or is the Write Zeroes limit even smaller than MTDS?
I'd rather not add another quirk with a specific limit in that case,
as well grow way too many of those.  TP4040 is the way to go for that
case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
