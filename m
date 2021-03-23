Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A8DC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3DA61990
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3DA61990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GyCOvwY3vccCd7mR2SGSYobYjITZaTs+4LwF6GTNTf8=; b=XYOVrF+5XIe8ulySwz3uOMhIE
	WqqzpG1LiMnuWYy5+1QegxuMz7Keg2RwzhQg+CTmVW+BBKz8Wwd2qs+J+qjdqsXTiQwgUHg0lkqME
	kTYGxmwF+PfaUxvEc/hhZu5pPe4c+6Qce1TpVXpbFJfFrCRgRLLgFX/szZprrlAE3aI0B+2dpgBZH
	UdGLrzYJMnDFAgr/+2Ed6giEjktsKyvxyxlZZvvwTb2IOCJVNtq8MEUucdouXr7F/wJ1EBIH46kWq
	ur8tq3+iVMrPaeMPg6uUYoI9OUlpGBE4ZEwIGFR/+JXpujwsNTSB3ngTZcVqs4R83TfQOMKMYnxhl
	SbvQQcTtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOjiS-00FILd-KR; Tue, 23 Mar 2021 16:17:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOjiL-00FIKv-3w
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 16:17:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 81F2068B02; Tue, 23 Mar 2021 17:17:02 +0100 (CET)
Date: Tue, 23 Mar 2021 17:17:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161702.GB13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <87a0ede6-b696-d34d-e74d-56429fe32ae7@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a0ede6-b696-d34d-e74d-56429fe32ae7@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_161705_346237_9C31A309 
X-CRM114-Status: GOOD (  14.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 23, 2021 at 04:13:09PM +0800, Chao Leng wrote:
>> The above reproduces with the patch applied on upstream nvme code.The new patch(blk_mq_submit_bio_direct) will cause the bug again.
> Because it revert add the bio to current->bio_list.
> Just try the upstream nvme code, and do not apply the new patch(blk_mq_submit_bio_direct).

Indeed, the patch removes the deferred submission, so the original
deadlock should not happen.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
