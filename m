Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BFEC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxI81CVyhl7L/g0ZztoaRV1Q5wsHvfLn+xv/+7fWLyY=; b=syqC5wJxBWdWIc9eEmwNQBjvr9
	y9/seDFTQlVrBqinvopBxqFMigh1hM2df5v1/136RSDqrr9RS7SIPLYzQFgRPrCLjMg7Z/hPtdDsp
	WhkNh1yqO/ufhXQb3HPR7TmWgDOBqWOwAMaoLy2/mkrBQkHaVI3XIDqd6u22HBxdcExfidLML2NqD
	uA4jO2jaiNnmtb3QQv2ChPQoBfsRSVUQXPmqW5okU3DVksfJBhUO1o9wots0zDVTpNv7DbabAbt3B
	1ipob0gEXw1yl0A3Wu94tF0riBLYjhXq+JmdVFHvXu3ucS3an2XUT+Cr1CkJsfullhXN3lcLB6iMm
	JOATHZjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9GD-0000000BQYZ-3XhR;
	Fri, 31 May 2024 20:54:01 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9GB-0000000BQXb-0u6o
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:54:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 009A0CE1CFD;
	Fri, 31 May 2024 20:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA4C116B1;
	Fri, 31 May 2024 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188835;
	bh=pgDYnODcp2BTX/BCu+v6+Qj8N74jOLekqacMvQEwug8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaOJ2wXAJI5oyhlMmOS1qpjcTQt4YPKlTTg9M50fjcAQE4skZPup6aSVS8e+pw4a4
	 zwGjXJ6IW+p0HAzP50/bIe+tgDHtW1TLeGoEl1mv40L0Tdmjbh1rP/vEkjrX+7v3dW
	 PLzPmXU/CKE/MNSUXie59xTvsgO5VgldFNzk12EHqJeM9Ovp/L/4vkrB5hisaQcMYs
	 Y4l9NbGonOuZ7BH5DqNm+IhpjdfkUdfBCetxuCoGBEJIIJXY2R1Y7Ekn6vxLdLeOSC
	 wPsQLxbInDr717xHnkyM42HDxumtc4nOqHvvrLYPWhfdp8GgtPcl9MlVWli6TWvS7y
	 DdO2dWR7Etqvw==
Date: Fri, 31 May 2024 14:53:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] nvme-fabrics: use reserved tag for reg read/write
 command
Message-ID: <Zlo44PRN94sfQAoI@kbusch-mbp.dhcp.thefacebook.com>
References: <20240531092421.317296-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531092421.317296-1-brookxu.cn@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_135359_486117_3A43FD68 
X-CRM114-Status: GOOD (  13.39  )
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

On Fri, May 31, 2024 at 05:24:21PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> In some scenarios, if too many commands are issued by nvme command in
> the same time by user tasks, this may exhaust all tags of admin_q. If
> a reset (nvme reset or IO timeout) occurs before these commands finish,
> reconnect routine may fail to update nvme regs due to insufficient tags,
> which will cause kernel hang forever. In order to workaround this issue,
> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> tags. This maybe safe for nvmf:
> 
> 1. For the disable ctrl path,  we will not issue connect command
> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
>    are called serially.
> 
> So the reserved tags may still be enough while reg_xx() use reserved tags.
> 
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks, applied to nvme-6.10.

