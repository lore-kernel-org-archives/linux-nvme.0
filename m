Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01718CDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RY9ha662dMRdgDKgeDR6bWDA5rzh9HIx7b6R+adtLzk=; b=LqBbwWMejkTcboJr2iMRWao9WJ
	XKVrY8dW43F3X5KjkrOVhmyGsmhrcSDLqZjP4inYXdaavZN7PMoSJ2Lnj2eaVSSRAB/6lMlaRfvcu
	rensQolLrHKQ2bQ3yQfG99gvv1TjeY+0D14I1zFitBIttTTsrnDHiUntu3GeyWIf94fUKwtC6zLzz
	abgM801Z2YkPMRvWifLcjwpWSLMzAAVDBUrS0ug0LtVoVmkOnxjycHUFEnw0OkJFaNklZ6OeYmbSG
	qtgGd7uvH4D/tsHV3wm70wx2CbIAcNzNxGxtMVbOGea1jwECEiTU4Mu0cyURWN7pPGDwyj400o1/N
	LSXK9exw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrKQA-003ir3-20;
	Fri, 13 Oct 2023 15:49:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrKQ8-003iq5-16
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 15:49:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E9B78CE3126;
	Fri, 13 Oct 2023 15:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668FDC433C8;
	Fri, 13 Oct 2023 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697212184;
	bh=rL5Fm1PuaW8VrEFnpvxPh1+LUIYB9ldBEMINcVZ90yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbhGZ/jMIp/K3p6Ir5ISnKZ5s+LJvSaOIFL2iIvuk3dhLrIW4EurbsZG10SNH/hw0
	 EV/I1P0vVvP2gn4KwxY8xr6GxSQooVciFLa/FelH+Yqn8zAMxcF/uTERVoix4szTeu
	 BQ/mbnq1UJVRBPbUrdjPItWplu1R3l0Nbm4Id5rI2bZrRNgTz815WWC7VBMQIvbwO/
	 tDcbmSRqT3+hwMllZ134tx8vE1JdjQBiz6CQL0qcHBP1d9w4aqvRdwmC4db/01c3vn
	 NiRs4PwUjy+Hp5ZkzKywuuUnwM0PBW8Nl8/pqReM1Z/Yxib57HxgrOgfIkStKYxwHn
	 ali4KPt0+Nscg==
Date: Fri, 13 Oct 2023 08:49:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v16 00/20] nvme-tcp receive offloads
Message-ID: <20231013084942.4ddc2b90@kernel.org>
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_084948_560642_A572171E 
X-CRM114-Status: UNSURE (   8.45  )
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

On Thu, 28 Sep 2023 15:09:34 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> This submission was rebased on top of net-next.
> 
> Previous submission (v15):
> https://lore.kernel.org/netdev/d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me/T/
> 
> The changes are also available through git:
> Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v16
> Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v16
> 
> The NVMe-TCP offload was presented in netdev 0x16 (video available):
> - https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
> - https://youtu.be/W74TR-SNgi4

FTR you need an explicit Ack from Eric on the TCP and skb parts.

