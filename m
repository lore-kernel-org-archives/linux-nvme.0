Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0132CC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/UuIdULV8fFIoZ1LYAo2r6PHZXwwL5vcyJOIr+KgSI=; b=pFBMtsk6V7BOmAlQ7jcASQ2/Dr
	5g7NUIxFitfYVA5gwdytQRYqyzN/AswSrk0DYiKWOl5tnvT6O3K+EPw8+ZWhmAFIqQEwvRaDbyi9U
	Ek0pRz96ndIK2F4EFOPpWiSe6QsRzHmZHXAqzmsFtSk/eyQPQBunvmVa7xJ88lzgwEQaxEwtIUTaT
	xvB6eFHZ7LqvbHwoAwXvJlu/91AUMLMIOiNSPzg2YIW9rgXT/tFm3d+PFNH7T8h48CJxHax7Rvpls
	vqBGjPH7JHx4HgTl6gcAOUPv4vLBrEzR6R91/6XQHTcV9ayx33zoO+VumNhLuCvxeidoPGGzty9Wa
	NyMYPFIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7AIJ-00000006dDl-1ozE;
	Tue, 22 Apr 2025 09:51:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78gp-00000006Ex9-44Zl
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 08:09:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B37B868AA6; Tue, 22 Apr 2025 10:09:07 +0200 (CEST)
Date: Tue, 22 Apr 2025 10:09:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-tcp: open-code nvme_tcp_queue_request() for
 R2T
Message-ID: <20250422080907.GA411@lst.de>
References: <20250403065522.90807-1-hare@kernel.org> <20250403065522.90807-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403065522.90807-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_010912_145914_FA9938A5 
X-CRM114-Status: GOOD (  12.48  )
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

On Thu, Apr 03, 2025 at 08:55:20AM +0200, Hannes Reinecke wrote:
> When handling an R2T PDU we short-circuit nvme_tcp_queue_request()
> as we should not attempt to send consecutive PDUs. So open-code
> nvme_tcp_queue_request() for R2T and drop the last argument.

I've added this patch to nvme-6.16.  I'm waiting for the discussion
to conclude or a resend on the others.


