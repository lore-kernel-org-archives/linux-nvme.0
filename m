Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A44C25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IEQCQILO0TqQsSciias4DJecaP
	zkOyyJh8hz1ukxrWCshFrreroJMThYCKrVaicxzCgOmR/+YkNrXVomDwPPfx2PZ2b36wY5vviJ8WF
	8FnopjZq1qFSA2lO2KWWU/ajJyInBp3WCFUgB8+w9KSrBRwYPpHWxF4bK6VfS3rVXCIBxo7F6gptT
	ahBa6H4wEleUxCwA3+23lUdLbXjTersNrFpRFYi72mOFMLQmA6YWVUai8IYNQOLCSSb1zOYpiG3VI
	ImQepisqiQDEJ0eiafPO/hi/oNwujMgDPBKhRtyNp/OwoUY3ggYMPxKGPM40dmCEEEEplEGOTL7o2
	7VNc9UYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvytE-00EOSq-2R;
	Thu, 26 Oct 2023 11:51:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvytB-00EOSD-0m
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 11:51:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF0E267373; Thu, 26 Oct 2023 13:50:54 +0200 (CEST)
Date: Thu, 26 Oct 2023 13:50:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] nvme: common: make keyring and auth separate
 modules
Message-ID: <20231026115054.GA3314@lst.de>
References: <20231025081253.113738-1-hare@suse.de> <20231025081253.113738-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025081253.113738-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_045101_424808_E34670C4 
X-CRM114-Status: GOOD (  10.10  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

