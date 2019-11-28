Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CC2C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:20:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78259215E5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PD8524kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78259215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mlc/PstARzAfSbX1q4oWzW+kxWAwN0cdR72zwcHyUhw=; b=PD8524kp8qCwGS
	791cJIY25vVtcFagKJzmNhfBVkB3NSZIaCgT5yWx5RnRvZsvcCCiPN3gtCl4fPDlw8chPVls9WBKL
	ydpv1esr4+WhrcbOw4XRH1qPu6ly2il2mHQ1jzmlQtIXHj1aiGpNxigkVIDActKHz3tnmxEk39s5T
	kcBpdMyaVhv3ydfHBUgcceIy4kfjlcLgPjwsmoWCcJ60c3BXSkawrF8CALhxx2xaVbHTYlzET21zU
	7aa81NTaH2jPoEGKTmLHJCnzhKKQEdaw6AhP8FKYczrVqKG2+iq/a8bSH8SGCzVv/93SsOX6YnJwc
	nu8u3g7LrFQl7DrCuJWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaE5t-0004Cl-29; Thu, 28 Nov 2019 07:20:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaE5q-0003ut-5S
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 07:20:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 600B768B05; Thu, 28 Nov 2019 08:19:59 +0100 (CET)
Date: Thu, 28 Nov 2019 08:19:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/4] nvme/pci: Mask MSIx interrupts for threaded handling
Message-ID: <20191128071959.GB20330@lst.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191127175824.1929-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_232002_366399_380E1B2C 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, helgaas@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 02:58:23AM +0900, Keith Busch wrote:
> The nvme irq thread, when enabled, may run for a while as new completions
> are submitted. These completions may also send MSI messages, which could
> be detected as spurious and disables the nvme irq.
> 
> Use the fast MSIx mask to disable the controller from sending MSIx
> interrupts while the nvme bottom half thread is running.

I thin kwe should keep this together with patch 2, not just in the
patch series but also in the code - I'd rather have two little helper
to enable/disable an irq with if for the two cases and a good comment
right next to that than splitting the higher level functions.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
