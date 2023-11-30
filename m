Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD27C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xMhoewd4WRoarWnOK0B9asRksxz77RsR+JLwG3kggw=; b=fq8RnuDxH9AtlVVPNw+KOTVOLs
	MZv+HfTYFU+MxfRUjPgM/wdTD9NDEewnoRg+zFvUCAwz4yk7GMsPeiip5xztja8bbSwHNANIqJFUs
	kNWUJJ/0gs7A1BqEeuPxyPw2pE3uyhm+/uvK5E9mJmSW2pObk4dr6S64bC6HA3l4qeOwwZHiDDG6s
	25vvn2G9lizIMO0cJiKBbVg9CN36p8rlMTs8QaeLuelNBgG8z6BufzOeS/Qvq8UnI1DuQQdUPoWiF
	S1O0ovdaqXUNMQfzCJCJ9shs55BIGn7dDtdIGrqSV3JVdq8PAjPDRt160F91ck/zUsofMrZnvGuGu
	9DimO2VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8pWj-00C38V-1g;
	Thu, 30 Nov 2023 22:28:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8pWh-00C37r-2Z
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 22:28:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAAC462006;
	Thu, 30 Nov 2023 22:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0DFC433C7;
	Thu, 30 Nov 2023 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701383333;
	bh=3xMhoewd4WRoarWnOK0B9asRksxz77RsR+JLwG3kggw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k04XMcpQpPcyBHfD7IuSoWPXM3/CZZ91qmhM+FUNxvTUg4ENPR9jy+mbJfC9yHAM5
	 f5ue4JHiJBdMWycSicQezqU/xlGDWKL48J2o5lehILg0TLTIF/Q++e+uHIKeHAoECD
	 YPpALVyQI3xth+jgUavV1iRP9HWBQ0viPrTElwR7abOvRWa5QNGgNrOCxyKBxm3F6u
	 3rCtT0j7vE/4xnnztq17/WR4OFwYtl7QeiARia81TiA144/L3my83xZ+cU+NpurhnP
	 0ijg8S/N/MDCeBXbgW18e2wtH7XXC2ldFckaP/m74jDVhZKh36Mh2Oze3oLXeG19hq
	 63p86JxzvCX9Q==
Date: Thu, 30 Nov 2023 15:28:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config
 descriptions
Message-ID: <ZWkMo6NzVIMmrBD9@kbusch-mbp.dhcp.thefacebook.com>
References: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_142855_874607_29383244 
X-CRM114-Status: UNSURE (   6.75  )
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

On Wed, Nov 29, 2023 at 01:49:51PM +0900, Shin'ichiro Kawasaki wrote:
> Currently two similar config options NVME_HOST_AUTH and NVME_TARGET_AUTH
> have almost same descriptions. It is confusing to choose them in
> menuconfig. Improve the descriptions to distinguish them.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

