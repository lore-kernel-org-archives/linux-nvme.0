Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA0DC4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:32:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9519E23AAA
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9519E23AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tT5ryRnXFi2FIU4WLOvlSx7PGYQ3oID2jDkaY0uTFos=; b=lJzK8WgD0Iy1mHoE3U3XKfG6k
	9/dpyXOehpCxUUaC8GHau/+XFb9Cw4s1YlYZLxRhi4DDyTU4cQ2kceZ2tSIyAKuTxJIfQ/Kh9djq0
	RM4Ku801IE2Ufo4o5TgJsYaCnFSObX+z/AONtTKDY02YWM5SXcQmuHMyqfuEFABQ2wpQGk7RAAOVc
	uUE/U8+NUIgE1ZwZ0rmUFjBWFSMtPrI+1CWTDziYz2ZQgR29bjbJfh78jSJTM4+UYJkuk5x+delDk
	Bj1ePED+rNb8Jg66i5UlBZa+sGccbAMxym/1KZvLRqqL8BJPCAwweC4WlfnBus+LsdP7Hhff3GMIp
	nXNEm0qvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmd6P-0004gh-0c; Tue, 08 Dec 2020 13:32:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmd41-0003Ea-4r
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 13:29:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC70A67373; Tue,  8 Dec 2020 14:29:51 +0100 (CET)
Date: Tue, 8 Dec 2020 14:29:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gopal Tiwari <gtiwari@redhat.com>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Message-ID: <20201208132951.GA847@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
 <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_082957_338392_58BCB38F 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 08:28:19AM -0500, Gopal Tiwari wrote:
> Hi Christoph,
> 
> Please find output for both the device .. 

So it claims 1.2.1 compliance, and the NQN looks like a valid one.
And that NQN is the same for multiple devices?  Or is this one PCIe
device with multiple functions that report the same controller ID?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
