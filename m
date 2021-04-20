Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C390C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 12:38:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E70E613C2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 12:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E70E613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uaP4xqLPJ55jvdTuWAmgv1sbOXm6QnS7GHObb6+JcMo=; b=H1F+CTQZwEpmumzMWypAbTzPF
	x1kFfLfPAneMKj0zX9cCPWh/Plq4gwnm4aW7zi3FEjt+su9eWN7l+mQYOQHFTvHZwAbN5BNdBP2/j
	FEu2qH2HkJrrxjeTcc3LkNzkuFuwLBnWHEhjAl1AOfFlic++MED9hvfk9LeOaGLksq+d+7tqfiqvJ
	3rGVrRRQfWU3IVYkvHNzzHORbhMkSLW0PndmVc6QEH3LKVE9d0dbg7uKbAzRPFif8kgdSHQaZMsnN
	3TV3RidwSBWwi6STLS5BTmGKWdNSBZH7JKLVaFV7mmJWr+mfPRarSB2AB3p3VSuGWYpj/GCgfvbkV
	o9y62u06w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYpdN-00C6iU-IO; Tue, 20 Apr 2021 12:37:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYpdE-00C6i4-HE
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 12:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WG7Pe6Skwq7erQviYLzLCFqAK1t6m8kwer3Psd1N2/Y=; b=zziCRw3rXlViobKXrVkOXqblEZ
 KCFKGoBKv0ePYlKDAkc8+bgMheld6ZOyuRWDfXMwyKNZu+j4215wf/b3X2XF4zKWMvEUeDk2lcNNz
 qPedTo8y2qQ+ABTFrmakCcbcSm19O8oZBT/CXwT1a1mGgdWWhC24+QCry/gYhIvIt0+uNFoHMdriS
 OUAR/KjY6z5rae7yO/hi9+NNspBIOS1OqKjmoCd54UhvJKBxb7z0pcePj81FAyPZFITLCe9oAK+qG
 So99Q0UqH6hJdVmjusw1UhG6kA50pLzJkpr1DomOTz4ReZJyjh6M0gTeUHZrKLMG6kWGkbwM01LBf
 viF3EeXw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYpd9-00C6pN-MK
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 12:37:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2DE02B229;
 Tue, 20 Apr 2021 12:37:24 +0000 (UTC)
Date: Tue, 20 Apr 2021 14:37:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, Arun Easi <aeasi@marvell.com>
Subject: Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210420123723.bregf4debvyincpo@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_053727_919984_C7DB67C6 
X-CRM114-Status: GOOD (  10.71  )
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

Hi Randy,

On Mon, Apr 19, 2021 at 09:19:13AM -0700, Randy Dunlap wrote:
> > +int ql2xdev_loss_tmo = 60;
> > +module_param(ql2xdev_loss_tmo, int, 0444);
> > +MODULE_PARM_DESC(ql2xdev_loss_tmo,
> > +		"Time to wait for device to recover before reporting\n"
> > +		"an error. Default is 60 seconds\n");
> 
> No need for the \n in the quoted string. Just change it to a space.

I just followed the current style in this file. I guess this style
question is up to the maintainers to decide what they want.

Thanks,
Daniel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
