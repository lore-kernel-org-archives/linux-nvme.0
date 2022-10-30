Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3667FA3745
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CqVB1JJ1vlzmHE8JQxjvlUZFxKgZKJq6LH8REyrLEs=; b=HpGWY0o9xhstDXJvK2pYpZwBNK
	9kH0cXgp317m+tU0u3DOBawr2vwItW45bQepY1x/vjoEO/1t6Er6yGDW4Hc8DQQHklplTaS5bpbLc
	AtGN+8zVDFVQEZBdHJqX7G11RW6+n3Yue9LsUZCBeDKaJx8KNdPlnMbuNECRTm7kyyd/9+nGExQGH
	zDLsSoCuy2XTjOFAjkj0wnKaZb9qmJ9xndvf7TnFa6Qet0nXhr2AGd8kZgd+yxXQwCxrlT2+Mp0QK
	nJQE3ORFpX25Jh3JbgOlngMXjIAZkciDltCBK7Z/SM3WQglKDtczioEnmnk4S5HutokGyFti8Pj8r
	1/Y6QTMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3Wz-00E77e-WA; Sun, 30 Oct 2022 08:18:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3Ww-00E75t-VV
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:18:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CC2A68AA6; Sun, 30 Oct 2022 09:18:52 +0100 (CET)
Date: Sun, 30 Oct 2022 09:18:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v3 11/19] nvme: Add pr_ops read_reservation support
Message-ID: <20221030081851.GB4774@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-12-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-12-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_011855_206051_E23F9CC4 
X-CRM114-Status: UNSURE (   8.60  )
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

> +	memset(resv, 0, sizeof(*resv));

Is there any good reason this isn't done by the caller?

