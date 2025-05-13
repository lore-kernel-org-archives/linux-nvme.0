Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F66C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUP8gyxaq6TcaCQTTZBu9YlOoWopJGH3OTCQF/q56ck=; b=HUy6/Tp/rjH0Yd464i5X4pxt5z
	la69IDf43zekTVvATDxdQ4r1OM4z+s9rdM1oHM0Bw612ARVg7qSpQ59PA3/dhVH1JUTQtKOR2pOgP
	Ol9V+xhtFqdm9HswC47ByU2ewzbTmPrbWiFEN5Jrw0mZIcpk3VCTIKaHgmrYj2HOx8DWJydfkVym5
	g8Id35N/DqqZonioSJqMBWDuupmhLpecwdFlYvju9aI7jBU8nEY7ueohzcXtirP1Z2vRAcfXk7h0o
	KCdkHM0tLpuNm1DbMi67cs+/cJoAeKA/0K8EyGSNAh1w2tx/EyQSvJclUS54BSC/e9VzZClovqFOA
	R46T2jCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqmH-0000000CdMc-0XHj;
	Tue, 13 May 2025 14:38:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqjz-0000000Cczt-1MCC
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:36:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BF798629CC;
	Tue, 13 May 2025 14:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E504BC4CEE4;
	Tue, 13 May 2025 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747146978;
	bh=tSPafprbd19d+77BeND/YIw+GAyqC5lHPBMsLo+NYAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCgofRGCq5KqCl6BNlZ/JFoaiu9VqwWASq9woMh+A5tXpZD074WOVWA5a6IE30DwA
	 9IZkaoBzt+cbqULREMHNzbFcVnBWBcQcLRF1EusHByJJYK3vbzz5Ii8iTyYoo3bXZU
	 0TLqYpSAIdV71TRLK3SG31YjEH1sDvsWgHpMtgu/YYS2gST92/hNzA983ea2qFty4Y
	 ywyZIDsf/wIiNBAwnqXLojVcpzQEgAobFJzJvyPIykalHvPzkeAw4myCum7mI5/p0M
	 UQkxiqnWzCNXV4i8pSxyf7MtwCwoSvY0lqPwpaIT2aZ2saqZQU1gBQ6IpGHYKtdN5Q
	 ++sYiFkhIORvA==
Date: Tue, 13 May 2025 07:36:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Gustavo Padovan <gus@collabora.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>, hch <hch@lst.de>, axboe
 <axboe@fb.com>, chaitanyak <chaitanyak@nvidia.com>, davem
 <davem@davemloft.net>, "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin
 <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>, ogerlitz
 <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>, borisp
 <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>, mgurtovoy
 <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>, edumazet
 <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250513073617.3a711fc5@kernel.org>
In-Reply-To: <253a57gzn1g.fsf@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
	<20250505134334.28389275@kernel.org>
	<aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
	<20250505155130.6e588cdf@kernel.org>
	<253a57gzn1g.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 13 May 2025 15:56:59 +0300 Aurelien Aptel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > Thanks, so we have two "yes" votes. Let's give it a week and if there
> > are no vetoes / nacks we can start.. chasing TCP maintainers for an ack?  
> 
> Sounds good. Do you have anyone in mind?

Eric D, ideally. An ack on patch 1 would go a long way.

