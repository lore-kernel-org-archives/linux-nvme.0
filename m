Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DFFC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwFU+eEcxDbMj3NsHG8vNO0tgM1xmF9XNTg+rS4pQEA=; b=1vgy58eAKCojos5iskgfMkq8zf
	anxUtpap7raMfUNvYom4NbyvTYv51q6H6Z7XDsNKglb9uRV7rSjxQvhKckRWkhYOOMNsKv4JU9at6
	elH+7k6xuWbKAfwTM9vZ6NWSiKA7Cc9//qv/ZP8V9WMJyTNSaglOLjSKZjUVdRxlS5cJ0EpZixSN+
	qV1Zn8BcXbfku8ppaWSQyCkPg+U/CdigovpBUdRaAddbl9wMGoXNZqos6ujTQY/KsZGwmJc3wOLyf
	oSp6b4pKc6TgW82pcoKv2keRh4mC8OCkjPszc/8POKz08gp93rrTbdJGEPHXcc8+FaDadnRQkvNYE
	vMz9d79g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrU8-0000000DoOy-1teq;
	Wed, 03 Apr 2024 03:40:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrU4-0000000DoNl-4A8V
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:40:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D68D68BFE; Wed,  3 Apr 2024 05:40:15 +0200 (CEST)
Date: Wed, 3 Apr 2024 05:40:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
Message-ID: <20240403034015.GA21683@lst.de>
References: <20240402144754.751976-1-hch@lst.de> <d4261559-66a5-41c6-b308-992b9e61ce85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4261559-66a5-41c6-b308-992b9e61ce85@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_204021_194880_37939217 
X-CRM114-Status: GOOD (  10.32  )
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

On Wed, Apr 03, 2024 at 12:14:02PM +0900, Damien Le Moal wrote:
> > +{
> > +	lim->zoned = 1;
> 
> Nit: "= true" would be better given that this limit is a bool.

true :)


