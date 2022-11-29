Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C35DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=tWMO5FPG9LV42qYA7EFnQzJBsP
	h9T1Af9NMDpIfIa+9gx6fDTFGoM8x6rjla68I9Gfx2CMPPR+tT6TTp560F5ufL1/isiMrvCBms89Z
	Aj+JnyzbqEUqhB61o6FXQshT26JvMbHyfMpRxTiw0UfoSey96C20hAMxmH0zVbJUR+Xesoi2MbsM4
	eq/nwQ/9oY/oTQKlXssRMeR6JUzjNANJPtkTwhinjqGJM4jN8qq3s8uFsFBzp2H5zGBXg0rRvRD2G
	f5EMfHB1LDQQOouuCHMnm/rj8dzf9WfrSAxgs+ceuFzpNsGfrgtlSqqObLf2+qbopD3S0w9vQo1pd
	peUHYjfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwH5-007Vc2-7D; Tue, 29 Nov 2022 08:47:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwH3-007VaB-4V
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 08:47:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09F3D68AFE; Tue, 29 Nov 2022 09:47:26 +0100 (CET)
Date: Tue, 29 Nov 2022 09:47:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: sagi@grimberg.me, hare@suse.de, kbusch@kernel.org, hch@lst.de,
	axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Message-ID: <20221129084725.GB26082@lst.de>
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122044929.27600-1-zhangqilong3@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_004729_333695_FAE04A31 
X-CRM114-Status: UNSURE (   8.64  )
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

applied to nvme-6.1.

