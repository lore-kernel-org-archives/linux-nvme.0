Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9BDC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:42:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404E36525B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404E36525B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SfPhoBGyG2ba/cDXu0ieJ2HpddBqGWCHzWr7xtrX/gs=; b=koF4MBvsZyFg0S0J1xDzImeoV
	azD4fgWtpEB0xQWqE6dmTTXcOnvo6wlEOw3ixheHjFq5oQGK2lxD6qK5mHLvz2XngqjBNfDr+toWh
	ellikSkPxFlpyxYWM9SeBRCjupArDUOG+183n5dk8nNSLOTAoJAJVnnxILIgLEvivhgXb4EhbBQGD
	tEz26TG443OPvHfV7uDzBnw9PkukyGiXKC8x4F2WhJ9g+ZELPZ/buX+Pep+KQ/1HciB0gHPDEIbYC
	Lr14857v5PCNKvjUuCmyaBNjIU70WjBKR6T40nz4L0Dn/aCaNUcuvISn1yXwPO5lsV9gK7Dseww8j
	sz9kjHIUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJakb-004Lyl-7A; Tue, 09 Mar 2021 11:42:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJakX-004Ly0-L5
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 11:42:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9869D68B05; Tue,  9 Mar 2021 12:42:04 +0100 (CET)
Date: Tue, 9 Mar 2021 12:42:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V10 6/8] nvme-core: check ctrl css before setting up zns
Message-ID: <20210309114204.GE9520@lst.de>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309045823.18545-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_114205_887169_09893128 
X-CRM114-Status: UNSURE (   7.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'll pick this up for nvme-5.12 as it is an important bug fix that
might allow not spec conformant devices to slip through.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
