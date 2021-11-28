Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7B8C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=maM97s3eFQlA/M/G3Jihob/eazYq2PwLut4O6wEcl54=; b=C1TEv9Zo0pDclXgKOCrpBOC1lU
	p7lsitpwU+zdXNHa0f7Z/f4ZDiDl71Mqg3YVwHfwCgFOmAqmevdcz4xjEXW4XB5Bo8n9lds3DNs1C
	51+kDLGJ63hwFdXmYgIvRCihfAQrgI3rWGefUkOL1JhO7fXyLwgLRWMyddB7q2dd1WZTIMrzCwJO/
	K/pJPxGZzv1PZzWE+V2myFeYGF4ahM2pXQmskBHvPZJUF040SiKwTR7p09e7DiFj/Al+RaWjrerGJ
	o27/EDZ+MzcBDj14iBn8BYKjY5u5S0ELywy0DwvW/0FmcJu1JKpy9Fvb+Pt4XUxrsk9KHRycdW+1N
	nf2tO6rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mr7nC-00Efug-3u; Sun, 28 Nov 2021 00:11:42 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mr7n9-00EfuI-6F
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 00:11:40 +0000
Received: from xps-7390.lan (mobile-166-172-187-190.mycingular.net
 [166.172.187.190])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J1pn21bDvz3rvq;
 Sat, 27 Nov 2021 19:11:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1638058295; bh=54ypOB+ijgfXMIzAJ3Y0gyBZ73m6bLpMirz7eYhg7Zw=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=RO/d+G0ZjwEhnybrmtseZs4rGg4ih6PNn2ORJl6olZDHHDZeVY4XrkB5PuIQsJRQT
 /CBkkcqNI9d4KcEgltil+OO6NhblXO1crj4UtUN9pr7u8RH/ESo4dJOwEB8HEbyIqX
 xKO8ta54U/AsaAF5DSC7rUQ0V4XextNQxIAZxHqc=
Date: Sat, 27 Nov 2021 16:11:31 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
Message-ID: <b549b4ce-4156-eaab-a146-1fa52f51b642@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
 <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
 <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211127_161139_417349_719104A0 
X-CRM114-Status: UNSURE (   3.84  )
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

>>> That said, I'm pretty confident in the fix,

Moot point kinda, as I see the fix in Linus' master, but yeah, it's working here.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

