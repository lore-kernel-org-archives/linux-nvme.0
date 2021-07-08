Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B0C07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB0D61C59
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB0D61C59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGOZrjUdrUJskcvTdOT42yGPCc5sUDVifX5oWB01XEA=; b=g8e8RLxnbQD+5P
	td+NPsW5sKBUbvg76XUFSo2PKb2GUPLKsBHeEN6fw812yEkqlD6dIpaCKcBzOns/cWUyjwkyizjqi
	szlPwp7i74eEcyqTlVy0fkKojyG3qdgjFzqCC/6d228tVzoAyLYijG3uCnGgu3cum93UbIWIM5Rxf
	tdEcfQ01J0kECy42LdxfYymNaggdhs5kJPWbOqeHLtgPOI5ZOTtyq7ytPqRmfzeGQIDyz40qFYd8n
	9Qe9lJrZAApbq65VyeEt2Q6bszoqUfqU8Pq/a1T8nyeNPZ+NhDW+AleT+5XAUB5gLH8+Ke5ix3eHR
	PgBiA60Hmb96lAnNGtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1Qro-00GY3M-8M; Thu, 08 Jul 2021 10:02:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1Qrl-00GY2u-LL
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 10:02:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 07DDB201A6;
 Thu,  8 Jul 2021 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625738564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY83sUxbP1YSNAyFbL4UskenZ+HyPDBkx+OjgcKakrE=;
 b=wP8WltU2JOnNk/F9ekzexzCBJ9iAsOzWVvWuSwtzfJVz4XHAaZBalXvZOHyapgHtFtZikx
 GKb3V++fvphZuKwqQXF8CTyL3X7l7/yI+sxunBvOMAN6xSP9CDETm6Ve2R60dMhszn+xP+
 JE9P9bdidGm13AT3xeVLWDWH3etl2OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625738564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY83sUxbP1YSNAyFbL4UskenZ+HyPDBkx+OjgcKakrE=;
 b=fsIVBWGkKAmx9LqLBi+zLp3vGxugJmHOfCJiSMvGkDixjYqX9SJ10esbf5aGeAX/05TNsO
 GLuppn35xp57ukAA==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DDDD6A3B98;
 Thu,  8 Jul 2021 10:02:43 +0000 (UTC)
Date: Thu, 8 Jul 2021 12:02:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request reference
 after completion
Message-ID: <20210708100243.ibmntolineesakyj@beryllium.lan>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
 <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
 <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
 <20210701115123.ir7huzzpifhsk7cz@beryllium.lan>
 <20210701115220.GA12095@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210701115220.GA12095@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_030245_885601_0283976D 
X-CRM114-Status: GOOD (  10.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 01, 2021 at 01:52:20PM +0200, Christoph Hellwig wrote:
> I think this can go in as soon as we open the nvme-5.15 branch.

nvme-5.15 or nvme-5.14?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
