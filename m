Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D6C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD3A61447
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3A61447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+3qlRS8DTh9SznXtfLquaIF1fhvXFvpvsEsfymtuZA=; b=UFZopdiUOyaTJ+
	kscr+jFkq5bHaXKNirXjkTn5wuAGbW4c1RzJIaLRneutjmfsCdMtPUWkrnlfk47ClXC1GFe6T+ysG
	ThnwTuco5NTsFoKPlWP76FLVziq09cnK+LuV5wdFrEIEXqLq/GSGoMmv0zyR2agKS9Z7Y4gLIDybp
	hG48Jr/zKTXpoWKPVki4db9R70w4UfxDufjXSZdssZGqb4Tyub+R/oV6Zkre3xsaxaXUiHJvIvCQU
	yddGCygWpILAQgBI2wraxgxeibbX9vbxcg0y6sY1tw5gFaaUJTCKYBxmtiXcjd9SmAnsOWHmvf7Td
	iEQpv8ic4i9GR/n0D4Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0M3L-008cEX-5Z; Mon, 05 Jul 2021 10:42:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0M3I-008cDX-Af
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 10:42:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5450D68AFE; Mon,  5 Jul 2021 12:42:08 +0200 (CEST)
Date: Mon, 5 Jul 2021 12:42:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705104208.GA14891@lst.de>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_034212_563700_8B1C1B4D 
X-CRM114-Status: GOOD (  14.11  )
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

On Mon, Jul 05, 2021 at 10:40:21AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> Micron Confidential
> 
> Hi Christoph,
> 
> > 
> > 
> > On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrote:
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >
> > > Enabling the abrupt shutdown support. In this shutdown type host does
> > > not need to send Delete I/O Submission Queue and Delete I/O Completion
> > > queue commands to the device.
> > 
> > Why?
> 
> This is to achieve faster shutdown at the cost of data in-flight.

What is the actual use case, and why would a module paramter be a good
interface?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
