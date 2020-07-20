Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A38BC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:04:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00B622C9C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgYLZ99D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00B622C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vE+oDY8uEkgf9yqcfDb1T2mQxj5hauTZl9XSG4EDDxc=; b=AgYLZ99DgCGVqnDAj7wihRG1i
	BmS6DgyV9x5KGOV5XIlLlU/Pc/fCPUG/2XppYhfV9oVEz6KqGN/9HjtOIvKT8AF0fP1gtDD7vDa7T
	Vw5QujiUarp6UnwYVmsQ1tTHqTAIeBEtzjGRy5ARTudERPM9umm+/Iv+2VaBtAwp797A8Zrb1Qifu
	Pj7QYiVo/FzDW3QlsqpgvORZVG6dBqII6SFnDmED3S2Gx/pO+iIp1voCRuPsOfCkTWKjBn26DUrNw
	Zd3hRFquxipWx7VDq8B5fbPsQT+OzH5ansxNOKmMpn/wVgk98yHNTO0gppGXoElgkviw36AYvmIwM
	lJv4P2FqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxWOt-0007OB-Ic; Mon, 20 Jul 2020 14:04:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxWOq-0007NN-Oj
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 14:04:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5659268BFE; Mon, 20 Jul 2020 16:04:10 +0200 (CEST)
Date: Mon, 20 Jul 2020 16:04:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v15 2/9] nvme: Create helper function to obtain command
 effects
Message-ID: <20200720140410.GB4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_100412_947896_23691194 
X-CRM114-Status: GOOD (  12.25  )
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
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 02:33:12PM -0600, Logan Gunthorpe wrote:
> Separate the code to obtain command effects from the code
> to start a passthru request and open code nvme_known_admin_effects()
> in the new helper.
> 
> The new helper function will be necessary for nvmet passthru
> code to determine if we need to change out of interrupt context
> to handle the effects.

I actually found the nvme_known_admin_effects pretty nice, as the
function name documents why it is there.  The rest looks fine to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
