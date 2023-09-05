Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC96CA0FE9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NVjfl8VeGuWepI8H5NDbfzwgNQ
	4Pf8qCV4FKlhoIbndIKR1WeYxIkJL4Mf8LqAjsLYkCBBtllaneZI8LSy3llg+S3SDXpihXWKoS8/e
	nH92ZV+6cHY0Ahv1JLZg8N7NpkBqIRBAhA4i8vX4ntLT5NdeMHpdA68eqBz6Y+dP6l89UUYuw2HVD
	48MutH2oLUCXOTTtwIa8ni1k7bkEdXpgI1FEa+omxxTexQNE+yi42e5SXid8DWCI1ZpBTkeYCDkdd
	ep8GGMC5rQN6OfdRo0q5vbgha/FQvqTvs0/HehPjhqRrjJrX8J65tjGFNG2BiLclGtmJJcpwov0P6
	3BEvAjAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPvF-005MGU-0Y;
	Tue, 05 Sep 2023 06:52:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPu0-005MD4-0H
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 06:51:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6624368B05; Tue,  5 Sep 2023 08:51:05 +0200 (CEST)
Date: Tue, 5 Sep 2023 08:51:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: mwilck@suse.com
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	"George, Martin" <Martin.George@netapp.com>,
	"Kumar, Arun" <Arun.C@netapp.com>
Subject: Re: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional
 authentication
Message-ID: <20230905065105.GA19754@lst.de>
References: <20230904152638.28311-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904152638.28311-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_235108_267849_4752E393 
X-CRM114-Status: UNSURE (   9.41  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

