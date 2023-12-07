Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84491C10F05
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GtCvdkUyohCBWg0kTZKtA/OJjLPB60ZU7A4TiZ/tI2M=; b=Tn0DMZEV8G8XKBItQTeAzPkwEj
	O0XJ/gDuqOtRFvkod8wj3BJna71np4gedfqaOusUn6O+YaFSEbQY9GaAxLUpmRppsLqfcw8N9sAKq
	08QEMmq/KQKd0t1ZA4b8xgWoHCI0Wn8pRXCcuAf4b/sG8kH/fE38ST7ryF67hc4L4NLvPwKUENY42
	c9MwBvGDbDBzpMVIcA6lGoUSNTuF7O0Cm8uclBzTz2gr3TEMQRucgIJadeFf7pCp063zSVyxooaU+
	Y/W/lp229bVKz2LUnzRe3G5gvW8o4ph5PHMeevJ8uvZzOOM0pfSXuL2wRIx2kLYuDF2hrHIvBAc5P
	9nlaNp3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGNY-00DD0y-0D;
	Thu, 07 Dec 2023 15:33:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGNW-00DD0M-0B
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 15:33:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71808227A87; Thu,  7 Dec 2023 16:33:27 +0100 (CET)
Date: Thu, 7 Dec 2023 16:33:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <20231207153327.GB21486@lst.de>
References: <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_073330_233389_DCFDBBBF 
X-CRM114-Status: UNSURE (   9.26  )
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

With the extra debugging removed:

Reviewed-by: Christoph Hellwig <hch@lst.de>

