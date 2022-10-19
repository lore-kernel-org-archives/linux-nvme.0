Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447E4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lq31HVI7STxJxZnfGB94LDcRJ0ZVBHExkibq6xlPiJU=; b=bqg/JcgOJF995B76gEPNyjfGOQ
	HZpx8rI/7rSrs6lzF8xCWlpc5jnP/I31XIMmi2Rccx840lgM8uLTwS98c3MxYFn34Q2Xb2/WUpdCc
	24IZJCbf6sA+fuoy3l4LcIjbMAp8w0FVGxEABjARAlWfU8+jTSBrTIpWNg+zVl6y9yq8wrrfgll51
	S4kxWASIogfSWWVqiUQv3g0KcfA8UoPCu8AZu7WzzYOhUnmo8HoieMYej731oKtGdjOzW0xKT9cvP
	qSWqYA7VIcXp1QKYVwSiKqzi31dMnILC+iHS4er21Ooy538ZjsA25JH0uqRjvCVGlVp3E28jN7OXw
	isVY6xDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6hB-000atD-EC; Wed, 19 Oct 2022 10:53:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6h8-000anJ-6p
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 10:53:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B283120455;
	Wed, 19 Oct 2022 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666176782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq31HVI7STxJxZnfGB94LDcRJ0ZVBHExkibq6xlPiJU=;
	b=NrHehF6kL0hXR6KwKlNmrYz0cCfHntXlHTvvmMLoGo7tCTbJTmM4/VKqPr0fy57gMIuXA6
	G9QzqmjrqeyatQ2j2NQ1vMtE2T5DHV4n84y4xpBthczuMiubs82dsa+j84cr0CsreWU96k
	FsGubeytaEhy5hNLSyNajtSxtWd2SM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666176782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq31HVI7STxJxZnfGB94LDcRJ0ZVBHExkibq6xlPiJU=;
	b=6v0D6P6ex0flzDw11j4nsMo+TkCR39IqykSq7H0iZO9ybEwfheNtDIZ73HGySfL6dyUt/u
	hqayjbDaved1SLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3EE013345;
	Wed, 19 Oct 2022 10:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NQ0DKA7XT2MzMwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 10:53:02 +0000
Date: Wed, 19 Oct 2022 12:53:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Message-ID: <20221019105302.tcvfxn4z7nzkit5d@carbon.lan>
References: <20220517061456.7623-1-dwagner@suse.de>
 <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
 <20221019085004.54mtkhi5qoix5ef6@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019085004.54mtkhi5qoix5ef6@quentin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_035306_417664_AB7965C1 
X-CRM114-Status: GOOD (  16.53  )
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

On Wed, Oct 19, 2022 at 10:50:04AM +0200, Pankaj Raghav wrote:
> Hi Daniel,
> > > When I reviewed the tests I asked wrongly for GPL-2.0-only. The
> > > project is using the GPL-2.0-or-later license. Relax the license
> > > requirement to GPL-2.0-or-later.
> > > 
> > > Cc: Arunpandian J <apj.arun@samsung.com>
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > ---
> > > Hi Arunpandian,
> > > 
> > > Sorry for the mess, but could I get a signed-off-by from you?
> > 
> > ping?
> > 
> I heard from the team that he left Samsung. Do we have any other
> alternative to get this patch in?

Right, the mail was bounced. I think it would be enough to get a signed
off by any Samsung employer

