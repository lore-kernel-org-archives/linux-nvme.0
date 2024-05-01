Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271EAC4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFU1Vghd+kcJ76QbCL6rW7E5UpbqtoJIArKrgFkDS/c=; b=unHX2j8fsDSxCsO7D2Gml3Fzx7
	rJBrAbdaorkBw3eJQSie0Bdk8VYnx7FnHDI8MrZs9HatP+TdiSNjLGC/xip6G2ufle5iQEejt2nlW
	Uib0ky3a10S4BMAX7hiUbOg8w75amUvhUAUJINCzt0gsP+YQhnokO6b8JsyM/ztBTQm+Cq5JdNCZP
	en8AkFmuSrutmujNFAHAls8d2c+8SDbKolPlGPy30qvYxByCgzuIsGQCQFuZg9owG75xmLvTm33Dx
	dU5GEfm1ll28MzSqZMtiRgKmW2qKypAt4fQPdbegkueWiyU7MYMwuAFLcLapnQfzCXD7nG/DH/jBP
	Jvk2CWNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24i8-00000008mr9-3EWv;
	Wed, 01 May 2024 07:49:04 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24i7-00000008mql-2JB9;
	Wed, 01 May 2024 07:49:03 +0000
Date: Wed, 1 May 2024 00:49:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: change rq_integrity_vec to respect the iterator
Message-ID: <ZjHz705yGUZhIaLv@infradead.org>
References: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
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

Please work with Anuj and Kanchan on a single coherent set of patches
to make integrity splitting work properly.  It would probably also
help if you posted your code using this somewhere.


