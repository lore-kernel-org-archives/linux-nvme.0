Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FEFC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lhcJcU9VifPT37uEkW5319Vlk1wbJ3luglscDxRzIY=; b=rqu82kW/UF6bE9AsjrkYS/iLa9
	PFKKzUSZIiIzpQ53zqY0mCW7t00jyq9Af/FUID+B1wgbN8Ugsa2TXtU/vD8bEUT4Nh9AZ7P5ZIVRX
	BkKlHY2fMabCiqKSWfY8Iw0Z9acrp/i6hafAZ403jiOXrAaOsBI0uDm7jII8I9GgnIDTyvMH+wFJl
	dHIsduTB50XFYe/efL6gQhE+zga23EKc9wpRNpPfyzhihaBlElJ/r+xyQUsxP5c8r1Tv/gVqf2dQ+
	qEIdaoj8i9KDkbjI5Kv81Fgz9y9NsaLXZ6AsrJ1P29erd82eS9VnbJs4jH7TMlXoimriW7yK01m4K
	Uq64hoYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchQd-00000004ROL-3BxK;
	Tue, 28 Jan 2025 08:58:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchQc-00000004RNy-0RX1
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:58:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0872E68C4E; Tue, 28 Jan 2025 09:58:34 +0100 (CET)
Date: Tue, 28 Jan 2025 09:58:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 04/10] nvme: add nvme_auth_derive_tls_psk()
Message-ID: <20250128085833.GC25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-5-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_005838_288723_8D9DC5B3 
X-CRM114-Status: GOOD (  12.88  )
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

> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;

Where does the magic 5 come from?

>
> +	info = kzalloc(info_len, GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto out_free_prk;
> +	}
> +
> +	put_unaligned_be16(psk_len, info);
> +	memcpy(info + 2, psk_prefix, strlen(psk_prefix));
> +	sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);

And this feels like we'd want a basic struct for this, even if it
just is the len field and a flexible array.  Which will also help the
compiler to to do bounds checking using __counted_by.


