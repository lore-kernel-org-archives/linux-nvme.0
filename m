Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B9C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 06:24:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0A761583
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 06:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0A761583
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EIYa5zhHuLqi093AelAqK9rIZ0+8XzYuLU3+Ew8ywEY=; b=Qxel/9Fk1YQk49Vf4bFiRUKn5
	91MEXbfSckqoyYqPtdW3k7Amd9sW13m8uZFxiRcS4WJSZEomFKHS0VwXY4YxfvZPqFqWaiZXJKtVG
	vrHB0FUPEvTy6DWR5qQAYe2pwvSkdh1WYj4KTVGz3EdbkVImI62PMvo+9UCRRIimtTR+HP96zWIxx
	PMNfgtQd2aCeaB1NXNi+Ot7pBZlGuWGd/gR9E2WZMxAh/le9ENUD18smdi5jqGTABWrq8rtFoOoew
	xLCrrbFqBIdL1AYS3gcWaf6fm6roaWqv6zdlNzInLRBjXxQm+1on4aWfkjNGamyTLnVztij7qz4qF
	uktNTu93g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKEjw-008TSn-Ia; Thu, 11 Mar 2021 06:24:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKEi5-008Sdl-Po
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 06:22:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3DE2768B05; Thu, 11 Mar 2021 07:22:10 +0100 (CET)
Date: Thu, 11 Mar 2021 07:22:10 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 4/4] nvme: add comments to nvme_zns_alloc_report_buffer
Message-ID: <20210311062210.GA3889@lst.de>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514516766FD5F343D4415AEE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49658642053EC41432FCD9CC86909@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49658642053EC41432FCD9CC86909@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_062214_060609_E99DCE37 
X-CRM114-Status: GOOD (  11.64  )
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

On Thu, Mar 11, 2021 at 05:36:53AM +0000, Chaitanya Kulkarni wrote:
> > This seems unused. And not really useful anyway since if this function is being
> > called, it should be clear already that at least one zone can be reported, that
> > is, the report start sector is below capacity.
> 
> Okay will remove the comment V12.

Please just resend this patch individually.  It isn't really related
to the rest.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
