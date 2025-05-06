Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D0C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7j4RlZ7YeNUapKgf+Chlob+RLOvYJtidQUMzo9Wj5is=; b=Ad3+tU3wE4yayNtHsdPdmFAnHY
	yjQzYnSTuqtTbNn8Svome2WgSLLRbXVg8ZvlT++hK6p7AAWaLx7R+K5cTN0iNPYAbCjGo2t5qy0eU
	QRwDP7w+nR5EGwnDSipn32Uzes1fj5LVcsrLKB3Sbb5itxKgnTCVMxO4sDL1UyH8RYsHPIt2BVXeF
	LZ+m70Mcujtnh93TSeDr7uR26LQzeCX1PHQqQCJ3ycISGcsqPnXc5RTkJ+32gLCaJmu3Q59xSKn5J
	1nmcXFrYdeUwQKdWN6rY7w5LGIN9A9P3dsxZSKeyGtdu/3XEoDlibaWAQHB+ToOsm50IpvZnWDszb
	nmq0T19A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMRL-0000000Cu17-3w0g;
	Tue, 06 May 2025 17:50:47 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIyz-0000000CGDK-31z7;
	Tue, 06 May 2025 14:09:17 +0000
Date: Tue, 6 May 2025 07:09:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBoYDS84d8N5STLq@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
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

On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
> are very welcome. (But you do have to sign the Oracle Contributor's
> Agreement, unfortunately, to get the patches into ktls-utils).

I guess we should just for it, which would also take care of the
musl support?


