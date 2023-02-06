Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72000C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 10:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79x2SpWvOp+EKIMS54bN5BGtL7Mk6NOqW8Vy9W0PyVA=; b=Z9mihC/s9a7u/NnoLBN245GGbe
	q3wnygoMSPUCDzOO1yqPYqEIH3o+4GmfijlWhd/M3jM5BHuaizoJJwdL6xztTZLGcdcnqTxFzKYB5
	lXuzb2VIE4MCS6JSRL0z78ggSIoCclyIb2XAoTCINNDZQt0vf78G9zI9gjWmjPRcwZ7BSQv4mcRV7
	HOhORSByvmTT4TO9zE0hB5A6/oCQ7Du36Yh5K9FFT4HUt30dg/R21IN0pC3/o2fQf1FcA82ZLQF0t
	5EJuvylE6qf3AX+SiZONy8cllnUUiOw3/FbowGcdXNGoy+2/1qt/FD/RSPDuI0QVO0dJoRHSNfyIe
	a7LEci/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOyMQ-00816V-8c; Mon, 06 Feb 2023 10:04:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOyLi-0080av-FQ
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 10:03:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BD1C3F332;
	Mon,  6 Feb 2023 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675677824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79x2SpWvOp+EKIMS54bN5BGtL7Mk6NOqW8Vy9W0PyVA=;
	b=XeH2ncgVEWSwJcpxxqNVRDKoPdk2SVgmlKeQ5/aMtMV6UmEJJ1cJ5ZI5ABXkxnVXd5MccP
	D+hkfx0o7i8EYb1UPHE6bdusWljY82cyxkUKn1jTsbQJP3KFetEjCv/g71ZQ1uQ0AweiNh
	m32E3ZaJCh0MF2m+LizjsoqFd/+yPUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675677824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79x2SpWvOp+EKIMS54bN5BGtL7Mk6NOqW8Vy9W0PyVA=;
	b=/DNcg4uDSlzfofMF5UdOuU15gsXPp7MBZH4kTyY6qlPSTUCl5QHPf4oyMoeGsSu41hU0NL
	3qox7NunnCGdYUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DFD813677;
	Mon,  6 Feb 2023 10:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9rQ1C4DQ4GP2QwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Feb 2023 10:03:44 +0000
Date: Mon, 6 Feb 2023 11:03:43 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <20230206100343.zzy5xxwm3birwqne@carbon.lan>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
 <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_020346_680960_14C075A0 
X-CRM114-Status: GOOD (  15.32  )
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

On Fri, Feb 03, 2023 at 10:30:13AM -0700, Keith Busch wrote:
> I'm just trying to build this right now on an embedded system, and my goodness,
> it is fucking painful. It's a bare-bones busybox enviroment with no internet
> connection. Just getting meson on there was unpleasant, and now the build just
> gives up with the failed dependencies.

I am sorry to causing pain. Let's see what how I can help you to make it less
hurt.

Is there a reason why you want to build it directly in a busybox environment and
not using a cross build?

I agree Meson itself is pretty anyoying in this scenario, though it should be
possible to use the alternative implementation. Meson is a specification with
more than one implementation. muon and samurai are written in plain C99 and only
use a compiler to work. Though I haven't tested this in a while. Let me give it
a quick test. I suppose it makes sense to add these to our CI build.

About the dependencies: There are only two non-optional dependencies:

  libnvme: json-c
  nvme-cli: json-c and zlib

and on closer inspection, I think we could ditch zlib as we only use the crc32
function from there. I'm preparing a PR for this.

I can look into making json-c optional again if you really don't want the JSON
related functionallity.

https://github.com/annacrombie/muon
https://github.com/michaelforney/samurai

