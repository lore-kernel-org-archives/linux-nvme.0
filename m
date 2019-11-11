Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA2C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 07:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAACD206A3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 07:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mGrgC66F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAACD206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vbk4De23fy2umm8vQO6SZ8fX7YxCgBWCcYxw7BT1y2I=; b=mGrgC66Flb+mz3
	cCneawf1ea3ebQOJPMgnP9eC0YXfkcXLm3nlD+/J/mhsu+rChuD/8jCWyQcizS1SbrOuT6QDFT2Yc
	ztzlMXuaHUoEA+Za5n4ma8hzKo6pNUi3JWdkgpQyf8UrFzjxeG1Bowqm4uMpSa5CytZb8Iems1Cak
	gf4+VzOFia6AnMMl2VFqq7nBLvZV8JQoIsbjOUZFRoyc2HPchMJHMtmLjh9VYJSf3uEoToyWCaL6H
	iL+RhGmDK0j5MYsUCvWmrIyRSYgI/lL89HvaqKzPp8KJcR2SIMH+pNK4F2Cr+VYCT70olQuVqf3TS
	m1mqPw0AGlr6N6XCN6tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iU483-0006pk-P6; Mon, 11 Nov 2019 07:28:51 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iU47z-0006pC-Dh
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 07:28:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CDCC9AC5B;
 Mon, 11 Nov 2019 07:28:43 +0000 (UTC)
Date: Mon, 11 Nov 2019 08:28:43 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Message-ID: <20191111072843.2bqgdzy4pd47f2eg@beryllium.lan>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
 <20191104095034.GA3193@linux-lxv2>
 <20191104101935.lzdhraz5wnd56g4r@beryllium.lan>
 <20191108104207.7paup72lz2ipqynf@beryllium.lan>
 <BYAPR04MB5749B7B17F2DD6692922D41D86750@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749B7B17F2DD6692922D41D86750@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191110_232847_606041_E4551100 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

> Did you see the same problem with the patch I've provided ?

I haven't heard anything back from our customer so far. I am
recreating the setup and see if I can reproduce the crash. I'll let
you know how this goes.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
