Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED00107637D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClPzcLGfiqcHZI7bXPOSuUHtKvOehC2Whs50HFnOiSs=; b=M7Lk2oFxgOT/j5ajyTRKJxw5bJ
	tSAiWR1upwtZqJ+1g8Byzfla1Dm1OXBSm06zyXvbQ+EZ77mqZC3gD9WbayT41HxbxBFHu/t6jJLj4
	WcqM72bWfmgtBEz5QvosJf94yx1hhIC5GE1uqgGFIZQGVIHV+MNmkycEQ1ZHOPEMsyEgnpEToqJoU
	xxinqJtCpsJqJOEWtuLEw8DVAm8rbL8SxnqI+5W4B6KBKnAbLb8xCtm66wHZAd7etslr1cEGCq2gT
	eLzof8dhPWAHqmYjdb9ptQ4iVsZF3CScncf1+Hu2cE6IgueKpZQYZWOjFCRd9IaRcGKP7uhQGCY76
	G572qdOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPL-0000000FTJU-37HK;
	Wed, 01 Apr 2026 14:18:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPK-0000000FTIN-0Ahu
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 14:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ClPzcLGfiqcHZI7bXPOSuUHtKvOehC2Whs50HFnOiSs=; b=OXkk8sTpetmADkyEQBj7uEFZSP
	78mCb40p0pwBWpfKCdxlhHl7+UPNGmS/KCgQo/NeMr7mrTj/JuZtkvl8y2u6EJXlxhn1X21NgJP2D
	dNK8UCD86JNs2kXwFeCpnvmrcasVMK1O1TYhexO3cEt28VbNRa1Mpi7UJAs1FG7U7aBcOUIi4rQGM
	kF8l3hr9uHVBWGHdXTcYW0q+miTiGYaVanPsxk44QnQ0OXNZRE4oDVmTSOIdJGhKEyx/b8gTn1HnU
	LH4WiAsKPs+rrIIE2x3RZNiLQ6piBpM5JMRtn2C1K1RuvQ/tkwBPYn+0HaBOrdG8WZy28F2qyCSBx
	wptwShcw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPF-00000000aTg-3tI6
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 14:18:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5059868BEB; Wed,  1 Apr 2026 16:09:34 +0200 (CEST)
Date: Wed, 1 Apr 2026 16:09:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: expose TLS mode
Message-ID: <20260401140934.GD21703@lst.de>
References: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_151854_155453_2CE33C0A 
X-CRM114-Status: UNSURE (   8.94  )
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

Looks fine to me with the example fixed.


