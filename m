Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC4ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 07:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukVRPzxF564A7MDYuDGy+jZnYYdHXZuwKBB+pwcFuDk=; b=OKZJaNvEvYohezcxLkBLu8iKUp
	1dkok3KLwoCjCqHCA1u6kSuNm9La7VLtYxLDuLtmXmxaO1uc6Ix5lkZfFJQc4tbSi/m/DAsuphFpC
	6AfzDv0Qfvi3QHXkGOEKIz+SSmsPjL9uf/xQ5dZV/Db8ZMBQ7AGqQwJWVTOOni/2bUWCzMoKPEgys
	gf8nNgYT5yCik69wI7ZLrNtQwkLFlj24m+hWjHUZ6PsLIHSNgcM5W3jIwv37gimqudp7w4ZO4tQ2f
	6fgE4ICip6BbQuZ/aIVvj+ojn9nQjFwmYz4dk5qSw9wd+Fs/5ELv5H/y2ChLiAlWWBQEmm//tcc2f
	PZ2zV4VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaBHT-009Hh9-SR; Mon, 19 Sep 2022 07:33:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaBHN-009HZp-A9
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 07:33:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76095220EA;
	Mon, 19 Sep 2022 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663572793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukVRPzxF564A7MDYuDGy+jZnYYdHXZuwKBB+pwcFuDk=;
	b=MvRcgcuGJRVyM7sYW/I7TbuyPlTKU7rxEcasYNPVKyzoGVQz552NQy+u2WsSyLY8a1Gdbi
	NhmtuiZqzvJBHddYcsyDnCflQ6aAR6E9HkCDxs07uEKg0eQJHrmL65U5aie6oWPQsdrBCW
	1s26eBfn8UB5zM549c3kZhrb8UAAy5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663572793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukVRPzxF564A7MDYuDGy+jZnYYdHXZuwKBB+pwcFuDk=;
	b=KaSSaO/2dwQ4ZzIsLorVDD6lIvZZ0iCYn5MyTqLIr449E9l+t7Tl96/UKETYNqtrX0BGJ8
	7K/jWYLK5DNcTIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66DF513ABD;
	Mon, 19 Sep 2022 07:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EDMJGTkbKGNSIgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 19 Sep 2022 07:33:13 +0000
Date: Mon, 19 Sep 2022 09:33:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix UAF when detecting digest errors
Message-ID: <20220919073312.2aoefykkekeuhiz6@carbon.lan>
References: <20220905105417.1241304-1-sagi@grimberg.me>
 <20220905120421.kxqtjtxcdpadi4na@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905120421.kxqtjtxcdpadi4na@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_003321_532382_840D7964 
X-CRM114-Status: GOOD (  18.09  )
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

Hi Sagi,

On Mon, Sep 05, 2022 at 02:04:21PM +0200, Daniel Wagner wrote:
> On Mon, Sep 05, 2022 at 01:54:17PM +0300, Sagi Grimberg wrote:
> > We should also bail from the io_work loop when we
> > set rd_enabled to true, so we don't attempt to read
> > data from the socket when the tcp stream is already
> > out-of-sync or corrupted.
> > 
> > Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> > Reported-by: Daniel Wagner <dwagner@suse.de>
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Makes sense independent of my bug report. I let you know what the
> outcome of our customers testing is.

Finally got feedback on this patch. It fixes the reported problem. The
host doesn't crash anymore:

  nvme nvme10: data digest error: recv 0x0 expected 0x7b844ccf
  nvme nvme10: data digest error: recv 0x0 expected 0x7b844ccf
  nvme nvme10: data digest error: recv 0x0 expected 0x7b844ccf
  nvme nvme10: data digest error: recv 0x0 expected 0xee74c89b
  nvme nvme10: data digest error: recv 0x0 expected 0xee74c89b
  nvme nvme10: data digest error: recv 0x0 expected 0x7b844ccf

Thanks!
Daniel

