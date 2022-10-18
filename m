Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F4C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWJOutz1Qr9sX+wIHySufI68nPro+UIpuXfPHC9/uwQ=; b=fGqRbyWfHK7Z6W2nT5ctt4BT9E
	wlgbS5xG3gUNxqRjgdSpggORZobAMb2OpSWo7pNTFPY6jHQ+eDjv+sXNogtM4I2bO4rSUD/ccVieg
	3k0qHundHfuZC59s5kv9EtsibLSyroFDMRPEno5YAI9HykHO9MjATVCyLb8UI8fpOShN7IkEmyLfJ
	Hg6EbELKTlUYkp7jEDOyvxufbo6lTfjli8JyYzLHV7JVTbxklQXTNZXl/pwudyEezHFHCGMUCR7Tc
	+ii0z8ZAk2UKVhjUDyElmHFoHZQQzxx1De1wKO++Klnx7hoU2gR4DKc5pDxuSKViFA8iMMejOpWL0
	5w45HYcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoMt-007WJq-6Q; Tue, 18 Oct 2022 15:18:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoKU-007UKs-BF
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:16:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23BC268C4E; Tue, 18 Oct 2022 17:16:26 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:16:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux@roeck-us.net, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018151625.GA22639@lst.de>
References: <20221018145808.681327-1-hch@lst.de> <20221018151421.jeqe2bi6nyj3afzi@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018151421.jeqe2bi6nyj3afzi@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_081630_556139_3BCA5362 
X-CRM114-Status: GOOD (  15.62  )
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

On Tue, Oct 18, 2022 at 06:14:21PM +0300, Serge Semin wrote:
> On Tue, Oct 18, 2022 at 04:58:08PM +0200, Christoph Hellwig wrote:
> > An NVMe controller works perfectly fine even when the hwmon
> > initialization fails.  Stop returning errors from nvme_hwmon_init to
> > handle this case consistently.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I was going to resubmit the series taking into account your resolution
> on this issue since patch #3 still needs to be resent. But you just
> submitted a fixup patch. Less worries to me. I'll resend patch #3
> separately then. Thanks.

I already have a locally rebased version, so don't bother.

