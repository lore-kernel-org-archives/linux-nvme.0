Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95835C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWmlBtyptY+plAaVq4BQEwn2CfxRQQFBai3Nu05N0aw=; b=V9Dstfop1PQQD+jpKNHmrVtGnw
	K8Jvavq3GZWC6h6ANXiQuKUIpGpjvhvMrohvqS09BpzVBbYYV59burX1wICp3rmmw2k/tfB7Kk7/n
	7U3Y0Ghr8V1iyqO1Gp/u/KhseK3EHZfY17DXC3fCuvqyKpcBKmv+Is+Y/ypmMQWYz/gKSf1XrOfis
	RsMC12NAYbqOTd+glmmuxR9CQ/o3Zk+xxOA/kd8mVIjdhv+S2dcCZaULwBavM1XUdJCK2sKaxCobc
	n5+Bcrf3VBtV3dCRG4EosmaBiK8ng5v8o1F5pQqiEuZxej2nxsTMkHfzXbezwYZTCIIffHaAQMyig
	nSrWEhuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchSo-00000004Rcq-2H4I;
	Tue, 28 Jan 2025 09:00:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchSl-00000004RcT-2guS
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 09:00:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EB7D68D05; Tue, 28 Jan 2025 10:00:45 +0100 (CET)
Date: Tue, 28 Jan 2025 10:00:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 05/10] nvme-keyring: add nvme_tls_psk_refresh()
Message-ID: <20250128090044.GD25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-6-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_010051_821204_F8F21F8F 
X-CRM114-Status: GOOD (  12.40  )
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

On Wed, Jan 22, 2025 at 05:58:24PM +0100, Hannes Reinecke wrote:
> +static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> +		const char *hostnqn, char *subnqn, u8 hmac_id,
> +		u8 *data, size_t data_len, const char *digest)
> +{
> +	return ERR_PTR(-ENOTSUPP);

Is this supposed to be -EOPNOTSUPP?

Also the later added callers treat this an an error.  Should this
stub be reachable at all?


