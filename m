Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CE9C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aiSSfTARXLXB+2b6Ug2v7LTxgYSipXgqDvEptgUSWk=; b=DpnKlrbFuIIGuQqqmUNUioCKiw
	TRzsg46L/72KVdzcDSnKhN/PDdfQBPBnwpjl0LrvNVZXAZ+R0u8h2AQLlqh4LyubPlePVOHJYcUoy
	G/PuWKFpmlyaBxqlvtsOl04ARPjMg8XEyg+e2KO8DeTaWsai01HVPj9AUurtuQed+ZytFUhha55dl
	Ll585+BjX9LsS02U9BDjJ3Cix1kN3BUiAZzHsn7qh4K0OM9EfW+fpxyeQkU6dUIsCY1ApfARA4o1G
	C0YZ/d5deBeq5oIIKYgZm2wEZHNFRboBj8EEEkixfC+R6uKppTgwbUkG7vhs6F04hmVMDqU0sLUKB
	jXT31Udg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797q-00000006LXp-2Bi1;
	Tue, 22 Apr 2025 08:37:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78PD-00000006BAj-3mKU
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:51:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1873668AA6; Tue, 22 Apr 2025 09:50:54 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	dlemoal@kernel.org, kbusch@kernel.org, kch@nvidia.com,
	sagi@grimberg.me, hch@lst.de, upstream+nvme@sigma-star.at
Subject: Re: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
Message-ID: <20250422075053.GA32269@lst.de>
References: <20250418080250.2736590-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418080250.2736590-1-richard@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_005100_077218_24AFE183 
X-CRM114-Status: UNSURE (   8.79  )
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

Thanks,

applied to nvme-6.15.


