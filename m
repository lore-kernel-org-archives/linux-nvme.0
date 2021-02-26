Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF217C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:11:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC27601FC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC27601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+9RdwjkQ2ENiwdrtzGun0avjPTx6LzgToZcAMS6W/P8=; b=JSByYIZmIPw+NYdTaXJOZaz0w
	1S5Oc0Fy4KmgTxuLD0qJ1TEE5PHiXPflJ9y3M/Q9x/FK76zH3b1j0vLIEXpITfxhOC19nM0VMN31V
	GFLRV1BBBHHPdsLjnFAQmkY5mfQ32cqRENYAB1F0+jf2PKeLg3zSGPm17+anQQrRtQBVnAOS1UfLy
	/PZCglNhI8sHjP0ViSRsiQNa67HdEVOrKFXVjU2XLmw+Jryh/vJp1jvYyWThGN3MbbJ1EeRcSlbjU
	0v2oomS9btigLynr7zZSTOKOWfesRvV19e4H9wwBviBYUZC+SFJlI7KbPggEj/IlpvrM5D+a25CHV
	2WCg/KYdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFZ9p-0001iX-HV; Fri, 26 Feb 2021 09:11:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFZ9n-0001i3-5q
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 09:11:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 15623AE7F;
 Fri, 26 Feb 2021 09:11:30 +0000 (UTC)
Date: Fri, 26 Feb 2021 10:11:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: add 'kato' sysfs attribute
Message-ID: <20210226091129.ejvejjku5u7erdj5@beryllium.lan>
References: <20210226075251.108025-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226075251.108025-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_041131_354602_90FCA32A 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Martin George <marting@netapp.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 26, 2021 at 08:52:51AM +0100, Hannes Reinecke wrote:
> Add a 'kato' controller sysfs attribute to display the current
> keep-alive timeout value (if any). This allows userspace to identify
> persistent discovery controllers, as these will have a non-zero
> KATO value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
