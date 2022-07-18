Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE889C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57gkp0hUG7Y73zWw1Kce1r7pjaK22KjeqS40qcTUkzE=; b=Hvrrg+B1fb209km1IxwylIUJ2d
	2QLdM6Aguhi/RWok6l/+O3YcLZImg+k26oCHVoUwbj5auGY8dJkxOxbepqCd3M5fXq2tsOkCHYHeu
	vVvZd3S/UuLNZWjJJPo4rdxW7PLMd6n5trggZQJ5D7flaGqeSesMERCM/CYu8WGoUFusGEND/q7Qw
	gnaO9nSoW384qGO0V2OHWkETharKZddFIj355oYrwzP75t6LBES0jAJx013FCPisE1jOr/uHQXrHT
	5QuwuwyhHLoHBq5uyq5W7kxNXgoXi3s1XNO42T/ih2sfS3Vl4e3qrXElyv6/CsKz+t95+U+ea30ly
	eDKaTmWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDMfA-00Byk9-HR; Mon, 18 Jul 2022 09:03:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDMf7-00Byf4-4t
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 09:03:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E42DD20D06;
	Mon, 18 Jul 2022 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658135005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57gkp0hUG7Y73zWw1Kce1r7pjaK22KjeqS40qcTUkzE=;
	b=n2r2J7I4Z/UzJsod/fdYlUtlEJWtvitT3bOwIAzakFS7uhwhRTDi3uM9pth+/ac4E2u+L3
	5BprjSWo25iMAg+H792pkEVZQeLUBUvcHtb+qOhfO+xD2YDX/I9di/XBPcc13OzqnLwsrl
	PKrw0++dcWeF8xtKPg5rV67vz0JiEsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658135005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57gkp0hUG7Y73zWw1Kce1r7pjaK22KjeqS40qcTUkzE=;
	b=VKBcZSQMwcZ3WQW/IZxze+BijA3qfW22vEo6v3DzaGTTp4yv19TK/Y1rUrM6R5J/MNZs56
	1dM1T2nh1F5sVJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4B1F13754;
	Mon, 18 Jul 2022 09:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Kf7YM90h1WINIwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 18 Jul 2022 09:03:25 +0000
Date: Mon, 18 Jul 2022 11:03:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, asml.silence@gmail.com,
	joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Message-ID: <20220718090325.4bh4xjfe5yuihdvo@carbon.lan>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
 <Ys+QPjYBDoByrfw1@T590>
 <20220714081923.GE30733@test-zns>
 <20220714153051.5e53zgkcabb7ajms@carbon.lan>
 <20220715110700.GA27117@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715110700.GA27117@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_020333_395946_276E7A5C 
X-CRM114-Status: GOOD (  21.76  )
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

On Fri, Jul 15, 2022 at 04:37:00PM +0530, Kanchan Joshi wrote:
> On Thu, Jul 14, 2022 at 05:30:51PM +0200, Daniel Wagner wrote:
> > On Thu, Jul 14, 2022 at 01:49:23PM +0530, Kanchan Joshi wrote:
> > > If path is not available, retry is not done immediately rather we wait for
> > > path to be available (as underlying controller may still be
> > > resetting/connecting). List helped as command gets added into
> > > it (and submitter/io_uring gets the control back), and retry is done
> > > exact point in time.
> > > But yes, it won't harm if we do couple of retries even if path is known
> > > not to be available (somewhat like iopoll). As this situation is
> > > not common. And with that scheme, we don't have to link io_uring_cmd.
> > 
> > Stupid question does it only fail over immediately when the path is not
> > available or any failure? If it fails over for everything it's possible
> > the target gets the same request twice. FWIW, we are just debugging this
> > scenario right now.
> 
> failover is only for path-related failure, and not otherwise.
> you might want to take a look at nvme_decide_disposition routine where
> it makes that decision.

Ah okay, never mind. I somewhat got the impression there is special
handling code added for this case. Sorry for the noise.

