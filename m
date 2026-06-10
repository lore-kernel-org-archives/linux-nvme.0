Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362B1CD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6G3aI0LugG79K9lPIlod2NJj3VP7NyRtydOCN0r1wM=; b=dz1O12RtJOTkdjbNiw9GWFX5rn
	Dw7qwokm6Mo+jgCNOHNx2keuvGQc/qzfZtkCLoY0Q0DLXq35uod4XU440JzAluhew/pfe9YLJf9LB
	0JxeN0n8ZwXyLOhHLMl2GOCMAaNlku/YLWIXKOJ1JPeWm3n5AwycNqH2yZ7lvmcgvhW2UrkQu4YQ2
	8LE+LbiyB2Wdy54hdaFvhVAehfvbchwoTpSf72EoQb2MKT+UKaJYK7RHRg04OOzg7RcMMKxKRGzO7
	AS8rDQiLEKYxP5BmNTiE8K7LDu7Q9N/U4vyx76ZvTreA2ih9Qe24mX7TbqlLZtNOODbB3jfsNsD2S
	frzUt+aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXFYc-00000007J0z-0mQE;
	Wed, 10 Jun 2026 09:49:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXFYa-00000007J0D-3ifi
	for linux-nvme@bombadil.infradead.org;
	Wed, 10 Jun 2026 09:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=n6G3aI0LugG79K9lPIlod2NJj3VP7NyRtydOCN0r1wM=; b=kImQGJms9NhDI5HQT+hCRMsVvU
	f6kcjb10j0elapjWEobkI0c2Iva8NpCgawFCxhcZl39PJXHlszyqW/wFLdH2nHMzNGvxn/S2tzilP
	mdMfqynZSvaCYX4Zu4nt/lIA7OsmbdXBA8j7j7vfji2LF75WkiKGQojcaDPe70Q7YtA7DVNcczW0a
	frC+qzmwXqaIDz6W0dmwo73oUe7S7LYxU6E4dKgsr+DUTFPweCLun/Dp2mYAnvlsGnDP4TiWkou6R
	MTaFZL198CM8+6qE35GLiE8VAfIDlEPp1I1yQ1Nyqra2wVXtcka/5E0oz9WprtBoUNTPDWgRwKO9W
	cz8gltnA==;
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXFGI-00000003gpS-0Tiu
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 09:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=KuPvhO1BhYA4GB
	6aUx439QYkZ+otlav39zOseMi0Xsg=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=jcOH2SbNEzho3erXbN/mv9PTlKf5WHrVUi4djWro
	TgR1R4pX6Z1G5UOMccVBBRF2h4dKJ5bRbfJ61xKsMo1e6k/LcDsZvkQrUsPvFg2VZgMvoC
	JOvbsKVbiXPrVUiLDfIziElCO8aFAU2S9cqJOTpoe39wFxaj4efFB2AujoK/o3iu5irwgM
	5klkMRvWyIPnwkJqDn/AXlJncIaKtc5+b+OYcX1XYOvKEFw3J8pfXImZUHcdxw/oQpGn+q
	BEfacYq2Vc1/3UEGn129t0mx8QDD9oydHr03QQ/B4DTSWQc3jBnGpt2Enbgsq1gVMaJPAY
	qDsJMPAQou5YRDen6YF9Jw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9399ba44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 11:23:31 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:23:31 +0200
Message-Id: <DJ59DJP51GGT.E93WATHA48KW@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <randyj@purestorage.com>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <dwagner@suse.de>, <emilne@redhat.com>
Subject: Re: [PATCH 0/1] Fix a kernel panic in nvme-fc
X-Mailer: aerc 0.21.0
References: <20260528092734.258899-1-mlombard@redhat.com>
In-Reply-To: <20260528092734.258899-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_103014_485159_2DD21038 
X-CRM114-Status: GOOD (  10.34  )
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

On Thu May 28, 2026 at 11:27 AM CEST, Maurizio Lombardi wrote:
> We received a RHEL bug report regarding a kernel panic that occurs
> when loading/unloading the lpfc module:
>
> Call Trace:
> blk_mq_tagset_busy_iter+0x210/0x440
> __nvme_fc_abort_outstanding_ios+0x1d8/0x260 [nvme_fc]
> nvme_fc_ctrl_ioerr_work+0x4c/0x90 [nvme_fc]
> process_one_work+0x1f4/0x500
> worker_thread+0x33c/0x510
> kthread+0x154/0x170
> start_kernel_thread+0x14/0x18
>
> The following patch, which is part of the Rapid Path Failure patchset,
> fixes the crash.
>
> https://lore.kernel.org/linux-nvme/20260328004518.1729186-16-mkhalfella@p=
urestorage.com/
>
> Since this patch is independent of the Rapid Path Failure feature itself,
> I propose merging it separately so we don't have to wait for the full
> feature to be approved.
>
> Mohamed Khalfella (1):
>   nvme-fc: Do not cancel requests in io target before it is initialized
>
>  drivers/nvme/host/fc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Keith? Can you merge this?

Thanks,
Maurizio

