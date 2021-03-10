Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628FFC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 08:50:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00C964FEE
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 08:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00C964FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nRZPcsz9zPsAGXZ9bIJlwsTuCHlFzKOqAXxRhqcXoPI=; b=Dfw0/XIK/uLZ0UuRqgeF5sSFa
	vTbrQvoa0AxNGzn7ytUP/gmS6civW8kJsVeGzdRfKl55UcMauol6YjIa9m4YJNwg7M/OESWFhPwcB
	nfdq097HOeWBgVdg5B7N3ci+1OooO2ahxGEEiPohi1hO4Db/PsYWanM8DxBjtO7mcki5GvaSQcOaC
	IGF/CwNT+YOx8V0E/IGJP+d/gc6ap9u92R53TiboyEwQRIMENfhkXKiE0Naq8VMi91+rV1Kfdgq83
	5qyz7PNqC8Yfn8J8pkmlDotj/hzhb8mtMf+VGbW++vPqEpT8x9SDA8o65UAOLiaNP0Q9Hy42Cg1zQ
	a2HmmAWWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJuXc-006MAd-KM; Wed, 10 Mar 2021 08:50:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJuXK-006M0j-Kl
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 08:49:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0896D68B05; Wed, 10 Mar 2021 09:49:44 +0100 (CET)
Date: Wed, 10 Mar 2021 09:49:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Message-ID: <20210310084943.GA5838@lst.de>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-2-chaitanya.kulkarni@wdc.com>
 <20210309113434.GA9520@lst.de>
 <BYAPR04MB49654C66E5F4BC09418DC61C86929@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49654C66E5F4BC09418DC61C86929@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_084947_808371_87F788B2 
X-CRM114-Status: GOOD (  14.76  )
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

On Tue, Mar 09, 2021 at 09:03:26PM +0000, Chaitanya Kulkarni wrote:
> Looking at the code again, this is not a generic copy function but this
> is a designated function for the identifier copy, and for each
> identifier we have a length parameter that has 1:1 mapping [1], so why
> pass that values for each call ?

The point is to keep the levels of abstraction sane.  Right now
nvmet_copy_ns_identifier is a dumb copy function that doesn't know
about the type of the identifier copied, and the caller has all
information about each identifier, nicely together in a single line.
If you move the size derivation into nvmet_copy_ns_identifier everyone
adding a new identifier or just trying to understand the code needs
to deal with two functions.  Due to the extra branches it will probably
also generate worse binary code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
