Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A35C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyMNrGI6tcwfpVWFXht81xChloweovY8t4Alr/1bBeA=; b=sl7GJetYOyul4ursdg+byWOLFl
	KL4ZQPbTnGHVrqSPUVC+exDUCb+MXR3L+JsI0FLyIyyOQaBIqA1Gi2PtgnztC2T4mP70/K2glX39I
	rA8jl/KqVvlLWqOSw/7h7Q3/F95sCvmtV6pzvSph3yjugWrE35LdIoFIotg8IQcF/+qI8YuRE+UEZ
	j1XnAQ/JNz55bA8Va0QrRuHGyg88xfiAvrb+0l5hV0Ed7BV0Ue9RAEJZAof7C2/dtEu7ji2v9qD62
	QzT9AumeNvrIzn7mg6+sSnbq5pqUFV5k0X1NR5me4WGr80dRGmwtHJqSXvhxxyrPa77kaNJ2CoqDI
	tWgMGlqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQRw-0047iZ-0H;
	Thu, 21 Dec 2023 21:19:24 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQRt-0047hH-1f
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:19:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7E0ABB81FF4;
	Thu, 21 Dec 2023 21:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68017C433C8;
	Thu, 21 Dec 2023 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703193558;
	bh=tNS8XrxgD/LAL2HMGEcNh0+nzHLj2lxsZMJ3xmjN6U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF2Vbgzcwygccl5riABaJAvvvmb1xZ9EZDjkFaZkioG6kvDtfqRTfRcr0/ssTHgFx
	 YFHRNwMLcRbeqHsTHQdJdWJ3vWjm8X4w+oz5SaKQRSibEChSs8XPPpVQRr1zYVl0eQ
	 sNG7sdhqagPO+4jHLgaK44xho8EEDBwqKLITb3YrVAfjPPvEJKZEckFGXXcaJnrG9h
	 HNporY3G1J3jp9WCk72dqHu75Q07DW9tDp+KhFNuZKMSG5s52g2ocdZDnTK3YqPW/r
	 2c6pnblydg0JEyVRg68z7BSoBqwCwmXL06YrVv7my+fsjATFljx1H4cFnrIimvL+oz
	 ojIFozLs2UDiQ==
Date: Thu, 21 Dec 2023 14:19:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, hch@lst.de,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvmet-tcp: fix a crash in nvmet_req_complete()
Message-ID: <ZYSr1A9wd_oA42mt@kbusch-mbp.dhcp.thefacebook.com>
References: <20231221163154.605669-1-mlombard@redhat.com>
 <20231221163154.605669-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221163154.605669-3-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_131921_716594_49A72B13 
X-CRM114-Status: GOOD (  11.22  )
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

On Thu, Dec 21, 2023 at 05:31:54PM +0100, Maurizio Lombardi wrote:
> in nvmet_tcp_handle_h2c_data_pdu(), if the host sends a data_offset
> different from rbytes_done, the driver ends up calling nvmet_req_complete()
> passing a status error.
> The problem is that at this point cmd->req is not yet initialized,
> the kernel will crash after dereferencing a NULL pointer.
> 
> Fix the bug by replacing the call to nvmet_req_complete() with
> nvmet_tcp_fatal_error().

Looks good. The bug this fixes goes back to the beginning:

Fixes: 872d26a391da92 ("nvmet-tcp: add NVMe over TCP target driver")

Reviewed-by: Keith Busch <kbsuch@kernel.org>

