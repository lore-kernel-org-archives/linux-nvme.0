Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74887C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:58:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9912D64EDD
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9912D64EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x+R1dQU1uX8UQDQs3lVhhoieQ7NR2UM78gY8554TtCM=; b=R11XGOIlbqXhihjBauneXFdtu
	ILmp8eoHHgU54sEnqTtX/yOK5wowZurn5IC92CkKn9Shlseo83xhsS8qFVAYEyEVWfMQdrJuoVVyH
	vA7eeDzFl+IWmOt46/IaE2K7OOH0Wu82MDenlDRl4AaMXwF78K3qVoO8F4RC9L1yZeuvNsNpAz6Ty
	HZGMmTivlyeg+6YE2oH1oP8OCZ88p6+jtvp7Q/voWAmVPQ37TpI2t29FInt7H72dxvtHU188d1jLN
	Ca4FMl1ySu5vJwxm8/v8eHkfqwi/h//A6pEjpAia5IxfG339WmQH5MrNs+ZMq1XNSyvROVNx0SW1l
	x3M+Mk9vA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6qa4-0006yc-Sa; Tue, 02 Feb 2021 07:58:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6qa1-0006xT-VW
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 07:58:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 213276736F; Tue,  2 Feb 2021 08:58:29 +0100 (CET)
Date: Tue, 2 Feb 2021 08:58:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: mwilck@suse.com
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Message-ID: <20210202075828.GA12160@lst.de>
References: <20210202005951.26614-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202005951.26614-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_025834_175087_014B6256 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 02, 2021 at 01:59:51AM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> While a controller is still connecting, ctrl->subsys is NULL and
> thus reading the controller's "subsysnqn" sysfs attribute returns
> "(efault)". This happens all the time when user space processes
> "add" events for NVMe controller devices.
> 
> Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
> if ctrl->subsys isn't initialized yet.

This is just papering over symptoms.  We should not be sending
events or display sysfs files until the controlle is live.

In other wwords - I think we should remove the cdev_device_add
from nvme_init_ctrl to nvme_start_ctrl (+ any error handling changes
resulting from that).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
