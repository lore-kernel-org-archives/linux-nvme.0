Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF78C77B78
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 07:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rtWXlVT5BsQ+9u99bjnLdBNoxWAcQElzaxacnHOXTI=; b=mv80WKYT8qI/Dg2tfxMeu8FYAq
	kJcHICMaYsfACNCwhcyqp6xPTre9M74eynT+jf4P+4k5Nt8p5dl2PDmgLuqLLUua050hLbQoIT5pD
	G4YUVw1OhGfRYoBgBMO/WdB50XeNcxUzIySXdYZMbg/6R1/9hjzn370eWS8mLlyS6m7gwlMVcDw9N
	4uOoE6n2xkTRADD8XxShAXaLnZscq7NY0KVruvS/Y+3tPfIRaklztPEeXqR3gCaMDYrDMsgF3xKia
	dvLFBOqQl/SyMZu63Nq22XDE4tfy5cNLd85m6VMpMAfodwudCxP4KQ3Sk6TRT57Bde/HtO8TMSFHM
	wEsGnWBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkny-009uWb-25;
	Fri, 21 Apr 2023 07:03:38 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppknw-009uW8-0T
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 07:03:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76E591FDDC;
	Fri, 21 Apr 2023 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682060614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rtWXlVT5BsQ+9u99bjnLdBNoxWAcQElzaxacnHOXTI=;
	b=1F8t7EYbDxtAnuR9jahNG2NSpaCyAN8tuFMnBdX0e9yVSzLrb9UO6uG+6VmdWHToruPTJO
	XcUaXvQOq9jPc2JZs1O7be9XRrm0QG703Ik2bv+15LpnlHvGuZlcjp0axKo+Wz/waAjm4w
	JxUni3tpgaWPkf0K7MZFqLolAmpSCn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682060614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rtWXlVT5BsQ+9u99bjnLdBNoxWAcQElzaxacnHOXTI=;
	b=VtwYNriBGsu5v97+sGmbgOcQAu2YRRbXwoACP3zhiPTY+elacxfqPuPXXNBKyBMxkmzwlN
	Vkk0IGGso0ShA1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A10F13456;
	Fri, 21 Apr 2023 07:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zZbgGUY1QmRKAgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 07:03:34 +0000
Date: Fri, 21 Apr 2023 09:03:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <7qew4jvwfgvpsqlci6dh6r6vjmzrzaphbqzzxqvvpdfadkj3ab@vxvbvh26bvji>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_000336_329426_B4BBAB84 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

On Fri, Apr 21, 2023 at 08:33:46AM +0200, Hannes Reinecke wrote:
 > +_nvme_calc_rand_io_size() {
> > +	local img_size_mb
> > +	local io_size_mb
> > +
> > +	img_size_mb="$(convert_to_mb "$1")"
> > +	io_size_mb="$(printf "%d" $((((img_size_mb * 1024 * 1024) / $(nproc) - 1) / 1024)))"
> > +
> 
> ... ending with ridiculous small io sizes on machines with lots of CPUs.
> Please cap nproc by something sane like 32.

Yeah, propably not really good long time strategy. I was wondering if we should
make run_fio() variants smarter and do the size callculation there and not by
the callee. If we do this, we could make the number of jobs dependend on CPUs
and image size a bit nicer.

