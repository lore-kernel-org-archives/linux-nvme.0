Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:56:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057E522243
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2PBhpRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057E522243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZVNWepWcMgwGm7DpveSLbCKbGlJiZOjFO2HB19H0mow=; b=P2PBhpRB3rrJ0cKFfxbJpUDyx
	aFRD03qgcP8E8vB8e8UHDkm5Qs9CLjwsnJLbvepQSau/OFWB8U/9HrQ8d2q3poYQhc0Weviyrk0Fd
	+z2tAEePavrj/1agf1MxDTV1WAvULnRMXyTKzADHiSUANHZarOFP6Dmy9EEfnh+L0PFojJ0Jtusd4
	8Sdy5e/VyfHkLKmWyBcCaCq6ptrPqOj/UPV2RicwQTHVwH2hHYugogp1/QlT/1zTldMEGxhMJrMe1
	An0hPBtSj63dGEhfHYcyJef7aDsx3wKT5n1qZ0dN9qIOVePL7/OiNbtq9SObSdgkmrfLX48nO/qdh
	vjie33Zgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSy7y-0002P8-Pq; Thu, 15 Oct 2020 07:56:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSy7u-0002O8-P8
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 07:56:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 796F668AFE; Thu, 15 Oct 2020 09:56:40 +0200 (CEST)
Date: Thu, 15 Oct 2020 09:56:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Message-ID: <20201015075640.GJ14082@lst.de>
References: <20201009231816.1524-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009231816.1524-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_035642_917471_36230377 
X-CRM114-Status: UNSURE (   9.83  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 09, 2020 at 05:18:16PM -0600, Logan Gunthorpe wrote:
>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  {
> -	int sg_cnt = req->sg_cnt;
>  	struct scatterlist *sg;
>  	int op_flags = 0;
>  	struct bio *bio;
>  	int i, ret;
>  
> +	if (req->sg_cnt > BIO_MAX_PAGES)
> +		return -EINVAL;

Don't you need to handle larger requests as well?  Or at least
limit MDTS?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
