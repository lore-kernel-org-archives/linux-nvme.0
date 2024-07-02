Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06189C30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ckKWwQz7IPUvT2aX/9bAQNsH6U/UsYA6B77GJWTC77Q=; b=IhhQvepgnWv1HutW5FKZEufegW
	JzCKL1X8xAUc4njJjeLD64TjGV8BzCv1BXTGnVyRXmPndz2yFIq2C0a4EE8nH/dElBrIKylVaQzsr
	qi4tyuvSo/dGqCmxBv7asx8E7VpkDIpD3ZQU3nmy37sO7aWoxFkjRXaoAAQzpnF5KRpzoRgwxu824
	wDOTQuy0gbL93QzkYEiUN9504iiiNvuWDZ+ujN44Y3INElXbMMmHJgfK2R3PseYcx20pQSWNT3Hjq
	1eBj31N8gh57sr5MMQMv5kA9FKK/dL0wJ6lt+HlQy101/lTBaRTu8KDf5f2FDRAJdbU6rL5HumFfZ
	GmO0ktqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOc1Y-00000006YxD-1Ozj;
	Tue, 02 Jul 2024 11:50:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOc1P-00000006YsF-1fAC
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 11:50:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DF2068BEB; Tue,  2 Jul 2024 13:50:02 +0200 (CEST)
Date: Tue, 2 Jul 2024 13:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Lawrence Troup <ltroup@cisco.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <20240702115002.GA16219@lst.de>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702104112.4123810-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_045007_598266_4623B0AA 
X-CRM114-Status: GOOD (  14.31  )
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

On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> People _really_ want to control their interrupt affinity in some
> cases, such as Openshift with Performance profile, in which each
> irq's affinity is completely specified from userspace. Turns out
> that 'isolcpus=managed_irqs' isn't enough.
> 
> Add module parameter to allow unmanaged interrupts, just as some
> SCSI drivers are doing.

Same as before: hell no.  We can't just add hacky global kernel
parameters everywhere.  We need the cpu isolation infrastructure to
work properly instead of piling hacks of hacks in every relevant driver.


