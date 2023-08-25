Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E96C7EE2C
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnYY8U9ugF44RNWGBtqhWfIQ34dMJpcLQpRX4lYVKPE=; b=YuTZ/KSqfK8JjN08gAZXfOcrRm
	cEkddKp7rDPzlFT3MefvvIwenfRCc9EMbPrX/bembVbCuR4FaTknUEwYQzOfqaHiUZxBaL3NVlyJ3
	Kxkw1LIoZfz1UGVQjsKrF1Ie+HiC7/tHSpwnGI4C9kW+KO0RKgPBIf+E1jzQF+YX/2DPCzUMwlrY2
	Vf2hLVtkDdoZuqwKMwnll4HZaO8/JaZDmeav5iddjtSCWhEkQDzpA9LwXOpHhPoosnp4z1lH82MHm
	PikSAGw88XSETAUYf5dNWpDnIHRJh6vGS3bTxwoO8wVr8Tcc7DNnjzhNPBn37ikCCSwJ4xZGmF+7m
	8nYlQSuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQQx-004TWx-2b;
	Fri, 25 Aug 2023 06:36:39 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQQu-004TVr-0a
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 06:36:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF8E61F8B0;
	Fri, 25 Aug 2023 06:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692945394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYY8U9ugF44RNWGBtqhWfIQ34dMJpcLQpRX4lYVKPE=;
	b=XpRtwWSxk7FWo6w7XUvip8eOXDVnoanVkJeY6WxaqprCeLJC1la4aNjAg6TVfjAUTJpoy+
	zDeyH8Cwvn+Gi8CJXA/1X9ipOM2uvqq5d6v2JCIN1HPYu2WG9tsclJAgE40GhMd7T9Pjmt
	gg1FXKAOubvLvqFcQ2WqKsMlMC1c3gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692945394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYY8U9ugF44RNWGBtqhWfIQ34dMJpcLQpRX4lYVKPE=;
	b=dULSZte9Z0e77TECiRslE6+piTA/77yfXrDwwB6FLOS59oN6v8/KjiPSd7Q2Bl50TebIoA
	iUjYcjtcqNDgYvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1EF2138F9;
	Fri, 25 Aug 2023 06:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dQRdK/JL6GQpLgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 06:36:34 +0000
Date: Fri, 25 Aug 2023 08:36:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Guangwu Zhang <guazhang@redhat.com>, 
	Ming Lei <ming.lei@redhat.com>, Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <j4azjg6k4cg3tynmvyl3qqcd7imcoaisy35ssqob34cw3ox32g@qk7dmqt72vbx>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
 <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
 <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6>
 <ZOYnzFSgWAwnkWqs@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOYnzFSgWAwnkWqs@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_233636_367200_E715B7EA 
X-CRM114-Status: GOOD (  23.06  )
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

On Wed, Aug 23, 2023 at 09:37:48AM -0600, Keith Busch wrote:
> On Tue, Aug 22, 2023 at 09:55:38AM +0200, Daniel Wagner wrote:
> > On Mon, Aug 21, 2023 at 09:11:38AM -0600, Keith Busch wrote:
> > > I don't think we want to bounce to kernel memory for the device to
> > > overwrite it. I suggest just change nvme-cli's stack allocated santize
> > > log to a use page aligned and sized buffer.
> > 
> > Sure we can add workarounds in userspace, though I think this is a
> > regression and should ideally address in the kernel somehow.
> 
> Not sure if this is a regression. Even prior to the DMA alignment
> settings change, you'd still hit this if your stack buffer aligned to
> 512b. The kernel bounce buffer sounds like it just corrupts kernel
> memory instead, so we can't have the driver just go back to the way it
> was for these devices; someone has to over allocate the buffer.

Okay, let's ignore the regression argument then. But what about the fact
we are asking for 512 bytes via the kernels API and get too much data?
Isn't this something we should address? I mean this forces all users of
this kernel API allocate enough large buffers to handle this device.

Alternatively, we could add bounce buffers in libnvme instead in the
kernel.

> A device over running their DMA buffer, though, sounds bad enough that a
> firmware fix should happen instead.

Oleg contacted the manufacturer but I do not get my hopes up at all.

