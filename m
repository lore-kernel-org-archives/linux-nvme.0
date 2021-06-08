Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50C860C4D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C50C860C4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8t0SKsg9fXLXAsf2Y+fDhXpgYH/FK5azemvgqNGpn78=; b=mq3Yx3yAYjHNs9
	NNZmwvSdXdaQLt9QoIzXVmSroiOps5VE/XWco+s+z/XtFRbtL4TP3Fn3jtonl13viUwj0yixJR218
	BYa1bDsgABIxGi69d+mCRM/Xdp2xTgdnjaEHImOADCD2jZTcLOugw+Obw0DbZLabjZxrNme4rbYtZ
	gGNC2FVv10p4/yp9FMQ5Kzx74+/tfhVDUZBEg6t+W+5UG0iOXIV/GMtTq2MEHiWyr129USG1ZVHS7
	CBilrM86UiPMguvWqkmyHIQ0F76gzowHHaBCXnroTupnl3R5CA3CogRLfR4ZcHXdfIy5jpTfseSSu
	dRJkxViI30f3QdqmYz5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maXZA-00F7Lx-0K; Wed, 13 Oct 2021 06:16:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqc0h-008fUj-7B
 for linux-nvme@bombadil.infradead.org; Tue, 08 Jun 2021 13:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vo96ck+1fKvzKmpasTByaEcQ40lzl5tGwAE0uHFmVZ8=; b=aM8cwn4D30pzFLu1URCHlWbkgI
 e0cefgqdgEx2DKHwPQysCYbft45bcem0MBNwOuZN+h8ruIVp0rjXYeTTW6ow3fS6SKgLVmLtzzcPk
 b/NvoshNhxqWAsEazLCKUjDl/ze5CMOl9+2DpV7vrmUm8DScE98DVkM0PFKfYBFNr8E73WTe1i8MU
 XNTLpt2VIfE8E4iCRNYx6WwEt5KWfI4JcpjPqC5mO71VIqaZfxDjF9I0atIzudeR0GO4z24hWoNVQ
 Fzs7ISc8M/1DkFZGe8y19V8BmCil2Yrxf1rxBtVpDfyu4YVYPLKCSl5o79Pl58VjGoAfIJt0TVDFe
 CW1Y8+1A==;
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqc0W-004lOF-Rp
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 13:43:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6299468AFE; Tue,  8 Jun 2021 15:43:03 +0200 (CEST)
Date: Tue, 8 Jun 2021 15:43:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Omkar Kulkarni <okulkarni@marvell.com>,
 Hannes Reinecke <hare@suse.de>, Dean Balandin <dbalandin@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shai Malin <smalin@marvell.com>, Petr Mladek <pmladek@suse.com>,
 linux-nvme@lists.infradead.org, netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: please drop the nvme code from net-next
Message-ID: <20210608134303.GA30977@lst.de>
References: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
 <20210608121925.GA24201@lst.de>
 <CAMuHMdWgLf8GJfOaRUyx=AvOTnuOs8FS-2=C+OCk02OLDCyrDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWgLf8GJfOaRUyx=AvOTnuOs8FS-2=C+OCk02OLDCyrDg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_144311_801887_5211307A 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 12 Oct 2021 22:54:01 -0700
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

Hi Dave,

please drop the nvme-offload code from net-next.  Code for drivers/nvme/
needs ACKs from us nvme maintainers and for something this significant
also needs to go through the NVMe tree.  And this code is not ready yet.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
