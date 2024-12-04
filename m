Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EEDE77166
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MQaEF8iizb4BpXJrN3y2FS6Sxc
	IE/1ozb6R61VMqB1IR/KMAP9vV9QjU/OOsNKtwAqg4o1Zcjx8Hjx3C+zqSm/CIj+KI6kfIF+iQ3bA
	EP9JjDFbIsoNDIqgxb5heTruUnAeVZK2Bk6+bUADcnTYYMUENwtVMlrrAlkAEySRblwRbMd1YU6I1
	hwNPdT6F5EfGQyRg0hTAwMmY1v32WbK9iu5NjHWgBfN6m/+vG5m4cN6K3viG7/2mFQ0Be868vpsg3
	HWWZwUvu956G+92CpTlkS1QavO58mdBysum0FaZvcivz5IiNtx+VCxbwB9rQUdtyqA2WjFsJb6nhi
	x4QWRHsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tId7E-0000000B6a2-0FCJ;
	Wed, 04 Dec 2024 00:19:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tId7B-0000000B6Yi-2InA
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 00:19:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 040BC68D07; Wed,  4 Dec 2024 01:19:31 +0100 (CET)
Date: Wed, 4 Dec 2024 01:19:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kanie@linux.alibaba.com,
	kch@nvidia.com, loberman@redhat.com, emilne@redhat.com,
	jmeneghi@redhat.com
Subject: Re: [PATCH V2] nvme-fabrics: handle zero MAXCMD without closing
 the connection
Message-ID: <20241204001930.GA22531@lst.de>
References: <20241203125732.393992-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203125732.393992-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_161937_718939_2F5649F3 
X-CRM114-Status: UNSURE (   9.00  )
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


