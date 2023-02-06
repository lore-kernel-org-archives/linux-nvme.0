Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1554C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 10:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RG3FH8Y8dgg8CMdcwjShR8GUOeCxJZKTcsm4L5CIIec=; b=n8E6ezit3gnV0hMpGUHM7+ti2z
	6+1+1R13/bBgxZ8ERsgqXifEDbpBeKTcGMBj1rThG9pRLpswb4hHnl/acgCNmdIrklFRmS7+KVyOr
	xz6LbE5b4o/Uks0+1PbHXgUsIVKrxgCeKGSLWu+q4E/oCVqUL2RX7udWtsw09hpiYQe3SpCWGTOMb
	Kw4z4tDSoXcQARmpn4daQEg36PsK+NWeyf5/m2iAuCsLTjNyj2meGEbA2rO0jFULPJ6ApfVDVtA61
	yrcAXlfJIyvqikbeZcahBWCij04LEYKUCsVV1ZxXuoHV8iAIxvsARnwpm71+r/WJxJ456MOI8wOE1
	eF7gvvHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOybt-00852g-Rb; Mon, 06 Feb 2023 10:20:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOybr-00851X-05
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 10:20:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6028960590;
	Mon,  6 Feb 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675678825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RG3FH8Y8dgg8CMdcwjShR8GUOeCxJZKTcsm4L5CIIec=;
	b=DOQQhPMmk08u6O2jlkb7K0TYx7WIb8qnDAIV247xfkzNJA6d0aFMRYwCTK/CahRuQ1GhVp
	VzcoqZHWpXLjCXlvn+z/6dG8ZvLAOV2Ue0QOVnPh5e1xG3s7Sj47ZBd+LbYfai6mD/UmWR
	nTiM6ELlyaxSSJJgvrFbUTOWSeB1MDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675678825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RG3FH8Y8dgg8CMdcwjShR8GUOeCxJZKTcsm4L5CIIec=;
	b=8nNfCSDBP61/O6Vu7xKMFgUgnZRcxFTJY3fHuQUOtby8lo4Vf6CHcVDxtf/4LxHPRd4/oF
	jqbo6Utc84EUABDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC35138E8;
	Mon,  6 Feb 2023 10:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RfkXFGnU4GPhDAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Feb 2023 10:20:25 +0000
Date: Mon, 6 Feb 2023 11:20:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <20230206102024.y7okujkwnojewkkc@carbon.lan>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
 <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
 <ad09ff71-5f7e-2d05-15c7-93815b66bbfb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad09ff71-5f7e-2d05-15c7-93815b66bbfb@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_022027_208975_D7E01911 
X-CRM114-Status: GOOD (  22.18  )
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

On Fri, Feb 03, 2023 at 12:43:32PM -0500, John Meneghini wrote:
> On 2/3/23 12:30, Keith Busch wrote:
> > > The current nvme-cli meson.build configuration for libnvme is always pulling the
> > > fallback. A workaround is to build libnvme as separate step as you would do when
> > > packaging.
> > I'm just trying to build this right now on an embedded system, and my goodness,
> > it is fucking painful. It's a bare-bones busybox enviroment with no internet
> > connection. Just getting meson on there was unpleasant, and now the build just
> > gives up with the failed dependencies.
> > 
> 
> Here's how I solved the problem on my redhat platforms: fedora36, centos9 and rhel-8.6
> 
> $ sudo dnf update -y
> $ sudo dnf install -y meson cmake dbus-devel libuuid libuuid-devel libuuid-debuginfo json-c-devel json-c-debuginfo json-c \
>        json-c-doc libhugetlbfs libhugetlbfs-devel libhugetlbfs-lib clang openssl openssl-devel dbus-devel
>                                                                                                 ^^^^^^^^

FWIW, the libuuid depenency is gone. The dependencies on hugetablefs and OpenSSL
should be autodected and not break the build if they are missing.

The dbus build can fail when an older version of Meson is used. The D-Bus'
meson.build fail is using a feature which is only present in newer version of
Meson. I've send a bug fix to the D-Bus project to address this. Though you
can explicitly disable the libdbus build as Martin has pointed out.

> Every time I find a missing library or package I add it to my tool chain
> because the meson fallback/compile stuff is always broken and full of bugs.

What is the problem? 'always broken and full of bugs' is a very generic complain.

Also you are not fored to use the subproject feature of Meson. This is optional
and if you don't like it just build the libnvme library as it was previously as
seperate step. Overall, the Meson tools chains very flexible to use.

Anyway, it is possible to add additional CI build targets to catch build bugs
early.

