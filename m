Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E276C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:19:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9463364ECF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463364ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A3mwZ8wzI7pxVDY+mYVcqePKtoQgZK/f2/+leA9pb+g=; b=p3Ftx2fCb9/7SZRX2ErbJhj5M
	TZKStghrIK3JARms4fPAJP8tIG7lcvJ85vzAjaUYQ7lQPorpH4QgObtdO29HTFCn8WOrCyWz+I93j
	2f23GCbRRDEU8a0BHj6SxH8juZMWHQRJWP1qVnLK9fgAusIuzJ4CEBKn+CEDCjboBJWx/Sx7w5Ola
	FnXbHXrEwjuFbL2QBfk9M6fVXW2s4f0SP0wjVEXTiR5ojg+iWRHaYMKoRgHtKR50v7psxAx7BDeZo
	YR1G2S81BrDnspJ4pxAcByaWP/Y/XqapLeog9i5x4TNVtRL6uEQ5h7MyOuh2omR+Mv/UYjvy+1SG4
	ar1Xxs5tQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqKU-0001bB-5T; Wed, 24 Feb 2021 09:19:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqKT-0001ay-CJ
 for linux-nvme@merlin.infradead.org; Wed, 24 Feb 2021 09:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SkLPtHa+v4mfuxmmR3i6q2WWq0IwoOHrO5EYp5WwGQc=; b=a1LhwCmIveS0OBAfRew0dJEhDC
 T1HM4uYxq2JfWUFsUyPoJSmYqeawLknL2feNE9WUWYcETduvTx1DZs4er/XLibYOiH/J62AEjV9xw
 UPAheWoVe++mxix53lTehNZPXHG9CdVFo0yMLqXf50XL2dvVY8JaFuBp2JCp2kIfIE1EX+qmlt/3R
 UbRf+EAPTmMJ1iu0drBtqH5hok0hUJBQM1bxLnmv9zE3AhH4tInouuPBnsAfa1RTHw9WWmk66bYcJ
 f7jQf/NWYG2tOpxtVLPblWTll3RTutqzhkkD4h5qbOXi3kIOVzfJO6SWZfo6CQ0t41RnFfkCSOmZC
 ynsVGFjQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lEqKD-009DEe-7Y; Wed, 24 Feb 2021 09:19:20 +0000
Date: Wed, 24 Feb 2021 09:19:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zolt??n B??sz??rm??nyi <zboszor@pr.hu>
Subject: Re: [PATCH] nvme: Apply the same fix Kingston SKC2000 nVME SSD as
 A2000
Message-ID: <20210224091917.GA2194565@infradead.org>
References: <20210221051216.3398620-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210221051216.3398620-1-zboszor@pr.hu>
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
Cc: gregkh@linuxfoundation.org, Zolt??n B??sz??rm??nyi <zboszor@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.12 with a slight tweak to the commit message.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
