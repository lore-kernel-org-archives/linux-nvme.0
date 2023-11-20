Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B02C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjFlCiiDgmGVfViB9bNatzRrwYMq09jqbSbMyq4MGl4=; b=iXK3n+c4YzY8e1GDNMqrlewk2o
	YkGG0rJtTlOD12lf9Ag7OwQskqZNrHMmPwQMB1BTPw3SxJ2467HDlhgGVVvv1cRfWSeNncUb/LcWI
	rY60O01+TDKrEGB4qWszLk/S6IpEI2EJ7XWwUXnDQjkoGF6WvAIW/tMyNV1jrIft+BqlWgijlq6TF
	9k9v7xosfw5pQBVFxZwZrVeTNiKGkOyoTfo5Rws5L8pq+T8b2U69gQXcuRZCtw+zqHCXOjvV3YUTL
	PamaqES8FjQ+28VFhVXD0wbJruiRw2Twop719fyj5gEPl7YmypXCnZ0WxsYTS/WO30dGYhkUJzaL0
	RcAclenA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r4zZZ-00BUzh-0B;
	Mon, 20 Nov 2023 08:24:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r4zZV-00BUya-1i
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 08:23:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C71B467373; Mon, 20 Nov 2023 09:23:46 +0100 (CET)
Date: Mon, 20 Nov 2023 09:23:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yuanyuan Zhong <yzhong@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <20231120082346.GA11622@lst.de>
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com> <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com> <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com> <20231117132846.GB7867@lst.de> <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_002357_750903_BD4516D3 
X-CRM114-Status: GOOD (  14.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 17, 2023 at 09:38:19AM -0700, Keith Busch wrote:
> The effects log is per-CSI so different command sets won't create
> conflicts.

True.  But that wasn't the point anyway.  It is that different
controllers might expose very different namespaes with different
capabilities.  Maybe a controller with HDD namespaces vs flash might
be a better example.

> Namespaces that are not shared don't really matter here because this
> problem is unique to mulitpath.

Indeed.

> It doesn't make sense for effects logs to be different per-controller
> for the same shared namespace. The spec doesn't seem to explicitly
> prevent that, but hints that all hosts should be seeing the same thing
> no matter which controller they're connected to:

Also agreed as already indicated in the past mail.

