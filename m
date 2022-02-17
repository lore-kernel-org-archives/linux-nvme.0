Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A04C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gszJw5NanmlBBPwD5ggKbtfwZVx9hGZz22qO6pYCC4I=; b=jZzXgf+QCNsoARKXQY1jhXFHp9
	g8Nb+7x9//vVvlaQk//8bJJMrpIvDqTDEVhD6CSWRqHi67ZUr4dbhp07ZIAIEPfGDxZgrFHN5hVnU
	og2hmaBBgi/xB7McycMxHhUV6rbSNZYwrC2ZoeIQtBapsRCt4Q8RsCLcrsaRyI7xyALHzpUHmAESI
	83uedP4XcKlhARSjEMZK5ZcQzpCJlgT6t/a2BhPt+goxZ8e7wXeOaDwz92ckPZdmc6/xlAaDh37Cw
	9w79NZIF4ekbVjS8K26ssaNEqEzwClE4IFqmmpVY+SjUr3CJyaM+Hrffy7tq+AGBGZSLWFfqjdbd1
	7w6rmhPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKhYE-00AvdP-PK; Thu, 17 Feb 2022 14:14:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nKhJj-00Aoma-6X; Thu, 17 Feb 2022 13:59:31 +0000
Date: Thu, 17 Feb 2022 05:59:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: NVMe K/V value devices
Message-ID: <Yg5Uw3o87cEyaMo2@infradead.org>
References: <Yg0QPv8nH+TusRe9@infradead.org>
 <CA+1E3r+98wk4MiaVwtOVHKVfR4chFTiA7soD+wPJ1HFmVGXgXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+98wk4MiaVwtOVHKVfR4chFTiA7soD+wPJ1HFmVGXgXA@mail.gmail.com>
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

On Thu, Feb 17, 2022 at 04:42:08PM +0530, Kanchan Joshi wrote:
> I do not have it handy, but I think at this moment there is nothing in
> the nvme-driver that limits block-interface for KV. Are you thinking
> of restricting char/passthrough only access?

The block interface obviously will not work with KV at all.  But what
I'd like to do is to offer the passthrough interface for all command
sets, including those unknown to the driver.  Which would be pretty
simple, but I'd rather not land untested code.

