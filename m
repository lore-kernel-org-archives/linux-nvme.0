Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5725AC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+1yAQj2+drdxOg7W1xMMihj39vdtsCy+k9dgFHWRk9A=; b=sxkaqRzCe2iMiNgcZ1yM/xs7mv
	H6tYiNzquciMubArqBT57YqWI0KnWIt2AX4iY4s9PhVjaY/RpROlooS+9OBibAPNUDFJ7BbvyQa55
	F98mVnBvuYfep53ASXHW3uID/rqXbO3NhYBjjmIAmKDJsJpjZjiiKOCr5dwQ77EG7fSe/lhEb8Ksr
	uRjDrVRc++kXMNXbdv7eX+2CUxOPApfAB7GGOZKFo6HJ5iwUpw+p0/mYFb7HIvGONsqtyk57+ut+m
	cquvTnLQEmn/MYYdBzKDeZJvWmJciZTRY0uS4+JnVXQvN/sx3FR9FzKPd8LjrDPzvolVAw1a546T5
	MaSq67kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJKM-002XF2-1R;
	Fri, 28 Jul 2023 09:00:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJKJ-002WxQ-2T
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 09:00:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13BD3219B8;
	Fri, 28 Jul 2023 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690534795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1yAQj2+drdxOg7W1xMMihj39vdtsCy+k9dgFHWRk9A=;
	b=N0rVU+qUJPLE+5c9Fe2qfiQ4QbEZQ7uOazDWiF4qTaPR4NpWdkKkS8jI1Ck9Zwe6bae+mr
	im99wL/jnP6faUX3Uo+ijZIgeoz6KKw7xaNAQ915XLzDNdTC3uQAKTpq9JFAvSll8YZiD7
	G2jza5/bdosUUSWdRG9M5kbJdc7MUAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690534795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1yAQj2+drdxOg7W1xMMihj39vdtsCy+k9dgFHWRk9A=;
	b=XmNFzsCzeT8aHQNyOZo67JTXE5Qr3GO1uEDjLw+BvbWChknTYmwEHmuilIIvi327JDHha2
	NIeacs1hzD+6y8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04B0D133F7;
	Fri, 28 Jul 2023 08:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3oH3AIuDw2SleQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:59:55 +0000
Date: Fri, 28 Jul 2023 10:59:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 00/11] Switch to allowed_host
Message-ID: <ldlkosfmplhb4cqunws5nknpxrgcenbgytlabszl547vygxtbh@xsd7pzil6nk4>
References: <20230726124644.12619-1-dwagner@suse.de>
 <hqi4yxhc3jc7v7ywf5qvy3u2th676irollqngbsh62rrlitkyy@rhl6axqsve5s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hqi4yxhc3jc7v7ywf5qvy3u2th676irollqngbsh62rrlitkyy@rhl6axqsve5s>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_015959_956373_5BADDA07 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, Jul 28, 2023 at 08:20:55AM +0000, Shinichiro Kawasaki wrote:
> > Except the last two patches are just refactoring patches. So if we decide to use
> > common target setup/cleanup helpers, I think we could add them before the last
> > two patches, which would make the last patch way smaller.
> 
> I ran 'make check' and saw shellecheck complaints below. I added 'export' to the
> variables then they disappeared.
> 
> tests/nvme/rc:19:1: warning: def_subsysnqn appears unused. Verify use (or export if used externally). [SC2034]
> tests/nvme/rc:20:1: warning: def_file_path appears unused. Verify use (or export if used externally). [SC2034]
> tests/nvme/rc:21:1: warning: def_file_path appears unused. Verify use (or export if used externally). [SC2034]

These variables are not used in nvme/rc at the point I introduce them. Only in
the tests. I could add the nvmet setup/cleanup helpers with the variables which
would make those warnings go away. But these helpers would then add the end of
the series. Also not really good. I don't what is best here.

> I also ran nvme tests with the export fixes and saw no regression. Looks good
> from test run point of view.

Thanks!

BTW, I am off next week, so I don't think I send soon an update.

