Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF77D2F7FA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jM8w1pd0F5JUbQsnrGNUz0JaND
	RTtUt00GTCUSu5ct/H42X9oBod3hS8Hwb5hbs+DMxES2k/lTlwvFxA+L7+hMN021eiffBNhB8hkao
	oU4JnHaH2aVskgUdZlHAP3Td+W86V7bURqjDw0e/+AxUvRTMK2ISOS0qENV9Qdk/EEwmyIUu4qlCt
	gAda/xLkO4cSasxb928NdT1c5EDIuZUOz3+cMjSlT2xkcnaTnTVGZe7DbzBcrbSRajV1BVxKDbP8b
	7mYrqlAvaUI8W2yQ9W4xZeWKTI1SLXZr8Pm6SeVxK+j849zc8Awg5WVebytx9scB1oN8M7WTHhj18
	pcxE3MTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LRD-0000000E4A7-2tpo;
	Thu, 17 Oct 2024 08:00:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LPF-0000000E3iD-2cBK
	for linux-nvme@bombadil.infradead.org;
	Thu, 17 Oct 2024 07:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iNtqKYOCKplLbY4MLRORQAhKO5
	4/Pbb5d0hyMG//oCrbbAHJKk9cav6RPKG1DXO1c3JdafB/MiweH5UDTgrIi/5ZsL0ew7FUoGl7Psy
	XtTFi9JQPZr62NqcAOuBrYA0WL28BQ9umxotGhDQg+BZKW5t0E82L+g1YfuQ614r3j8SuLkjXa/qg
	Pr1DqVhNbiooE9AG1Z8ZFcR6ueV/cVw3YA2bMtBaOwyQDBDEjZY+la3mi7XxVeSSxqBDVdLxdMrns
	rgKAk9SQtMwCaymqmbVeo/IntXCdZpIMiBnBqWkhOveBKLw/H/lWSUzffJUjgxffyucDbIRQb64kK
	4ZfD+C1Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LPB-0000000754Z-1Jkc
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 07:58:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07EC1227A87; Thu, 17 Oct 2024 09:58:42 +0200 (CEST)
Date: Thu, 17 Oct 2024 09:58:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 05/11] fs: introduce IOCB_HAS_METADATA for metadata
Message-ID: <20241017075841.GC25343@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113743epcas5p3b4092c938d8795cea666ab4e6baf4aa9@epcas5p3.samsung.com> <20241016112912.63542-6-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-6-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_085845_889867_98D9DADA 
X-CRM114-Status: UNSURE (   8.17  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


