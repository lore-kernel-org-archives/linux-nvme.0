Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B75C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Nov 2023 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EqBpMF6+W/H/NdkcPSZDiyEXyNi38LQ4S3FcnkyXMPc=; b=HU1J/GJeZjVoDUl/wFTKknqsKL
	351ysc6y/vC2vfVssdi+bJ85U2uIentEvX6YHCI2N+I9oFxEpx/z4HUFDzPy9IUVTYBVHkzmda1Pw
	Z6/5GdBFwKw1sj3/3NCxBtFqWb6N4guFJ2gKN2f4am77QPaH06Q2CJnnhehr6ZbnKpTrXWXZWgCPU
	G36N4+WzQJOzXWSqII9uBPQJxqw40PIwucnDChahKjfIUpjWKEkupDIQiEQ3wiaqg2QUuGatoLdV3
	0id92xK827Pppva2EmYLiXMxdaFcyN45c6jVihtWQSB8Lo81Mn4odO4DwErdWyjOHWtoBSaQNNCEK
	Y4uu82lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2Ze0-00EJft-12;
	Mon, 13 Nov 2023 16:18:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2Zdt-00EJfQ-2p
	for linux-nvme@lists.infradead.org;
	Mon, 13 Nov 2023 16:18:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF5FC2191A;
	Mon, 13 Nov 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699892304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqBpMF6+W/H/NdkcPSZDiyEXyNi38LQ4S3FcnkyXMPc=;
	b=KZNAjkMgC8t4PthC6FscdPyMa+pyp/EfvvYZdUfylStaNt1XmYQRJoa+/K0htHhowVYn+E
	ek8vGyhACjN6p43tN6bW0a7xIvmuvD/fDCxlXUYZCx6YDJPI22hEetgbKmVfmEZKncst8C
	A6yWY18TTqQ5l0EDMfLIU6n+VQEEkig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699892304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqBpMF6+W/H/NdkcPSZDiyEXyNi38LQ4S3FcnkyXMPc=;
	b=gbkTgnY52fO4dy6MNJTH2eV55muBAkr/LmaF6lJo7nxH2gfekJ6+8YN7LaWv98ZDgZRe6o
	Hud60Pd6MHCFK9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE79913398;
	Mon, 13 Nov 2023 16:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xjPyNVBMUmWTZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 13 Nov 2023 16:18:24 +0000
Date: Mon, 13 Nov 2023 17:20:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests 0/2] nvme: Allow for pre-defined UUID and
 subsystem NQN
Message-ID: <6nhppt4vvmiqxejfn52blczirkzz6jkkd7knhqjqyhzmjinlkh@4jwzljveqajj>
References: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_081830_082033_A684A0D8 
X-CRM114-Status: UNSURE (   9.53  )
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

On Wed, Nov 08, 2023 at 03:47:51PM +0900, Shin'ichiro Kawasaki wrote:
> In the discussion to run nvme test group with real RDMA hardware, Hannes pointed
> out that pre-defined UUID and subsystem NQN will be obstacles. To address them,
> he created two patches in a PR [1]. I post the patches here for review by linux-
> nvme and linux-block members.
> 
> [1] https://github.com/osandov/blktests/pull/127
> 
> Hannes Reinecke (2):
>   nvme: do not print UUID to log files
>   nvme: do not print subsystem NQN to stdout

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

