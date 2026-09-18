Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE54C982DC
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=B/kPORuZRvRKVIU8qcnqJH3KNq
	Ydv6uGKQT6cMktf1nQIjQOaIjs4q9JGCZfaxBekUGxoj8SLOJjX3DKJq9JXLmVnaW4J0sARp8WmVz
	WzuE0vDNnfhCEtZrw09LDMZV0q0jo8R1Q4X0UFbT02Q08O+PcJU29wWX7xS3ZPz32mV4dK0NBq120
	xBEpPqTmp2tORDSh74Fz6h/Y7pzMRMcORWpqVarQWzIzxMIDpYxvjunA6bEWqj8ljTxjnXne9u72D
	e3C+3w6+dhUiJW8SlHqVa6al0icYpJHrEAc8iIFqyBjwd8MENxV/ZGk/T8EOMmTVwwlu3wqlUHhB7
	OlmuzEuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XQZ-0000000EKwT-0PSR;
	Fri, 18 Sep 2026 12:10:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XQW-0000000EKvn-1ZnV
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:10:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0325768BEB; Fri, 18 Sep 2026 14:10:45 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:10:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: fix underflow in ANA log bounds checks
Message-ID: <20260918121044.GA16650@lst.de>
References: <20260915021956.3142320-1-4ncienth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915021956.3142320-1-4ncienth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_051048_565398_D9EF6525 
X-CRM114-Status: UNSURE (   9.14  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

