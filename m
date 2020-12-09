Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 21:34:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9435239D1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 21:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9435239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iSdU/yM3lqUtMg76S6Qw6vL/0dO7pd8VqxZsib0DE0Y=; b=rmi4lZ0sVhL8HvNvDZdNbiTI9
	mw2sLOgBwLv0vo9+GX/hzUq1/BqW8lIg4XnNy7ZEpuojcoc5J5qn1QicvNHLgVoiut+9ylEN08qDC
	4NYlILTKAyfj1/DTYlkRf2ySAX+dGvzZlOms/8raVSd105MAyMx8p7FRKMSH+Tjtv9LE+ZX8wlpKC
	DoXnXehYsKnZpinSL/U6WdSPSc/ey5ZZfpwQ8KNXu2Tx8dV7DtQigaS8cyGmjmb4tiIJiB55W4I76
	VRZT2wL8HdhVs0baSjijEi9WZqG/5I9kuE5qmt7CjBFX0gyWTFeiRE3Xj7wEVbM6h56GvXmW8l59s
	CCHUGxszA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn76j-0005n6-1X; Wed, 09 Dec 2020 21:34:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn76g-0005mb-3z
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 21:34:42 +0000
Date: Wed, 9 Dec 2020 13:34:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607549679;
 bh=FMLx0M7q/FxQkCD2o3f3o8XG8h/hrDyXLW1nyt+perA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=jaFPTssemgrrNRkfNMDT7ogdMsgREGYSEYVJI5Z9zvQ/S/NuXD4iuMqDuDZEXb2Y+
 fHe4utIpo9OUbsky/m67U2EPmIgAEdt2BjJwg0EJwzO9xFI6L/tcIYKgJzEX58H1F4
 sJ/+Yw7jB/UG/2DJgTz3AJQ5l9sKTUl7w9suNRpP6wXGlnNvBVmaBviQFkGHWEIVRe
 vYTjp0K7uHw0XnsVidwh0tltyVF52W8CXdNTcdmo2Jhk+JJDtdRg3496pWOZMTX6ZW
 dvEdp+0OEJoEwsQCLwh81JKX5XM9SGtu5JMgud+OHcMTB31e+DlWKR9k473vTiA2CB
 ReOVWGOKyoVEw==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
References: <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_163442_226098_7E38E5BB 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 09, 2020 at 08:58:06PM +0000, Knight, Frederick wrote:
> So for case 2 (the attach), there are 2 AENs for effectively the same event.  This is where we are at with the existing text.
> 
> Whether this is what the hosts want, that is a good question. What changes are desired (if any)?

Linux hosts currently want an ANA AEN anytime the host needs to refresh
the ANA log. That includes any condition that adds groups that didn't
exist from the host's previous reading.

If the Namespace Attach occurs to an ANA group the host already knows
about, then you don't need to send an ANA AEN because there's nothing
new in the log that the host requires. You just need to send the NS
Notify AEN.

But if a side effect of attaching a namespace results in a new ANA group
becoming visible to the host, then that group creation is considered a
separate event, so the host wants both AENs. I believe this is where
Christoph is trying to steer the interpretation and the text.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
