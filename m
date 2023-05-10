Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3DBC7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kuetgIzwwu+7VqT/P0y7E9p5TtmeuKVCGagj0//uNXg=; b=0x2rzq1NPSAlaVQaKTB7ULoLIn
	IgHbHNZJIE4wHD3VwHAgzX3AaFZfH9D0aZjhkevBx4oENl54x95d0vQsZphbVCjHFSMswCldzCjZG
	bi/7bx5BrR2V3FH02hwtAzEiBdGslu0oSO0FAGigJUjux8tyuNPcncdnpQorrBs/nnNEn0t088E55
	yWWW6OIqCYTXCVwv4xqAZ2gCAlF/lpnWVfq8h7S3Gq/DlqjTs4rPzXL982DQVRYcE/ejDLL3qZ9Uz
	AJHMkKwM8YLA/G7sYa8xn8qdVn0guakWl4wnYJIO0vVS0YffD4bBPBcNbr9bFaCbTrd8s615pNM39
	pzcYRLBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwnY1-006eqU-2V;
	Wed, 10 May 2023 17:24:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwnXy-006epu-0s
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 17:24:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6DE1F8B4;
	Wed, 10 May 2023 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683739452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kuetgIzwwu+7VqT/P0y7E9p5TtmeuKVCGagj0//uNXg=;
	b=YWD7wPAXrRp/wAp70Aa1nMiD75z2StfVsG9Y8R+nU0bqMuMoAr5bAEaUSEwT/kKxbx+ESo
	GNaaPHcFEEAievvqbVFjfWk174vWnNruT9gyxsZgbdyYUyTFKHJ8MEl3fwExMGzVNG5SE9
	tdntxfynuUo2gNbA/Abvbel7xUJBfmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683739452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kuetgIzwwu+7VqT/P0y7E9p5TtmeuKVCGagj0//uNXg=;
	b=VMHcJ3ee1DpYaK0F65tjcDA8Jto+NLO6Hki7H5ikt768MwZWsEh38WEqMcvyEyJDDQlaDd
	iv7zegohShT4ASDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00F2213519;
	Wed, 10 May 2023 17:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hTFHLTvTW2SWDQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 10 May 2023 17:24:11 +0000
Date: Wed, 10 May 2023 19:24:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Message-ID: <5mizvgs3mwoxbkgb3axuhgkmjjxa6svi4laksdccg3oue5fwf7@4mqtz2dm6phj>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-12-dwagner@suse.de>
 <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_102414_479655_0808236F 
X-CRM114-Status: GOOD (  14.50  )
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

On Sun, May 07, 2023 at 11:34:51PM +0000, Shinichiro Kawasaki wrote:
> On May 03, 2023 / 10:02, Daniel Wagner wrote:
> > Move the discovery generation counter code to rc so that we can reuse
> > it in 002.
> 
> The last #12 patch no longer touches nvme/002, then I'm not so sure this patch
> is valuable. IMO, the lengthy 002.out has the role to check all of the 1000
> times discoveries are successful. So it looks the better to keep current
> nvme/002 as is.

While we don't update the counter anymore, I still think it's worthwhile to
do some cleanup. We have two tests which do the same thing so why not use common
code?

