Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B06C001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWySdREPI5hHmHNzsFw3MuXRmrs7v8ANmnLx+oatmfQ=; b=Vtn9jUMjwurwjYHRvDry1iwk9V
	O3fU5wskZS378Ca+rBahnc0YVb1Mx9apmNQL6eMgYM6RxArtUhQ0OtB1GeoXUTeUh7hvg4xG2pHtG
	AiG1FVTYg9xHDILKv8RrHXRGEVaUdI5l4uSzx6X+iev8vNL/eJ+N07CcFhO0jJya4rqwvco9JCXtz
	7RQDFjLhTYC/X3F7gFGLCay+xqxn1vWxh7aPERhQJDZCJ4bcDCiNrSA9nHM3VSQFaUhqTlmSwyg4L
	v7oE6VfoJHp9G9N/ulV0GBOt/TrRWZXth6KpBo7yhTduMqvytxQ02gKFw6MtRRrH6HYAXHpecn5Mg
	dLCQ9aZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIiZ-0026mT-0m;
	Tue, 08 Aug 2023 09:09:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIiX-0026m5-0q
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 09:09:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B75AD21B1D;
	Tue,  8 Aug 2023 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691485767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWySdREPI5hHmHNzsFw3MuXRmrs7v8ANmnLx+oatmfQ=;
	b=zc83YCep0zi5/UZgrI7JZrCkXhjnJplzmjgMZUbbyF+0iK4Q81RRyCUIlvy3RjuHN4YxZE
	Lb8+CQWqbAJ3T3rEIlpl1DiICzG6tR3GG3fTwMXyns50bsSaw6PQ63OPjhejxGDMUeR810
	5Oeaur7O5BAYisP3FEwgcypj0CHPDys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691485767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWySdREPI5hHmHNzsFw3MuXRmrs7v8ANmnLx+oatmfQ=;
	b=JJCqGQ2R7fLgP93TPNpnGAFSXzkFPOeTsvsapWVKcpSCzjdvTQUl/S4joX2lvsQuCOEsrC
	V3bEF8kghZe5MtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9AA313451;
	Tue,  8 Aug 2023 09:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UKhmKUcG0mQvEAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:09:27 +0000
Date: Tue, 8 Aug 2023 11:09:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if
 not supported
Message-ID: <u7asjmkjqxs6edpj2eg6zw6tuo6zypoyzpjcjyj722f2ol6r4h@6m6npperooul>
References: <20230808070907.18834-1-dwagner@suse.de>
 <20230808070907.18834-3-dwagner@suse.de>
 <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_020929_466180_0A955C76 
X-CRM114-Status: GOOD (  11.96  )
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

On Tue, Aug 08, 2023 at 11:47:14AM +0300, Sagi Grimberg wrote:
> I think you want to check this before the initial call
> and avoid the retry altogether.
> --
> -       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
> +       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
> +           nvmf_check_option(h->r, disable_sqflow))
>                 c->cfg.disable_sqflow = true;
> +       else
> +               c->cfg.disable_sqflow = false;
> 
>         if (e->trtype == NVMF_TRTYPE_TCP &&
>             (e->treq & NVMF_TREQ_REQUIRED ||

Yep, makes sense.

