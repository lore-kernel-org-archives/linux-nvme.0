Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90684C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OERjrkV5h41xYrEn4LNfKcoyo3YpYUbXf6THMe6hnbw=; b=CA/LSExUCa0t74HUqt3tQzwizJ
	n6pmOUrYVli7csa8siO7WncFeWw1+emkRRnHlsqcuD9/gMlhUTGE+NO85xXmxpSI+3H8Xweyw6bcS
	nAAtWFlp2dZZNw9CpQlgdi4ktbzGgW/0143KBUfxmFutVAB6lojLqFLsqImPRDBnzXK8aE4/cKd/t
	Y5i9fRg7K6PuW9tJNV8SiSNpdroDaGUZbHl2c3ci5joHDgO0iNYv/tA8r75GO3pApiW+fj4InFedC
	tLkWhEK+I6kY+YzufmFt0K/nEKwRpiD15zFAO95kUSYOJ3ah7OzGVJAGKl9O7ntoNYIaVdPyaz/6W
	exMqWtag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSJa-003PAE-0L;
	Mon, 30 Oct 2023 13:28:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSJX-003P9f-1Y
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 13:28:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D70A26732A; Mon, 30 Oct 2023 14:28:16 +0100 (CET)
Date: Mon, 30 Oct 2023 14:28:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: use crypto_shash_tfm_digest()
Message-ID: <20231030132816.GC21741@lst.de>
References: <20231029050040.154563-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029050040.154563-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_062819_662114_54A9088B 
X-CRM114-Status: GOOD (  13.03  )
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

On Sat, Oct 28, 2023 at 10:00:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Simplify nvme_auth_augmented_challenge() by using
> crypto_shash_tfm_digest() instead of an alloc+init+update+final
> sequence.  This should also improve performance.

Nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>

