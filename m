Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C194CE7A81
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCuMje2XpdmvDa3lCEa5YfkqWqoj0pullsp9Lb9SJDk=; b=Zf5MC9Av/1ea8GWJQITpXxqLaN
	najPwWcbw8ZEX3s9odP1Odghroyvhw6Lj0BlPBlH32mLE6tVWIL4q5TRAX7+kOVxEz6NnfdnJHcxp
	ZnS9VqQ6EZbY0cZp9UpM+kF3o2C8KIwjnBHIKTordXXA0QgT9W+uWB2a9Q7orWhzmzASH1SZ3C/cs
	h5J9hhmxrznhK9FVsoAKBLxocJLCfWqlW6XcnHdKh+tfYu6PRtjgcYyktKgze+2/tGMZJqYeVxylx
	wdqoO1gvQFYKk3Ycmcird6+1oMMt5IrOUDAlMtVtFSlkg+K/HItHht5gXKjkNfxkv2+89Cc+/XZ7m
	xdfa7NQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qknCO-00EVom-1I;
	Mon, 25 Sep 2023 15:08:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qknCI-00EVmx-1O
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 15:08:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D454021853;
	Mon, 25 Sep 2023 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695654505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCuMje2XpdmvDa3lCEa5YfkqWqoj0pullsp9Lb9SJDk=;
	b=1d+F1KpUu5i6igGVbkMbVoWblg54XbwhMX4uxYAk0oJnOOlobhtCQi8Fz6mCS1I9XFzHXk
	o5oNSvMOXEYrlzHZiVC3Tw7vLAaixFvMtbKwRVSIHLjVJJ5a4B76kNS6CNNL2IxFiBdeGj
	tc4UY1qRrymYwZrVBmHRoWSrxa0Ayas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695654505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCuMje2XpdmvDa3lCEa5YfkqWqoj0pullsp9Lb9SJDk=;
	b=xdET9V8aa4Kqh/qFMzgYKo5jeuRkYw2N6HO1vliFhNJJPlTeWWeaV2DvDZeSQhC1jYowMl
	bRQSNtlU3YhUmjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C039813580;
	Mon, 25 Sep 2023 15:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FVQKL2miEWWRSwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 25 Sep 2023 15:08:25 +0000
Date: Mon, 25 Sep 2023 17:09:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Guangwu Zhang <guazhang@redhat.com>, 
	Ming Lei <ming.lei@redhat.com>, Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <fq5ds4d6u7zz3bsag6tj3xdjhodwc25g5nggvalgwmcfovbjma@guuybbch4eja>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
 <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
 <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6>
 <ZOYnzFSgWAwnkWqs@kbusch-mbp>
 <j4azjg6k4cg3tynmvyl3qqcd7imcoaisy35ssqob34cw3ox32g@qk7dmqt72vbx>
 <20230828092155.GC30603@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828092155.GC30603@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_080830_631536_5309A79B 
X-CRM114-Status: GOOD (  17.23  )
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

On Mon, Aug 28, 2023 at 11:21:55AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 25, 2023 at 08:36:50AM +0200, Daniel Wagner wrote:
> > Okay, let's ignore the regression argument then. But what about the fact
> > we are asking for 512 bytes via the kernels API and get too much data?
> > Isn't this something we should address? I mean this forces all users of
> > this kernel API allocate enough large buffers to handle this device.
> 
> There isn't really much the kernel can do except for using an IOMMU
> when available to protect itself from this, but that will mean we're
> shutting down the device when it does that.
> 
> The device just seems completely broken unfortunately.

Just a follow up on this. I've update nvme-cli so that all payloads are
allocated via the nvme_alloc() helper which ensures that the payloads
start at a 4k boundary and the buffer is multiple of 4k. This should
address this issue.

As turns out, more devices suffer from this problem: SK hynix PC611 NVMe
512GB SSD[1].

[1] https://github.com/storaged-project/udisks/issues/1193

