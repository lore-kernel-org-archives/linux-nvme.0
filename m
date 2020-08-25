Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68CC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E357620578
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y1GC4tnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E357620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UoTXlYOOnS/I8UFjbIQ4Q1VxvXOe0he34Cv/ELkl4W0=; b=y1GC4tnlZzPSUMqV6OYwI9oK/
	pi0t2EtQGs60UfWHpAKJ18Eu9o9VGleiChudtRXn7bnompP+jAzsTM7LE9g0M6Pdc00Gep+QGup+J
	yL5WdC+93ZoHintcnz141M57zg0cNexaQ549GgNnAb5JeorEPcC/ki3wMVNNweyHayE8AwVltySB+
	kEoOK2HVLefJFH0mituE1wIpTtBbPFPxDKwCiNOcmdUjztrvejh5QkSyDKqLBN0fC3vIk1kFGG626
	ijhp/FxDJp1aK1maxZnHnnDtwx0tgyrGzlfvU73KIkX5b5YD+Pj+NA/s8RFJCxa/zikQkxKc00ojt
	fW78z400Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAT6C-0001al-5f; Tue, 25 Aug 2020 07:10:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAT6A-0001a9-06
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 07:10:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7909968BEB; Tue, 25 Aug 2020 09:10:24 +0200 (CEST)
Date: Tue, 25 Aug 2020 09:10:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock
 in 'nvmet_fc_fod_op_done()'
Message-ID: <20200825071024.GE29268@lst.de>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_031026_192777_FE2F9766 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, james.smart@broadcom.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 21, 2020 at 09:58:19AM +0200, Christophe JAILLET wrote:
> The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> in this function.
> 
> Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> interruptions are disabled at that point, according to surrounding code.
> 
> Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not tested, only based on what looks logical to me according to
> surrounding code

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
