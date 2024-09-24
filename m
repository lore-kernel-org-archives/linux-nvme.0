Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8554CCF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2gka9nnOhXhAZ+fzJ6Db+Pqr34PyAvnaX+GZOTpIKE=; b=jCz6mYo82BMV5WDGUoVNHnBHhB
	Pj12iwol5EbYiB9AGTG2XvF/Q6E/0aEr9wy9byU1Y7nTLdoOyg6WGmG/vTUXuOsO6SXcScMEUMySV
	nJt/Sf83DDL/cG8C9Nyge4ZodAUH6YW11iuwDzHHdxv35kfJCe0pLY836F3kWm5DjWut5wdd9lO2F
	MPrU9NxuLmSoc8tmfkGRiZbZdDpaXPR1rTGcvKgQPTFTh4QF7i1OEjk2N7+CVkYCecYTKlQXlmpIn
	HoiBHzZW7w5W4xPRajAxizCA4lMJvdJfy1kw7XQeoDjNhoKoRi+04fK6pVxSLRR3F4lGXNLks25zC
	cul0dZHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st1U8-00000001j8s-3gy2;
	Tue, 24 Sep 2024 09:05:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1st1Tm-00000001j2J-2vrz;
	Tue, 24 Sep 2024 09:05:06 +0000
Date: Tue, 24 Sep 2024 02:05:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: null terminate nvme_tls_attrs
Message-ID: <ZvKAwtSt9YoyQNey@infradead.org>
References: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
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

On Tue, Sep 24, 2024 at 06:01:34PM +0900, Shin'ichiro Kawasaki wrote:
> Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> separate group") introduced the struct attribute array nvme_tls_attrs.
> However, the array was not null terminated and caused BUG KASAN global-
> out-of-bounds. To avoid the BUG, null terminate the array.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


