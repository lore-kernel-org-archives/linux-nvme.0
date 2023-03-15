Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE0AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=U68t19SeoFvXYnMU+YpSUaX6X8
	TvblB3YNjf526032B+GGn7Bq/d/LlQtALrJ+PdJ2ehtAJPD3mN5Mvnj95GBDy5l0lbhI/7ZN0a09r
	ZkKXnDdbw7o/p9NLbley+R7QUWGw4UPhh8NznDGtYlT/59i718vfdS3Rs51jqfaU0zLw0rHtl6sDS
	+wcu8MIoh6Dm/jDe/0kdtbHPp6RGX6jAEb3cRF7fQhH3ISpWFPmWtF63NuVNGjI9pb2UO+NuCxo9c
	kgOXt1pyqb9b16ZLu3ZuV3wJcwY+UREWRp/yzit5oHx7uMGd/ZTyzBduc/jLjXt4xE9HZ9JyNVjaP
	iVJJshBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSqy-00Dq2c-2T;
	Wed, 15 Mar 2023 15:15:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSmJ-00Dlii-38
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 15:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB9C468B05; Wed, 15 Mar 2023 16:10:53 +0100 (CET)
Date: Wed, 15 Mar 2023 16:10:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, guz.fnst@cn.fujitsu.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is
 done for bio-based device
Message-ID: <20230315151053.GA32066@lst.de>
References: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_081100_176842_ED0B6BD5 
X-CRM114-Status: UNSURE (   8.48  )
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

