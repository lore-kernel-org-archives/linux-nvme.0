Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD26C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PYP92NBrhj+kJYS4P2w82uupzc7bxGX9eOQbLT6Ntg=; b=IM77wqEKlf8QXnpUu6i7bqQmP8
	nQIqS0A2ARwkkhwP4oJ4sqKVvzsMZSFpXXSIfR1wehr0kuA46nJCiN+qo/YP+YmTFy01bgTzPAmGI
	h5ldJ7HXvFT+JIwQBNEAC2UB6WpjxAmiSNireg6sZ1zmkU7BGpYUUuuqienCJ6BXquxdLBRi4XONh
	HF0nwA1vd7FsQy+7xASB4aREy1FURbATPs8NNvQUTf6uzOjGFMy1ouIfRqicV+BCMZESllqdnLVJk
	p+9RYyIZz7FYwWW7vW2UQkYaoUjaYrI3lQd+oidYHj5tXxqeuKJ5C/qu/5Wpb32v+CdiLnCfqPVf5
	xHj4D7og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIZBA-008EJH-Aq; Mon, 01 Aug 2022 17:26:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIZB6-008EEW-N6
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 17:26:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C72D968AA6; Mon,  1 Aug 2022 19:25:53 +0200 (CEST)
Date: Mon, 1 Aug 2022 19:25:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: avoid unnecessary flush bio
Message-ID: <20220801172553.GA16852@lst.de>
References: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com> <5d0c0304-9116-732d-f4ea-0264501b6b2e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0c0304-9116-732d-f4ea-0264501b6b2e@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_102604_943352_FD866904 
X-CRM114-Status: GOOD (  11.33  )
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

On Mon, Aug 01, 2022 at 04:54:32PM +0800, Guixin Liu wrote:
> Hi,
>
> Gentle ping.

I'll pick it up once the tree openes up for the next merge window.

