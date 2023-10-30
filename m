Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B30C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 06:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bp8Ruapeyw6Jqhg32Pkaoo5eG4QqBWWc2DVZjypxJ4Y=; b=wG655/iBRCVwGhgt6gQVxRkzug
	3Thl4VKyl9w+qvjuZk7fUCWYZymVkx/sKOWJfgfWeX1jwO/8dKdcIAiRI09OfnsNDgNxpGn3v3pEs
	LDBhLIjVuXHAKEoBr6FiKUG5vJLopntyl3eEG01oD3MEtmXXEB3R+Tcxm9Ux60HckG1K7tuCDzc+y
	RX1+IJbIw14gBVqD31kf7YDo9VcG/JYpiJB5gmge9oYaQh4dhz03cLD2qqZ3ZxM/ST5bkNSwguraL
	sW9s9UyHupi8UgVlqItEx6iG9pWFYQ6UMEid4k8okIEEzR3aIPUN5b2mlQxP2G3pEvR/kzt7GYj9g
	cRG9rhyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxLZ0-002eDE-03;
	Mon, 30 Oct 2023 06:15:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxLYt-002eBw-2l
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 06:15:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8628FCE0FA6;
	Mon, 30 Oct 2023 06:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E8C433C7;
	Mon, 30 Oct 2023 06:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698646535;
	bh=+AjgvHo7u4AjcdW78I1WaXMZlIBlola+cFHDPGBHpLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qka4v1v3TyipegT6yuUPK+zMEbXj2mOvJPm6FMIwyhH/OUY185zUFNuhbk0WTBVLa
	 LZ4U95ZVFc7qgyY8zg+uenVqOToKnTx7NJr0uB85+lnTpCQEDgHkllI0PAmABjXPKN
	 +IwfKalWj7nbET8SqqZ8zJNaxDFb5UFgYUkgU+Yl7t6X0FQG6Hs123PLqyNwdMKY1e
	 daOP/OfRMcCks5guz5FB0ExqBk1/Oq7dfP1W7uRjoUIZthTS0MRtJjOWbkoThkmvel
	 LaiDM3fH7G4IXEfkJuh19p+oLV1WSAJNsXovyncphbkNSRLC2+NI4k8Y0e3ZF34iIQ
	 2o0kmFbl5XG3g==
Date: Sun, 29 Oct 2023 23:15:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v18 00/20] nvme-tcp receive offloads
Message-ID: <20231029231533.79dcb9ef@kernel.org>
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_231544_089192_63C6B3AA 
X-CRM114-Status: UNSURE (   6.96  )
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

On Fri, 27 Oct 2023 12:27:35 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> The main change is the move of the capabilities from the netdev to the driver.

Patches 15-17 never made it to the list :(
Please note that net-next is closed for the duration of the merge
window.
-- 
pw-bot: cr

