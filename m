Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3080AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9MvlCJWQOm1aFAiAkdTfXU6ukFOu/4d9pEHVVXMiDg=; b=zu3m1+ejENpkdOYsB/k3bnNm9C
	ehbQ/2yQ7JMnzydCwZpiOkwQIGLBP28ecITisuj8o7YP+RqRcVlGkUMX0bG2i4aAVza/j5TfmYLsN
	kqfb8qWpACBtC1+/RXKHCLB4fRi72MG85As++3jxnJdmC0gTan2BPk+LudcR9Xv/V4iJKg4951d5t
	6xa8Z8H8Qn1HrncuCQOjNpq6ZMNPtT46A7PR70c0a6TIeiDYafzAcbeUZhy3Zki4xjrDFM80Q8Ti2
	w7SI1j2La3LPv7uRQgfZPmOiiYaP7crAAecawFaI9++KxRqiCdktGyVQhQ7A0VQFa9pKrzvjKnP5r
	1gaIRWJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwY4-007fRP-LF; Tue, 29 Nov 2022 09:05:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwY2-007fPh-0L
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 09:05:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 026DE68AFE; Tue, 29 Nov 2022 10:04:58 +0100 (CET)
Date: Tue, 29 Nov 2022 10:04:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221129090457.GA27310@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me> <20221116132225.GA8071@lst.de> <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me> <20221116132805.GA8496@lst.de> <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me> <20221122123154.GA5610@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122123154.GA5610@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_010502_250936_61643A30 
X-CRM114-Status: GOOD (  14.30  )
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

On Tue, Nov 22, 2022 at 01:31:54PM +0100, Christoph Hellwig wrote:
> This would be the queue_count version.  I have to say I much prefer
> the tagset check, as it is self-documenting and matches what
> nvme_queue_scan, nvme_cancel_tagset and nvme_cancel_admin_tagset
> do.

So no comments so far.  Unless I hear more feedback I'd prefer to
go with the ->tagset checks that matches what the other code is
doing and also is more readable.

