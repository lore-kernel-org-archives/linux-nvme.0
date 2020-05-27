Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF83FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 03:27:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7757C2084C
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 03:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fT4ICkgZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJzHlshr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7757C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HTMevoHFbuW+VBeo4d3f9toeMDdbAU9EuY16OwbQp94=; b=fT4ICkgZJoDixl
	RGrITXbMdtnpt1D03e4hiYpzgF3SbyRLVguVnV+iwfjdz0BDawe2/6IwSmL+V96qqpIaoIx0VfZG4
	JoVK9GmDQs77fiE6upNVlnSuVrRf02rxjyhDRttPcmRp2VXPDEiQpCVUU30WE7EkCj06fkdrop9Zu
	5Rf4EFmp/g6kUlrF+a+YgV1Pn+8X5w7GOXCoUMk6GVQBr6Bnw6sf0DEvKaOn+ZBUJL8UgrwsWW8wF
	R0w/yibohY8YfW/hjhaSXBSbhvrjKaQkgASszfw+/EAN/KMRkjcMFElXBp0xf8hKe4Y7ICLvyjv8H
	rgugu9cHvlSgHr9Cb/tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdmim-0000hm-7U; Wed, 27 May 2020 03:27:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdmij-0000h9-EO
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 03:27:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F3A0B207D8;
 Wed, 27 May 2020 03:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590550029;
 bh=f0tQJ3C9w8njZRPMSk5toxWyDDKhAtvSqcBeGFZA8O0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BJzHlshrLUwiFNfVqCGdLf0Y71C8PxTR58aO6c8r1ae8KhYNXg/T1zujukMwCUGss
 URuZsH6MJivslMtGq5gx6zFdOasojdFsruwZXA7UVHIpNTmciYw5/xNUpt1Wf7CXh4
 +p6qcFRyqvG1UGqPx3vpYaBdogHBVe27a/bpZXYI=
Date: Wed, 27 May 2020 12:27:01 +0900
From: Keith Busch <kbusch@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527032701.GA24861@redsun51.ssa.fujisawa.hgst.com>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527004955.19463-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200526_202709_506447_104CB665 
X-CRM114-Status: UNSURE (   6.17  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
