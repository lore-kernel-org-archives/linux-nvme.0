Return-Path: <SRS0=LUlw=ZJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2AC432C3
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Nov 2019 16:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EC920715
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Nov 2019 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oGmCVH0i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLsKdkNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EC920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VBvZUqGXQ62DGgngu467vBzn1u6p6/CivZqMzI9PEhc=; b=oGmCVH0iaFZ2yw
	sQgbxGVkyZHhN2jQ+g2cl0J0i9zz5PYigjkYCBr47q+EQY4BL4cok6xEh3ctdBcJcZCBiWVQeLZJr
	ExMLsmdT2QIz/4P6JxKSrZmkVQG3HrrBAQMrIdQRVt7eAl9XKl+/ZnlMoX5ZCZgnDX23M9ccEvadN
	trH3K40EkUsNyNTFjcHwV+ovbnT+21/2wgimKorE5QQrlbxa69qhPzrFB+cGEhq3jdwdGRHwHEIRn
	/Z5Wf4V616dSNRVF/6lKkLbO+N+Ck3f4uMW2zL5uud9bVbHySDUWY8POQoKLn6ud3KeEGAbNffXCw
	MVJTlFaddMjzrfE7Rpdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWNIE-00071a-Ly; Sun, 17 Nov 2019 16:20:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWNIB-00070y-QY
 for linux-nvme@lists.infradead.org; Sun, 17 Nov 2019 16:20:53 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A651620700;
 Sun, 17 Nov 2019 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574007650;
 bh=Yufnt2ARnU8qngrikuB/q9ldKmwkDzb11j4c6BI8Hlw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wLsKdkNgdlj21oHTi97rJ6B2jguCyQQQzndLRoUElBMqZG/RqomqzfkNVVqPvW23r
 85hYEIvaZDLW8TcOtZyIrf7D1lDh5zluC+ehNuVuyAhrFvUjIFbQUJwJkKmM97qtKv
 egRZGS0GK9Qz++E97UlOGEsP5UGEiojFT5tTqTro=
Date: Sun, 17 Nov 2019 09:20:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: add another maintainer
Message-ID: <20191117162047.GA15623@keith-busch>
References: <20191116175038.6105-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191116175038.6105-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191117_082051_885258_92E006AD 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Nov 16, 2019 at 06:50:38PM +0100, Christoph Hellwig wrote:
> Sagi and I have been pretty busy lately, and Chaitanya has been
> helping a lot with target work and agreed to share the load.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55199ef7fa74..1e9439377485 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11633,6 +11633,7 @@ F:	drivers/nvme/target/fcloop.c
>  NVM EXPRESS TARGET DRIVER
>  M:	Christoph Hellwig <hch@lst.de>
>  M:	Sagi Grimberg <sagi@grimberg.me>
> +M:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com
>  L:	linux-nvme@lists.infradead.org
>  T:	git://git.infradead.org/nvme.git
>  W:	http://git.infradead.org/nvme.git

Thank you, Chaitanya! Patch applied to nvme-5.5.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
