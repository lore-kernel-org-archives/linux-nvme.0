Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FEBC3DA6F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTQTzS7jcW5Dyy70M1pwbotuquEpW0pW0g8qkbMwvjI=; b=lvIt1i1fEpR3JNXVlit+5f5gBk
	yy8BvA1/8QYghYYtKvyRV023MTzdq6RzVY3Vu7jvFihHv8SFbS18iKsrVsXVVKUFaogJF0UseVBOI
	qGERDcKuNaJAj7yEg/4GDxXaYLe8i8EGuinB8zlS7O+YjNf8Jz6XuVPwib/9e05iDmC7eicfpsHcL
	MluqJ4cZNfY1nfvlCjxlubYXn9l5aqUSXJtQXiGuFGs1xyJGWxf+c0MuEBVixraqyFD9sm+PF5XJT
	vPEUb5yHQz9zUytu/i+kamD4FpheqFWbkqyKG7oiflvXZN6xwH4EWIcGyUV5ptuQKUaDkrK86mfbD
	HYfhY5lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZUzo-005EQS-20;
	Fri, 25 Aug 2023 11:28:56 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZUzm-005ENi-0X
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 11:28:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E91721F99;
	Fri, 25 Aug 2023 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692962932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTQTzS7jcW5Dyy70M1pwbotuquEpW0pW0g8qkbMwvjI=;
	b=Y7RosvmMmMWKXTY3jAPvch+LYM6Xhah4CZ+LYCfgpYHbAdSsNIYgy0+56Ed9DWkGnesy/X
	AKbVO9/nwMeAFrNmEWV4b6rJWClbzKf0vs3Vti/AyE0mV378sqNAfxbfMLa2o5IuOnRl3f
	ycyIsbg9uXQIeITAarhBvm7L2J1yw7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692962932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTQTzS7jcW5Dyy70M1pwbotuquEpW0pW0g8qkbMwvjI=;
	b=sZQ4exe0xCHdRY6mCYV3Wv1Xzq6NgHdVEAUMcacq8P8Od6utsz0UsAJLFyobcasbPZLTml
	gMzDSDR2NiT7XUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E85E0138F9;
	Fri, 25 Aug 2023 11:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id K2u3OHOQ6GSJPAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 11:28:51 +0000
Date: Fri, 25 Aug 2023 13:29:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <kmnosm2p2vct7sxalz2dhr2yt32s2vdx2hvuvk4jli2hwjudv7@gdkrlayoojrf>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230825_042854_380908_9BD312DE 
X-CRM114-Status: GOOD (  22.06  )
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

On Fri, Aug 25, 2023 at 07:34:21AM +0000, Shinichiro Kawasaki wrote:
> IMO, SC2119 is not broken. SC2119 (and its companion SC2120) assumes that bash
> functions do not have optional arguments. If any functions which refer arguments
> are called without arguments, it complains. With the assumption, SC2119 is
> useful to detect missing arguments of function calls. (I guess Bart thinks this
> is useful.)

I wanted to say that the implementation of SC2119 is broken, not the
SC2119/SC2120 itself. Sorry for the confusion.

> However, when we implement argument parsers in bash functions so that the
> arguments can be optional, the assumption for the SC2119 is wrong. Then SC2119
> reports are useless. Until recently, blktests had few functions with such
> optional arguments, such as _init_null_blk or _init_scsi_debug. But most of
> calls to those functions had some arguments, and it was rare to call them
> without any argument. So SC2119 reports were easy to suppress and not a pain.
>
>     I doubt Shellcheck can be improved and detect if functions have the optional
>     argument parsers...

No idea. But we are not alone with this problem:

https://github.com/koalaman/shellcheck/issues/2511

> Recently, you actively cleans up tests/nvme/* (which is great!), and introduced
> argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, and the
> second one is this _nvme_target_setup. It looks for me this is a bash coding
> style change in blktests, from "don't use optional arguments often" to "use
> optional arguments aggressively".

Yes, it's a bit excessive to hand in all possible arguments all the
time. Especially it makes it even hard to review if only value changes
but 6 default values are passed to the setup function.

> If we apply this change, we should suppress
> SC2119. If we keep the old coding style, we should keep on enabling SC2119. What
> I see here is the style difference between you and Bart.
>
> Now I'm tempted to disable SC2119, and to go with the new coding style...
> 
> If I have any misunderstanding, or if anyone has more comments on this, please
> let me know.

All good from my side.

