Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6EAC3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=94zhHxZXH0xjsMFtar0zFUFh3/IqUeIm+PVxGCPSgAI=; b=FHoONcsFEwvds861cpAoWlrW4P
	FRu30+ZCn0Nsi25m9VIB4wDioUDdX3Uk4AT5GU0WePLGm3xoGTP26FsLBZyReJRBQUlRJ6KhOekRH
	VBENUv/wRLUlMrnMJvlSEPexuXAfydTZgseDqBZ1X1o0dex50bOhkVpz6t8g9yl1T4Sus4njVeaG2
	LmYUPBig7ApqXxGa86Blux6ExWZWM1y14tc5ev6dlhMB+xquK2uKhZBa0wkWXaCLE95gGh3FAeSUY
	DRfArUDlz9O3QGy0E7SoBs5xKJATgtAVne8TOCmRHUKcRlXv/IG95VB8oAlrfl/RHyHpf49DCIan+
	3VE88R0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZBO9-00000001kT4-2l9U;
	Wed, 31 Jul 2024 15:37:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZBNU-00000001kN5-2yDw
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 15:37:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 393B8624B0;
	Wed, 31 Jul 2024 15:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BBC116B1;
	Wed, 31 Jul 2024 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722440195;
	bh=94zhHxZXH0xjsMFtar0zFUFh3/IqUeIm+PVxGCPSgAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUQSQ70J8x/ViALASVFqSP0qBpka57PBVC3sHwcB6WHM6C9jj6eWzcMwCI3bek3SA
	 edkOUIrjtsvu90LuTIxVSGScdsPqY3SoDm01i5o3g++/xa99zf4NcriLRLBv9XZBT/
	 tT+UisKK6oV9CP4A75LWYhVh1nH8yOMBU1pkAtPQ/GfClBVX3Fp5H9iC3X2CXTFTlw
	 rZV6/5wH6R8zIbV/0HSPOj3Uowg29+HznMieY7Iqd3iyBqarWFeebJ5b6WpXtnzI7w
	 DPCDdPxMy0utwRcPH1gJMcWDaH2Cf0gg62o5dSD6zXZZTaQIY0Ivxxg73yJVzgSHJ2
	 HpD4rLVr5MEIQ==
Date: Wed, 31 Jul 2024 09:36:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: remove a field from nvme_ns_head
Message-ID: <ZqpaALE7NtsdwAfG@kbusch-mbp>
References: <20240730103138.66714-1-joshi.k@samsung.com>
 <CGME20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5@epcas5p3.samsung.com>
 <20240730103138.66714-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730103138.66714-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_083636_811390_EA5F160F 
X-CRM114-Status: UNSURE (   6.29  )
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

Thanks, series applied to nvme-6.11.

