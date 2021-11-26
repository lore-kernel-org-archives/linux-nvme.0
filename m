Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A9C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KtDvwluavbKcCNuDU9utI6QGtGwwJ78ElPTR/iUZH+M=; b=NGZohzawQ5pP8uBR8VUGBNKlYX
	tJF3eDa29Yzn1lD7G9wH/bqmTWQIj82wmBUi9VwKs4akH7P9ri7Nz7Mo55N5NPKaeP9njZydpK0aH
	yO2qSqRIF+/dvYD9JB0RVK2XCSMOdv6K2k/qN+3Yh2boeZxfzBjrf0ZjSWUc2Ftv/30kfdlHfw251
	oyvnUsBFaCGQt0vNDP5/krwLpL0f8pDHuSIfAu/11styyeKq0zxEO+IPZMJ+jP/hwGq6JM3zPFjIq
	ppyxkza1y5WYkJedi2rSr3Elor053r1nucCL7rI79DvpSi/CAKjuVtgh4XzAzbgjJScxEwqAhy0Eu
	jTre8JBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqfUO-00BMit-Ls; Fri, 26 Nov 2021 17:58:24 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqfUM-00BMhe-39
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 17:58:23 +0000
Received: from xps-7390.local (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J12Xq2bzPz2wQp; 
 Fri, 26 Nov 2021 12:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637949500; bh=IGNkEdY/1fSW0p0DFCKX6RcLSqM6E0d4vaFMfumBmtw=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=YS+84g8rKkhBrdTRSchw7CEu/65NpFZwQCMztRP/04D0Apb6Xp0npukJWqyz9R1Z7
 rW5b0GQwPHYDq7mpnV0Gr1f1bVORwnXwhqR2KlLHYOcK+SFQhb/IHOsjgiwH+ttD/g
 q9x4CC/s3UZSA1zOBnR8fHzcnH9rL42Pxjo+3sRs=
Date: Fri, 26 Nov 2021 09:58:18 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
Message-ID: <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_095822_230522_C7C55DC4 
X-CRM114-Status: UNSURE (   6.80  )
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Fri, 26 Nov 2021, Jens Axboe wrote:

> Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
> it for you?

Since it's related to writeback throttling, is there anything I can try to
taunt it? I was thinking "iozone" or "bonnie++", but if there's something
better, let me know.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

