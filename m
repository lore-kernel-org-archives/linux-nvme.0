Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFC3C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 04:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=Ks4347A6jHIFH7iCwFgb3UCYpN
	s3i1SlF25LLlpARb0daYPsbr38wWkcVcfSbSDbiHXi4as8R/Bj6f59Xs9VumzIrZ2G6eJ2BpWx2hn
	BapWsMKlWGS9bYhWiNcvUno6GXBfJdCTcsYyx/uBg0sUs9Ns5ZZSl0vIb+fpk0VWqWtHI8eJSAZvz
	8FM8w5z7BKhxPKdPevS9innD2jbUQDOZQwMUEGuYPWU2D67VQxPWa7OwdK14SN8F9oStWkMU39NvL
	QnqFZXgV/n2GmgXQYFV1LfKavgsEKrSBx/otMkOpDeEeWvJDUuAmL7mwNEJseUNgWl4zpDAoQHS60
	YmVxUDrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqD-00Awqh-Q8; Mon, 18 Jul 2022 04:58:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqA-00AwpB-Eb
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 04:58:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CE9568AFE; Mon, 18 Jul 2022 06:58:31 +0200 (CEST)
Date: Mon, 18 Jul 2022 06:58:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] nvmet-auth: Fix a couple of spelling mistakes
Message-ID: <20220718045831.GA21700@lst.de>
References: <20220715132413.301017-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715132413.301017-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_215842_702838_AF23FCD0 
X-CRM114-Status: UNSURE (   8.18  )
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

applied to nvme-5.20.

