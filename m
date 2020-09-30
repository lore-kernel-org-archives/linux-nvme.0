Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3BFC2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:13:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146D020754
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IV6+N178"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146D020754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=beEa1wtSE46HvED/3FMrt8dZ7Jrrjv48lgpKTxDiA2A=; b=IV6+N178/U2dZtVtelK/HItsD
	RJYre3WwyYuxxTop5yd+CGjlfDfWPhKuwtEvb5+qsX14eHNmOVJsoPAzRH2HmDxvwtSsM0iOkOtyH
	AHrL8pjOJLGzKmXtWxyx1C2CXk5G8rRlQZ9vpZSkAuzeZjwgMnSwJz4CeZ6cu2TBsudgWC+p57QPX
	rTFLu9HaKo3ycFP2i/0lcj+wiwaRUAzb0PLQI5PX5EMbYo4wdrAkOQqM29s6n+sZ8xXZDtwqp2LQX
	Ko2VXOodehuZWhmH+1rTeL4A2JDU7cKGkp4nBFyjbs9g0QjASmzbJDDFZUSnThBo8Ii2bEMD+8CsF
	teWMP/xJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNVN1-0000IJ-If; Wed, 30 Sep 2020 06:13:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNVMy-0000HI-KA
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 06:13:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 020DD67373; Wed, 30 Sep 2020 08:13:39 +0200 (CEST)
Date: Wed, 30 Sep 2020 08:13:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 18/20] nvme: move nvme_validate_ns
Message-ID: <20200930061338.GB1939@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-19-hch@lst.de>
 <BYAPR04MB49652C7EA9C2A45C8248A50286330@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49652C7EA9C2A45C8248A50286330@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_021340_779923_483B909F 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 30, 2020 at 12:22:28AM +0000, Chaitanya Kulkarni wrote:
> > +static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> > +{
> > +	struct nvme_ctrl *ctrl = ns->ctrl;
> 
> the ctrl variable only accessed twice and there is enough space for using
> 
> ns->ctrl so that we will not exceed the 80 char, consider removing that
> and using
> 
> ns->ctrl ?
> 
> > +	struct nvme_id_ns *id;
> > +	int ret = 0;
> > +
> 
> no need to initialize ret it is getting overwritten nvme_identify_ns()
> before
> 
> the first access or ret = -ENODEV and return ret on test_bit(NVME_NS_DEAD)
> 
> error case.

This patch is a pure code move.  But I think all of your comments are
taken care of later anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
