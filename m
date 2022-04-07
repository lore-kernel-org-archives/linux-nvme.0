Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B23EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X69adQDrGwDZlc0D5nEGrCy32SkxE7qKRKZldZufcHg=; b=SM4r3pbnCjZU1D1oxcdBPkqPj3
	wIckNrQQh3Ffvw7IiPYcPQnZgSqD02G3c9v/8FjILzfFobIeXVkV/Kl3+vTbBeIdwwdgSwaXupgb/
	rdgy5RogoAAYjWasCkY3+4vhb++B9/YnI1xvd29fQ+kxDhvUZwg+aYmbcgMBjC+1iBkXo+hD8ILUN
	+8QZbNBg3c2/ZbOJmqH4/U+HUatMH32cV4H8wimlqCQrckp4Ke5+HeXxhFZddVVQKxWK+eHQCi9OR
	K7K4AbMkFWKCz6rOIZJgISBEZr/Rl6HrEhDSgQTQ9t8NBVInqUNvfj0GAXxJgpWIDJZO4lo4NMrhK
	ECLZwUWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncO8u-00AiSI-2W; Thu, 07 Apr 2022 09:09:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncNok-00AZ3a-L5
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 08:48:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0CAA568BEB; Thu,  7 Apr 2022 10:48:32 +0200 (CEST)
Date: Thu, 7 Apr 2022 10:48:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Message-ID: <20220407084831.GA19062@lst.de>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_014838_886354_441FBDD8 
X-CRM114-Status: UNSURE (   8.00  )
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

This won't help with other controllers.  But it still is a useful
patch, so please submit it separately.

