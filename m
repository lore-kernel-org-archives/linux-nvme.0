Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77262C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:14:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADE164E05
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADE164E05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rxW8oc6RBpUO6lpG70oHkIJC92L++lK3qEGfzoJClc=; b=RYZFjmseNnISP7QV0X1/WAPj1
	hSBA6Iqr7W0FMQUrE1x+5MMnKR8heKoyuDwQx/rw9aCBiAiysc6V3IUQjrbYrUBo8rclVyEYEgG51
	BL2f3/OY5ed50kcOt11NAauUY/+ldsprwrPoSqCf6QYPtstKW3oyp18IeSzNlBLvm+j8br8APKr1X
	6TJCCEdUs0kCik7KZH8O4qSE7bC5VlsU4PMWq+C3+ft8akJlq5VytbXGkLXtiI5W+rVpYnlhwckve
	L0pV4a6YdHlmnCZtSeumn9VhpyzSjyfv6IsNlOa+RuwY5C534qbLxMyOGaAv70TZu+dhW0PhB5D0b
	opq/2Wy0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqFi-0000id-VR; Wed, 24 Feb 2021 09:14:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqFe-0000hR-ML
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 09:14:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1ED5968D0A; Wed, 24 Feb 2021 10:14:33 +0100 (CET)
Date: Wed, 24 Feb 2021 10:14:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Subject: Re: [PATCH] nvme-fabrics: fix kato initialization
Message-ID: <20210224091432.GA5517@lst.de>
References: <20210211175826.4821-1-marting@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211175826.4821-1-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_041434_918698_90A0443C 
X-CRM114-Status: UNSURE (   6.17  )
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
Cc: kbusch@kernel.org, Martin George <marting@netapp.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.12.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
