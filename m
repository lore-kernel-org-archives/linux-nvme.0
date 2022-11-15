Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6017C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ibEuYy8Iqx5zLxAbc38oM+76UevLvOn0llUoWbNTuY=; b=RqPLpuGlqk4fxYiwwol5amngad
	8vGByGUORcPwW5t1ulbekAYTIgexUPTgTOM7FZahKu1HP6c+S8jHeq7EYvPRLBajVuck15aNUNOK9
	EWZmX6rwiAsgHcz8gKDn2souCRqmC02yJMz2nPAMPg3wUdJnDsIJ1RGUS1GtoR7PtISxKclLg0IBR
	gn+uaPgyO6gFhhZNq63cG9N+phtONEC+iepuD5F8DIY11/h2ZB3H2BwlHYTWk4qjBS0I5GPozvWTJ
	L7nKIedQFU8GsDAYV+boy274/pAjsX1J1t+sn3wnaJ5//AL2EpcHJAISRSUQI+eBJz8OaC0zLGjkS
	lOkTnIKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outEy-009y2y-TO; Tue, 15 Nov 2022 10:32:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousuK-009kIT-Ct
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 10:11:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3250B67373; Tue, 15 Nov 2022 11:11:04 +0100 (CET)
Date: Tue, 15 Nov 2022 11:11:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 00/20] nvme: fixes, cleanups and enhancements to the
 dhchap-auth host code
Message-ID: <20221115101104.GA27030@lst.de>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_021108_633766_A9CBA706 
X-CRM114-Status: GOOD (  10.63  )
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

Thanks, added to nvme-6.2 with the struct move dropped and the
mempool and slab marked static.

