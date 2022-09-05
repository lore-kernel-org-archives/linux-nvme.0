Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAB0ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVhJ4znc1KcVyBUOwfngnnreag8kwGtYyldUdMkc+hQ=; b=mXSpD++sy4k/pXMHlYpPzxhbxk
	ByiGKDInL3cxpG7S2w+lVAotbjUeMKZzK10Wa5U6t34lPEdhx7D0L9sCMpu0BAxbUdPjRxFlb2OTF
	aJv0ux7YkwnwsVTFq/aE2AIpEWMZ71oTt2pPh4fTiX2tfcs+XIvS7JHS3TMjCoDn7jSqyEs9VINxy
	ZgDbnaQxMxNRSXua6hstbz7x7H6lTnE5uDqahwPD8uA/U9h/kuDdHwLpbPG1A1aPJbHTbpjE8iayu
	JYiyO6Fs27OyzwoAdTPXwjs28Y8G7LlwbNbi22HAjGnYc91Md26S6kN862KqlG0bWzEIT+7s7G33U
	WfwNFIcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDzd-005uoA-Ft; Mon, 05 Sep 2022 15:26:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVApy-001lXO-Q8
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 12:04:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A7465D021;
	Mon,  5 Sep 2022 12:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662379461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVhJ4znc1KcVyBUOwfngnnreag8kwGtYyldUdMkc+hQ=;
	b=UE9hN+f0fIkZMkiJynCrvHXp551Dj/lvQrmDYLgSMgR3wmarWf16QsQr4QB8JIw+XzCQPj
	od4MhgTHIgdv+wUFoIRjxBMrVk5hrPaDbMqkNVLFG5WWDk7Bu1CKnsCqrm5JC05W20oawM
	oSVcE+RajckwnJK0ZKWqjebQ3zVlnjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662379461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVhJ4znc1KcVyBUOwfngnnreag8kwGtYyldUdMkc+hQ=;
	b=unGhiEPSJ2Rfx3q0I7hSHxqPRxLUYcvEyTs04xg3u55YbBV9l+niIL192HfjQdlfuWpVxN
	SdRIgwthnthrXIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C41413A66;
	Mon,  5 Sep 2022 12:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1Hk5HsXlFWNXdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 05 Sep 2022 12:04:21 +0000
Date: Mon, 5 Sep 2022 14:04:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix UAF when detecting digest errors
Message-ID: <20220905120421.kxqtjtxcdpadi4na@carbon.lan>
References: <20220905105417.1241304-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905105417.1241304-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_050423_666391_EDDD7838 
X-CRM114-Status: GOOD (  13.18  )
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

On Mon, Sep 05, 2022 at 01:54:17PM +0300, Sagi Grimberg wrote:
> We should also bail from the io_work loop when we
> set rd_enabled to true, so we don't attempt to read
> data from the socket when the tcp stream is already
> out-of-sync or corrupted.
> 
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Makes sense independent of my bug report. I let you know what the
outcome of our customers testing is.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

