Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995B8C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vasl3Zao45k71qET2Cv7fJrQh++BoZZwFAggUA3Av5U=; b=1usKTQTCHMbM4SwFLD+ItBzLcX
	v3EDEA5mn2L4XV+peiA0fB724w7VATljRqJD/T3Przlkn9o8BZQUld9+Jjxg6+gHvmZ96jmV0In6l
	+vt55IcFmCMxtiO1esRpCvepP1P02Oxz2NkWo/pRgD/leQgHt4OxCgprpO9i8U/rhRSydwtZfGIQa
	1C4P0Kj4UhdDFeFQOqZUbcJYCgcLHHjWEs2+JDAm+ai7wPwJSWVhHN+WQztvU6SxM+ekN/i2gCzaY
	mYySKE2Rglir+yplcB5krxMGPPa9xC0XX2PMmzFp/Z/bXisbnhSFPepc4i1UYBIBFUJkRv0jvHiH5
	Jcy2ezbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsMl-0021I5-0B;
	Tue, 02 May 2023 15:56:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsMi-0021HY-0P
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 15:56:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF1B421ED1;
	Tue,  2 May 2023 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683042990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vasl3Zao45k71qET2Cv7fJrQh++BoZZwFAggUA3Av5U=;
	b=tG9+8yL2LciJ4pAgNSGdXy9+mjdpD9nn8gdA1cxqmWY0BtMOsTCWhdaA1RjtXB5JHu+5SS
	400hWmR2P7BgSjjICGOCeBNdjCoj/Twg6lfNmHyY2Ab1OfQ/Gw3a6HMZqJSwm4vYE+PM0i
	NT0fem8OXlFUhAarQKi2QyZ9SXk3cfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683042990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vasl3Zao45k71qET2Cv7fJrQh++BoZZwFAggUA3Av5U=;
	b=enD5aWtik20RB7OONKWjXSwFPxPgAIkKlM9QF6oNz1wyC12nh/EWyG1mutGD6F4R2dtOrr
	ax3qH2sex/bWhMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A10D4134FB;
	Tue,  2 May 2023 15:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vCo/J64yUWSWMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:56:30 +0000
Date: Tue, 2 May 2023 17:56:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery
 generation counter code to rc
Message-ID: <4txznlflpzliiljmqstfd3q2eqa75oihig6oe2shwux3x2udoa@qpsbmbmacjl4>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-9-dwagner@suse.de>
 <2nqdgwhiuvjsupuunxzzcoeumxqz3cosx52nhgtrv35u7nqsiq@2is3qc5gftl6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nqdgwhiuvjsupuunxzzcoeumxqz3cosx52nhgtrv35u7nqsiq@2is3qc5gftl6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_085632_307865_C19374FD 
X-CRM114-Status: GOOD (  14.42  )
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

On Fri, Apr 28, 2023 at 04:23:27AM +0000, Shinichiro Kawasaki wrote:
> (Let me repost this message, since vger.kernel.org declined it due to too long message).
> 
> On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > Move the discovery generation counter code to rc so that we can reuse
> > it in 002.
> 
> I think the core change in this commit is the removal of discovery related
> messages from tests/nvme/002.out. It removes the dependency to the iteration
> number constant 1000 in tests/nvme/002, and prepares for the next commit.
> If this understanding is correct, I suggest to note it in the commit message.

This change is really just changing nvme/002 to use the same infrastructure
as nvme/030 uses. The number loops isn't changed.

