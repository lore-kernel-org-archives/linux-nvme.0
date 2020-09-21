Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9362C43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:01:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F14320758
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEni+aCx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GFEHtErB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14320758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQ8rX/BoGzSaOrw/Pz8r+iPSbZH7XfRcjd1AlHME/0o=; b=hEni+aCxEHRNz8JZ2lsoyjuN4
	5foWnCwZvz24irs0dbAZakzDz58LO4bBIE6C3jpAzQVGgwx8IPEHzF8ccVu2e6VVt6XbwpJ4XJP5h
	6qjdZyLnJTXo3yEvgozYnHZYC6L9SUvue5Ud70Df96DiNPZXRWBqfijxBbLR/knXxvxci2ux6sDQb
	1DelSqPU/HK1DdY9RJPWtNLmGZYnie1IuYHZS52oR/Yuy2CX5rTO6azxjHn8ScTfSLuKPMv0utqD7
	01LGad3lk7ROIzN1OixaxCPe0fLZFdYC7xq5kUNJTgM4aew1joe7FCgjgi9NMJU2koGyq7hp8rpgE
	h42F5L6sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKNJz-0003Xz-Mj; Mon, 21 Sep 2020 15:01:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKNJp-0003Xj-Kh
 for linux-nvme@merlin.infradead.org; Mon, 21 Sep 2020 15:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ttM3K97Opw3P5YgnRz7EfFbdq/l/YhzWIc24UC0lj3I=; b=GFEHtErBbjN5fc/AWN9DYBES+q
 J+jIcd5Qbf34+nkkGZpxCwwZTa5SPVUBdtkokNXI9Sn8QMiAQp1YYkH6t4h9DAduh5vL2zxRginc4
 LaPMNv70iu0coioa7G+hF5Vu54TGtDnjTZ2KwcwOCrCRk1SgvcuL0Bbr+K5blgRuSnTzC/Dv7IjVz
 SSkzb6v60y0xfdk63qbWCGgKAElNNhGthqpFCkD9HII7s5d81X5xcnVMQIRWw8fVakNdr74BKlHQa
 D50jIugkfS3ehUQCqZrtJwpzFj/3BKFStMVORVePtiNKsU7UlMacMB/GtqIOqo/ToQRkvvzxgD0lj
 r/dW+pcQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kKN4k-0001D2-F6; Mon, 21 Sep 2020 14:45:54 +0000
Date: Mon, 21 Sep 2020 15:45:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: fail new connections to a deleted host or
 remote port
Message-ID: <20200921144554.GA4616@infradead.org>
References: <20200917203322.57405-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917203322.57405-1-james.smart@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
