Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553BCC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 22:19:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05201230FE
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 22:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05201230FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8kRHPdrZi8jKY6ACoU7DSP8AkLDyHfzlbSZqo3byQHI=; b=WcruUviYLiFNf5NmoVGqtD5k1
	QWAjqMk269BNRpqqL5z4tVxMmFY9y/NLVZxhQTJmQ8rAj/eX7rtr3RTr0NjnJwXDMx3i+SflH1uRD
	odLxqxw1zSWmNM0jHZnugWvfPPBhXG8i7+MNRKU/hHskEdIkdMZdIyDZRcKjG+LIQ8g34R4rfiFyT
	S2NaTtnak2MsQ4JdbLYb67p8AqsUDTp7vRMwXHly22fLa2L/L+npK27Dx2yCh/23Ed5zrJnu+hk9V
	TEkk/GHl12U2FlwzHtpkYeUzT5+nSaFOFptf878S8/XsZsudjdsJciXrp4avmbpcDHImhwxTXhfUZ
	YtWlccjMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1zL3-0000Yy-Nd; Tue, 19 Jan 2021 22:19:01 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1zKz-0000Xb-B7
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 22:18:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DA09CB73F;
 Tue, 19 Jan 2021 22:18:53 +0000 (UTC)
Date: Tue, 19 Jan 2021 19:18:49 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210119221849.npokdza7linj5ocd@hyori>
References: <20210119064318.124415-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119064318.124415-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_171857_512861_A713DD52 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01/19, Hannes Reinecke wrote:
>The original design to use device-managed resource allocation
>doesn't really work as the NVMe controller has a vastly different
>lifetime than the hwmon sysfs attributes, causing warning about
>duplicate sysfs entries upon reconnection.
>This patch reworks the hwmon allocation to avoid device-managed
>resource allocation, and uses the NVMe controller as parent for
>the sysfs attributes.

Works fine on my NVMe-oF/TCP setup now. Thanks.

>Cc: Guenter Roeck <linux@roeck-us.net>
>Signed-off-by: Hannes Reinecke <hare@suse.de>
>Tested-by: Daniel Wagner <dwagner@suse.de>

Tested-by: Enzo Matsumiya <ematsumiya@suse.de>


Cheers,

Enzo

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
