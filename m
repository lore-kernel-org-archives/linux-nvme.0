Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9061C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLMozy0dkGzAxkEH+6mTGwef2aO2B+EM3DOG3H3P/ZM=; b=lOHa7AyPiD+/gH7vn4pBhiEXjg
	lltupYjjqvsInQqn6mhnp/jh/9I4FlVY7gce/6nywArlYETk5ckVpgYbOyXlKIS2XrJFbKoIZusE/
	OMenBTdh2BP5mgrfBEoeWzJP7M/P2o0QbH+wmqwbyRFViDMoZllWNShK6DSRLIm3q84Fj4x09M5rB
	oQCvCwfqerqKjFw68qDo/tiiShppYT7w+G5M/GN3QkqQ4mU5Ue2BLxs3ITj4Tyxmbrc70haT4m9HJ
	JBO0K4EJbql22ouO5DfK1zz7aQATHzhCv+SJnW5pvoLG6LGHtCCSttLKCUXYfN2XMHzjPcaZ69cQZ
	LYAex09A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKQS-008QDg-Mj; Mon, 17 Oct 2022 07:20:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKQQ-008QBP-0B
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 07:20:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C179C68C4E; Mon, 17 Oct 2022 09:20:33 +0200 (CEST)
Date: Mon, 17 Oct 2022 09:20:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xander Li <xander_li@kingston.corp-partner.google.com>
Cc: bvanassche@acm.org, paulburton@kernel.org, kbusch@kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
	jeff_yang@kingston.corp-partner.google.com,
	dora_chueh@kingston.corp-partner.google.com,
	james_liu@kingston.corp-partner.google.com, vincent_wu@kingston.com,
	xander_li@kingston.com.tw
Subject: Re: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Message-ID: <20221017072033.GC30661@lst.de>
References: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_002038_199866_6C86B2B8 
X-CRM114-Status: UNSURE (   7.33  )
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

applied with a fixed up commit log.

