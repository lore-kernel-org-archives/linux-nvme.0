Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBFC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=d7OMvkapp4n46NS6X1kzn+Qvy1
	td9bOPVrUTnmJpo9KmjhYKr8SpmpFMb4Hfr4RXHsq4STnqhpJfyqqJcdk94TaZhUqVzXuUXOVvsWC
	dnp1nD2Dzjre7oAdWy/Q8/e7Z/EjZjktaVwhFoX3s0Kc+NGrc5BAMNRDVGh58Te0qHT1c/Gpw1doi
	QQIYXipGHd96diohQSpbmu/aHnPx8qLaBwNIFOyu6+RKPE78XWR5XCey8+PEsITN94kT0ACyRJztS
	tRhcXo4xejxzecdsBuCisRKM1j32Q1W8aiB6yha7POWzuMy8wKoi99h/V/4P8Sy3s2cAejDG+Bo7t
	p+IODiZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nSk-00000006WR3-1zKs;
	Tue, 30 Apr 2024 13:24:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nSh-00000006WQO-1Rop
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 13:24:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFBF767373; Tue, 30 Apr 2024 15:23:53 +0200 (CEST)
Date: Tue, 30 Apr 2024 15:23:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v7 2/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240430132353.GA2843@lst.de>
References: <20240430131928.29766-1-dwagner@suse.de> <20240430131928.29766-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430131928.29766-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_062359_537114_05210CEE 
X-CRM114-Status: GOOD (  10.48  )
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


