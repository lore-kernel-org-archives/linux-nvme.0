Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091DC433E7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:45:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9322A22243
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HtiJYp4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9322A22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s9EkTK1EZc0zhTbsC0s5A4sl4d/Z7nzHQ++CtsaAE18=; b=HtiJYp4ziHxmD1BPrJRLD+p/J
	bMt4v+Mf4pdvuKhjyLNa+fFhoz/w+URo20IBwKBxw7ye2qQ5V26LtmDxtyyEKAvsw74hQwLr/sXBz
	XHpGkO9PUY5U5z47qPnC68kTccKKljuS5Wg3xzmJA3ZBB9xp0a3UehO2BoQf1zsJ4GjCCJv2K/AB3
	6kMFX+tncou/chSWAcHKKP7gX4fMHetcOWjXKoBTSJ7xdBayr3rtGhRXoOSG7ZsS/QUIU8Vzjv52d
	ZuJ2R+2XaUHm7VcOLEZkl1pBAPqTSx/4bjqynZUm6H7LAseM+bcJ/WRj3OeHDgKhmAO35KRzawwqI
	cB6suGTlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSxxC-0000gM-4W; Thu, 15 Oct 2020 07:45:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSxx9-0000fa-2B
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 07:45:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63EFD68BFE; Thu, 15 Oct 2020 09:45:33 +0200 (CEST)
Date: Thu, 15 Oct 2020 09:45:32 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Yang, Bear" <Bear.yang@amd.com>
Subject: Re: NVME driver throw out NULL pointer during initialization and
 system will be reboot
Message-ID: <20201015074532.GE14082@lst.de>
References: <MN2PR12MB43048EF6642F885022011626F6070@MN2PR12MB4304.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB43048EF6642F885022011626F6070@MN2PR12MB4304.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_034535_259111_09EDC348 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2020 at 11:52:41AM +0000, Yang, Bear wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi ALL,
> I encountered a problem and not sure if this is a NVME driver bug, so want to ask you to help to see if there is a solution already.
> 
> Server: AMD 7502(32core) * 2, total 128 threads
> OS: RHEL 7.6.6

Please report the problem to Red Hat.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
