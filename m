Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AEDC77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOkGMScXr2xzxYGwl2ZKfzUeL4mY6lt5XJozlj4l+6U=; b=nFARsxNNFC7AFgdAOCCfJbt2mo
	XaHGG6bQwAp0I7PNK9/thmuZeK3y6izxkxkqqMRec0V1zNThYGqWarP1XoJdw14R2BL817fVCe/lW
	+brufVUzVtkDY52o0nzXEoaqRYZdzZobyfTOqFctNS64vpDjtyM0BpwQ2BfkPjlUhsAbMGNgk8A4K
	+CVccU3Iwi/KigHVMsBCs3peK97p0N24KUcFeicJTDt0N2Ps8PHSUSCnme/bKBcn1/rs+0eP0QSPT
	JKi2ws0xciWLCXTCvFp8zRwFNvt9oiQrfuzNhA4mIXZKPP1pQbjmhHfr56jfw+dVg6Kv+M//mI7Q+
	y/3zAR9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puCxd-004mBW-2h;
	Wed, 03 May 2023 13:56:01 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puCxX-004mAl-31
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 13:55:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49F8C2288A;
	Wed,  3 May 2023 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683122151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOkGMScXr2xzxYGwl2ZKfzUeL4mY6lt5XJozlj4l+6U=;
	b=RPY7b2OI8mjErUTc/mf87ltSwMViQzLcbweR99mxJoFI3WsAwdJpxs6HfCaplV/jrOEWGP
	fzoGq0Fl7riZyBoYk3wolFzo8duuBddHOwCDD6vc6vEvrIx5aaTjsP8S/R5CNYwX+HZiVP
	pSpaB7R3KS5OJH5O9vZcTFKgj3q31gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683122151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOkGMScXr2xzxYGwl2ZKfzUeL4mY6lt5XJozlj4l+6U=;
	b=bOrJMHG+Ja2eoo1NcgvLDDo/IcPUgKwhZQPjqwS05gdwCAJsCZ7j1blVogUKEOBcCuhVC/
	5zmWwzvXTqyIZtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C0B613584;
	Wed,  3 May 2023 13:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bkuVDudnUmQHMQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 13:55:51 +0000
Date: Wed, 3 May 2023 15:55:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: 	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Message-ID: <m7icoy7ggamihsjscurhwcqc6skjhrlrdggx3lm2frxue6obnv@zeitny5i752u>
References: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
 <9adc17de-5159-94bd-abd5-e52a09e9e3d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9adc17de-5159-94bd-abd5-e52a09e9e3d3@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_065556_149468_3B52BCD0 
X-CRM114-Status: UNSURE (   8.65  )
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

On Thu, Apr 27, 2023 at 08:42:34AM +0000, Chaitanya Kulkarni wrote:
> good idea, in order to make the discussion more interesting and productive.
> Could you please share the latest code LSFMM so that everyone can go through
> it?

Sure, I'll update the series

