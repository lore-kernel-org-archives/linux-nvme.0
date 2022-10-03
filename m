Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59FEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Np0n427eeI+9reabdHxY6BfURex0FU7l6mbhOXS54LA=; b=tApaBG2UZDJmApjm/rbvNKU2EW
	I7+3BHMsCtmzGl5yT7pJXMNLAL59lIlbhd5dtptdp0WBDmJNOuAWCfAINmyhyfCzHJIC8irEztnIx
	q7y1R905vLrsa8V9qL7xdGWU3jJMIkDBF2Jhpv59YDWKv2aGneT5TGdSnFV3PvZn8BD27a5Z6Sa/l
	WhLU+1kVHIPC7EoWHLhpau81TR7Jp75qlq9JFGueJqykNRoDBCE56yA1pkvngri6ZG/UAxugo5YYM
	zJutR6dT/7I5KPXnzm2GOJJuFJWvkejr54qP8yR4QGdjPMOKFX3GNzhAPSirVT/IczJB+S8SDi08K
	jjuFP6EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofNN6-006SUp-D3; Mon, 03 Oct 2022 15:28:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofNN3-006SU5-GR
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 15:28:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6394761137;
	Mon,  3 Oct 2022 15:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A9C43145;
	Mon,  3 Oct 2022 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664810920;
	bh=egRzaguwiAmhjHHlqqCJraw7EaIGbUFlmqqv6qZnqZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEze71G/o9K0RLEseBuJblJ0zcDW6+XUOEja4V0kSUB+bEplZTIRUgmYanoYVEfil
	 3YvLBgS0IefgMNS+HK9yfeMjZNm0Uh1H0vmEXwfh3MVot+i7BQWZP+sFtnIdegKjsh
	 J7mYSsUjdXHKE31ojbjiANVNVREm5/7dwMpiE6kasE/p3+fysNOhsDWaKhPYpgOkVf
	 M32K7wEoFoTcb+YGwoNKPMMpIVteipaEj0I0v9Y67FC7cg2yrqXUu8OYMko+FFamm0
	 WTfUsj/R00KaUmQCELLrsiieZvpHrOKNVfI0A6bL0P4o60iNMUxjdPhmEyvP8SxEpa
	 otURC/3YPjNIQ==
Date: Mon, 3 Oct 2022 09:28:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Message-ID: <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003133240.bq2vynauksivj55x@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_082841_624618_C59BC137 
X-CRM114-Status: GOOD (  11.11  )
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

On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
> 
> BTW, I came up to another question during code read. I found nvme_reset_work()
> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
> controller is already disabled when the reset work calls nvme_sync_queues().

Right, everything previously outstanding has been reclaimed, and the queues are
quiesced at this point. There's nothing for timeout work to wait for, and the
sync is just ensuring every timeout work has returned.

It looks like a timeout is required in order to hit this reported deadlock, but
the driver ensures there's nothing to timeout prior to syncing the queues. I
don't think lockdep could reasonably know that, though.

