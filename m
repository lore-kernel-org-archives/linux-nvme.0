Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C2DC3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZjMxrhZX3PqZC48WDq0iIbfVoV5QzA01VRsQ1C30T8=; b=xA61c6PBgRszUQiTskgWAndnnx
	iynQGuCAt/uAJBrOhPmjg3N8FSm9RPRwXnjP8J4TMvzEjgVuZdzSmTCtjxON9Rzg/5SZUAYLfVPqc
	jH3a/gkyu3CCDGqaTrSWeX81/7brtLq5oZg7dWYdtYrX5Tn6Sgs/iy1eCFsE09OJ9+GuF+fLfFecK
	7Yy+Ywm9PxdqjWxJh6Wota6mfrjlAc/GxgcHKK+Ae9IWcwPqS/8l0u6vAiJnTez1kGcmOo/glCoVr
	kua432gp8lsV1uWrU5DYrqbZt2lc0qHJusFSyKUGGbWacRLY9AgfBZf/mlGznnqK/IKBlNv622P5z
	UNdSWnbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mh0-0000000A4vC-2Sqz;
	Tue, 29 Apr 2025 15:16:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kiU-00000009jpy-2oI9
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 13:09:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE46068BFE; Tue, 29 Apr 2025 15:09:37 +0200 (CEST)
Date: Tue, 29 Apr 2025 15:09:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	csander@purestorage.com, shinichiro.kawasaki@wdc.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
Message-ID: <20250429130936.GB13970@lst.de>
References: <20250423060621.632581-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423060621.632581-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_060942_840612_195C5381 
X-CRM114-Status: UNSURE (   7.18  )
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

added to nvme-6.15.


