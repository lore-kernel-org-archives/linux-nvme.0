Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693BC25B4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9RnHFrap8nDDjGCyM6i1mAERC4lxoC/s7HCcmlx53U=; b=I6+xVieNuA79gy1WbJ12gG12N7
	G+MCATCbABl2f6AhUHOzpZMqorQItit+LihRQ6wqp07SEWjcpFIv5oTy462MfV2pLqcTARBRO5Eeb
	JYNEiBuLJMiuMy/aygJ76mpRcwLbRsNmFCXs7QJuzlnfkLQNyqPRv5N+wUICNT3WHpIqEth2bkj78
	N0Y7uvhlWFao9k0IQCEP+ADA48EOiSTSSrZF2MKs1Pa4A4zNs457TS6ZpwCHSWdavzz5+vkUnWwl+
	7s7lCEt9BlOo+g6eAha9BZ7JRYa0iswcEKhX+U8TyCZD4ubK/6Wdc1B84PQA6t7lS80mQGBxsRPN7
	BmqN4GPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4N8w-0000000Bos2-3eqP;
	Tue, 07 May 2024 15:54:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4N8u-0000000Bor5-0fXW
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 15:54:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0AB10617FB;
	Tue,  7 May 2024 15:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7EAC2BBFC;
	Tue,  7 May 2024 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715097248;
	bh=hRMR8YMhpfOJQey3GBzzEwyQQ/uLoZnh6PzwZ8zTVWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+NBvzXRpyqIItGD2W7HuWw5C3Cw/PdFEW2cqGDVwxOBwMgf9nCWZIBtLvvjtqnv1
	 9WGvJrKgttyTDyDQGIemR0vkS8ZXSQoT5HJdUv/ijtwIAvZwKCdLSPFaaEHT5NkzKI
	 5WAZTO+F3FEP1OzMax9CiUaOiGEIptXMUfsSHUJ4gz+5g6/ekL7mkdF2VMgDvskGiS
	 Kwx/ChV0Qw4Wudn8H9lWfY6UpkU+ADY9s9D/nWfcZzpOjHjyIUUb4+rqo7x9OYCS7K
	 93zI3XOVo+Zq3H/YBQb7QT+Lw82fMFHo+sCyZlbtGLo3NtQ1uk/Pb/c54LZTeRNr1P
	 lZq9KG4R5LIcA==
Date: Tue, 7 May 2024 09:54:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-rdma, nvme-tcp: include max reconnects for
 reconnect logging
Message-ID: <ZjpOnmDwUMwwY4li@kbusch-mbp.dhcp.thefacebook.com>
References: <20240505152517.8508-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505152517.8508-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_085412_431912_26A63B71 
X-CRM114-Status: UNSURE (   6.22  )
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

On Mon, May 06, 2024 at 12:24:59AM +0900, Tokunori Ikegami wrote:
> Makes clear max reconnects translated by ctrl loss tmo and reconnect delay.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>

Thanks, applied to nvme-6.10 with a minor merge conflict fix folded in.

