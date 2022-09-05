Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5F5C54EE9
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=cwyNsjMqJK2iM/6vZuNeGeJHVF
	mcrXuvnif9wCJpupTUlLcfrsuOnyXCXjv+IAC+4OsJhHbbJUi4qg56m081vo+0nRRuuul2k9Dzrud
	ZZRm5DDazy4y7Ym18wGqcIhl7TzJ3A6t2p/O4lFuom0+iKwxVLGDIR0EqR9+LJNVhCmW9RRcecYn2
	0wUnuSX1GyuhLnYAfWie0z5dFsW5JNzfVV3vU1a/yncd6UeWz5dU7K7JmBUIs49aEPiF71H5kL+lH
	dYKpPknw1+s+QNNdwQETUAN5L0aXBp8A3YJ/k2sr++A9JFkpOatVDsw/d9m7KNouqVGSLTOc9Vh++
	BJY2Eo0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCm1-004AgI-2v; Mon, 05 Sep 2022 14:08:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9sE-000oK8-VN
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:02:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B8CE68BEB; Mon,  5 Sep 2022 13:02:32 +0200 (CEST)
Date: Mon, 5 Sep 2022 13:02:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linjun Bao <meljbao@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add comment for unaligned "fake" nqn
Message-ID: <20220905110232.GB21823@lst.de>
References: <20220810140812.GA24773@lst.de> <20220811074024.4382-1-meljbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811074024.4382-1-meljbao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_040239_495850_644CEF2E 
X-CRM114-Status: UNSURE (   9.15  )
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

applied to nvme-6.1.

