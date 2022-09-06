Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E911C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 04:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=H21WUeJV2nB+PnFgRfEoG7WTAD
	k2NIDn23eOZ95Y57Ch6tBYbysGGUDPpqrPCC1NrNzMbwpY/dJCxjoHW2LIW0rQMvh0/tbx4m3OmxK
	4UcQII1IlNSf/c9qQD3ImypgeiFdV1VckT45uAwkkGR9NZANuRhY7AGvD+lFB4fpOxJ8ZIWmu5XaJ
	OCN/Ah9YR7yN1y9VvAHAqlE6hFCOqOYfegMi8gkHdO8oE/1KTdSlx3OA5zzKf74RtBhXF1mbtXaeW
	kRh5z3rNFz6P7Fk39iE3Zz//onqghihh8vKVJCG4lgbNOSZROGJPOrHohE+dcgsVZJD4/MZIdL6cE
	8Pkr1ZpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQQo-007iHE-3t; Tue, 06 Sep 2022 04:43:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQQc-007hXy-7S
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 04:43:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F160B68AA6; Tue,  6 Sep 2022 06:43:05 +0200 (CEST)
Date: Tue, 6 Sep 2022 06:43:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme-tcp: Fix UAF when detecting digest errors
Message-ID: <20220906044305.GA32413@lst.de>
References: <20220905105417.1241304-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905105417.1241304-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_214314_467427_2CDB2E14 
X-CRM114-Status: UNSURE (   9.60  )
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

Thanks,

applied to nvme-6.0.

