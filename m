Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9500C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BF7TrxuHg8VWiYmnBgXSU6xi1GIgMGkhEuKcEkcRrWE=; b=Qy8LOKOseGW25/R/kqY/qUXqdC
	y4bo2nTWmu9L5xZe1I2l/nh14qWn9Xf1Yiw8M20wwbIorjAWQlCQKze0t03mzNxzPQuFnS4g137g7
	9tj7V4lQ+qGqpcNDQvqgLDB6eJWOZsDdnc4EHOtj6fXvrJEi3ijJETd2b0p7xv5ITLxUnEKLpOkFI
	6OrcyinsY1e0O8Gn0Eq8IXGszx/KL1QJUAwvASZv89VGPURF+qQYX+ln6ysNOZRzRymlpuD2GBKDV
	WZ2V5NqOFhcYxDANw82sV+tPz/8BhUBNmPs+QkWYsZ3j+RddU4V1qrDxrCCErpvGnHmvPWZgq15/j
	Y4mZEO5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpKd-005R94-4X; Mon, 26 Sep 2022 14:43:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpKb-005R8Y-Gx; Mon, 26 Sep 2022 14:43:37 +0000
Date: Mon, 26 Sep 2022 07:43:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <YzG6mZhtd/QysvdH@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk>
 <Yy3O7wH16t6AhC3j@infradead.org>
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
 <YzG5/1zSdiMlMLnB@infradead.org>
 <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
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

On Mon, Sep 26, 2022 at 08:41:38AM -0600, Jens Axboe wrote:
> Sure, I don't really care. What name do you want for it?

Maybe slow and fast?  Or simple and meta?

> 
> -- 
> Jens Axboe
> 
> 
---end quoted text---

