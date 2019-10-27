Return-Path: <SRS0=PT9J=YU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF3CA9EAF
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 15:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6913F21726
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 15:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JE9lTjQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6913F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uhbyj50/mFkttgNBu9FCdGffx6WyJTUqXFG8ZOtjsaE=; b=JE9lTjQegYYFXD
	CnMOhpcGm7dhX/wS+3B/HCZLwfvSQ7KpAAoDw0+u0pg2cc1Jt+fdESJ0UnSGkLTgwlq54eP6x9Ixb
	gwDJU5u8TitjDmrUBphVQHPl/wXXyOf0DgR7e7DkDtUmdABfZKOdsJy+tgb1njVpr9ndKRElHeSJN
	/4GXvOjjL5cYTE/TzMIyCRkMD9Apf+R+V7kG41o5uaKB3mmFUVRh7OD3qhOjeJQQifmwQ1Y/diRch
	WbnqM2u68WvR48Mp3KhX1/KexUB7+bqF2ZUSVvYr14eyvNhww3gR78d6tztrCixwEodAuabW0Ixo1
	yEV/2dQ9ht/Ly3x7Pq7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOkGz-0003cL-5v; Sun, 27 Oct 2019 15:16:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOkGx-0003bV-ES
 for linux-nvme@lists.infradead.org; Sun, 27 Oct 2019 15:16:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C9A2368B05; Sun, 27 Oct 2019 16:16:00 +0100 (CET)
Date: Sun, 27 Oct 2019 16:16:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fill discovery controller sn, fr and mn correctly
Message-ID: <20191027151600.GA6199@lst.de>
References: <20191024165558.28056-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024165558.28056-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191027_081603_635515_64B5031F 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 24, 2019 at 09:55:58AM -0700, Sagi Grimberg wrote:
> Discovery controllers need this information as well.

Can we please lift that code into a common helper?  Especially with
the desire to make the information configurable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
