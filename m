Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B9CC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 05:30:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64006611C1
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 05:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64006611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+bHmDkHCnaTk5H4pD9iOy+GMtKl740hz2hxCuyybxlE=; b=ljTKIec0rpW/nd
	vYT9Thp/qWe8Aa2kI2u0k1OOAYijOpOrAjWN4z9RZBWOWwfQI3C5N3ebAoq1+YVAufhe2aRh1qX21
	wqt7iWoxD1pdpBDhsxm3HvM5Ea2w7L81J+qHTbaZKnwMv1x+LuD3vW2trXoh1lvff9Gj9ZStWa+LO
	Oesp9HNrZbjGgj/YcmMAZ9kP+VV3e5ilfwsw9UkucakHdXr0//NtnLPoxSAxEpwmZEEkRNa5FHTm/
	e2RT/6b6TC4JaOEk0kGepVhJeO9VXsddcfITX2nzuWt+tzxhBVsHOKy4XuDCptL/h7Ch5nuGN4c5g
	JuhHMndCl9AMAm6ya2kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3B0D-0098tn-GV; Tue, 13 Jul 2021 05:30:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3B0B-0098th-DP
 for linux-nvme@bombadil.infradead.org; Tue, 13 Jul 2021 05:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sB+NFj9NADKAxiEcRKRS7St86v6A8h4ntYhh2hdlodA=; b=LN1XKIoPELsBvXzKzzaBw4VzYF
 iGXLvwamc+iMaAunMrBmSmdhd2dRIXVTPAN/MkZ6y5Jbxh5aqZ1SLwj6/M/pwpid9QNOhrgk/Qp1N
 3/LdjyhgIT8skCpgoyLVGs6D+rf5ZGeh3q3uSm+10AX2Ggz6YC0fZRI8IyXM7mOk4kBBgDrJuhHMP
 UeMD9oMHg5cJJp2Jo2DNgBjR2fnVbUo+zGi1aQFiZ/ezofsjVovKXnA91B8c6NSiAYTe9pYPQMqy7
 9lSuMil0vUTRrO8bIGEZfI6YkPlxXIWxbcM3bKxfzQIP3pOJyTW8fxMIl2S/0htVDo0xrqdGMoYAQ
 7DMbl95g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m3B00-000lln-Nl; Tue, 13 Jul 2021 05:30:30 +0000
Date: Tue, 13 Jul 2021 06:30:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Padmakar Kalghatgi <p.kalghatgi@samsung.com>, qemu-devel@nongnu.org,
 kbusch@kernel.org, its@irrelevant.dk, fam@euphon.net,
 kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier.gonz@samsung.com, prakash.v@samsung.com,
 d.palani@samsung.com, u.kishore@samsung.com, mohit.kap@samsung.com,
 jg123.choi@samsung.com
Subject: Re: [RFC PATCH 1/2] hw/nvme: add mi device
Message-ID: <YO0k9JFO93EMaFIj@infradead.org>
References: <CGME20210709135651epcas5p1c544dec5377413bfa4b2eeab6ee43f26@epcas5p1.samsung.com>
 <20210709135545.GA11148@test-zns>
 <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 12, 2021 at 12:03:27PM +0100, Stefan Hajnoczi wrote:
> Why did you decide to implement -device nvme-mi as a device on
> TYPE_NVME_BUS? If the NVMe spec somehow requires this then I'm surprised
> that there's no NVMe bus interface (callbacks). It seems like this could
> just as easily be a property of an NVMe controller -device
> nvme,mi=on|off or -device nvme-subsys,mi=on|off? I'm probably just not
> familiar enough with MI and NVMe architecture...

I'm too far away from qemu these days to understand what TYPE_NVME_BUS
is.  Bt NVMe-MI has tree possible transports:

 1) out of band through smbus.  This seems something that could be
    trivially modelled in qemu
 2) out of band over MCTP / PCIe VDM.
 3) in band using NVMe admin commands that pass through MI commands

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
