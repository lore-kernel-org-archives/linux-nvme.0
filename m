Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6430C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 15:15:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A37664F20
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 15:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A37664F20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wtsx0RUMMMkM6lQYoHfev7tXgH9RHHbMQ208cMoSuv0=; b=tzL/qA6OzU6DiQRtjuDOyodZH
	psVM7Vs1mycWu3+T85PHlMObeoKZPOxdqw7Oce7MpRKUO6I0URMHdfCVDvfhMQt/q2Hb6mV+JoAR/
	uZjzLrH8sziplLIIr75urEYbn+ipgFg/LREsnaHYkoJwXjLOXmczYEGmOS3zt+xb39WXZiF+vYTS7
	+71eyPm93D1uAI6VSqhkU/otxurXVMucwGrsjVs9AE6Xf5dmf7eqtvscq981l+lVPMdZ/YtUaGdAI
	o1HZqtPYQ5Y6PFvyDmijgCNwPCcvIcqVquLpEmhYS3fffajOSt56Qb/kBuzk7FejvZOfIX1ooo76y
	uLIv6lizg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l98G1-00061u-Mp; Mon, 08 Feb 2021 15:15:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l98F2-0005R3-Va
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 15:14:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 756FA64F0C;
 Mon,  8 Feb 2021 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612797260;
 bh=DucYZkWATVxzEoEhJHaapV1iD43ubcZhJZnAgyL5UOA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mAFVoAC6GZBP2j8muPqydnIzRnskvhcDVd+qckxl93KnmonbE496bPWo/VHJw8Be1
 6HmBAcmzYgNmzBjJCruVEUP+EEVvEQPpnK4N1XatMZrunuavSUSCDpCIS9UVi4+Vaq
 fbnI3BpzswF8TObRuYJC2rIChwZbr44QLsjbQk4YwIjRsFvMaiEgcV/T689SVmDMhu
 UPb3xY9Y4jCakmU6Ivzy2bYaxRX79p96iaA85SBfTuktQUhFgg6Uvy/zAuzXi6Y4iU
 ZyXcaDnnbxr0Mk1RqX3YJU0plLyr3Ng0T6VKB5mTDW62fmqvu4Ug4YS4+fsNOXpfNS
 AxIm4QWjS4NrA==
Date: Tue, 9 Feb 2021 00:14:14 +0900
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Message-ID: <20210208151414.GA16360@redsun51.ssa.fujisawa.hgst.com>
References: <20210205195002.2657209-1-kbusch@kernel.org>
 <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210208032851.GA14062@redsun51.ssa.fujisawa.hgst.com>
 <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_101421_144419_0C91D45B 
X-CRM114-Status: UNSURE (   7.40  )
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
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 08, 2021 at 03:51:18AM +0000, Damien Le Moal wrote:
> 
> Hmmm... I see the zone model being set for ns->queue, but nothing for
> ns->head->disk->queue... Shoudln't nvme_mpath_add_disk() also set the zoned
> model for ns->head->disk->queue ?

That gets set via nvme_update_ns_info()->blk_stack_limits().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
