Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37820C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=YqRYqkR05tjSeyGYG/yPbLVBg9
	KgcsqzJOOtYnZrYxqHpQRQ4a5cRceZahkY/79SiEXcTGp26VB0NjKj1zldLvY3tZNFK22jLbxZd3A
	1d4/BCfRaN28Y2B7+lgeP5Q6draLM5HBJS6l4ICDxJktjft1qvc+Lk+zRGMyxNlKqdxdLOTyFOxQh
	G65HbpTFM2gda7LpmemsMniyaltjCwkUQ2rKj58/16GyM01sUE/PLKvj3XrnjtAq4hX7xa4AajPgY
	sD4qsPIJ1LJvtfNP3jhxoFc6KlTv+1Epq8is18CaX6QhFSX/aL4hZKtNL4qRlGK4bhko11mGX/i8f
	PmqgEeZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK00d-000gQg-Az; Mon, 23 Jan 2023 16:49:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzt1-000d4X-Uz
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:41:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44B1C68C7B; Mon, 23 Jan 2023 17:41:32 +0100 (CET)
Date: Mon, 23 Jan 2023 17:41:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: Fix initialization order
Message-ID: <20230123164132.GB8398@lst.de>
References: <20230120174354.3437046-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120174354.3437046-1-ross.lagerwall@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_084136_237940_3F96CE55 
X-CRM114-Status: UNSURE (   9.18  )
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

