Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA8C07E9B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA4C613D6
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA4C613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7OEmTjTkE56Ei1SVQyKJqfZNFZcIOKo3Myc3Ted3X00=; b=cFEeoFqlS2uk/A
	oClsTAOze452wvEkbVsSQyitJBFS4l/x8ovfBXS62QzChYLu0Yu74qH0heSkad7LcC1Si3Sn+oxCF
	dZCjxbava0oskDXRAZb3w+VDXmBh1twlm68TrVgNzKO1TcuLj+F/XV5estGaZPD0ZruoyOu/VZ9jX
	z/1nRz3WVg+Z1jEC+8C3w2anpbJVOtES+BB/IFjbhVmpD4lJii32RZ1d/okx4PIDKaLbIwDHuxx3l
	g2KhBH6bPi3lnSnA9nP0CXuN4myr8bwOR2rp8/3tT5ncrVhPUw9OrFFMRLNuj2iZ00/k5rkm6AAtE
	AIRevja/CNYqP6wc2V2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1nYc-001SlN-G4; Fri, 09 Jul 2021 10:16:30 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1nYR-001Skt-PG; Fri, 09 Jul 2021 10:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5TICEsa94xNlu+MZ0tydmQ+U5vWint8NY+YS0CgtLc=; b=W8AmzrPBw7iJxbKQeZ5eRqIIA
 7cNn5zbRxcRp8/Bpt/6v0HIEDFr+LIQ7VSYSqujbtWV3MYYBlNe1KH+XLAKoasU5R03JgGF34bXAU
 F++yS6EC0aLTznbLp87HXkbuZFt93AnbhiQM3rnqe15JiK6etWyXxBgRz2h7f3ZdINkeS1idhQGUm
 aH+IMcLZJjB84ps5Elmh/bvEpmrWq+zS4mCCO0jdPynOGIgJbh3wh/2cnqt81+Kck1ELm4nzZnrYx
 ecZXDEab/e/8+bmdrhljGmC0j4L2Ciiet30zPajs6ytzj48B7VY6dtwP0xrvl7NjpKrfS6JF4cBc9
 ur8ckvLGg==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45908)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1m1nYO-0001ii-Ni; Fri, 09 Jul 2021 11:16:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1m1nYM-0004st-Dy; Fri, 09 Jul 2021 11:16:14 +0100
Date: Fri, 9 Jul 2021 11:16:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <20210709101614.GZ22278@shell.armlinux.org.uk>
References: <YOgK8fdv7dOQtkET@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YOgK8fdv7dOQtkET@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_031619_861998_1BFFC4B3 
X-CRM114-Status: UNSURE (   8.13  )
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

On Fri, Jul 09, 2021 at 04:38:09PM +0800, Ming Lei wrote:
> I observed that NVMe performance is very bad when running fio on one
> CPU(aarch64) in remote numa node compared with the nvme pci numa node.

Have you checked the effect of running a memory-heavy process using
memory from node 1 while being executed by CPUs in node 0?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
