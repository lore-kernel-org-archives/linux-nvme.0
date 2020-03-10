Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D06C10F27
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA371222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CP7mEivZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVbLJwOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA371222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=erlK3c+5mu+TlHWhsMvZhL0M4CEfYQU14U7TD9u3CHM=; b=CP7mEivZgi3XkS
	cUl18IxBOIkZbnGhei+tTOnxIouZPhhHUAzqpUV3Mdw0o/P47S7fj2gX42cLujDg4sw3GZ/Y5R7DJ
	OXnSGcSlr00WsW4lpUwWNvmO2yYerkWPMojz14/RvyHiPKfuQnGf/M2ClIFqb4roi9Rywp3P66zMG
	OmBlyAZF7Bo79AzQv1mV1t8tpE8Gmqw/qdCqRvotc/6TXnecPFhBceZFc9SS6ii5IeWI38FNPP3XN
	wK97pGkeWMKmUfWQW/A1Wq1o0hznezFsELAJGvy/4sdH/6lLGt6FOcai2d38RrDfeE4GIQxttmtvy
	p8X/DDuAPJwZDRRYNmpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBluQ-0003Ul-PC; Tue, 10 Mar 2020 20:55:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBluN-0003UU-S7
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 20:55:25 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3CB6C215A4;
 Tue, 10 Mar 2020 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583873723;
 bh=KGUcn0YOw3zJ1k3j3MGypr7rdHBuOokGHaaVEQyBJz0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NVbLJwODF0QXc9hXaS34pQX+lMXAsB4b7YxGfRtcXI6wRfQBT+KAw7AkGlfdPzHhu
 WLdDzHs/A6uhAA+pA0Hj54Ns2XEISbbde7rpqf+3W9LTv/fIN1wAMrFSOOIhrQZaCz
 mctOqZXDyxvsxpk1p4Mno2fyW7WtMDIiqhHYAzVE=
Date: Tue, 10 Mar 2020 13:55:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] nvme/pci: properly print controller address
Message-ID: <20200310205521.GC604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200309150412.63297-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200309150412.63297-1-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_135523_933339_570074E1 
X-CRM114-Status: UNSURE (   6.89  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09, 2020 at 05:04:12PM +0200, Max Gurtovoy wrote:
> Align PCI address print with fabrics address that is printed with
> newline character.
> 
> Before:
> [root@server40 linux]# cat /sys/class/nvme/nvme2/address
> 0000:0b:00.0[root@server40 linux]#
> 
> After:
> [root@server40 linux]# cat /sys/class/nvme/nvme2/address
> 0000:0b:00.0
> [root@server40 linux]#
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Applied to 5.7 with the minor subject edit.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
