Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D45FCD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 05:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5KIntCnebj3DOEUNTb9cQGXz+YTURxOUwDGpZBnjtS0=; b=QEVejsVUt7u6xnQyMPS+l8Tonx
	DvX5ezU0fvCmZ3Vnd0Eq2f3WNVw/E31qzpa5w3GvJFoz/ADzLdn2grHxNGX9fa+/vmZbWmr/jqWDe
	ucdAP32LiXMW9iVo8RN3G1keiZ5YcM2RJnfax6gAvzIb+XaNHmR8tQYopHyvL7w+MGxfwA+a0LNJl
	oKu0lfPwH2hUWJqag7Ob3UeZcLJaNSH2yLUA51vLcAVaOHRf87T13a8IEAEBpZVOJTih1mNxLYjpv
	rdZIhW/iLdEbYWaZ67Q7alsKS2YSavhgdALhtomsQiPL29Vy2tUg0dE5I6KdWpz6OocqhOLs44OVs
	NcGE38Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRNf-00Eo6u-11;
	Wed, 11 Oct 2023 05:03:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRNc-00Eo5x-2a
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 05:03:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23D1F6732A; Wed, 11 Oct 2023 07:03:30 +0200 (CEST)
Date: Wed, 11 Oct 2023 07:03:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"vincentfu@gmail.com" <vincentfu@gmail.com>,
	"ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011050329.GB32444@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <8a0e5f41559646d9b505b11386142b55@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0e5f41559646d9b505b11386142b55@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_220332_984467_9FFE21A6 
X-CRM114-Status: GOOD (  11.82  )
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

On Tue, Oct 10, 2023 at 03:31:23PM +0000, Clay Mayers wrote:
> > Sure, I can change it.
> > 
> 
> What if the ns used the KV CS?  Store and retrieve are the same
> op codes as nvme_cmd_write and nvme_cmd_read.

Yeah, we also need a CSI check here.

