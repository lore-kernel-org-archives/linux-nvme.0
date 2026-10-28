Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF63606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eLOfe2Uq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7C2dxR+nSVKI6ig9BzzXD4gecQSomoKQXcjtQPbdAnY=; b=eLOfe2UqKfIHQ+3XiYLFOBYC6B
	MC1dvdazvdqx3PRE4yA2bappfKOpuV1smppqmdvEWF0ojoDO+ae7xx4oaV8YfDLj6rAje1z5jVZvF
	1mn3x13KjBjqKrUZF7Hzub0rq9RfxcLlplf5V48zllV7oP2uQmBmS4VlvXjzJrDDhtqkXtwRHHpcR
	FGyapiD1tnrf83imPP66hgTA3PODbbjemnW/ukm8aNk5vKB5yx8GALkQiUqhxbuOun9O2gVXEnqzU
	QDgr3dHhq7GZKi0vFtrI4v7hDD7g3AVrQ6MiLlcAMzSuGMeHcrsXVNC8/XMVo9aVU+cCC1wJUEYF/
	SKeTLNYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4oB-00000007E0u-2URo;
	Wed, 28 Oct 2026 14:39:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4o8-00000007E0X-3RHi
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:39:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3620668AFE; Wed, 28 Oct 2026 15:39:12 +0100 (CET)
Date: Wed, 28 Oct 2026 15:39:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiale Yao <yaojiale02@163.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Armen Baloyan <armenx.baloyan@intel.com>,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Anthony Knapp <anthony.j.knapp@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Max Gurtovoy <maxg@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: serialize port attribute updates with enable
Message-ID: <20261028143911.GA13737@lst.de>
References: <20261028051329.149005-1-yaojiale02@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028051329.149005-1-yaojiale02@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_073917_006820_E6C95F2E 
X-CRM114-Status: GOOD (  10.65  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 01:13:29PM +0800, Jiale Yao wrote:
> +	scoped_guard(rwsem_write, &nvmet_config_sem) {

Please use normal locking primitives instead of turning the functions
into a mess with the guards.


