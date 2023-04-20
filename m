Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1BEC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yd855QufpSTndikkrlPcwAwqjiD7xx7jVIQwBoEWpJs=; b=DyREi9f8wB6m3H3guLQ3e4yeD5
	hp9oX1LHDKbEHF8DA+4NJwiS4YXV7m9pA1bHfofYya4AzpmvzfF8paVEoH415J2cRfAlX3nFRrbVm
	V7CiSy5ZcUxTA0tup95ulZok8DKgw924hJP2tcCKIt3yKl6JCsKxWftiFG4xEhKXLpzC5j7sqwbEO
	zCCJs3pgMlknTvl+T4+xJfrEhfCZQvK9ateHUQ92TUyophEpLH/hydvOMaxvDhOt6TEU3Fiq1fwKt
	TwIVJJQ9ZY/hxjiEszebJKwuKibhpKWCvBJy4ctJTNdpgUq0su4CUaDnam7c1oKmQakTNG3q7aa1S
	E3ysfmDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppPhX-007PdZ-18;
	Thu, 20 Apr 2023 08:31:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppPhU-007Pd3-36
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 08:31:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73805219E7;
	Thu, 20 Apr 2023 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681979491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd855QufpSTndikkrlPcwAwqjiD7xx7jVIQwBoEWpJs=;
	b=1APtTs9B9/M72KN0K8QiDSwnotsp81/ODC431BLOoGUmvAL29PhNqeM1jlXC+RMrKPMDKg
	PTgBeRxWhbKuPVR8NfntkHbmyC6QUUeOWq0lzYY7bEnKRxk+EuP5qm0V/rO4yhjX7zoUvq
	b4/ynx0zTWNTjY80f1tbgWxSn4XjpbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681979491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd855QufpSTndikkrlPcwAwqjiD7xx7jVIQwBoEWpJs=;
	b=ED6M1Uv2SyEnsPleNx2Aopaqz886wN/ApXoQVa5+0q9WNIuXpIQjyAfHFPOwfknJEs3dyw
	j32eGem0814HKACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60C3F1333C;
	Thu, 20 Apr 2023 08:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 16KWF2P4QGSIcAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 08:31:31 +0000
Date: Thu, 20 Apr 2023 10:31:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Message-ID: <xhnr5dhpjqh5ynhqkcwn5ohfjvzlaw7chmuqicp7oqdd76ixxz@uzsozlvenedd>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
 <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_013133_160190_EDA78412 
X-CRM114-Status: GOOD (  19.94  )
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

On Thu, Apr 20, 2023 at 10:24:15AM +0200, Daniel Wagner wrote:
> On Wed, Apr 19, 2023 at 09:11:33PM +0000, Chaitanya Kulkarni wrote:
> > >> Those jobs are meant to be run for at least 1G to establish
> > >> confidence on the data set and the system under test since SSDs
> > >> are in TBs nowadays and we don't even get anywhere close to that,
> > >> with your suggestion we are going even lower ...
> > >
> > > Where does the 1G boundary coming from?
> > >
> >
> > I wrote these testcases 3 times, initially they were the part of
> > nvme-cli tests7-8 years ago, then nvmftests 7-6 years ago, then they
> > moved to blktests.
> > 
> > In that time some of the testcases would not fail on with small size
> > such as less than 512MB especially with verification but they were
> > in the errors with 1G Hence I kept to be 1G.
> > 
> > Now I don't remember why I didn't use bigger size than 1G
> > should have documented that somewhere ...
> 
> Can you remember why you chosed to set the image size to 1G and the io size for
> fio to 950m in nvme/012 and nvme/013?

forget it, found a commit message which explains it

e5bd71872b3b ("nvme/012,013,035: change fio I/O size and move size definition place")
  [...]
  Change fio I/O size of nvme/012,013,035 from 950m to 900m, since recent change
  increased the xfs log size and it caused fio failure with I/O size 950m.

