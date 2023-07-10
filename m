Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01CDEB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UIZvDVy9k/7OMTz4A4x2ug9kFE4VMtfrWhDBOUfK4Mg=; b=DC8q2GA0N5yMjsiOApSRIqtyz1
	3pTuXtDGWT0l32vL9tGXBCHAOhCVwKX+r5gAdOjK2CK9iWJR2zimHoWev2khV4nzrK5tvctJloiVj
	Tu2hpHCem0aO4ThbBvbYqwW5ZTOYFzCIbUkl3zgY0cm0DPtpE0SlwZYnsrQdPexGE84j7GH+SPkN2
	DmSocCJCepanX7dj4noGHfsBRDQmWxorSucurHPFTJwTGJn5MrV1DonU0YjNdbZ/FdHqiRbhj1XCL
	7JNx0QLyCRkf5JsDhv/+irGvztw3lCp0KXbrhKlegm3OCH05GyYWPurmAc7fra0KK2oFIAgHYAMsb
	fbr7DiCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qImEu-00AqVv-1g;
	Mon, 10 Jul 2023 08:27:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qImEr-00AqVE-2g
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 08:27:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24C5021E8D;
	Mon, 10 Jul 2023 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688977638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIZvDVy9k/7OMTz4A4x2ug9kFE4VMtfrWhDBOUfK4Mg=;
	b=D1duItWpVprF4m7rIL37r/2RswiHoIOPBjUPTljv7afso5npmgIyJIhZSxI3AZ0eTshORs
	/tebehspJiJRXL2HV5l6iJoOUmp82xp00hPCVB+waC4mSljUy1O9bQKZ04cpEMzHTO8+fc
	xsv7x5IJro01X+CKAIujb3+/2TyKE9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688977638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIZvDVy9k/7OMTz4A4x2ug9kFE4VMtfrWhDBOUfK4Mg=;
	b=h9IHnAzUbdOUzsHPmGdRZwgsRo3pBNef5WKps6f8Bm7OFmvWtfW2VYZo9J99N4Td0t7/p5
	qCgCRAyov7EpJrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1402E1361C;
	Mon, 10 Jul 2023 08:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Wm0iBObAq2ShDQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 10 Jul 2023 08:27:18 +0000
Date: Mon, 10 Jul 2023 10:27:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_012722_036183_C12DFDBC 
X-CRM114-Status: GOOD (  16.55  )
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

On Thu, Jul 06, 2023 at 07:11:58PM +0300, Max Gurtovoy wrote:
> 
> 
> On 20/06/2023 16:27, Daniel Wagner wrote:
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> why would we like to ignore connect attempts during blktests ?

The problem I observed is that there were two connect attempts (one triggered
via udev and one via the test itself) which disturbed the test. The interference
resulted into a complete hang of the test case:

https://lore.kernel.org/linux-nvme/6g53yj5afhhonwf2psf7ft2gkakkwewy7klkix3y3u6uclpa5w@tt2yfzigyxgg/

> We define unique nqn/ids/etc. So we never should disturb other running
> services, unless it uses the same parameters, which shouldn't happen.

Yes, that should do the decoupling between udev and blktests.

> Agree on setting the hard coded values for hostnqn and hostid instead of
> reading the /etc/nvme/* files. This should do the work IMO, isn't it ?

Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
is invovled? At least for the well-known discover controller the hostqnq
doesn't work. Though not sure if I understood you correctly here.

