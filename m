Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC9C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UugCjklOjCn5kZMbTDF5u+Tcynyl/XAXE9RFMUvansE=; b=PftWEfoNtHgjWQ2F1dWbu8n2Q9
	AAxcV9fdwVe/g6WoRd2mhlXq4t7Fmk/sbnLx/IMHQMSYbXCVavgYrlm/KycAl1/cL/eXBn61UhHV6
	5v8LRN5oO9AFBswJlbNRuKric/UaobGKnD/MVEp8CsrxSxdAEOr2E1/QRHy2IPN5buQSH4Uprt20a
	sdy0VqwWyWroB+HsIBrLElPzrthHgVMgT0OZrcuQovbWQRt4JYCqHXty+lyUn+K+J3IdH8DHHrRp3
	IVVvnpuSSyhltNEmi8L37xeBLGIrejX5+SfPOe4t7d+rhsDUjjEBpsZMep1VH2Q0hRkjJUDxIzpLt
	B6UhOo2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olrwz-007svR-0H; Fri, 21 Oct 2022 13:20:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olrww-007stb-2Y
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:20:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50F4C68B05; Fri, 21 Oct 2022 15:20:31 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:20:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <20221021132031.GB22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-4-hch@lst.de> <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_062034_280000_009599EA 
X-CRM114-Status: GOOD (  11.29  )
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

On Thu, Oct 20, 2022 at 11:26:55AM -0600, Keith Busch wrote:
> Since you're not dealing with flexible arrays anymore, I don't think
> srcu strictly needs to be the last member.

True.  I thought I had removed this sentence when copying the comment
over, but it looks like I messed that up somewhow.


