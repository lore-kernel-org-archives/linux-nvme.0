Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:04:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935E265101
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935E265101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rxW8oc6RBpUO6lpG70oHkIJC92L++lK3qEGfzoJClc=; b=TtWtHbJhZPZI3qwGF3xHfxwKC
	Ma3boQOc0a8e1HBaIqr7IgafcqAyRi7XD3V5Jcox32xZ0CXuIk9kt8rDFa4qCkmr1mQIO9jcAFZMF
	MIyGocguNhLsdAYmPaqoAtQxieOwrm/bA13O0Q4tZOv00fj2SYaJ38paHKA4PCbdcnPr34VBDi2X1
	jO5wvULeqzEDJivqoJ+Pcojre7GaUdvXir7avWX3zxf7mVbPe0ybZSFRk3eTcCnOH1NS8gGIM9gUq
	gHHz37aPqJ4PnLdaJOh9v39Z03eM2YPXDgM9LAdgUwnHpj2C5IjmJigAmsz4VVNVkoz8S2JgJr4gg
	AnwemJkxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZDt-004AZW-O5; Tue, 09 Mar 2021 10:04:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZDr-004AZ7-9w
 for linux-nvme@desiato.infradead.org; Tue, 09 Mar 2021 10:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mj8eBj+VT4BL6egNSJRqQr4Kz1rqAxuIWsFt0M1Ifrk=; b=B5kzfAztvwnbNwxH63mkIYk2+H
 3xrS0O/ElWDTvbu+cqV3g1Fv3N6coU9FiFuWb0diwUKpnCdHIqtobIvj95onVySHWzg/YYkd15cJJ
 O1EyiLJdQWMVJb1icTMDPSGQBxahOF1AtNdMIjE0DttQvX27xfhFIEqDg1Pa/34RklctufOe4LRjt
 rTDPALIFus7K3nl2FH3/GFR1WK4IdX3xXLWWcm5WKKgVkrBFiXGArHX5h0CuEWXlonkhkBlPkjm2i
 ZnLgTAs54f1wp56wwwZykBCvXgKD91FmhJLVQlRsfHXDiwwkwAkp8k/YwY15S5j2VMPQnWC5fIm/M
 vJbeYWdA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lJZDf-000QGN-C5; Tue, 09 Mar 2021 10:04:06 +0000
Date: Tue, 9 Mar 2021 10:04:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, emilne@redhat.com,
 stable@vger.kernel.org, Nigel Kirkland <nkirkland2304@gmail.com>
Subject: Re: [PATCH v2] nvme-fc: fix racing controller reset and create
 association
Message-ID: <20210309100403.GA100868@infradead.org>
References: <20210309005126.58460-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309005126.58460-1-jsmart2021@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.12.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
