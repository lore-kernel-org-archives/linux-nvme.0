Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF3C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/EmC10WycS5DhTnXU41FSYHKaDnQwgMs8E/KVmSyhrg=; b=Z3vbHlPQ0sNxdevj35d7Y1O1O7
	2EKydFer+fDgn/h2T84qw4FgKt5Dvu2b/PF3kadv17HwhIuTtnRWpfvcsL3S5TuRyLyALEvvdQNGZ
	Gm3ATgGmrua/eBIOf6D7XQiW6zUbNrx72lMpMip9Tniqa12/tXBPDLuPGqPGXC5w+pfJDVqWVOG+A
	Fno1dcEqNrJWD+HJGH/+0Sp8o2QPyLV0QbpLqORSkpvK3MNGCcQ/7tE2/6ePZGBsYL0sCGuckWk9g
	J+1KyKuN+4fbRoO5JJiaXmYU/oqylkxgu0jjG82vyg02+Lf4xeBDRSMrYhqQBBqsnA+iwcEKM/8Xl
	RXCug5dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNztE-0034z0-Cp; Fri, 03 Feb 2023 17:30:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNztB-0034yW-6K
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 17:30:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B91D761F54;
	Fri,  3 Feb 2023 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A00C433EF;
	Fri,  3 Feb 2023 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675445416;
	bh=lj39keWR2XmayFaSKGL7oxwgolpkzG6VtSrXifhvFF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtxXwF0LL8eNO16m/9vmZ1BifbGLsythfNZZ3VC/Hv2LxjA2Q6mRgPplCJNgqABIP
	 TbBVhXLE5hLu9WdMYkyHqxM0ok/vMez/Oiq5GpElB1cMnpyFk+DcxKXKQX8qRJ+XpD
	 KNb9IVGR5PNh3AyXY0RSvLuujvM4TVoUeJMZKmnLZ49SNADf7ag7bVCgOA1xAehYh8
	 Q4aGYxMIxu7DYpKdiCbKCCxXd0Kzvm6F5yeHVannKMtVhIA9OFJbvsP6ltrDU/nC0R
	 3cCNkaMW/HUutjifn7XezKAc4YflGesg3EWFM6Vz9leKAHLs/YGYhxmdzpAc4IHVer
	 CHeI7zj797vTg==
Date: Fri, 3 Feb 2023 10:30:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_093017_313487_1C1067C2 
X-CRM114-Status: GOOD (  19.92  )
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

On Fri, Feb 03, 2023 at 05:22:13PM +0100, Daniel Wagner wrote:
> On Fri, Feb 03, 2023 at 10:43:04AM -0500, John Meneghini wrote:
> > I have a question for the upstream nvme maintainers.
> > 
> > Why does libnvme, as v1.3, now have a dependency on dbus?
> 
> libnvme-mi uses a D-Bus service for discovering devices. Initially libnvme-mi
> used libsystemd as D-Bus library. libsystemd is only available as shared
> library, thus we can't build the library statically (yes, some people want to do
> this). We switch the implementation to use libdbus. I made usre that it can
> be consumed as suprojects. New library, old optional dependency.
> 
> > I thought the goal was to keep the nvme management plane as streamline and
> > daemon free as possible.
> 
> Yes and it is optional. The new feature is that you can compile it
> as static dependency and this is what you currently see.
> 
> The current nvme-cli meson.build configuration for libnvme is always pulling the
> fallback. A workaround is to build libnvme as separate step as you would do when
> packaging.

I'm just trying to build this right now on an embedded system, and my goodness,
it is fucking painful. It's a bare-bones busybox enviroment with no internet
connection. Just getting meson on there was unpleasant, and now the build just
gives up with the failed dependencies.

