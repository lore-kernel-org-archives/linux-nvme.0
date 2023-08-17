Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C75C30624
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkwiCpQo896fyL2M0/MKAJ3AcqSD9MJw8IKCLwJoY5o=; b=YXo3zQdfE8vBYnTUwgN4R/h/xb
	UW5LWEzABDS7+iutqzheb5O4/F9HFoUyjiNgoNG2odcuNYiiOAGxwfdGNRaU2E/AG/x213k8zwjya
	ndQb2Z6upvp04aLoV29c8Z/k/hXf7TrDTlSYtH6TOQiRzuJRJ1vvck3VsUnm9RaPc6MFf7ofnBcpf
	oVJsq7OQ3OY6vlCat4XzrKePhjz6LD3Az6yJOI8U4eync/4z2t/A0m2L8VsEpUfq1skL8WyNdHstR
	/wIX+Y8FBT0ZWp7KquyXOmRk8ahS219PduN7avNa+e/kLEPwmzqq3FrtuXoKHCLItMV71ZL4rEmc7
	UvHUvrPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWeA7-006Z4Y-0H;
	Thu, 17 Aug 2023 14:39:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWeA2-006Z3v-1t
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 14:39:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D88AD1F37E;
	Thu, 17 Aug 2023 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692283179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rkwiCpQo896fyL2M0/MKAJ3AcqSD9MJw8IKCLwJoY5o=;
	b=JKAw7NUPNZZVkAAMn5ZYNDzhQNRxx/affSeS6tgkgSsayFekCAA2VZknrAiA403jYpzC5T
	rkxvVR/xFCnpVKvYMMxjqfG+cAFUr/HEBsbXYQ4rpSjNhmjkZ9MkQngOtc4XSAft9fuu3e
	BiAN+2zYn7KQ5CC1jpVWv70EHL2ozsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692283179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rkwiCpQo896fyL2M0/MKAJ3AcqSD9MJw8IKCLwJoY5o=;
	b=kt29ZKRFhM7YBQ2gaDGPzNOcoSmUUlMma1GMldC4FqopLNwPJnA8rFfAkZrWOIJ65RLNvp
	frgsBUJimVgROcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB1AA1358B;
	Thu, 17 Aug 2023 14:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id b8CQMSsx3mTKKwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 14:39:39 +0000
Date: Thu, 17 Aug 2023 16:39:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Message-ID: <3wmt5cd5yd5ru3uzp5grcspkvi27ijztnxwxhov7chmf6wicg5@6dj2qed6ulja>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
 <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
 <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_073942_785466_59FF4230 
X-CRM114-Status: GOOD (  22.52  )
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

On Thu, Aug 17, 2023 at 02:09:39PM +0300, Sagi Grimberg wrote:
> Where do you stand on the kernel exposing capabilities that do not
> manifest in "valid tokens" when writing to /dev/nvme-fabrics ?
>
> today when we read /dev/nvme-fabrics we get a string with all
> the valid tokens. that is useful for userspace to understand what
> it can or cannot pass in a fabrics connection string.
> 
> In the example here, we are trying to introduce a new format for
> traddr argument that is now supported by the fabrics driver (tcp/rdma)
> where traddr can now be ipv4, ipv6 or a dns name (where before this
> patchset it could only be ipv4 or ipv6).
> 
> The question is:
> Do we enforce that every new capability must come with a matching valid
> token? Or do we want to expose capabilities that are not necessarily
> come with dedicated tokens (like in this example)?
> 
> I think the latter is a be better approach. But could be convinced
> otherwise...

My gut feeling tells me in the long run it's good to have some generic
way to inform userspace of options format or feature changes. I am
pondering if sysfs wouldn't be the better place for this. But then we
would need to gather this info from two places. Not nice.

Just to through in another idea, we could also introduce a version
scheme, e.g.

...,traddr=%s@v2,...

If I got this right, the current libnvme token parser would just ignore
the versioning string.

Obviously, the simplest way is to introduce just a new token and be done
with it. I somewhat don't like it. Maybe I am trying to over engineer
this.

