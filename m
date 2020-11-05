Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E70C4741F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 16:13:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB61206B7
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 16:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n7o9kwaU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkd3H2KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB61206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KhZKfg8YSoo+cSgQuXE8tl7g39tEJ+qFoLzPl3C6A4I=; b=n7o9kwaU73P7VmgxDSAaKKnVG
	4iGSnJf4m8pfTd1j4vYgFmIJaXNgxT+Mh3XMycggrqi7cnPqgTdhAPN2MIkmpvu4XSx5XdlJm6b6P
	+rXaT1Ymi7+vQJVqmdZWj2N6AQjkhVPNzRk1S40b/QD2LUvTBTV8R2BcObpfmU57zHAwbBsOTfxaU
	U8p05tKfDhRxJoWh7sRZWPteCaXLwGkUynesZm5IFRB4niyB1LGLfPfDY/pfBKemI91Qs7YPcKvSU
	0YLrolHiVJSO0fvVJRggDGr6hQsQoo63RWroMqr6ApaxEDIY+tEmusFy7XsTbcqArgTLJrV9+Ui9v
	Nf9IOCKhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kahsx-0003D6-8D; Thu, 05 Nov 2020 16:13:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kahsu-0003C5-Py
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 16:13:13 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 515C3206B7;
 Thu,  5 Nov 2020 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604592790;
 bh=NYtIMNiuNVe+wQezBRsSPlIMoNLKQBXjqAxiQrH1mlE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hkd3H2KI5rQGNNl/WnERPYhb/hPYp+1o0aJdIFQMcgt6g4Lmiu8w09zsXMjQsJKB7
 GhUNE8EqEBFPYF3+QVMbv87x2EmKk9dbiJX9T13zE6av8tQDjkrdPH4igeWV3xDUVI
 rAJGvah9CvtyyQKi6v1M/2dZcT45XSjE5VCQnh9g=
Date: Thu, 5 Nov 2020 08:13:07 -0800
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: free sq/cq dbbuf pointers when dbbuf set fails
Message-ID: <20201105161307.GA2210800@dhcp-10-100-145-180.wdc.com>
References: <20201105142847.3500-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105142847.3500-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_111312_942960_44FBC65A 
X-CRM114-Status: GOOD (  12.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 05, 2020 at 11:28:47PM +0900, Minwoo Im wrote:
> If Doorbell Buffer Config command fails even 'dev->dbbuf_dbs != NULL'
> which means OACS indicates that NVME_CTRL_OACS_DBBUF_SUPP is set,
> nvme_dbbuf_update_and_check_event() will check event even it's not been
> successfully set.
> 
> This patch fixes mismatch among dbbuf for sq/cqs in case that dbbuf
> command fails.

This fixes if host dbbuf was successfully configured at one point, but
fails on a subsequent reset, correct? Otherwise, I don't see how the
queue's dbbuf values would have been set to non-NULL.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
