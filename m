Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B855C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:41:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CEA610A1
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CEA610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Fvr/V6JIB7Sk/UENuaYNU4+fOkzNldiUuiCTKH+xEQ=; b=ujuxaQjKoFu/Vp
	JiOaX9isUTF343UIA0Z6yTKt1hV5VPXNiVQbBgpm7TIAgdN7ZZVtkXB3UcMjExwJy1C3UGWfqEPoZ
	VxRQeWcEZoNTq3UNZ+AiPbdjoEuEQfRrflSD3Q3rUJg13iVpkfHrkTeGYnf/RTdpJ13fb0u7FOmXt
	0hMEyvTZO/syoUgx+nuYObeSxl7TtlLqOiDtPIkJBhlp6iRfmAISnpR8wE7RAi0VibypiNQz6kU8c
	3v81vbi34FpBzZjBG1x2AHZdmwkbhiVWS5X+DmVlpWFJzKKtk3FqmGTY4vZ1iXBvgv7HjvAJtorzI
	MEvFmc8rueN+5QVQDMkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqhaj-00AGDu-7O; Tue, 08 Jun 2021 19:40:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqhaf-00AGDa-Uq
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 19:40:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D3C261182;
 Tue,  8 Jun 2021 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623181245;
 bh=qfuqQmybyoljq64r0RNXg0MCacqzHKintngcUPoNU1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rukof2lFlIsdSSLRDf4Yj8FgPS3MrVjads+/4I7R4vNh0NXly9Q7ysZp2K+c+6Hnj
 KG+9IQlpJsntLINn+QZIfOiObQivVWFi7RaYRQNEEwbCuosAcPp9PJy13Ps+4JQEPR
 3tzPehb9+Mm/EoPtn1jtVeKFPgTx0ooMJCLyZE7zGfCXjA8NVlWVdA2VAisTKRK+ZN
 zDeycpNcLjpreu7E231pj1rMJPtHk1Bp4tVNTssqfhbAptLBkiWEe274ucwvQ6c/+s
 2N3DQ9v0BmL5YMdmYGt08R2jnzceHyuUBXwqBEPVekYDczYzH8ioZ5Fyu8iOclJTOv
 NrsGwGE9Hf6mA==
Date: Tue, 8 Jun 2021 12:40:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: hch@lst.de, geert@linux-m68k.org, axboe@fb.com, sagi@grimberg.me,
 okulkarni@marvell.com, hare@suse.de, dbalandin@marvell.com,
 himanshu.madhani@oracle.com, smalin@marvell.com, pmladek@suse.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: please drop the nvme code from net-next
Message-ID: <20210608194042.GA339628@dhcp-10-100-145-180.wdc.com>
References: <20210608121925.GA24201@lst.de>
 <CAMuHMdWgLf8GJfOaRUyx=AvOTnuOs8FS-2=C+OCk02OLDCyrDg@mail.gmail.com>
 <20210608134303.GA30977@lst.de>
 <20210608.120839.259439633590059559.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608.120839.259439633590059559.davem@davemloft.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_124046_033904_8B5777EB 
X-CRM114-Status: GOOD (  12.18  )
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

On Tue, Jun 08, 2021 at 12:08:39PM -0700, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 8 Jun 2021 15:43:03 +0200
> 
> > please drop the nvme-offload code from net-next.  Code for drivers/nvme/
> > needs ACKs from us nvme maintainers and for something this significant
> > also needs to go through the NVMe tree.  And this code is not ready yet.
> 
> Please send me a revert, and I will apply it, thank you.
> 
> It's tricky because at least one driver uses the new interfaces.

Shouldn't whoever merged un-ACK'ed patches from a different subsystem
get to own the tricky revert?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
