Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D9C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7i0hy7M7VlUlff/5DvvnbTzq+R+Q/j4ostQKaaRjm5A=; b=PCtrbH/tHjxrp0ShiycWj4AZ2E
	PwQScn41kKbyYOrMXc4qAwRLAlRlCgcj42/Bdj2A2B4oiuHhbcud8VWuXbRslJTaVSlQmUNfN4gXf
	LhXyydTgPH/Xf+b1V5Jvdk4fW4QDr4KF7AhafDQgkySbf9Xr5Akdz/kbEelfnNJ2+o/s5RMrcRb39
	u4S/MECRRu+UBDsFhXeMGg8ebs+N3mBlV3ruq9vQNjoyaij6B5IvNzv3JCEVwiwzKZaualfrUanuw
	YgkgMrzRBIjYS1zVVfYHbSMkeuJuw3TgoLR1bWccmrUxTx7YFmo5UD1xXyjZRUGznFjvGBky0/ixG
	0mYt7msg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetMI-00000001TWY-1tuv;
	Wed, 01 Jul 2026 11:44:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetMD-00000001TVd-2xZR
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 11:44:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9564068D07; Wed,  1 Jul 2026 13:43:50 +0200 (CEST)
Date: Wed, 1 Jul 2026 13:43:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2026
Message-ID: <20260701114350.GD17996@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_044357_895307_B47D4977 
X-CRM114-Status: GOOD (  12.08  )
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

We proudly announce the 9th Alpine Linux Persistence and Storage Summit
(ALPSS), which will be held September 28th to October 1st at the
Lizumerhuette (https://www.lizumer-huette.at/) in Austria.

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, zoned storage, and I/O
scheduling in a cool and relaxed setting with spectacular views in the
Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surroundings.

Attendance is free except for the accommodation and food at the lodge
but the number of seats is strictly limited.  Cost for accommodation and
half board is between 73 and 92 EUR depending on the room category,
with additional discounts for members of an alpine society.

To attend please request an invitation by mailing your favorite topic(s)
to:

	alpss-pc@penguingang.at

If you are interested in giving a short and crisp talk please send an
abstract to the same address.  Attendance requests that propose a talk
will be prioritized.

We will start sending out invites on August 1st, and plan to publish
the official schedule in the beginning of September.

The Lizumerhuette is an Alpine Society lodge in a high alpine environment.
A hike of approximately 2 hours is required to the lodge, and no other
accommodations are available within walking distance.

Reservations for the lodge are handled as part of the ALPSS registration
and do NOT use the usual lodge reservation system.  Please let us know if
your require vegetarian, vegan or gluten free food or have any other
dietary restriction.

Check our website at https://www.alpss.at/ for more details.

Thank you on behalf of the program committee:

    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger

