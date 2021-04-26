Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67859C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:17:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0844B61076
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0844B61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vzzkVWTXI2wWeJ3KOalyZ5n+rQavXt2CWT8qBAdzVpI=; b=BYvm0ubV7FrqtDlL3VNDOHn0w
	Qq8QUxB0STB/KmCFR4YXNnZxAiWrixGQbvV8tR4R053h0aZAoll33ofGFY/BQjYjMWs1R6NfnOjy4
	vzepEFE03saXb2iGrsaV0WwSRMoOrURveYSDYqF7k6uRP+Rkqap3F+MpYSVt9XREfkMo5uX2tlkjl
	rlJXZITt9HbicHvuFEAgqgdlC6lfHjl1sohMFWuB8MLEEcjG5ewBXUts8GxRqCqiL0K06jJ5DWqdz
	NYe8XGtK2dodPxLFSOVzfHQAoXlkd4D4+uWjVtglMjuKIqvec3OL4h6JTNQOOfXMrDuhgVDkb0WFk
	4XPtkiByQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2yt-007wko-0T; Mon, 26 Apr 2021 15:17:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2yr-007wkc-7p
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 15:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H0FEDX8BF5wZWc89dLWYNPo5agjBN7zMdH5iD2q8URs=; b=rq2cVJlDby0P7i3mBkD/QC/er+
 EZQOkYG3TDWDleNP8tFITs2/QmdDCL+N70pjfKfVuMAxPwz+uxPyJ0OyIy9OKscNBrqgisvv2Q59t
 SZ6kPMJzq+oQazt1uS7RvL4Rg3Fy2rs9x4W/EG1pyOwGt1xPysaa7wKH6xKuZWjIBP2nMzFw16F00
 PPp4vtpVj3gMdEd1xsxGS06joU3q50edI60mgjGzrZYQUT3e1viLcVUN/9FCYArsqe2TKekTQa8xW
 MEC/n9FwFizIPX5/wgnUOXUdupzim6OZuWRKYevaLLoKEhyvr88ata2r4jdsNqUwK7K6dSgdQGQc1
 9JoJttgw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2yo-00G2aJ-Ok
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 15:16:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DD1461041;
 Mon, 26 Apr 2021 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619450218;
 bh=4Yn/mfaMho0PcS/JLVj/WsgPQuu9nCREYLZ2ygXW6O8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VbVZTrTNhL09YE/4lCwX4x2zMYhd9XUyckYInILKLTgZvP/J6EtehWLcvi5dZbaRM
 Pt04Ofq1bxFtAftxBbSIPhVrihewKtOQ05mgcoOfKJSJ0HvcGzNxK46J7IN8ztYNvt
 ct9DIRntDt6hqiu1w0Ec5FsrPmdafONeA6TcaXjEMyj/LzrG30IMnBOBmpm8RmNFFd
 cfTxMFEtGU9s/jkaLXgO2re2jrMXdPFQvFjpcH9nGojnl5/QMBct4jORXlc2ATn8DA
 uE3EGAPZLVqn7VLSs6CGKsSmfWsbvxN/EbxCIKIjHn50yenGqRssEAcITkri+vXgXB
 YOYTWgq1B9ZOg==
Date: Tue, 27 Apr 2021 00:16:55 +0900
From: Keith Busch <kbusch@kernel.org>
To: taochiu <taochiu@synology.com>
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me,
 james.smart@broadcom.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Cody Wong <codywong@synology.com>,
 Leon Chien <leonchien@synology.com>
Subject: Re: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines
 to core
Message-ID: <20210426151655.GC12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210426025310.3005573-1-taochiu@synology.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426025310.3005573-1-taochiu@synology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_081658_847232_15289D97 
X-CRM114-Status: GOOD (  11.23  )
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

On Mon, Apr 26, 2021 at 10:53:10AM +0800, taochiu wrote:
> From: Tao Chiu <taochiu@synology.com>
> 
> queue_rq() in pci only checks if the dispatched queue (nvmeq) is ready,
> e.g. not being suspended. Since nvme_alloc_admin_tags() in reset flow
> restarts the admin queue, users are able to submit admin commands to a
> controller before reset_work() completes. Commands submitted under this
> condition may interfere with commands that performs identify, IO queue
> setup in reset_work(), and may result in a hang described in the
> following patch.
> 
> As seen in the fabrics, user commands are prevented from being executed
> under inproper controller states. We may reuse this logic to maintain a
> clear admin queue during reset_work().
> 
> Signed-off-by: Tao Chiu <taochiu@synology.com>
> Signed-off-by: Cody Wong <codywong@synology.com>
> Reviewed-by: Leon Chien <leonchien@synology.com>

The series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
