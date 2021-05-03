Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB68C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 06:53:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09B361244
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 06:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09B361244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CNR1PRAvR98yisDSKQ2UUxQId8rVCd9NjnBsBOcGDX8=; b=oGHCLIGQU5mZzpH3Uue4aECoO
	9iUEA29PX8dU+ozYYrISbaf0OhcGVDDycwRsk6RLBmuQfG5ITVjRbZLUCaY0bGgCoeTeK+6KiYdxG
	rXhBs2FyKzcv+5nMb0HCkgwKYPAmzAEwTAQv5zcmCXC77Q28MS4dACQpooEtmPopy8kN2fxeIFW1E
	Bt4PhKRj0NbRFj0frKAPPHei5vM9zDI5nGQ/ou+QfKU4swzmUw0OBfZJEnbcXwN14ErCtp8+c8Hhu
	YlR0fCD8HKQKD3lpY59HXMpolrAKn84xHRrPMK0LvSt2dno7dHRpVvmDD1gt+dCBKLUI4IE5+cMZ1
	MhRmLdSsA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldSRu-00DK8U-Cf; Mon, 03 May 2021 06:52:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldSRk-00DK8B-76
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 06:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=d+fHnJr96VIyT5hDcQKxJ21C7rYU+7WOKbcU5jdJE+E=; b=MGWrwm+9TJRF2EVqbIwLSGe3gS
 82H7RBmmwd5CSWOFMM32xr+Le27y5uiSv6ujn57REI7Ft+S5NuGavIUXspjhuogBbX5Ys74//DXgJ
 uEWcnCCHkZko5qu/KcFpmkoZtNe+I4oKvQRhL019I5oQgtsPqitnfSUR69UIq6/jntQ65p6rzF50M
 n09STzTxT7Ra/DRDUa0C1ThwckDEcIJb1zigUSnnRWCAAWwqQP2PZLO6G3VrNW2jfQpgysxIPQ28y
 mpNRvceXtF0OhKWfs7jbWb5Dm2Zs2Uxj5x7fni312v1N996uzKMB3nLYFGReX1BmpK7U52WwOnT0q
 mVFC6ATQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldSRg-002sPg-Ta
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 06:52:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD7B467373; Mon,  3 May 2021 08:52:35 +0200 (CEST)
Date: Mon, 3 May 2021 08:52:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Rao, Vinay" <Vinay.Rao@dell.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Message-ID: <20210503065235.GB32627@lst.de>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_235245_131842_246EF2AA 
X-CRM114-Status: GOOD (  20.20  )
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

On Fri, Apr 30, 2021 at 09:21:04AM -0700, Keith Busch wrote:
> On Fri, Apr 30, 2021 at 05:14:55AM +0000, Rao, Vinay wrote:
> > + Madhu
> > 
> > Hi Chaitanya, 
> > 
> > Some of the AEN's like ANA state change and Name Space attribute change events are of interest outside the NVME driver. 
> > 
> > It would be good to consider these events to be propagated up to user space. I am not yet convinced on how propagating this above to user space is problematic.
> 
> The namespace attribute change event pairs with the Changed Namespace
> List log, and reading that log will change the result for a subsequent
> reader. User space racing with the kernel on a log access when there are
> read side effects creates non-deterministic behavior, and that is
> problematic.

The only way I could think of making this work is by:

forcing the RAE bit on for all log pages that the kernel cares about,
and only delivering the uevent on controllers that actually do support
the RAE bit (IIRC it got added in 1.3, but I'd have to check).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
