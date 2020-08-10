Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C5C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:36:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098F320678
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zHmksebR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098F320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1ug/LW3yHCDxTwtHZIcqpwIqqU+FxFwrE2wo9WRDqhY=; b=zHmksebRoZ6TGzw9BgENtiMgK
	Z67dtGPjcnrXHVXbnpl4ibb3Zb0vw31qj+iPSLCIS4n2ZcU0nwia6cBGsFwl/uz3MBRylVrh6shrr
	w5/K0yZhBzt4/Y5h9TBgGYGUtc9IW5wtFKN+lqKQm+/hw87Ce06R7mUt8l/aLNaMKoavY1dOySGk7
	k+hE/U554g5/FwBxHGsp2H8egvxtgDPTOGjplyc6o0WQT5WQOLYWGBcsknSEwP2VvDzX2tH17Ii6R
	ndwiVmlplIuZWGgxQmbEc1H4N40pg4Z61OsRe9zKjvqM5o8aDGYOMofORrz+8LcdlE5v5T7DsPeFA
	hy2rBymwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k572u-0003lL-E5; Mon, 10 Aug 2020 12:36:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k572r-0003kN-PP
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 12:36:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3197468AFE; Mon, 10 Aug 2020 14:36:52 +0200 (CEST)
Date: Mon, 10 Aug 2020 14:36:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATVH V2 3/3] nvmet: call blk_mq_free_request() directly
Message-ID: <20200810123651.GD20069@lst.de>
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
 <20200807022032.48873-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807022032.48873-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_083653_945615_886F2663 
X-CRM114-Status: UNSURE (   9.63  )
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
Cc: Keith Busch <kbusch@kernel.org>, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 07:20:32PM -0700, Chaitanya Kulkarni wrote:
> Instead of calling blk_put_request() which calls blk_mq_free_request(),
> call blk_mq_free_request() directly for NVMeOF passthru. This is to
> mainly avoid an extra function call in the completion path
> nvmet_passthru_req_done().

Not strictly a fix, but I think we can just queue this up for 5.9
anyway as it is for brand new code:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
