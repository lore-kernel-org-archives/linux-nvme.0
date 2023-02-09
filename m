Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AC5C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 05:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WAJ87P2siboc5t7utwShD71sEOc1NCF7c5GvFO7lDaI=; b=hhmNKAdGurAzWFlA2ifWXRya1A
	GG6k0NzXId4uVEywo6y7P3nXg9Z9Pq7EKbKPNnC3GH3/VwyykmhkhC+3JiIqOIj+SVjiJmLdONTU6
	JW5pKhI9vO3UqXTFxFpVgMhTcwY4zj9Cxwp8gc7znaHG2e8+9xbjq4glVRnJzykSMkSWMMmIoyYG8
	7NpQFrrKvlWNWCXtMsIlG3ev9Yqi4YYzNP+IPbV+w2HzxInihGRL9Fq+r7yrVBxkC2O5+ZNzynDQT
	vwSMRynQt+OLrdJ2xwLo/0Zo1UhU8Me1VO8SExsd5D1RovT5Jgt9Ygh/JuceqHzRgLV4IKoxrVaNI
	l6AViZQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzM9-000CNv-Em; Thu, 09 Feb 2023 05:20:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzM6-000CND-KV
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 05:20:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6664367373; Thu,  9 Feb 2023 06:20:18 +0100 (CET)
Date: Thu, 9 Feb 2023 06:20:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: make 'at_head' parameter for
 __nvme_submit_sync_cmd() boolean
Message-ID: <20230209052018.GA8510@lst.de>
References: <20230208151720.109130-1-hare@suse.de> <20230208151720.109130-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208151720.109130-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_212022_838787_6B5DB523 
X-CRM114-Status: GOOD (  12.81  )
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

On Wed, Feb 08, 2023 at 04:17:20PM +0100, Hannes Reinecke wrote:
> Use a boolean for the 'at_head' parameter in __nvme_submit_sync_cmd()
> to improve readability and consistency; it's being converted into a
> boolean anyway.

I'd much rather have an INSERT_AT_HEAD bit flag, going all the
way down to the block layer.  The use of a boolean for this (and
also some other things in the block layer issue path) is really confusing.

