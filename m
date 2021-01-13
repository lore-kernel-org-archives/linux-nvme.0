Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B8C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 18:34:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A082054F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 18:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A082054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BEe9iyEQM/5HFFaZRf0rCNLNSUAvmUINlrur5f1h238=; b=tEnU3XrTm4FD7aousdkoSsPS9
	9fmtbaca/q9mWOruUZQk38YK5HjCPdveBnY+lcHTwoS3rxV6ewcUQoD2RY00iL/k0VS986ffbAuf4
	ZJyBUXq7Bpx08Ay/rK/FvFhwbAQvg0RRrecb/GMjOp/NBbJWOs+W/9rM9dOqOuoCE/i4BYWL7Goqi
	2y725LqRTJXvlIAXvKeKPAe4TwM+bM0zQqrgOUn8YaHAw5JR6RQPkKKANPXzhJ+iQ0cZ+s+H1cBgq
	Z0wvakV9C6AJeZaUEWZy07jNjM6/a2gu5Mv76UZhQFmXBCnJZeo0biF9plWqvDFj/8diBRucBWUZb
	sFJHs4hAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzkyU-0001zZ-QW; Wed, 13 Jan 2021 18:34:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzkyR-0001xr-T3
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 18:34:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B261F68AFE; Wed, 13 Jan 2021 19:34:25 +0100 (CET)
Date: Wed, 13 Jan 2021 19:34:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [V3 1/4] nvmet: set right status on error in id-ns handler
Message-ID: <20210113183425.GA19474@lst.de>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
 <20210112211410.24742-2-chaitanya.kulkarni@wdc.com>
 <20210112214801.GA1505636@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112214801.GA1505636@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_133428_087147_1BA871E9 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 12, 2021 at 01:48:01PM -0800, Keith Busch wrote:
> On Tue, Jan 12, 2021 at 01:14:07PM -0800, Chaitanya Kulkarni wrote:
> > @@ -541,7 +543,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
> >  		id->nsattr |= (1 << 0);
> >  	nvmet_put_namespace(ns);
> >  done:
> > -	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> > +	if (nvmet_copy_to_sgl(req, 0, id, sizeof(*id)) && !status)
> > +		status = NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
> 
> If the status is already in error, you don't need to copy out the
> blank struct, right? Shouldn't this be like:
> 
> 	if (!status)
> 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));

Yes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
