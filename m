Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73041C3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 14:43:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CD220752
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GgtRiDIg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zOZrBhuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CD220752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OUBHPN3+6Nk4hIbKL+vQJF9cV1RxxtbC1z5HgabO5Lc=; b=GgtRiDIgOVTR++
	d+fhVO/UTo2AFjmgdVRrQv1soGC2qLrUTA+8t88VuF8FXscueMDMjCms6tmiWr518nWojPDtETVlg
	T4I65ocGZojuphvs9s5iDTszRktrg2jxxUTNe9KChzcFANOzQmpRZNla8qahLzmK/3yGq1eBOkPPe
	QH1aURyNjTV2tSj4mGW5VDLUMs1M59ss7IbKt+FJ8FJj7IcahLm23uTtoiblSRuq5zk53gAZHEj7y
	D545ySus0dCyObqLbS5WzzZ9sPIt3E9wEavNCt8qo/aSJhkjeMzYnasoj3V0Ab9eL7xI1DX4etSfv
	rjTCJ5hRrbgI6tN5/8TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVcJR-0007ak-UJ; Mon, 04 May 2020 14:43:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVcJP-0007aM-IU
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 14:43:16 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 800322078C;
 Mon,  4 May 2020 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588603394;
 bh=GI4o3j/j7V+tSsHBWjzTEiwrtLDcn36StHVbZXAqss4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zOZrBhuM+vOBfe2wfaOwG4Bo6DbCQtaQqpAcjMehbJm83tqy0NeNZVCoC+0zUU6H7
 ldU+0Bvdg37k+8f/aayarl9Z5D076Rfn09zX8XrlqUtrZM0Pz1L2Cd5kjEw6GOFrsU
 3t8TjVFy5p5uE1P4mK//2nmMy9n3Nhym1GZnRMFU=
Date: Mon, 4 May 2020 23:43:07 +0900
From: Keith Busch <kbusch@kernel.org>
To: Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH v4] nvme: align io queue count with allocted nvme_queue
 in nvme_probe
Message-ID: <20200504144307.GA27747@redsun51.ssa.fujisawa.hgst.com>
References: <20200502072937.GA12656@192.168.3.9>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200502072937.GA12656@192.168.3.9>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_074315_628073_1D3F8422 
X-CRM114-Status: UNSURE (   6.02  )
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
Cc: hch@infradead.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
