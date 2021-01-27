Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27647C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:06:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3FC207E2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3FC207E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JyZuu0s4dBFX5Vd+7Etim2FkUDKOUZfSld9dx4C5L+k=; b=tRVCqxfrU3dPsbTtbInS2l0/D
	SDTadDEsjiyuYW1CebFipYTY8maet4/PtpdZSZ9h4wYf8AwYoH0eId5Xd9lb0xn5ufpNYIVvp+5ny
	TnNg5/F/yAcG+EemBVa7pr/VdXdr6iBRnoYBYZYyxpOB/WWhri/tzoQoWMG1q/TM3scB/i+AmgqLS
	L7FKTYuo7o56QqGe//aiksc5lUa1goSLRp+AABPqmmlFN99fVGud+gwwAfNHHLZQQoze9Z/7p/HGt
	zjAJoLlt+P9PfSlmEtm0zPDHGeB5CSQDrn/CAkIoM+BGPcia5hhGOahOAG92hMsiqkTcAtLK40R0n
	N8gUZysBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mOQ-0002Dj-4n; Wed, 27 Jan 2021 15:06:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mNy-00025o-Ib
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:05:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45D1207E2;
 Wed, 27 Jan 2021 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611759933;
 bh=MQSk03vwlgwSRPE84q9Zd2Dii/7nv5hmnsZcEyoRgrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N1GOvGQ0iw0rnCI7BuB2p2XdZ6s7ZKus2uGunVD4Lo83+Jw0BsmOvHRSnBuFzOdqp
 FGhn5ZH04KZR9y3Ri8fyCN3ByDzMxiIXptxHiScnyEYFJBzqVwQm+On5EXC/Aoj9U1
 s/vfledPPCgrItHk2/gT3zFuhTyjfhNb6vTnipEbCzOn4JHXoDD7iXzQjSSCMdXpbf
 AZJk5wsNYhPGjjNbnrczRBgmwHhbYBeceRbRcukX6KqpoPzocKqa+kveYxjJcY1kO4
 NGnSJiH6EYQS73IDzSp8pISV0PcJpZLkCWUgjd6za7BWCcHst0JCY25iVwk5IuxBy8
 1hwP8ym8gy/vA==
Date: Thu, 28 Jan 2021 00:05:26 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/5] nvme: add NVME_REQ_CANCELLED flag in
 nvme_cancel_request()
Message-ID: <20210127150526.GC23059@redsun51.ssa.fujisawa.hgst.com>
References: <20210127103326.16191-1-hare@suse.de>
 <20210127103326.16191-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127103326.16191-2-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_100534_787856_18DF99D4 
X-CRM114-Status: GOOD (  11.93  )
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
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 11:33:22AM +0100, Hannes Reinecke wrote:
> NVME_REQ_CANCELLED is translated into -EINTR in nvme_submit_sync_cmd(),
> so we should be setting this flags during nvme_cancel_request() to
> ensure that the callers to nvme_submit_sync_cmd() will get the correct
> error code when the controller is reset.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
