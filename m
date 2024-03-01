Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC162C5478C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vaCI6AV8Lak3qhdvwoBflxxoyDmXc+I7w5TAWB/IFGo=; b=z+B/X+D56U+4M+4xJgFi1aUoGc
	d+cWgjNKiam73csRrdFeVntPrm1wl64vZiQanRwzVjIK3yM3vEm94rpeqOL9BmqMTW7aLSGdOjcVu
	hexYQbPk1hxCK33qLkqnsszjOFHpJhCxpOa5V1n7Gc6OGPsbdL04fuN5IowozMQy3XmSXIHZGP+Ww
	mSfDUMRgxRvtJp4H7yR1Hq/IiiSxvLuJDTL/Ne2NDo56Xh5lAHU0k9FJ8iyTCzAmbWXl2ygUma5u8
	Od6IbFgts6jPJCwHsPwubkEeE9+1kHkIbNaY8y9yqU17Rrd7XyJsoqxS/6jZDklWxE9KU4/O2IG/Y
	U6TrUhKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg6Hv-00000001FZM-2Wg9;
	Fri, 01 Mar 2024 17:03:11 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg6Ht-00000001FX9-067z
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 17:03:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5EF2BCE2600;
	Fri,  1 Mar 2024 17:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127ADC433F1;
	Fri,  1 Mar 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709312585;
	bh=vaCI6AV8Lak3qhdvwoBflxxoyDmXc+I7w5TAWB/IFGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NOwBAKSNqfkOIltQyi4HntKRYTLS8J3BvZ6GXN9J0wV/C9LeZQlSdYHwKyb8o2Os+
	 MXYZDR1K8TSGjlCOMNPSnbUB0B3ZDAmUT+Vyweyp7ZWCvgOQxyGKg7HKtOAAmNPrZG
	 gfSnZScW6+lj5EpDLGmG0l4s250y5LZlUZMUSQyIOT846GpH2+aglL5iIY57njrl74
	 ff8YM+Ws4UguqU76gY7rS3WGWtYJtdsIe7gXk4UUG+Djef/zvRhs4DD1Z3BHWJlo4b
	 P34R74KLUd5UU6Z9ugxko14VBNUY+llqrBZIOo6kAoDXLnEQYhI7nFTieHKawI6p6r
	 al2G2TXLtnM+A==
Date: Fri, 1 Mar 2024 09:03:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v23 00/20] nvme-tcp receive offloads
Message-ID: <20240301090304.6eaa3407@kernel.org>
In-Reply-To: <25334ta5f36.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
	<20240229093219.66d69339@kernel.org>
	<25334ta5f36.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_090309_325043_BA298B9B 
X-CRM114-Status: UNSURE (   5.68  )
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

On Fri, 01 Mar 2024 14:09:01 +0200 Aurelien Aptel wrote:
> Out of curiousity, what tool is generating these warnings?
> I don't see them on patchwork nor in our local CI (running sparse, smatch,
> checkpatch, clang...).

make coccicheck

