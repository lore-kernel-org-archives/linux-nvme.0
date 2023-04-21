Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20567C77B71
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/1bU+3yxMOBZJYn8hiebgLUc19mnJbyR5cgTJ3rOoE=; b=DGRQQlBouogfNB+TU+WaQE0ypv
	tMprxjHHmUHnhK/PcltPXpCVi2bLgfoZZaCnCTCCqqcWg9d98fCS7LRYrXThL94dqfBS/gSnd4IS3
	s3U4NAdJOBEmQbrS11NQZalgBdLFvS6YKPfHdekTvqhl7to7FdDBM4VlrEV+wEjBTGNVCP8srYYdU
	H5yBpf20WUlU84olewr/MBNNj9pggqkC/e5cOf7xsVOcl4SpMBPi8CGFXGmIa6oRihn5/4TkJKv+A
	iJPe2IAfUl/lTPYVFlQp46yESXsq9Qx1bMAvMJc4GQqqxFYnj/PxRKeMcyxMCOSCD6ZYxkNFwPj55
	opMtbrXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppsQF-00BFJY-0m;
	Fri, 21 Apr 2023 15:11:39 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppsQC-00BFJ6-10
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 15:11:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f178da219bso18928105e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 08:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089894; x=1684681894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/1bU+3yxMOBZJYn8hiebgLUc19mnJbyR5cgTJ3rOoE=;
        b=hhG+TO9WxHxANJSrDJQXKbAfVxr5nASIl4VJafCtX+r+xFfke6XZJxRmU0CznQT2M1
         N8zPOoSlq+zj2D7fGkVuKlsb4/0KcCTig+kaJJbHlcZvwtvR/GqWe8cRfCPQB/8mp0OS
         WcZcLY5Mgzt3MfKDESYzXCT0oW091QzxKmPb62SFK8+z0aHy8DhtcnFnmN9ksnS1OlJw
         c0phk8KXRGFJ3WYMl8P6q1DAN4W3WRqyrLZACO21NDLUzmMaceTukxy4KMq3aKRWpdn5
         VJjMKOZhrveemG4tkz556dNhy8hQMwp7PoV9VAlDzRpsxtmoXc4wTIhuGdt6zfTYe0MX
         BY4g==
X-Gm-Message-State: AAQBX9f/r8IJpNOb5HG4p48TyAvnnzcDmG7jRfeNep76f62e5FsB3Fd3
	cEOwqKZkt+U0yR38MDESOIc=
X-Google-Smtp-Source: AKy350YDSzZrIvT5JL0AAWk8219k6NeLFDVD+qfQEpr4w7Xa0eQOblolNTj8eRXWplZdeZgdYRBmEg==
X-Received: by 2002:a1c:c906:0:b0:3f1:6ec5:3105 with SMTP id f6-20020a1cc906000000b003f16ec53105mr2233609wmb.20.1682089893877;
        Fri, 21 Apr 2023 08:11:33 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm4990006wml.48.2023.04.21.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:11:33 -0700 (PDT)
Date: Fri, 21 Apr 2023 08:11:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <ZEKno++WWPauufw0@gmail.com>
References: <20230419102930.2979231-1-leitao@debian.org>
 <20230419102930.2979231-2-leitao@debian.org>
 <20230420045712.GA4239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420045712.GA4239@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_081136_361961_8845F601 
X-CRM114-Status: GOOD (  11.81  )
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

On Thu, Apr 20, 2023 at 06:57:12AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 19, 2023 at 03:29:29AM -0700, Breno Leitao wrote:
> >  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> > -	const struct nvme_uring_cmd *cmd = ioucmd->cmd;
> > +	const struct nvme_uring_cmd *cmd = (struct nvme_uring_cmd *)ioucmd->sqe->cmd;
> 
> Please don't add the pointless cast.  And in general avoid the overly
> long lines.

If I don't add this cast, the compiler complains with the follow error:

	drivers/nvme/host/ioctl.c: In function ‘nvme_uring_cmd_io’:
	drivers/nvme/host/ioctl.c:555:37: error: initialization of ‘const struct nvme_uring_cmd *’ from incompatible pointer type ‘const __u8 *’ {aka ‘const unsigned char *’} [-Werror=incompatible-pointer-types]
	  const struct nvme_uring_cmd *cmd = ioucmd->sqe->cmd;

