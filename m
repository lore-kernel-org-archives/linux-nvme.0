Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3165DCF0427
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDc6whnZAEVcNfoO/qtDUfaWpbABhtdYNjnJaJBpA8w=; b=L0iZKE48ZEDg/EsTLIp7q+r/OM
	ixrSnNOX4tDw5PkH943AeR95uy0TrRZhnnXuW81B+cwRyTztXs5ZkTN+JEK8uRYloLAWyldChbtUa
	Wrh/aXCn3Hq4+fJ0qUNriM3uUX7aG7bZqPOIRLltX4Rs6CSbPMQIi9CDxnITQps90p+ViHFZToubX
	QJn5smqIcPir8S8r9nO9kk8A/Yjf0SR+7umh/YIMlvreMd+HfwZU3QPPCZJaGHgvfPWS3Vr4F9Jsq
	MYExtjdGL74AStu/eSUX6kxGpWJTtkRhJZ1E0olhEdphldzzIx572/fpCH79s2gPP5ZWISdjuNG1I
	yAi7o85A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syHbe-000000079q5-1lu0;
	Tue, 08 Oct 2024 21:18:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syHaS-000000079dD-2PPa
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 21:17:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 832445C5753;
	Tue,  8 Oct 2024 21:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129ACC4CEC7;
	Tue,  8 Oct 2024 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728422263;
	bh=A73k37M+WrMmDWoydNcIM34AaOWu0Cs9OtC7KLKWnLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/RfyPe1Z6l5bGPyCScFXKhnU6XkOz2aqUu9jBJasck6CEHD59ztFNQZsW0r9i/gL
	 MVOAw4T/Fc3y6b2KQ9byvU6Ufz2hpV4ciYBp+WKOPak8FjOEfc7vT0mcu7yDGXNwbN
	 L3wjkLXi1fTwM5hJ4/TVc7L7Dcvz9AHgvtO3WTJxR5eE+NNMa+diVHbqFzfJLs8s8A
	 r9S3WUCNtGimZDFU5GMK9ElGTKc+EeM8aXZfmERxa+0lqhjdxTQLH0m9zhKj6o9/RN
	 /v4EsKgDxGqsH1GJlPkeQrepbZEbj20K38qPzVeyZRideJuXz193L6DXD2O9nmruEf
	 LFlJkxRDSrOPA==
Date: Tue, 8 Oct 2024 15:17:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-rdma: use sbitmap to replace rsp free list
Message-ID: <ZwWhda4vq3TwJE0g@kbusch-mbp>
References: <20241008093708.107392-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008093708.107392-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_141744_678417_D8F62AFB 
X-CRM114-Status: UNSURE (   9.21  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 08, 2024 at 05:37:08PM +0800, Guixin Liu wrote:
> We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
> free lists and spinlock, and we can use an additional tag to
> determine whether the nvmet_rdma_rsp is extra allocated.
> 
> In addition, performance has improved:
> 1. testing environment is local rxe rdma devie and mem-based
> backstore device.
> 2. fio command, test the average 5 times:
> fio -filename=/dev/nvme0n1 --ioengine=libaio -direct=1
> -size=1G -name=1 -thread -runtime=60 -time_based -rw=read -numjobs=16
> -iodepth=128 -bs=4k -group_reporting
> 3. Before: 241k IOPS, After: 256k IOPS, an increase of about 5%.

Applied, thanks.

