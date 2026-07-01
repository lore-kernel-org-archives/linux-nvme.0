Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527EC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tl6zJm5WNPjuBJOl+PM4LRxgJu
	KGDkEHiBjvF7tJjDnAduc3XnLJVQty1sUCUTMP9Ur2nWQ5AmOCos1roFPKrjEhjQ4+9ZHqosK8IJC
	9RQKNHIejUEQ6K5RnHvaZ20KoL2qqGs8ZrIq070ZVtPmkXlHd38boH29w0xi5wUyUqdL0UBhvUbMV
	RpIKvxWAwqbH5jT6k1lV+TQrtFWO6jGZgujQxjPzv6u1y2emavNfMUU6fDlPbSYcHMPqqAIx6JN6M
	ES+SxVZ2IucMzj2k0q2huWC1wl1DTBU5K6eHrHSAh5wpYpC39OcX9B4Wej2hhxuIHKHG/V+MUXn/L
	DkmhQ/FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesS3-00000001LU8-26kv;
	Wed, 01 Jul 2026 10:45:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesS1-00000001LTo-21LG
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Jul 2026 10:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZiiWU5uzuXybltLCEolYka2B4a
	Cwv5X5x8P0E6kl6AB/xtZYoq2mU+UBpbFjlSP/n3aL4FiFqvUgdLEGwUS98WGZ2IVWocSU6D9YH+i
	2S3lqBTkrE86WLjEGLWEKDqJmRq86xPpjqbLMUSvL8Y+ZGkhxmGr/8+gRe60wO3v4c5Tln5NT0YZh
	ja319kh4M4zyhcYOHd+Oi4umj27dj0Ygcme/KgBV9NCldp4QL4iPx/FhPr5iiOe9oC3YasXqp7O7g
	91pWFGjoOb44q9H7gXGRqAbfIJVmsMmSI2Z5qjbHCQzmspzq/PwyswXnfpK6LubovUBl+28CAkZh6
	L8y3z7WA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wesRy-00000002de9-1xRr
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 10:45:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0621868C4E; Wed,  1 Jul 2026 12:45:40 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:45:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: handle positive error codes in nuse_show()
Message-ID: <20260701104539.GA13474@lst.de>
References: <20260630102717.2671475-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630102717.2671475-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_114550_670852_71505669 
X-CRM114-Status: UNSURE (   9.53  )
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


