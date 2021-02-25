Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D724C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:37:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0CC64F19
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0CC64F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0qgeFs+nNfQjh5M8kdvkcnHeGeDhEIkDNUtpv1IDayM=; b=vC+Kk6uQ3ya7Di9cUGiZLuRwN
	Ug0AvCkT5VG3+NdeQv81csd60GdaFbnXHgx7AJ+23ocC+i4+odW8WKNYT4AhWxVE8NCdJl3pqMbbE
	RP4XtEjoL7BiRHb30MbMATE/0NiuS072jpElXsZaymEfUzcbmOE30pvLAUWnT5R0u/y5EhtYNfvfM
	xXp6z5OeoM5f2clIsG6su1V32dJqC0y+QBQZQ+NllIZ0uzmc83V2EMNV/Tv+p92N8nwzWgHbrwPp+
	nL+RdyfEqkWhM/VNEyY/cBAkf63BR3VFpQzXoFO4VXKIw4WChT6FeNq1CYON+ndVrs5UrugWohhEi
	1E8UEQVrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJdq-0006Cq-8t; Thu, 25 Feb 2021 16:37:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJdn-0006CQ-6X
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:37:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A62E964F0D;
 Thu, 25 Feb 2021 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614271046;
 bh=azgrLQ884us3W5acNKdc+ETQvpICk5CXQdzJHMsgGe4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bwZjWM8DcYMMGyzWcTYaQ5npuVgP3/hnkLP5U4LP/nYkj6vkuNlBQQoCMx7vLvTHm
 ON/Qu25umXhdl+ILxAvuATVIfIBFWs/ucvwjKM7/rl2NCCPckOn+7MYV0XVg9zI6Bb
 4YCAysKeQ/0Dz0wpGZ60k6wEjnclcbrR8KJ40pPUNd5GSkGKYC5ZEq+ult/i36lNDA
 z9/HV2v201gu7xCVWXZZ1BqR2sJyiZvJOkLHp69x19jZyHDYc2U7VGc5LQCt1ti59g
 Txf108SUr/g9q1tWgh+dfbEIQD/iVEuIPkkkiuIbj0/u0WLe3vRXZ3KVEZ1Csdt/U1
 tsmKFrwQQneVw==
Date: Fri, 26 Feb 2021 01:37:23 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
Message-ID: <20210225163723.GD31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-4-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225105527.75277-4-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_113727_330841_69159A80 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 25, 2021 at 11:55:24AM +0100, Hannes Reinecke wrote:
> nvme_fc_terminate_exchange() is being called when exchanges are
> being deleted, and as such we should be setting the NVME_REQ_CANCELLED
> flag to have identical behaviour on all transports.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
