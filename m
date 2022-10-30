Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA7FC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G54QRrEEQKOMr1BCfM89KQloV1kMcfDO8c+MidYK7io=; b=trQWmx9CxtZso5b7rGwjFUeGF+
	LbitDY0vsVVHTZvanwHbWxYvEKy7JEg/RdafshzYh/YnrA0WoLs5F1Kvzly6J1RfYWYdzWaaEetJY
	/a3K8CSORCZqTApPGkLClZrV73jHerFxiQ27G8y9MSl1im/Go4XejbHMQWJLZ/5jalex9egS51LLy
	5u9jU2bzXu8qSrwZv3hC6vZmTvOzYxsnakMHyk9XdjY1m0vuUMfgHoD1dQumoXb22qceiY+VvaWPo
	gA6I7qoXyHZzzgRtphYbZrVi6dOGDOwPJdOBZQKXC1jON26Jfb/lqTFOM0b2Arl6wC7+Kh97xmou4
	7sp1FbkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2vX-00DnxW-NA; Sun, 30 Oct 2022 07:40:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2vV-00Dnvf-NT
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 07:40:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00C9268AFE; Sun, 30 Oct 2022 08:40:10 +0100 (CET)
Date: Sun, 30 Oct 2022 08:40:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jinlong Chen <nickyc975@zju.edu.cn>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
Message-ID: <20221030074010.GD4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_004013_926483_286167C3 
X-CRM114-Status: GOOD (  11.51  )
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

On Sun, Oct 30, 2022 at 01:26:46PM +0800, Jinlong Chen wrote:
> blk_freeze_queue_start is used internally for universal queue draining and
> externally for blk-mq specific queue freezing. Keep the non-blk-mq name
> private and export a blk-mq alias to users.

I really don't see the point here.  Eventually all of the freezing
should move out of the mq namespace.  But that given that we have
actual technical work pending here I'd suggest to just leave it alone
for now, and just respin a version of patch 1 without the pointless
comment.

