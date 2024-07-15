Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4085EC3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0PVm1jzoalcMOTWE6B0y7yqmnfUDCUb+u7ztxv/z/FQ=; b=jmQRj7JlRPbYvv3eVfrV1Z0M0W
	O+HRIwWTCRvMgCW5TTJzEWd/QZgVX8q4hInatYMlJO/C7YAhGAkds9kqAYmbB+NtH3No1pqSgt6lI
	DhFONKn/995Yx05vN6T+4Hbby9hnXjVF7XmjazoM0/lsienx5CxAaRgzDcRrLg8KW+tHu0IBunsen
	nxk2S5sEnqPEts+Bcc+Bl8Y2WfohvJNATQwoejHuI2QnxkG8gdyrUVQKNmOhve5niTLokpx6gbMEm
	6kpDdI5QUedwMX4FOg1Zb3HC2pEM2Hy672qrnTmr4rVnf4gEhkYIglOa7Xh4V33O64PV7Gs+l0N2w
	A8DPsW7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSeY-00000008MUo-3VNa;
	Mon, 15 Jul 2024 20:50:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSeW-00000008MUL-0neV
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 20:50:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7854761284;
	Mon, 15 Jul 2024 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2FC4AF0B;
	Mon, 15 Jul 2024 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721076631;
	bh=0PVm1jzoalcMOTWE6B0y7yqmnfUDCUb+u7ztxv/z/FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBvrGOt6hJFyIMre/LuVsWV6M4MbvZopWto0Y6qS7GXQzMdedkgab50aKCCMpc68F
	 pPbq0y1POGHlk7l3VpMWrQAuIVtet1ILHo5fiPPMe3dZZ3Q07YLIZvOYL9ysBcM4u8
	 vVzMNVdSYCtCQRPgzRxvyX8kkFzrh+5t8rIRD9AUnnjaUtwMP2d6GnQEkjDI1IGtPw
	 kngjA3q3C86qhY6BpoMnK7UESzN10a+mbGopspLZ7DGY0K0sw3a0Lk84EXf2LEA94F
	 nKIqfCdE+IyvDdcEhbaPsGpOkdTzx48H6xW7wDSzyXS+kA92eJfw83wqqZUB72FOP+
	 bbEZ96hsmkGHw==
Date: Mon, 15 Jul 2024 14:50:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, guanwentao@uniontech.com,
	huanglin@uniontech.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <ZpWLlOgZ69dmT_-t@kbusch-mbp.dhcp.thefacebook.com>
References: <6CDDDB0BA2EAE00D+20240715093144.1548609-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CDDDB0BA2EAE00D+20240715093144.1548609-1-wangyuli@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_135032_314528_CA989EAB 
X-CRM114-Status: UNSURE (   9.99  )
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

On Mon, Jul 15, 2024 at 05:31:44PM +0800, WangYuli wrote:
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 10 hours, there is a
> 20% chance that a nvme disk will not wake up until reboot.

Thanks, applied to nvme-6.11.

