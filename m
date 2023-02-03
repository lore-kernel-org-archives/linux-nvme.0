Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F17DC05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJKiZzoFGVjWIWu3KENtW4+5zEK7j8y6GQ2PLVX2ZBI=; b=pRRz3b6Rat0MSpBmP388OOdKX3
	X42dpgfPrYB0bnS7+jeFAOLr6mFVdSXb3EIKNqY1Bogn5uwqMIw1zwTmcmeOl9Qt44NueYi8V8lUp
	xgk7sIfMmjQy2OR7X6VYCTcSITR+UaL0SdskaFOqpUjQkeJK0vvadJMKmnvrxPD9jPt7F0kPlyeDn
	hZQRxw5ri+4hcDa+My1cbF5n1+ONM4IPRONoBiPDTtymDAWcR7Bg62m2IfVhb1syFrU+5iK0oBWwn
	M5r1pylnCDOjG4zEWZA57gXz/5QQ24dWUxvsO+xa6sdIRSTOiEDcacpUgatk7OJFwN10e2bEspCPx
	C+M3kNbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNypS-002ttH-JZ; Fri, 03 Feb 2023 16:22:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNypO-002trb-FD
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 16:22:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5CD034BBB;
	Fri,  3 Feb 2023 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675441333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJKiZzoFGVjWIWu3KENtW4+5zEK7j8y6GQ2PLVX2ZBI=;
	b=UFj3Ajla4MvBZtNLrwhvUm5iyz4cXBiNDAtiOrqiVRZwzPsM4XnRMTv5vQ2iupiqzdKWjp
	HXB+VF5MJk1/jnb50v7kzOJ5sCgaCCosk7wkuVPHvGYOxl16mhfYapGeb522mafGfmSBPx
	TXjHwsrXX3hGT4lgRecOAMMkoVVsMs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675441333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJKiZzoFGVjWIWu3KENtW4+5zEK7j8y6GQ2PLVX2ZBI=;
	b=f0lHMr0xs2jr2LbC4nnYD9FrChr5MNsjiVgX9W4pKGy78Ij9rqz4UjUmR07mSQkYMrwRds
	2wSzv1/5f7ACSJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B62C21358A;
	Fri,  3 Feb 2023 16:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +SZwLLU03WP/VwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 03 Feb 2023 16:22:13 +0000
Date: Fri, 3 Feb 2023 17:22:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_082218_689721_6BA9C1A2 
X-CRM114-Status: GOOD (  13.81  )
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

On Fri, Feb 03, 2023 at 10:43:04AM -0500, John Meneghini wrote:
> I have a question for the upstream nvme maintainers.
> 
> Why does libnvme, as v1.3, now have a dependency on dbus?

libnvme-mi uses a D-Bus service for discovering devices. Initially libnvme-mi
used libsystemd as D-Bus library. libsystemd is only available as shared
library, thus we can't build the library statically (yes, some people want to do
this). We switch the implementation to use libdbus. I made usre that it can
be consumed as suprojects. New library, old optional dependency.

> I thought the goal was to keep the nvme management plane as streamline and
> daemon free as possible.

Yes and it is optional. The new feature is that you can compile it
as static dependency and this is what you currently see.

The current nvme-cli meson.build configuration for libnvme is always pulling the
fallback. A workaround is to build libnvme as separate step as you would do when
packaging.

> We already have a dependency on the udev daemon.

Not on code level (no library). I don't see how we can avoid this and I don't
understand why this is now a problem.

Concerning meson version: We always used features from 0.50.0 hence the min
version of 0.47.0 was wrong. We just updated this.

Daniel

