Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652ADC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qegu4a+DCM/ngntIifjRxIKp92H+3UpuMl9dAH5gwhs=; b=wV/WJzxnQ9f1guHh56B3BRRy37
	GUKYVb1zjC6zNpuNgQPqJJ+8X4PCq8wjm7Fns5rqYpC/7aXdmpuHAUYymrJiho0uckSdCxq450swV
	5WJiGE5KbXC/JOVUZ/wg44wbRYQuz0WoRr4n8wpJRzGzf6QMQEfQ/EQRXYtT4f5cZpwNkgci8cgo3
	A/0Ps90yRqDididNlvs1vbZz/Xmtzk/ODZ1AqNdCma7Q+VTIOv50w+k2kbZcpnhW/ryCmqbxQ8i9K
	kS0P9Q0QZo/fN7jFtwtDecx2NergJ1gFGaakRSGzBEyZKfSUWAAu8RlC9qaQfk1Hh2eSmO+3dPCui
	/R18qG0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWcU5-00AnRS-BX; Tue, 22 Mar 2022 11:15:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWcU2-00AnQL-Bq
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 11:15:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB38168AFE; Tue, 22 Mar 2022 12:15:20 +0100 (CET)
Date: Tue, 22 Mar 2022 12:15:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Message-ID: <20220322111520.GA29151@lst.de>
References: <20220321115727.774650-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321115727.774650-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_041526_572384_742E8AD7 
X-CRM114-Status: GOOD (  16.94  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 21, 2022 at 01:57:27PM +0200, Sagi Grimberg wrote:
> Any attempt to flush kernel-global WQs has possibility of deadlock
> so we should simply stop using them, instead introduce nvmet_wq
> which is the generic nvmet workqueue for work elements that
> don't explicitly require a dedicated workqueue (by the mere fact
> that they are using the system_wq).
> 
> Changes were done using the following replaces:
> s/schedule_work(/queue_work(nvmet_wq, /g
> s/schedule_delayed_work(/queue_delayed_work(nvmet_wq, /g
> s/flush_scheduled_work()/flush_workqueue(nvmet_wq)/g

Should this have a Reported-by or Suggested-by for Tetsuo?

