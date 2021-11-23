Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5370C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lafoumQONJIHOzxWhA7cp8PRo3hyaQg0pPXGxKwik0=; b=3PV0hEBK3VeImn0M8MKoueDSDK
	BH+kFbjKEP4FsxH6VulDR3jWIMImAhgYujHDOrUrAbkaonzWIEOSN7jE8EBcKPwnx6fE+jePVmPgL
	GdZ0ITlPtVydOKnpxbK6YSvMtyJRsV8koEV87jWphqki/c6KOJkSxYx4V2Ehii6dpoe/xjo4wQOQt
	T2vS27+mmoR5OQXRMped5/72WSfYPMmsws2hNKJWAjxFmCTzN0KTW63GEKBEeWOj3KtX+ysuL3I/v
	7mWUW4IpUDJpVwxRx2X85b8FgHQpge81F5dzq29z6nFyF0NEztEQNushmi63DYyj/8QwCFqt3bNDF
	Gk9lmHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpfK0-003hbh-UO; Tue, 23 Nov 2021 23:35:32 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpfJy-003haq-D5
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 23:35:31 +0000
Received: from [192.168.126.80] (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4HzL9F04Y4z2jZm;
 Tue, 23 Nov 2021 18:35:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637710529; bh=HBtWdJ5zUb28ErfUwUNE14xqSlNsDyjDfpzy2cbGpww=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=exvnzz/eEC966N2LvA2irfRvqxboThIcXUSNxas+VnsNhPDdjDRNrhOOOWfeSwAaJ
 uT7PRfDQUjq4ene50x5eAKvUSRym+aElzpzAfgWIE2yTXvIxZitGSMfp1iI70DSNY3
 1I5rpjHaqIZAFCCXNcKgd91aQczaDRKCRD1cwHUk=
Date: Tue, 23 Nov 2021 15:35:28 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
Message-ID: <acdb51c1-2980-4f79-3fc2-4f834fa7501d@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_153530_552834_8EA07AB8 
X-CRM114-Status: UNSURE (   5.25  )
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


On Tue, 23 Nov 2021, Jens Axboe wrote:

> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

Thanks for getting back to me; trying it now. Today seems particularly prone
for some reason (can't figure why, my workflow hasn't changed much) so fingers
crossed.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

