Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8784BC3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqxXPPab9rpKtIadjzmHbS4MiRHzz/3SsNgmWFKEfHg=; b=NzkwcP21DQBLpft4mfd/HphjIQ
	7zhHga61zLRuaAKsd4bV5gPGNrVyxthI778M8n4cNoiUbiscKtpM6lTXy9gsQY9SsKCDp7fW07R/P
	RmV9tuxxldhmLpxWmOiLpOJX2pOnafwnYKRzog6eGG6sfa5qt6yZqjir9szxxehed3y/wnrMtveUQ
	qh2vpfktXh7PUzQSnp6ByJt9hBPLTh6pzRqDuxK6GnyHzTGAMmw2NktkfaeRV2xtXmekWaC0UXoyS
	pw+45wK5TPcsgn9fdVTaZph5dX8iGg+lDidkf9eCmuzlfb06nvT8BotErcvR/DNWdVrSMEGZdFkT+
	xY4s4Ppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHMuH-0000000Czf7-1IfP;
	Tue, 20 May 2025 13:21:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHMrm-0000000CzI3-3xrA
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 13:18:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C71ECA4E919;
	Tue, 20 May 2025 13:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F6BC4CEE9;
	Tue, 20 May 2025 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747747125;
	bh=3MlZ6pJ3PgzLg+lrX3zgXpF30gosCty23jYj1U6ABBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHZFwaCxrPnFBX+bCrP5SkGGkSpo8BjIXmypxC9p1xgUqUVI4SItq8gDUSbD/AZfa
	 wtrfH0zta4wZBkhj62UOCiue0+e33QAgbRtBIGgqva+jRnocD2SZleuKv63XMgiKV9
	 j9lbRtSHDM9ULHKpQnU/yIFlVUYNTenfQHTGRKoZOVPEjis08m3aMIMLmjTA//YMju
	 V7fmp3019Gsydch6NSzmwWZMxrYP0phNVLd3cvY7QV7kOC/Sv1H8igKvkr/VTVd2qC
	 yCDPCvIO9eg96H353N5rnH7gGbQaXeC6V2eWT00dQ7okBDANBDYR69Z10sD9Hu4DT/
	 r+bZgLir/nF4w==
Date: Tue, 20 May 2025 16:18:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250520131841.GH7435@unreal>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_061847_045004_36D8BA1C 
X-CRM114-Status: UNSURE (   7.63  )
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

On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> 

<...>

> > 
> 
> Thanks Eric!
> Works fine. Correct checksum tested against siw and cxgb4 peers.
> 
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

This patch should go through RDMA repository, Please resend it.

Thanks

