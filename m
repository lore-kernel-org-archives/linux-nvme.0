Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DBCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 05:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5CHM1ScxRJ9/WWarEsT7DnCeMBxy0euFRCF5vYWwXI=; b=EHCqH6vlYJgIOt9QhbjnE441JG
	TOzZ5AdFrZ9YukwXEoqfIROfKNwD9TDtiAvZuYd5pnnDxr5YZNNqbkSn1P8Kxxdg7hocUc75f7Evq
	/FMMW4ZYVYYpzNxBcQur3eqWK3V3EVS9tfxvIcWjLmycu0/mESukHC0MEubHktP7X4ZOt+g9sYkH8
	jDZ2XMzkKwlbiA+QBYWaXd0r+fW81+XQr71cwZxRj7zlEbnqH6q2URX7ABy/IfUYBia1JluWJGGsj
	RVwsOFvgQcnvfwpYGKg2ArYw9NJfWhEQkFEXN8G5XS9Tcj1mpvDUbCwlFYGmEIe4sz7V+Y4KCUpWj
	GTyyv5QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpOpP-000wTt-8c; Tue, 23 Nov 2021 05:58:51 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mpOpN-000wTb-Ox; Tue, 23 Nov 2021 05:58:49 +0000
Date: Mon, 22 Nov 2021 21:58:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
Message-ID: <YZyDGRhyjYJu+9jK@infradead.org>
References: <20211111132135.19216-1-dwagner@suse.de>
 <YZfakf32dXVFhK5E@infradead.org>
 <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
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

On Sun, Nov 21, 2021 at 12:22:28PM +0200, Sagi Grimberg wrote:
> 
> > Thanks,
> > 
> > applied to nvme-5.16.
> 
> I thought this is not needed upstream. Daniel?

Why?

