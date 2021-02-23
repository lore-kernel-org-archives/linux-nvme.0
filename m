Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44379C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 23:22:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD81064E05
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 23:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD81064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YueL68pXYOARZvcLjteeGFJ6bL2nCZNUpl0XBN5EDD0=; b=FFfEkPQiUDtYYDkEk6wJUTUMT
	01yH50ZKnB6qjfhntUONK+53bHBpAHpU2UqYeDDwxI0Pr6vZKGEtgyt8xoer2KAiT2DCchQ3Gl9vM
	8Y5STgm6XZJVBy6k1dTJ5L6BZIJJgrAc95oC1CqGB5IoJb4A1QLVjWxFl6muGWent3famj152T9S7
	zHaCA41+90wRVsAaE+P6vkJuyXw2TDERDE8ArVSwCaYg9xJP88wP8zAWPJKMGprq3sXn8XTaMpElr
	yaCpR+ywMP7UXkXv4NBb63ySs9bIM4tRlZeLp7rVoq1HQUo8AL06600tIOqfNdAqS0AvldGIrkJMg
	kwYOODJYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEh00-0002YW-Gl; Tue, 23 Feb 2021 23:21:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEgzx-0002YA-Le
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 23:21:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F8E764E05;
 Tue, 23 Feb 2021 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614122504;
 bh=DHQY5VOhQgWugHDBTaED/kPS/C+Hwsvci8kCZ8A1oh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1a9Rb9OwZJYHoOyOfm4dAFIMKU2X4xzGh2IuVl5yfGN5yXFNIW1KWtWMtDeh51o/
 oac6JAYt2ovf0Su/c12dk/SqzRKOovI74xo1AG/MDkLXdxqSXUkuiv8rklH63pNbQn
 /PYmgBUaiu9B+D7aQkhO0deAX+1C4x83AlXFmXAd5M08Q3nI1z53r0g56t2Wi4cmI8
 auq6CFBav5zlKTFCoumaH0/rwU686W6sJn1u5d4dAwuFOZHBxJZWJruutMAZZ5i7MI
 f5xjqjm9XbSBvWm2O+DXsY9L4YhFzZGeYSuHGpCW6A7gLyQKWTM1rPAnjDOn7YVxAk
 228Jp97NuPvLw==
Date: Wed, 24 Feb 2021 08:21:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Message-ID: <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
References: <20210223072602.3196-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223072602.3196-1-lengchao@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_182146_087833_4F8D8792 
X-CRM114-Status: GOOD (  10.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 23, 2021 at 03:26:02PM +0800, Chao Leng wrote:
> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
> over rdma(roce) reconnection, the reason is use the queue which is not
> alloced.
> 
> If it is not discovery and no io queues, the connection should fail.

If you're getting a timeout, we need to quit initialization. Hannes
attempted making that status visible for fabrics here:

  http://lists.infradead.org/pipermail/linux-nvme/2021-January/022353.html

There's still some corner cases that need handling, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
