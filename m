Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75140C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qjqT7SoxoR9mTBoMZMCI7jluhIaJmn/utMED2HCl/Q=; b=MSBI/xbdY24UihaoRq/N+YTYAY
	JkQxmyPWXNBB5b13ZLOIwa9Hev9Bej2q5dd7IGq4i2swYr5qHSvxBNxjsOZ/2ItDEHUSZYYXqwLBG
	v/fZJjGKG3imwPfkNdIdARNYnCwkhvlftISVrjwKF/MbrddwEndaceLjN58bTJw23zGLHAKjdGkKC
	Kny3Peyg91aED4hk2PE+GG8hwRE7ubydtk8ILr9yjWJzftN5m0ruBuFTMWrsmqToIM8oMt7JwwdNg
	10E2xTIJNDE/1Bssl/E/heAGVpFYGhuXJWK0My+agLxv3dsuWndsxIKkCFqaS7wZzdKg7Sd5C3dCB
	pF9X/Wlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0nq-00Fiyn-Ki; Thu, 14 Jul 2022 15:30:58 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0no-00Fivg-Ci
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 15:30:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE80F33FC3;
	Thu, 14 Jul 2022 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657812651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjqT7SoxoR9mTBoMZMCI7jluhIaJmn/utMED2HCl/Q=;
	b=EiHzMxDmlU7EFkfaKGQ3NPyWR/nQ/wJVfS/BfupL2vMMk58MErRaeDyeGYGNDzxwKFgnIt
	30I0tn0r+DT3V4zqPunRblVvDPgUA2cOt255YYKdRdSFQl6xdR8noYXbKZBcbV04eDnI2x
	xoRaK24x0c0usq3+HWBlsb1ZpfDHCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657812651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qjqT7SoxoR9mTBoMZMCI7jluhIaJmn/utMED2HCl/Q=;
	b=AtG53+dMYDD2TdTwBe3wsKp7lrtNO3JD78sVC3LoZbBzIqQIb+wtYbhF9Av4AwOJdyu5Cg
	30nEAemoaiE2K7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB5913A61;
	Thu, 14 Jul 2022 15:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yxZrMqs20GLUTgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 14 Jul 2022 15:30:51 +0000
Date: Thu, 14 Jul 2022 17:30:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, asml.silence@gmail.com,
	joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Message-ID: <20220714153051.5e53zgkcabb7ajms@carbon.lan>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
 <Ys+QPjYBDoByrfw1@T590>
 <20220714081923.GE30733@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714081923.GE30733@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_083056_603610_1DAC5C8A 
X-CRM114-Status: GOOD (  12.85  )
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

On Thu, Jul 14, 2022 at 01:49:23PM +0530, Kanchan Joshi wrote:
> If path is not available, retry is not done immediately rather we wait for
> path to be available (as underlying controller may still be
> resetting/connecting). List helped as command gets added into
> it (and submitter/io_uring gets the control back), and retry is done
> exact point in time.
> But yes, it won't harm if we do couple of retries even if path is known
> not to be available (somewhat like iopoll). As this situation is
> not common. And with that scheme, we don't have to link io_uring_cmd.

Stupid question does it only fail over immediately when the path is not
available or any failure? If it fails over for everything it's possible
the target gets the same request twice. FWIW, we are just debugging this
scenario right now.

