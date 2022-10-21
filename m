Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C88C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRkWhYpPUVo58MdzZWveO+NT7EXGP4y1ZpkGikJHQKE=; b=4gxXilWvej3H+i6Vh19PjY5rBv
	reXCEbhfsC5X7Z13FnM2wVx5yp0bE6QyJR0vI6BfDMSYigJ8rE5UehzSDD6tCdYPldYI8gV1LNTHu
	A/P9FpMWmUcBCKZbv3VWiMFxTVMu72LDhjrOTS6VHgmWGug8D7UrImVil9r6zR5AVcCTSVqVaoAVC
	st4RjxlTiHGWGMuiALUY/X8jKjkk4b6O7Z9b5xs/0MKGdEnukbUcn9QcctcD0MLTnnab6wp7oo00Z
	FHeKIq/5Kvq3GfOTm9wUvEG/v49u1iaHQ4xCyXexZz+x6/RLSVGR7mVBAH376WKX0TA3UDrAxPBmh
	RrkQj3+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olozv-0071Ph-3D; Fri, 21 Oct 2022 10:11:27 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olozp-0071NP-FE
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 10:11:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 552011F8C1;
	Fri, 21 Oct 2022 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRkWhYpPUVo58MdzZWveO+NT7EXGP4y1ZpkGikJHQKE=;
	b=eUvVTqQpGFArFRGwV/F9j3f9yKthowFMRA1RfQahgAbLptkQn4diAWSUi3tXA2zrJPjRC3
	LARiTyH80rpgZaHMCT9z5dl9RcWBmbKKaEQK5PD1k9ldQeEPq/YY33zKmadZZtjgvEpK4z
	7jDD8SUVTwkcViJPcwz6T0DzTaXOkeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666347075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRkWhYpPUVo58MdzZWveO+NT7EXGP4y1ZpkGikJHQKE=;
	b=SUq1kYiyEkKG29qL68jBSHN5kMJ2pOpSggzSVMVwK1gkYuwK4dKPZavnbNq7rfmcumts8e
	8zf6IrCNUkigkLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A97B13A0E;
	Fri, 21 Oct 2022 10:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pwFGDkNwUmN4EgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Oct 2022 10:11:15 +0000
Date: Fri, 21 Oct 2022 12:11:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221021101114.pq2mp4q4qtbpeoqa@carbon.lan>
References: <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
 <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
 <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
 <930775bf-4e8f-5580-8216-d2f28e369cb3@grimberg.me>
 <20221020141658.x63rk7ymtduw2q7o@carbon.lan>
 <370e8446-14d6-b916-6383-785b34c378bc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370e8446-14d6-b916-6383-785b34c378bc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_031121_692490_8BBE38F6 
X-CRM114-Status: GOOD (  16.10  )
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

On Thu, Oct 20, 2022 at 07:20:13PM +0300, Sagi Grimberg wrote:
> 
> > > Just for the experiment, can you try with this change:
> > 
> > Good call, this seems to do the trick. The splat is gone with it.
> 
> OK, it doesn't say much because it is just one of many conditions
> that can make a socket release to allocate an skb and send a tcp
> RST, which can happen under memory pressure.
> 
> It's also not a great option to set a minimum linger of 1, which means
> that if the controller is not accessible, we can block for 1 second
> per queue, which is awful.
> 
> Does this change also make the issue go away?

Yes, with this patch alone the lockdep splat is gone.

