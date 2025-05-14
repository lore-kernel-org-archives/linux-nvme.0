Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A5CC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoaumT21OMEtYD2qzulej+cD7W7qxKTWklRXU9O6q4g=; b=1WxgsdLzVGLMMfSwjDXHA9D23F
	r8UGVQ8MtaOIBgaPUmxCrXDP4xHugjuPvy/rPi0+bnhyTzsNsiXJib+oJVnwp1dk37FsMEBDZdEcQ
	+4Rjy6nnRhwbelYXhIGysFMYNEvc6LnBt0U7o+EvYCxsVZ9XsWaqdWYzRjwsVdUkOjSUC8NkMRR43
	UW5Bg2BnkBD4ApiH4WZsONUmzD8/HtBRYAA48AOThHtT7iPTKfHUt6z3F6vl0/WxZyHSWRzf4kFnX
	23rS44rQ5qA6uyOkAqJ0RazhkfZstCdNaHY21mZYTdoX7/JBeeK+zMfyP1URcIzNJUXe6bu2EIyPV
	jHudENZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDGK-0000000FRAO-26Tb;
	Wed, 14 May 2025 14:39:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFClr-0000000FN1c-3qoL
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 14:07:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E02168AFE; Wed, 14 May 2025 16:07:38 +0200 (CEST)
Date: Wed, 14 May 2025 16:07:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ilya Guterman <iliyagutermann@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 025e:f1ac
Message-ID: <20250514140738.GA26520@lst.de>
References: <20250510102130.14710-1-amfernusus@gmail.com> <20250514053802.GA24939@lst.de> <CAMraO6-rQsf8T_ocOKbe3yMP+91W=AF6WtRUYVPtNuq43H8qXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMraO6-rQsf8T_ocOKbe3yMP+91W=AF6WtRUYVPtNuq43H8qXA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_070744_099488_7C5F1EF5 
X-CRM114-Status: GOOD (  13.13  )
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

On Wed, May 14, 2025 at 04:14:11PM +0900, Ilya Guterman wrote:
> I've only been able to test on my own host system, but I found similar
> reports from others online.
> 
> Let me quote from the reddit conversation
> https://www.reddit.com/r/buildapcsales/comments/1e4tgge/comment/ldha0ye/

Thanks!  I'll also need your Signed-off-by: tag to apply this.

Sorry for only noticing now.


