Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFBC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:09:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553C5611AE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C5611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PKvfjpR4wiEJl0aQBtD1Baod61uhGjdbpOLBCAs4Lac=; b=Iy1l0L7kPDmAwk
	50RUZx1Ut+B2wK6NiN2037BM+OUFX0Z9RQQ4BQcOVyN3U3BZOEho0W84esQGwVdaSuYmG/QvZ688O
	GvrAjKuH1QvzmC+cdUuHWE49ydAcbjXkfEvohniH199ZzHrtkHj+6CvlZzLs9MiwHK14daaNlLrmk
	xGWz7pNg777NoaSWXbmwhymdl7gOJj2nobuoR24RADEVu/zWonotS6jcGkm38xYc+bxZ/anqB/SCm
	J2KMDw9ZdAlzKbl9OGMMzoS+LQExqFfy7UTmgmjBiN0kXcR7W1AXizAbf3ABwzvvA7+v7tt85lReO
	26n+PXIuFK6pfC/dX3oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqh5o-00ABne-8T; Tue, 08 Jun 2021 19:08:52 +0000
Received: from shards.monkeyblade.net ([23.128.96.9] helo=mail.monkeyblade.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqh5k-00ABmX-Sp
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 19:08:50 +0000
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 by mail.monkeyblade.net (Postfix) with ESMTPSA id 8AE204D30E6A0;
 Tue,  8 Jun 2021 12:08:43 -0700 (PDT)
Date: Tue, 08 Jun 2021 12:08:39 -0700 (PDT)
Message-Id: <20210608.120839.259439633590059559.davem@davemloft.net>
To: hch@lst.de
Cc: geert@linux-m68k.org, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, okulkarni@marvell.com, hare@suse.de,
 dbalandin@marvell.com, himanshu.madhani@oracle.com, smalin@marvell.com,
 pmladek@suse.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: please drop the nvme code from net-next
From: David Miller <davem@davemloft.net>
In-Reply-To: <20210608134303.GA30977@lst.de>
References: <20210608121925.GA24201@lst.de>
 <CAMuHMdWgLf8GJfOaRUyx=AvOTnuOs8FS-2=C+OCk02OLDCyrDg@mail.gmail.com>
 <20210608134303.GA30977@lst.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2
 (mail.monkeyblade.net [0.0.0.0]); Tue, 08 Jun 2021 12:08:44 -0700 (PDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_120848_963118_5A2A8528 
X-CRM114-Status: UNSURE (   5.96  )
X-CRM114-Notice: Please train this message.
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

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 Jun 2021 15:43:03 +0200

> please drop the nvme-offload code from net-next.  Code for drivers/nvme/
> needs ACKs from us nvme maintainers and for something this significant
> also needs to go through the NVMe tree.  And this code is not ready yet.

Please send me a revert, and I will apply it, thank you.

It's tricky because at least one driver uses the new interfaces.

Thank you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
