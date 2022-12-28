Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C4CC46467
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDj/xrm91wNbKoIYx73VGwdYUYYGhSF1F9vGqHEqD1M=; b=cC+Q5gFnIldlL8dITPt4ChGEX/
	OAejO01D/dmIPKekyFbU2KSzJoziiBldc3IszhvnNU/eMOAU7l3nwzVEvzGcE5F9QDS+f1jLQ4gtB
	XvyNi11q1yFtELgZHHozeREaoL0/Fh8+xyXv9FgOXjOkptbLmyafqq3LWx0aRf2SDTqsBE3sYrYs0
	uxsf6UG82EwB0d/DQn2pZbExTouSSa7Yty7yQgqtXIG9is44ZfkstOVg4uK12eSHvKgbLHMj7zwQF
	HAiKnvhEzSZb3OyVSuXWpRTzXLT12u4+/vWO6DMzQ6IvMXBVNoM1My8On5KIDYjMOxuVRpn5u98JC
	JUey609w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYVH-0060O8-8k; Wed, 28 Dec 2022 15:38:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYV5-0060LO-9a
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 15:38:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7ED3268D06; Wed, 28 Dec 2022 16:37:45 +0100 (CET)
Date: Wed, 28 Dec 2022 16:37:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] nvme-auth: fix smatch warning complaints
Message-ID: <20221228153745.GA32688@lst.de>
References: <20221225112851.351885-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225112851.351885-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_073800_336224_F4E4FE07 
X-CRM114-Status: UNSURE (   8.78  )
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

Thanks, applied to nvme-6.2.

