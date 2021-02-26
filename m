Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:17:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F70564EE7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F70564EE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bQM9vkjXpV3+ukZE6miVVcb3yS3PxCq9CB7qWDmsZoc=; b=XNJ63Ltx9O1Uj/+wlTKa3vQKQ
	zALUno1YnuzpvqLGNbrsVWRflzrg/PoPMD6vRuL6XncGhXhn9TblMp8fDz5v4ipPT6iP+P2CK+8Pu
	zBZiiyDUGYi0WWOUnmgoqYz8fpMhC5EC2+K6Lks2sZmW/ZBs6tI9ANLExQL4zX7MjUDeulddabOzZ
	TgzIPz2sUjim5C35UFzURUv5BjcBTDl0l8Mzfvp5AlsRcUc3tImC9cpUNO0JTejW1hP2Zg4pPRwGP
	0ooXR178DOxrohFESENoygXTvYwNSJOd3Q+clnuRXkC6Albf5zrIJ8laEGrnaMrT8IXZNmrc0OJFH
	oUJmlR6Kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFZFY-0003LN-BC; Fri, 26 Feb 2021 09:17:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFZFU-0003KG-9G
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 09:17:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EC0FBAAAE;
 Fri, 26 Feb 2021 09:17:22 +0000 (UTC)
Date: Fri, 26 Feb 2021 10:17:22 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: send uevent once a multipath namespace is
 operational again
Message-ID: <20210226091722.5flr3pek2raumunc@beryllium.lan>
References: <20210226080538.108392-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226080538.108392-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_041724_945234_A152D3C0 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 26, 2021 at 09:05:38AM +0100, Hannes Reinecke wrote:
> In an all paths down scenario I/O will be requeued or aborted, and no
> further I/O will be ongoing on this namespace.
> This leaves the upper layers unable to determine if the namespace
> becomes operational again eg. after a successful controller reset.
> With this patch a 'change' uevent will be sent per multipathed namespace
> once the underlying controller moved to LIVE and started I/O processing
> by calling nvme_kick_requeue_lists().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
