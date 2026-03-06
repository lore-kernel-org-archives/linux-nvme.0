Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F49F33A92
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+0ng0VkF+fh++aJEbIr0JbXp8W2Xa0y2C+DwrwCE0g=; b=RF6nfRh4FrvzimiXqsoaQY/lYh
	c+vdZ8T9fV63NdSI25wXUuXzf3cOw2A0/t+Ebr/S5HWt5GHvxLvLcMe1Gtf0cUFdD+S6NtZv9IyVk
	qgy2St0Pj3rfNKD2BofOZ3CYhai3VaD5UD368DV5sON4Wq6Wmbqubq9WTC6+ds4utjJ9XSGnm/gPw
	jsKp0FJJ61CJpDo6tVJcrsBaJFRVx1AjMeEihUtnop9Q0JzrYHNZexO1OQQR7ILRqAe1qWUw8w+e6
	b4pj7o6hYyWld1ewg/pLBtGlpHMIbefSp3/PWCWgVpiOjj9d77zr+fg44k2MASaO9Aa3h/3m+NgXe
	BWAd6Uww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyW6j-00000003uHy-202o;
	Fri, 06 Mar 2026 14:24:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyW6c-00000003uGD-0VqT
	for linux-nvme@lists.infradead.org;
	Fri, 06 Mar 2026 14:24:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F3CB68B05; Fri,  6 Mar 2026 15:24:34 +0100 (CET)
Date: Fri, 6 Mar 2026 15:24:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robert Pang <robertpang@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Zhang Yi <yi.zhang@huaweicloud.com>, bmarzins@redhat.com,
	brauner@kernel.org, chaitanyak@nvidia.com, chengzhihao1@huawei.com,
	djwong@kernel.org, john.g.garry@oracle.com,
	martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com,
	tytso@mit.edu, yangerkun@huawei.com, yi.zhang@huawei.com,
	yukuai3@huawei.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: honor NVME_QUIRK_DEALLOCATE_ZEROES for unmap
 Write Zeroes
Message-ID: <20260306142434.GB16612@lst.de>
References: <20260305202735.1773922-1-robertpang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305202735.1773922-1-robertpang@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_062442_326462_97538001 
X-CRM114-Status: GOOD (  12.34  )
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

On Thu, Mar 05, 2026 at 12:27:32PM -0800, Robert Pang wrote:
> However, certain devices already use the NVME_QUIRK_DEALLOCATE_ZEROES quirk to
> indicate that they deterministically return zeroes after a deallocate/discard

Those certain devices are completely obsolete first generation Intel
SSDs.

> Update nvme_update_disk_info() to allow the presence of the DEALLOCATE_ZEROES
> quirk (combined with DSM support) to set max_hw_wzeroes_unmap_sectors to enable

No. This was a hack that got sneaked in in the first days of the nvme
driver and never should have been there.  It most certainly should not
be extended to any new functionality.


