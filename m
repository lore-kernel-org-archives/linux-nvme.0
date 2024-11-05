Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEA6D3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CgDvLst2QZYgggGWsrRZv/qg/WUortbDjcf0TN4oHw=; b=Mab3C3O4SSrwpOCWvjwBFxnAJm
	/qOhsElNpcVyfMSvP65qvK8xct3f6jZBETUOZTx54XWtfmLzYMPAPpaf8DZ9374vSZPZtRYZW1VR9
	aUAi9tgTlArO366Q8yzXMGx43EwC8HMxy5nF+oD3j6AYV6jj3d5yb/3OaI1yJV4biu6As60uduZQ5
	HJmReWWbyzKExPsIjHbF5D+COWCLAc6Nqu7PJENuv/TDtHBpmAn7257PcsJnE8cVq4iP0avdfLRh9
	+MqpgMHmGLAQky5pR9Gwg7/tZUsVC6N0kyGbbEzOWafrbb5ysSL8UtEH6H5O5otV8ZuHo6oorlmxX
	W2L1D6xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NNr-00000000CzQ-2zir;
	Tue, 05 Nov 2024 17:30:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8MfV-000000005ro-0Q40
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 16:44:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 883F55C54FC;
	Tue,  5 Nov 2024 16:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D798C4CECF;
	Tue,  5 Nov 2024 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730825076;
	bh=eeqd+TMqxy8WPk2FkSY/4JHsQnG3XjsdsrRexg1DcO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGL68PWWMgb9jrS/tQq08wb0da7KQvztAODTMW93HqGV3ymARrzP24fKpyu9RL45m
	 GJVNECCpv8LDR4Ibg2kPeWsXkKecNAEtpz380UVQruFZznnurUYVBFi95IA4QGvu4Q
	 UDSb3w5q6X66ZnmemSK6wCFyK/8xwf/2roLg5XYw7oWgzXlYiA6psa6s77ICPahUVY
	 TlEbuEmLTdsnR2aMbFWJsfanD2ubKmADexsbMq/A6vmCYR+USXW9Nsd5V6tMwBr9ow
	 dgoggtFWxr/ceelWFmdrIQruBu65XAopO00Lp20kHOu+RiX4oKQNfjUkri6XPa0SSg
	 kKm8PaSNQ4dUg==
Date: Tue, 5 Nov 2024 09:44:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: remove repeated wq flags
Message-ID: <ZypLcUyAgvZ3CjC1@kbusch-mbp.dhcp.thefacebook.com>
References: <20241030064737.95291-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030064737.95291-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_084437_201230_45BECA2A 
X-CRM114-Status: UNSURE (   7.00  )
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

On Tue, Oct 29, 2024 at 11:47:37PM -0700, Chaitanya Kulkarni wrote:
> In nvme_core_init() nvme_wq, nvme_reset_wq, nvme_delete_wq share same
> flags :- WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS.
> 
> Insated of repeating these flags in each call use the common variable.

Thanks, applied to nvme-6.13.

