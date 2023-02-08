Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3FCC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=MhOzX5bh9t4Oz8K4GUBaeuKKjH
	gAX0Uup+zv9ifPnY+Vz4pW2GKN3r1b1brhZj6tQsAuJgTAUTb6hgn4/a7cbCG6EPQuZ9LUlWapQvM
	z+IHWR7JY2bIZqEzM9denTU0pDVBnMJIgsJgiSDsdZi7bK7qFpX/CBjD51axpRRuwUBEaTwLTPKN8
	T+SOwCt+r44grjK3jceEEEZhBShp0JKG/mQKviv60ljdknrLVlwSTLjzp4bPZrOmzyA76D8W7mAMW
	FUrFmnoG2hFM7e2uzXr1lQp/Bq5iMGzxFRDrukFKSR/c4g1X8vxn4lxw3sR6kv+bwC0oBqhL8SdN1
	gQPlbD5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPdwv-00EIlT-R0; Wed, 08 Feb 2023 06:28:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPdws-00EIks-KO
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 06:28:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58B1B68BFE; Wed,  8 Feb 2023 07:28:50 +0100 (CET)
Date: Wed, 8 Feb 2023 07:28:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Rix <trix@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: set nvme_auth_wq storage-class-specifier to
 static
Message-ID: <20230208062850.GA14899@lst.de>
References: <20230206145700.1798073-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206145700.1798073-1-trix@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_222854_830204_88759898 
X-CRM114-Status: UNSURE (   8.31  )
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

