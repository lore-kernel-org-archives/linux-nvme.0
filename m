Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006ACEDF022
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 02:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sX1XW7tJ/z0Pr56vbIk8Z1EDnz+Qf9JZzo97tvG6WE=; b=a5Y3UDNC0tthkWT9PcM0Nj4c9d
	O24bUtpLFM8sUL5shcHj+nNitt5yqw/+Hx01qnZpY6YK9u+Qn+iwIMAGKaWSv5shxKacJDVNsiDp6
	j3O2/iLHXpGf4VUDT/tHEtDCkiPKI1FSjochqXF7dXaBx42DXPC2wYFDRUR80nHVDSeVHVmgXYeB4
	CH0EBYjOL4cUM1FZD2B7nxVFiM2ixsKmz7rgkPuuaVGR7QGhReOe/okB8XFKmqZaFar+n3QAx+R6z
	0cqz4/0rP15imvTMHUoxcMmjIMDTHr7OnYQIw+cI9/2+7bHx1DsEEY3VNpdiS9vt57LcTLk6z+nLV
	0xO99EEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMYI-00000001JmY-3IOR;
	Thu, 12 Feb 2026 02:35:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMYG-00000001Jm8-1CMR
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 02:35:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8030742A93;
	Thu, 12 Feb 2026 02:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E0C4CEF7;
	Thu, 12 Feb 2026 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770863728;
	bh=ko6yxxKaVAJWKBeEzC5KTCTdKrjG21ikZel0jHx8TV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4ANBJmqSHhZbZ74occSkl4vIi5yt9neUFgIcd+Fgs2kgYRW+TRcttUePyVGH4jcp
	 wqUaTGh+PdZ7SQu3oD+7XhksDsJXsbhGv2vhfbmK96fRkxNim74t57JksJaWpBMwe5
	 phZHe5+r4LCj0p8GeQkgLgs7doZSKYl2JRx2d+ln81e9tV4pnYYtUJNfmGERSG5aO2
	 e636+DuVJffrtPajX90VhjwlvW1IWTc8fwG40N4XU1CKwTeeUyOGATqUSTxVfE/+Ap
	 GLPDhjvgs2HPTf+x0ppiAygtjgL9i9qpmngcUAQqXP7pbp0LdAULpKDRa3yTYOLtsu
	 TPWwA9Wsd6t9A==
Date: Wed, 11 Feb 2026 19:35:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvme: fix memory leak in quirks_param_set()
Message-ID: <aY08bqdX9aoxtp5O@kbusch-mbp>
References: <20260211163028.76913-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211163028.76913-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_183532_347633_25985CD7 
X-CRM114-Status: GOOD (  11.20  )
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

On Wed, Feb 11, 2026 at 05:30:28PM +0100, Maurizio Lombardi wrote:
> When loading the nvme module, if the 'quirks' parameter is specified
> via both the kernel command line (e.g., nvme.quirks=...) and the
> modprobe command line (e.g., modprobe nvme quirks=...), the
> quirks_param_set() callback is invoked twice.
> 
> Currently, in the double-invocation scenario, the second call
> overwrites the nvme_pci_quirk_list pointer, causing the memory
> allocated in the first call to leak.
> 
> Fix this by freeing the existing list before assigning the new one.

Thanks applied to nvme-7.0.

