Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB354C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6T6GuDQfJbO43/1w1VH6Uivf7Fp4Qwl962Lj1m6+Lo=; b=X7bpjHGnkcQgEyah7FYP+tn1q9
	ch112XDo7mxyQgA0lfaQxwF0h39ct8k6gmU7I/AZ+OTjFOLlvPQ6OTNBegWIQ+RwY+BNLOAO3eFF4
	OrBgI1ThuH4X1gSzhReGtiqKE1rO1uAlyexZWw+1QM8aTAiGUu2ZAx+aBWijj7sLxL3jMAIjuxuVT
	a+B1e1WUgxt0VFaGG7+//dKXEFiTgQ+aG/grSDv2xQC3Xh1ly95YBoH4x1ADAF+pJnDFDGxm/98RP
	zEr37PqCLb1i34rBNjsc1L+A7H4fNQcXRunGOG3xIUdhS0K9QZhssWsAg+c9GoH8J9281fe66qUW8
	cH/7rnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqu1-001oC1-2k;
	Tue, 02 May 2023 14:22:49 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqty-001oB6-25
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 14:22:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 390E51F8A6;
	Tue,  2 May 2023 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683037364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6T6GuDQfJbO43/1w1VH6Uivf7Fp4Qwl962Lj1m6+Lo=;
	b=zgCrmh7GvS0UCf3/prJ/RboMX2Ki4PzsGnEyDNmlTehNdNLon7THEZKq5ISDaYttXVdHvn
	LSOzCGzD61p5zdqaDXeCQhaJNbVxKk+iiCTe10KcEQnHDXlYm4pRgHEnZnm2i7B6BFdbag
	tuJQLV7vBxGs3mDQXtCRIelkksRaA+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683037364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6T6GuDQfJbO43/1w1VH6Uivf7Fp4Qwl962Lj1m6+Lo=;
	b=Y6is8m8YF1YqTPPmsh9/sRZt7MNTOyZw+M4CQkHbxAjyznZhS70hG0YJfNYvBGP5ybSEj9
	7KR7fQ+ANb6bouBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A935139C3;
	Tue,  2 May 2023 14:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Mk9eCrQcUWT6ewAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 14:22:44 +0000
Date: Tue, 2 May 2023 16:22:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Message-ID: <cds6ccjotmwbwckpuhefedr3vizx4gkuqor5z4hhfodbj5hbwe@wb4tp2p7lk3b>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
 <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
 <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
 <bnr5gwlxyfixvajlpzm75mfmizgvq4uibb2b4t5tqij3jmkqrl@ialjk5an7nla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnr5gwlxyfixvajlpzm75mfmizgvq4uibb2b4t5tqij3jmkqrl@ialjk5an7nla>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_072246_826884_E8025790 
X-CRM114-Status: GOOD (  16.42  )
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

On Fri, Apr 28, 2023 at 04:29:57AM +0000, Shinichiro Kawasaki wrote:
> On Apr 21, 2023 / 08:57, Daniel Wagner wrote:
> > On Fri, Apr 21, 2023 at 08:29:22AM +0200, Hannes Reinecke wrote:
> >  > --- a/tests/nvme/040
> > > > +++ b/tests/nvme/040
> > > > @@ -38,7 +38,8 @@ test() {
> > > >   	# start fio job
> > > >   	echo "starting background fio"
> > > >   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> > > > -		--group_reporting --ramp_time=5  &> /dev/null &
> > > > +		--group_reporting --ramp_time=5 \
> > > > +		--time_based --runtime=1m &> /dev/null &
> > > >   	sleep 5
> > > >   	# do reset/remove operation
> > > 
> > > Wouldn't it be better to let _run_fio_rand_io pick the correct size?
> > 
> > Yes, makes sense.
> 
> If you do I/O size change for the test cases nvme/032 and nvme/040, could you
> confirm the runtime reduction of the test cases? IIUC, the fio process stops
> due to process kill or an I/O error, then I/O size reduction will not change
> runtime of the test cases, I guess.

The fio process doesn't survive the reset and the deletion of the controller.

> IMO, --time_based --runtime=1m is good to ensure that fio runs long enough,
> even when nvme device size is configured with small size.

I've updated the time to 'infinity' and added a 'kill $pid' after reset and
delete. Though the process should be gone till then but making the test a bit
more robust should hurt.

