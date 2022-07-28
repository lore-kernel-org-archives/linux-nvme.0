Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D8C19F2B
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7R9KkCO0wZDI0KVAOOJAxneA/dxTC/0eO41a96rn5kU=; b=uir3r5j5YAd+sompNWuGz+SaTv
	TSXYgUYU+QWUGXjlnUISTQkip/HLVEgQ8IntEDww/DSinICx+Z+3OSK7dPNVLzAdeE1JaqigouUbY
	044WnnOVg7xUfCE4+qtbmTR527YzPW2DUhnslfQCxyJRCIYywT5yHLaMx8EyVkX2fiYZheyU+0tZL
	aFp2P4ZbqfoXsr2sH/2LEhXiR+WBB/pQ1xaEiymrPrKvc/3eilL170LCI4PzAi9Akzn58LlEOn8TA
	6fE+N60Rqs7AhZMYt4modU7iJ3tcGKc0EwzpkfWvviwx59f+l+O2cU59aFtbkEK8uFrqisEQ69fiY
	y7fpszwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH62Q-00AnDq-8d; Thu, 28 Jul 2022 16:07:02 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH62P-00AnDZ-A9; Thu, 28 Jul 2022 16:07:01 +0000
Date: Thu, 28 Jul 2022 09:07:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com
Subject: Re: [-next v2] nvmet-auth: use kmemdup instead of kmalloc + memcpy
Message-ID: <YuK0JRw/9msWCyvw@infradead.org>
References: <20220726025632.1401689-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726025632.1401689-1-zhangxiaoxu5@huawei.com>
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

On Tue, Jul 26, 2022 at 10:56:32AM +0800, Zhang Xiaoxu wrote:
> For code neat purpose, we can use kmemdup to replace
> kmalloc + memcpy.

Thanks, applied to nvme-5.20 after fixing the coding style.

