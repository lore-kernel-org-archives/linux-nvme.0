Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C813C636CD
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=x07rfRxN09mMeAV6sffTDYqRZ4
	2YA2fKMlVl8a7yL+gzkCgHPXlP9A28YX7jw0kylBX+uwfKF5ISfLIITPnR97zg2rLuM9Sz6tYlL0e
	msuTzmGm+luJ0itVCZYsv6Bzos3Y9zEjrp0i9Tcd1ULZQESbpHDZfwFm4Ure3Ch/rn5JhmN1j6v8B
	EKv+jXn2criYDm7WtReVE27479ZRvxus0H+f5rdvOKFTjYIFAJ25Zi60pQzQkOuayhhXTyQo5migN
	mBe6B9hurHRIcuv30d3hkXrss96CusXQsZLzP26DwFP7pSV0Ql0RH1LAoo5qqEZ4f1Oo7J7sqDKds
	rKYBv9+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND12-00C0eR-PZ; Wed, 01 Feb 2023 13:19:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND10-00C0dU-Fi
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 13:19:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADF9B68AA6; Wed,  1 Feb 2023 14:19:02 +0100 (CET)
Date: Wed, 1 Feb 2023 14:19:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix potential invalid pointer dereference
Message-ID: <20230201131902.GA31444@lst.de>
References: <20230127154237.349113-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127154237.349113-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_051906_687648_BCFBABB8 
X-CRM114-Status: UNSURE (   9.03  )
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

applied to nvme-6.2.

