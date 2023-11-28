Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46992C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TqtZit8AUTnTDJGa3bd/JfDOIV17RZW7pwIJrygaUg=; b=g7nbeksMAePe1p4cahPDMGwuJu
	A4S10y6fLuqIpuyJROPue+0uGRst97Sab6kGdsM+iw22sZ3WroyGYrkTejnIDN+gJE7R38zU8YMxe
	Iv/Nnd9i6rzXwJ+sMq10dh9YuvgVDUZjcpO3CPrFTXPMzkUyaadx2YZG+2K7uMJt3eck/5yzVM1Kg
	AfDvTwtdmwDR7ueD1knZsoCW6y4gjv8chvxU6HDPFpOmrAW4W2J6ZInyyc1J4NA1wzTaMigKbI1TH
	wBezx27smMYNAgEqfQUSCbmvw4s+yAugiqUTQLkPZZX05SH7hNtyrYGBP9vXBF4cxP9ecUM6rfMMd
	Yy3C/xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r84pH-006H5t-0F;
	Tue, 28 Nov 2023 20:36:59 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r84pE-006H5Y-2X
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 20:36:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D4AACE1C9F;
	Tue, 28 Nov 2023 20:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E5C433C8;
	Tue, 28 Nov 2023 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701203814;
	bh=/TqtZit8AUTnTDJGa3bd/JfDOIV17RZW7pwIJrygaUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdcrGJob5UD2VDnytOmQSJ6tUAyGUDqqgqzx3kmtfosvSSG6KLUYTCQcO0rn2EPni
	 4VDkKC9ylXO3IpgAmmrcZXgWIIIqWl3EATpBfYGcsWEmIxUuMhaDjzd4BguhdlXfrg
	 hWVa5blalDDsGVuHLwlfyFl1X34DV2oYKT3trJXkZYns9djeL+lLUOnRacgPCdeoFB
	 jiirOkvW0qqsC62wK6YP6/xXOH+i5eQtjeVNDf6JA1+98/LkM4/Qy7sK7oEz+hbDWH
	 fjcAmEkemPfim5ZH+TMMC7+KGQdz2qIeOl2m/cmgM06a6FW8IXzy1J1/iuJ1yl+RAQ
	 i659YCyZeyfEA==
Date: Tue, 28 Nov 2023 13:36:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: [PATCHv2 1/2] nvme: introduce helper function to get ctrl state
Message-ID: <ZWZPY4eelpI4fNLq@kbusch-mbp.dhcp.thefacebook.com>
References: <20231120175035.978147-1-kbusch@meta.com>
 <b7beb838-00a3-429d-a45e-4534e99b1dd9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7beb838-00a3-429d-a45e-4534e99b1dd9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_123657_035110_714016E8 
X-CRM114-Status: UNSURE (   5.52  )
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

Series applied to nvme-6.7, thanks!

