Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73F9C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=33foQuKgXJEeYpqXI7wcOD+kHw
	5VpMBs6W/nlNWPYyAinJqJGX5YDNtT0fZrliEdBNJg790L91Ee57JrgQNm0BVT8utH+gUPzvpNGnY
	fAS3S1ZSZDMGBbwM4BzSM/kK80EEwZqQ9ZD2nDq99KYZzP4bMHmTz8nMWv1A0dSM7CHiCo69UnTRf
	SzcmbBsOCxvbjBJIscbhJMsy3NFJ28p5ZNyArzqhgxktw839dahEnCU+b07kToDkQKh5DORnWb0dr
	fDO9iqTjFKubKe/REGvMXZt4qj9NJlEEIRfe4jb0sziXCW+AwEOjxuxgxO56gSO3dOVObprZyMMIj
	J/A3kuXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUBL-001zlC-0P;
	Wed, 12 Apr 2023 06:42:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUBI-001zjr-1m
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 06:42:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9820C68AA6; Wed, 12 Apr 2023 08:42:04 +0200 (CEST)
Date: Wed, 12 Apr 2023 08:42:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma
 devices
Message-ID: <20230412064204.GA20294@lst.de>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_234212_754908_9D25F5A1 
X-CRM114-Status: UNSURE (   9.25  )
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

applied to nvme-6.4.

