Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6F6C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sw+8y7hOOWHK2xGCb/CS9bKEIiTSVqOfnlG3OPwpTrw=; b=n8UQEpqKEW2P8jj63zFRhf6G1h
	3hQGboseYOwps477O0ZXvi/SSqJH5iZT9V5cX5bjXlWBqJ1n5DaOpv1G0uyrGmh84SyviAsOsqVQi
	yFp/kMuvLIaGe9N1u/61ENPvDwNDXIRanx+ECOdG8/GWNEnYJkpXLckqdoHLVhkN9m0KSV22mdLGK
	/SqWvnhPaSqEygo4Lx1os/BpPTrzu0HBFXS2i+qZRrfZfqxG3bLqu4GpwzOiOIAJwdTiJGgvxzww5
	yEbPtZhcCZNsW+owlxAIDrTVcVkQIlppHMF/dsR/LhU6wPnnwGOCWQPZrjJipmCL6pY173mYRuzWl
	ZtCzooYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01ra-009O7W-GG; Tue, 29 Nov 2022 14:45:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01rK-009NtN-1U
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:45:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A7976732D; Tue, 29 Nov 2022 15:45:11 +0100 (CET)
Date: Tue, 29 Nov 2022 15:45:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Message-ID: <20221129144510.GA18909@lst.de>
References: <20221003094344.242593-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003094344.242593-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_064518_258109_9BCFF502 
X-CRM114-Status: GOOD (  10.24  )
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

I've applied this with nvme_start_request changed to an inline
funtion.

