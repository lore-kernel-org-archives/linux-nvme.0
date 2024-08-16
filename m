Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC908C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QhnCxymFoIv9K6ETQaEq4+7EuzNAfZOFPpPMg3JX9Jk=; b=d24U9Cp20agGcM6N3punxZp01F
	kTLTlqnSua2kovIGEajj+XqG3A//XfDno23mKAPQOQxo4xyYD/5BaViyfekUy/zlsGXZfooXu2ZSL
	kQQH9q6NBDctcICOx06TVnstGOxp608lRhG32WWgwmMyg1/Nw1DrkBSnmP84QoNdl8R8qDR8+4vRa
	Xdw+jXbwJykQBv02WPiCDgXHvNBq+GcQ8Ynb7XPguLRzjfGv3AZp3GtOubc7DQVIjIvETmD1RBCqB
	Hxli/N4KPZ5zq/Lqco3sGbtONDg05mqTHNI+um1WVGNli3uidNsafD9wiJ8Fx5DjaNOSwhD2W0W72
	5HsgRGpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sersV-0000000CCmQ-1DRD;
	Fri, 16 Aug 2024 08:00:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sersR-0000000CCkk-1WL0
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 08:00:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9286227A87; Fri, 16 Aug 2024 09:59:53 +0200 (CEST)
Date: Fri, 16 Aug 2024 09:59:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvme: Remove unused parameter
Message-ID: <20240816075953.GA6703@lst.de>
References: <20240814135702.99402-1-nilay@linux.ibm.com> <20240816054111.GA29113@lst.de> <16c5ec69-da33-49ef-9032-ef0cb9ac09f7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c5ec69-da33-49ef-9032-ef0cb9ac09f7@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_010003_570772_12B7E19D 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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

On Fri, Aug 16, 2024 at 12:30:45PM +0530, Nilay Shroff wrote:
> Yeah ok, if you prefer, shall I update the patch subject line and 
> resend the patch?

Maybe Keith can just fix it up.


