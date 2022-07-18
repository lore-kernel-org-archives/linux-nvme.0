Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4474C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 20:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KKdk3yMadlAL++nLxzC5VkvLimuFAX2/RGSqkqYvWU=; b=B8jr9hX7HmRvBhfnEAYhUIRWFY
	IQqllFZNyqgdVcgQuW2F3Vn3NQXmx4Ft8iwY7qzVgh/nbea8nzFC86DJUi77DnqgJ0DpaOq9otqTF
	d0OYjddxe4pxV7O7th8fjVvpU/oLhp8sli2Zv49NJ6SKVMa1/iJ0ghPb9UVUuIYqm2vw5ypX9NAuz
	v4bitZQTJq3r9f9iLo8eAjV3hCGJBBXBFYbZMXSORpZVMAH+rIm9f09rq6rqtWX7wo3K2uDiy/dJr
	TzW3dgy+JA+ouhcAfh/ItRw8JLtabGOU/I9ffoJP4GuJESJtjz1Orenr4yLJ3f3MVBY3JxmR8e7Dj
	xNCAd28g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDXCU-000jy0-3r; Mon, 18 Jul 2022 20:18:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDXCR-000jwd-3x
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 20:18:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7468560B2D;
	Mon, 18 Jul 2022 20:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F87BC341C0;
	Mon, 18 Jul 2022 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658175517;
	bh=+KKdk3yMadlAL++nLxzC5VkvLimuFAX2/RGSqkqYvWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwIaxJFegf7IwUJOOzwxA7Nw8TRUUm3qvmThKP9829wcoX0WKJXe3Xix8avTc5BVZ
	 WDl5MsrXhaV84ZwHsIMfrtJ/6Rqg2PIbn2v9gfVKJ2HBy9n883YhUCwES3PXzxdD/S
	 PeaOsyufTqzrVhi5ZmsF3EnUeAZV4bryNshMtODnY7r+aK+096TLOWff20HyNMFD9E
	 z00LgNR7gjiKFW/WvQLjmIFvCoBVeIsGzZg+QpbgYL/Zk8Gd0EM+6erx5tCaj8HDmQ
	 g83UIpXsdPmi3/OgZL2GfS1KLD2ZMm5VzaqOOUVeUlME94ap9NLrgutPbCTEyS6uG1
	 mdUu0VjZoNkow==
Date: Mon, 18 Jul 2022 14:18:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: don't always build constants.o
Message-ID: <YtXAGFEuh7mw2Set@kbusch-mbp.dhcp.thefacebook.com>
References: <20220718051252.231757-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718051252.231757-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_131839_213378_3F3C9759 
X-CRM114-Status: GOOD (  10.13  )
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

On Mon, Jul 18, 2022 at 07:12:52AM +0200, Christoph Hellwig wrote:
> The entire content of constants.c if guarded by an ifdef, so switch to
> just building the file conditionally instead.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

