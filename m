Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19CDC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwE3upmckLLdCB+kYLuY6xsD3Qnv7LUUiO0d0lVOCH8=; b=iH7ItaehcCfX6hrVwYmvDoRXvc
	fOyNCqQaQnYriMb35i03BAK5pxA3qE9hq7yDQmzeZ7j4Aqv50IYwzNZ9ryb/y0T7OMKH6elV2IH0z
	i0t8zDQTMjz6awlH2sl/jT+yR4Ge1NQcjJwGQqumSTh9Wg/+TMxxZ/MOlNtH/HyEugkjxcXcBEhPd
	cUEtdBVCPsiN293r7g0JD4gCiJFSPM20NR5h2BEjJCqrcwqLM6Ts2k9rJi/VMAS+/9mhXNpd6hePJ
	xYU1EaYZxxhAJHrdS+gqLHOehbrfeQuWADQC46gwq+SSK285ILG/SPneQQk9oXpNPGUGP73DdmCuR
	P46nhaBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXlDX-002M6V-EP; Fri, 25 Mar 2022 14:47:07 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXlDS-002M5W-Fz
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 14:47:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id E704D4400BF
 for <linux-nvme@lists.infradead.org>; Fri, 25 Mar 2022 22:46:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648219619; bh=6HPXgfPP8+BOya1F5AkjcNxtjc44ThKa1XwWzyF2Nro=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dxfctSC8au/oUaM1rvmMG2AsvB+7G2K5obNmzilVRgZbsYn00zCDbX9v3feulM1GQ
 G6xMVcuH28Y25nbTBCFNRfWPNb1nOIBM3c9M+cSQXjcwv/4ueESL5xKr2mqzlC6o8u
 Sw418z9tIWnxJTIfEfaaEyVdO2BMO82nzMfO7xW4=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 2062265529
 for <linux-nvme@lists.infradead.org>;
 Fri, 25 Mar 2022 22:46:59 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648219619; bh=6HPXgfPP8+BOya1F5AkjcNxtjc44ThKa1XwWzyF2Nro=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dxfctSC8au/oUaM1rvmMG2AsvB+7G2K5obNmzilVRgZbsYn00zCDbX9v3feulM1GQ
 G6xMVcuH28Y25nbTBCFNRfWPNb1nOIBM3c9M+cSQXjcwv/4ueESL5xKr2mqzlC6o8u
 Sw418z9tIWnxJTIfEfaaEyVdO2BMO82nzMfO7xW4=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id F135815414FE;
 Fri, 25 Mar 2022 22:46:54 +0800 (CST)
Date: Fri, 25 Mar 2022 22:46:54 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220325224654.00007cba@tom.com>
In-Reply-To: <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_074702_905978_CF0C305B 
X-CRM114-Status: UNSURE (   9.41  )
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

Hope the 3 combinations can support the claims in the commit message.

Since for the later 2 combinations, due to packet dropping and
timeout-retransmission, the bandwidth of each TX node could suddenly
drop a few hundred MB/S. 
And on the RX node, the total bandwidth can not reach to the full link
bandwidth (which is about 6 GB/S).
.
In contrast, for the first combination, the bandwidth of each TX node
is stable at ~ 2GB/S.
And on the RX node, the total bandwidth reached to the full link bandwidth.
And no packet dropping occurs on the 2 switches.
This is even competitive to the performance of RDMA.

