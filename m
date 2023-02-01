Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B21C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=062q0IPYjRYUhKKECmadg8ie4FBj78GTqJ9X+civAxA=; b=WD/Z0qAC7GaxuNg92JKtCjq880
	zQjXrcBYsCEe4tjQV6+MAcKVqMlJMwh/Z39WQ1dzTgsumCKeJ+4YPGPntsllbhOCMcglG610JbEy4
	0RD5uJggi2cn6NOwAIGlqIsPF8qw5AAMEgx4JsdWZXLfjnYqwAQN9wNzxXsGmBeFJk5pdzV0yDXkL
	X8nc4S2IGQDtwPAvpLIbDXtYYgHz+QpBjXAugMuC5aYFLI9JMe5HQPme4eae3xdP2C/lGdKcSXAQJ
	uzoZXn31LUxjptZMW/9XfNcLip/9jmEojAD2laPyudeEYv0M4lSO/i3H4W+p4F2ld/EqJv4oqxsfL
	JE4B8roA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN86q-00AjxV-8H; Wed, 01 Feb 2023 08:04:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN86k-00Ajvl-6I
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 08:04:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2835120B32;
	Wed,  1 Feb 2023 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675238677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=062q0IPYjRYUhKKECmadg8ie4FBj78GTqJ9X+civAxA=;
	b=n7ySbLB12bnwSCzrDJ2E2OliOslHt8zuv5m+3/9GBCxxuqnqRfwlEtcejPArh+iAkGwLG2
	Vin0QlYanYfCNbxB8V5HblRDEXZxpkde8s7/Vt8Sz25EQ+mVoDMBruMPQyXXdfDO0bdMmL
	6aqdSFeeRKQ4XZfyBUehoBsmJPxIVoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675238677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=062q0IPYjRYUhKKECmadg8ie4FBj78GTqJ9X+civAxA=;
	b=m/IL9Ien31gIoENoQHjqEqnyUG5MsdflcjR42lNnCslJ+k9zSns9KkLYzsCbr05ans9qcY
	/aTf+IQGm+cqNrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 188C41348C;
	Wed,  1 Feb 2023 08:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iWnbBRUd2mO6PAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 01 Feb 2023 08:04:37 +0000
Date: Wed, 1 Feb 2023 09:04:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme-auth: use workqueue dedicated to authentication
 works
Message-ID: <20230201080436.eunvgvc5zcxd77oq@carbon.lan>
References: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_000442_387310_81158915 
X-CRM114-Status: GOOD (  12.91  )
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

On Tue, Jan 31, 2023 at 06:26:44PM +0900, Shin'ichiro Kawasaki wrote:
> NVMe In-Band authentication uses two kinds of works: chap->auth_work and
> ctrl->dhchap_auth_work. The latter work flushes or cancels the former
> work. However, the both works are queued to the same workqueue nvme-wq.
> It results in the lockdep WARNING as follows:
> 
>  WARNING: possible recursive locking detected
>  6.2.0-rc4+ #1 Not tainted
>  --------------------------------------------
>  kworker/u16:7/69 is trying to acquire lock:
>  ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: start_flush_work+0x2c5/0x380
> 
>  but task is already holding lock:
>  ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410
> 
> To avoid the WARNING, introduce a new workqueue nvme-auth-wq dedicated
> to chap->auth_work.
> 
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Link: https://lore.kernel.org/linux-nvme/20230130110802.paafkiipmitwtnwr@carbon.lan/
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks! This patches fixes the lockdep warning.

Tested-by: Daniel Wagner <dwagner@suse.de>

