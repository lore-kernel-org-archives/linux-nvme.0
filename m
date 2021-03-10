Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AEDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 07:14:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE0264FED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 07:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE0264FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XeTOPZospEBe8l68kdpCIEHK7S4BlDm74sMTaOGNf5Q=; b=BXQ0deUW/KNDtFWGKG1OsbZ/z
	1fSz8Xl4nMJActvO7liI5WsrVlNWNDPndMbyC/XKjXTNhK9FsuCcE1xN362DGGCqfVy8ttKFQIVkf
	lRBE4A+dXdlnCufjcAgeMd8yZpgTQ2c4xWdcB3Gy7o9gOTlE6s1kyMyeF4ObGiF5mZNxf5GBkLiul
	ga0Ie+GH7eFHbnoYjUJl6hR0hPA7cgjkHXKXv7Vcg5VlqZft6PDpware/U5Gud6WPwNWifEi2BKjd
	t/rHbPZv++e5O986IedCmK4MV3tXZzFCJfiYPJG/1yaDwFlJycb1zXorvXCos/IRfE+iyTr6fpsyW
	XrPuN1rqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJt2z-006C0U-S7; Wed, 10 Mar 2021 07:14:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJt2v-006Bzl-PR
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 07:14:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20E7C68BEB; Wed, 10 Mar 2021 08:14:14 +0100 (CET)
Date: Wed, 10 Mar 2021 08:14:13 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Message-ID: <20210310071413.GA2389@lst.de>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-4-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB4965B3BB165D157291466F2A86919@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965B3BB165D157291466F2A86919@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_071418_096891_28881662 
X-CRM114-Status: GOOD (  15.41  )
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

On Wed, Mar 10, 2021 at 07:05:14AM +0000, Chaitanya Kulkarni wrote:
> Christoph,
> 
> On 3/8/21 20:58, Chaitanya Kulkarni wrote:
> > @@ -1174,6 +1185,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
> >  {
> >  	/* command sets supported: NVMe command set: */
> >  	ctrl->cap = (1ULL << 37);
> > +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> > +		ctrl->cap |= (1ULL << 43);
> >  	/* CC.EN timeout in 500msec units: */
> >  	ctrl->cap |= (15ULL << 24);
> >  	/* maximum queue entries supported: */
> > -- 2.22.1
> 
> I've completed all the changes from your comment except this hunk.
> 
> Based on your commmet it needs to  be merged with patch
> "nvmet: add NVM Command Set Identifier support",
> but since it is based on the BLK_DEV_ZONED I think it should be a part of
> "nvmet: add ZBD over ZNS backend support" patch, any advise?

Just drop the conditional.  There is no harm in just always supporting
multiple command sets, even if only the NVM command set is advertised.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
