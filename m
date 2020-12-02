Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB3DC64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:20:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F9A20872
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F9A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kKzhh8tcbG9TnPkGa0edlxE7bADNM6gyt5UeM5AWKmM=; b=X+ubrYzzj6vDEoQt9/2NSgr0P
	LHH3Eh5YzS26IpgjnXWvrZeM/qvQw1xF+4rQkUyl+gawYnjCUAweFUTvxnGaLrPmS5kUK7K/+/JYj
	THbod6SC4SI84cMGSFGj99y8swjVryoGpnLqoZQOZFb3dDkt8KHATdA8NAgb67o3Z3uAEH7VcNvsw
	Gxswzqa1b6aejl40msmA6OQOgMyy9lnQZHis6yRH/+afkUHP4jpllW/xhPMjd7/+3caR6CURbCAaE
	oNzJsk8+VmL7Bm41ykvAcP+7kZHum7qtFJkvU3fUQHyClaTT80h7PAM3uwidenRnoildSBJFg7+c5
	26kegYozQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkOJE-0001pf-BZ; Wed, 02 Dec 2020 09:20:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkOJC-0001p5-FY
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 09:20:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 403D868AFE; Wed,  2 Dec 2020 10:20:20 +0100 (CET)
Date: Wed, 2 Dec 2020 10:20:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 0/9] nvmet: add ZBD backend support
Message-ID: <20201202092019.GA3957@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_042022_639384_AA3C506E 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me, johannes.thumshirn@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Unless I'm missing something this fails to advertise multiple command
support in the CAP property, as well as the enablement in the CC
property.  How does the host manage to even use this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
