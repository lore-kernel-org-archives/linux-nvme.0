Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16A7C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vg4C90jBRgLDIwdrijabwetFKfvP0D3f5XffqsTeWb8=; b=vTKPMDNYANqHV31ipupPGyl9SJ
	3KpP8kn4hzeVFrvHHDGeVbCRvtVkNHAvN0sPClh3DuEWfyKGJXHYk0fWGuFIg8WkeOvv0IY333J8d
	yRxXxknbkb7kFjmmMdWOP43ccvMWZoCtEEfKGrIUSxuA4zO7UFrrZ6eS7+R8BP74Y9abuhXbVf8uK
	Kq+NFEYEx7A4Oa89VYg2mXk71co7C30NhVpy8t9uCbnWwWNkxsCkNP83Cie7qkmGIXT6LRL6xM4Y2
	rC9XYSbcN2YUczV0nzCKrcelirStDE7gqdMRvV1N/h564V9xP1sr1mSHDjTygMnTx4V9YDWiQrURt
	0/MTy7pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmqe-0000000BUjd-1Fkd;
	Wed, 07 Feb 2024 18:40:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmqc-0000000BUj4-0UbL
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:40:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88AB1619D7;
	Wed,  7 Feb 2024 18:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB8DC433C7;
	Wed,  7 Feb 2024 18:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707331237;
	bh=1Z3gwKYZXYR2IXGrkdtNhZFLQHh3s+dc7M2ca7gxgEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugiN3vjrGckga/avEV4Iot0ttpTJY25IlXI5MgvmvBgSo/BPhIhZPhEsBuBvy7nvv
	 35GkxF7kFdVYedrLCP7ztoXXUHirLp16pYjS/Jrh1r4Q2jlL9bnD9PMnzsU4x+BWQt
	 q4Yarauh5x1kTmuLViwX0wbyv8oI176LMlk4LdyiVuSw/PVxry7UJ+Qt4tsLfp2F0p
	 +JHqFGD/7tnkv5k8WlnO8EOzqFJPdPOeJCjNMgo6p4MNPvIklc8FI/7th7tzxsXI6V
	 Wl5X9tbmlME9Lkl2UctBvBkGobSDjsDc1Rx1XizHzalUC5gHvYWvSyMOER8/jtPZk4
	 EQ8r4Zx2ze6kw==
Date: Wed, 7 Feb 2024 10:40:35 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: alan.adamson@oracle.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: fix comment to reflect right functions
Message-ID: <ZcPOo2_uErLnA_Q0@kbusch-mbp>
References: <20240206003021.6422-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206003021.6422-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104038_217261_F120E399 
X-CRM114-Status: UNSURE (   8.19  )
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

On Mon, Feb 05, 2024 at 04:30:21PM -0800, Chaitanya Kulkarni wrote:
>  	/*
>  	 * Set ns->disk->device->driver_data to ns so we can access
> -	 * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
> -	 * nvme_passthru_err_log_enabled_show().
> +	 * ns->passthru_err_log_enabled in

Thanks, applied to nvme-6.8 with updated comment "ns->head->..."

