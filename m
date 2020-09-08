Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE7C2D0A7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:47:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D592064B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pyX+U2BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D592064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=72da5TVfMldWO6+Ipdp7gukgELxYvO+sld1mNZSB+TM=; b=pyX+U2BPNdIlPJAjTdRw7/3wS
	Ej/W3xFI9QKc0rkxCZLXQbxxj7oNBDc4qxIwmqnEskw+VYxqLbVGYPYNkEH+FNQZ4/TgwJMBAZmca
	Xd5/rVOzuoWKzd07sOf3QY9fJN/CsBOuS/445Q7pt8vDYwZsDY69ztfOrjyxXeCJxZt8DUB8l/MO9
	BDo7z1QFwn07sPUxT7pf+nw/ggEWeP4Fw9cQAyOk0E7J0TXqaC754hiImbFlq2/WtoNH/dJuQbxMQ
	GW+EF2HAzgSC01kiFGBu2BCY6cXiYxfZ8TBm7NzHhCRBy5sHwoBMNVrphqiJQCWkQxhBRzO2NZcFm
	yDgs8yb5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFhij-0008Fw-SJ; Tue, 08 Sep 2020 17:47:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFhih-0008Em-Qq
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 17:47:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3C68668AFE; Tue,  8 Sep 2020 19:47:50 +0200 (CEST)
Date: Tue, 8 Sep 2020 19:47:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with
 teardown flow
Message-ID: <20200908174750.GA20319@lst.de>
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <20200908174727.GA20285@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908174727.GA20285@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_134751_992106_46BA9C1E 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 08, 2020 at 07:47:27PM +0200, Christoph Hellwig wrote:
> Applied to nvme-5.8.

Err, 5.9 of course.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
