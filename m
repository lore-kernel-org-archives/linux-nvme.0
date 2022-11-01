Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F70C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=cq+k7Pu8zsNR0aEtEhBlcblDCA
	fCn9JH5mlyIYN2gbJ/Cv6zPTCa4qafyhjKzBD+Dr6xCl28IbcEdeN8laSIjJCEvp7aOx/K7UsZy+C
	sczGfxu54WKhfKs6USGiYwVzytxwxcNaTf21PvuhZxnenWt/P3WPRDrk1GUppYEupc7zBJ4lj8ldh
	8oxIqLMJtD0+PDuwyUfwZrkqm1GnLs0asJuLKqTzbvoK/yomAEp9UNPjeYWHq55Jo7GCMflIkyx0A
	kwsgZ5rUJ8vDQwc3Q1NCwAntrMMaC2nuyYbLfyJOrgmfnyHi39Uo9kXPiVXCqO2dACymfiVTkCofc
	UXtVyGrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnph-003jn4-Bs; Tue, 01 Nov 2022 09:45:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opnpd-003jko-QD
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 09:45:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D94368AA6; Tue,  1 Nov 2022 10:45:14 +0100 (CET)
Date: Tue, 1 Nov 2022 10:45:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvmet: force reconnect when number of queue changes
Message-ID: <20221101094513.GA12858@lst.de>
References: <20221025155008.30028-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025155008.30028-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_024518_026285_EA075C67 
X-CRM114-Status: UNSURE (   8.79  )
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

applied to nvme-6.2.

