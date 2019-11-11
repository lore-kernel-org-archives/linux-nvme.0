Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B00C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 21:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173492084F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NsqJRJOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173492084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gwdNgbPyRJi3NW30ST1PGMECBA9nNlggCmU998RxAR4=; b=NsqJRJOpNnSkRJ
	DJw4vKhqN+UkYz28BT80Q1+cQ3/UGMLtAqDofqYKy9vXQHa4pP9HzXEn6N8UphPJOBAMN6+uIBxtc
	eCl8bdOPDJ8lkQXk2QHi/KikLNAera/4RgR3WCQv53zYEOIsQ5ukfLd6tR6fueLQXRbiJYiBsJFsN
	AXaMuSmzgvJc7d42BiiwLVNinURfVNMNBLt+OS1YI4mupcgg/WESGf8j+/jMXaIzvs925RHWowBew
	dtwHbX0DddeTeHJAQDJva0NR9oi+PdU6ZQvfPGE3YyaJXQn7q9VTnlugDCHdXE4LSO+bHPZcFbUBQ
	jvUAtLJtTYjGmiMafYrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUH1j-0002y3-A2; Mon, 11 Nov 2019 21:15:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUH1g-0002ae-GG; Mon, 11 Nov 2019 21:15:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 58C6368B05; Mon, 11 Nov 2019 22:15:04 +0100 (CET)
Date: Mon, 11 Nov 2019 22:15:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20191111211503.GA26588@lst.de>
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
 <20191111203743.GA25876@lst.de>
 <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_131508_697985_F69ECE1C 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 11, 2019 at 01:09:17PM -0800, Alan Mikhak wrote:
> Thanks Christoph. Let me repeat what I think your comment is saying to me.
> You prefer all parsing for nvme command received from host over PCIe
> to be removed from nvme function driver and added to existing fabrics
> command parsing in nvme target code with new flags introduced to
> indicate fabrics vs. PCIe.

At least for all the common commands, yes.  For Create / Delete SQ/CQ
I am not entirely sure how to best implement them yet as there are
valid arguments for keeping it entirely in the PCIe frontend or for
having them in common code, and we'll need to figure out which weight
more heavily.

> Any more thoughts?

I'd love to eventually find time to play with this code.  Do you run
it on unrelease SiFive hard cores, or is there a bitstream for a common
FPGA platform available?-

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
