Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF2BC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZI14wyn4OgIUCp7y8yNsNT8zd4og0MICxhTg68hXu4=; b=4H0xQ6xruxrNJctfEk/tC1LSGu
	WLZPVLAKOng6qzEkpR0kf+LyWY1K5gi5mMDxVFQ1FR58LaVbPMDhFgEmQf/z8hc4nG9XjOZU8+h1w
	K71TzAkfFtVNY4e+OGqEn6mZzZ6rgZUMvvx5uoSe+ufe9jbnNLxIXfVOSBcwZqxfGVbnQi1DAefTe
	KCgxQmRlKBfqKdv9/W/FzB5+a+FzVhP1u6D7mcLF6AOnRzNjMoEyUdpVYwzJ44lDvxFCjsEg+WZ9c
	ySuHMxhVD7PfsWuvtkiobM1MFOKP6s97IUocBrIYfSjAgkwnMfNsD4orGLIdnijWQrYO3yqFojMS/
	e30wpa6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeBBZ-0081Sz-Ra; Fri, 30 Sep 2022 08:15:53 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeBBW-0081Rk-VK
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 08:15:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7638A21886;
	Fri, 30 Sep 2022 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664525748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZI14wyn4OgIUCp7y8yNsNT8zd4og0MICxhTg68hXu4=;
	b=AIiSgJ+A4wab1QJWmY+sd3J2YXy9M2ypH88BQDPnK1TnTaRsSihwwBBADZgnaPaJchv0ja
	PtRCSkThUKsqhaE7sx/5yqLBA5np+RnznWC61464rZPMnkzcrBclu8JP68jWFyp15x8OP9
	3bF9EABdoVC0nA+ONnTgDC8W9G4oIYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664525748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZI14wyn4OgIUCp7y8yNsNT8zd4og0MICxhTg68hXu4=;
	b=JVImaRMu6zDXiaeYtkEWi30C/XCCphVazmTsgJ9HopDmuKnAikloOIguJ7Q2wgVck9Vkx0
	61nGMZHXSK1zhhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6835313776;
	Fri, 30 Sep 2022 08:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nYlNGbSlNmNWPgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 30 Sep 2022 08:15:48 +0000
Date: Fri, 30 Sep 2022 10:15:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com,
	Tomas Bzatek <tbzatek@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC v0] nvme: do not log errors for user commands
Message-ID: <20220930081547.rjcbifhvrqk7ke7m@carbon.lan>
References: <20220929171338.10792-1-dwagner@suse.de>
 <YzXpKdR/yjzgf2My@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXpKdR/yjzgf2My@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_011551_169001_5831460D 
X-CRM114-Status: GOOD (  16.71  )
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

On Thu, Sep 29, 2022 at 12:51:21PM -0600, Keith Busch wrote:
> On Thu, Sep 29, 2022 at 07:13:37PM +0200, Daniel Wagner wrote:
> > @@ -325,6 +325,9 @@ static void nvme_log_error(struct request *req)
> >  		return;
> >  	}
> >  
> > +	if (nr->flags & NVME_REQ_USERCMD)
> > +		return;
> > +
> 
> It would be more consistent with existing usage to set RQF_QUIET in the
> request's rq_flags before dispatching if we wanted to suppress user space admin
> command errors. If we did that, though, there are no more admin queue users for
> the verbose logging since internally generated commands already set RQF_QUIET.

I've tried to find a way how we could pass a quiet flag from user
land. I don't see how to add this flag on the existing IOCTL
APIs except by adding a new IOCTL like NVME_IOCTL_SET_CONFIG or so.

In my books this new logging infrastructure bd83fe6f2cd2 ("nvme: add
verbose error logging") is causing a regression. Thus I would like to
suggest we add the RQF_QUIET flag to the admin passthrough commands as
well and let those who are interested in the additional logging
figuring out a solution.

