Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF8CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxxqRXWI+1B6ULorxM4PywC1UFSbhMu+6yOrWSWfxj0=; b=UpQcypczsaO22EnZw1GA685ilC
	XhBek11jVRpY6s8H5b9P/mNDJq2EaYMltFnD+EkrsmOIaM/L06qiMlX5apacMojkiBeF36pFXOqa8
	vrBGOcMCuy+fGz0ceIawYzpo/Y3DL6eepJl7t3l5fMaBn6Y8Sf20sYlMmGA1kEP3C4WDitfwg6/g8
	kfa1j+RcCBIOB8BuWdrUqgAeh1Z+hd6hZHTZWslufH3itCjYeZJEswCqOJLlUTv7yhM3d2evL79Rj
	ow8TkYWUTTPUVugNfjyHaS9pCnHtgWQZobafSoFIq6HkXTSLtqGgy3l3p8f3h8sATnlB/gx8kjzpQ
	xcZSmInA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdGa-00BMjq-0C;
	Tue, 17 Oct 2023 06:09:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdGX-00BMiL-2O
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 06:09:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74C5868BFE; Tue, 17 Oct 2023 08:09:08 +0200 (CEST)
Date: Tue, 17 Oct 2023 08:09:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de, Akash Appaiah <Akash.Appaiah@dell.com>
Subject: Re: [PATCH v3 1/3] nvme-auth: alloc nvme_dhchap_key as single
 buffer
Message-ID: <20231017060908.GA8454@lst.de>
References: <20231016225857.3085234-1-shiftee@posteo.net> <20231016225857.3085234-2-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016225857.3085234-2-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_230917_946472_DF91BD6B 
X-CRM114-Status: UNSURE (   8.55  )
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

> +struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
> +{
> +	struct nvme_dhchap_key *key = kzalloc(len + sizeof(*key), GFP_KERNEL);

This should use the struct_size() helper:

	key = kzalloc(struct_size(key, key, len), GFP_KERNEL);

Otherwise the change looks good.

