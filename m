Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D045FC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Nov 2021 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ky7CrhQYRstlhwDriLv44uQdeNIz9jqsrdOoNB09X0M=; b=xQs73I7JPeJZIZ7v+gPVXZ1C+b
	WcX6xHc3xrlPfFIXblDsSiY0/RcxxTNETg7WnG3bHbeCZhQ7ZbYjt6A7AWNYbiccU0S3ZN8jeffvJ
	YtexRdhGtsqDr7V7AojMH6QKq0MCeoemtjGPCsxIbsQI1vPu4jHXgRqNKlv32QHVBu38y2hlrFHyR
	2M0P+c89l+Ylvg1Pw1VnER+7i9/RGGxxVzsc/KYEUm492uT2mgm4+/MG3B5bBAm8ZaXgbwfg+0vQ0
	EOl9VeosG6fVYoPH+cq2kUb6zOBMEqZfY1GPN80PPC8K91bcTHw35NelOz8/Y9yl5Nw1ywhXVNMk6
	TfOru1WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1monmp-00DmTf-J3; Sun, 21 Nov 2021 14:25:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1monmm-00DmSR-9C
 for linux-nvme@lists.infradead.org; Sun, 21 Nov 2021 14:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637504734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ky7CrhQYRstlhwDriLv44uQdeNIz9jqsrdOoNB09X0M=;
 b=bn6B3EiW2w5z9OdiFBMXKWfxtG1pGKIoj0KoqU25aHPu87TbQkVsbo6mB9KEfNdbiBzP56
 VN/4fjZCR6ccvp7ukaQDauV7uMu2AIFRDYmj0N5Nsti/c+MFQjl6Qsg0uOIPtwIC/MV/W+
 sct7ndJWPhoH4fC7UljLEio3szvJxZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-yf2SgwNcN7-bHfKcHe9EVQ-1; Sun, 21 Nov 2021 09:25:28 -0500
X-MC-Unique: yf2SgwNcN7-bHfKcHe9EVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 392FA801B26;
 Sun, 21 Nov 2021 14:25:27 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C331C5D9CA;
 Sun, 21 Nov 2021 14:25:25 +0000 (UTC)
Date: Sun, 21 Nov 2021 15:25:22 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Message-ID: <20211121142522.GA255554@raketa>
References: <20211117152454.122014-1-mlombard@redhat.com>
 <20211119170233.GB15360@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211119170233.GB15360@lst.de>
User-Agent: Mutt/1.14.7 (f34d0909) (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_062540_545798_82BA58A3 
X-CRM114-Status: GOOD (  15.76  )
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

On Fri, Nov 19, 2021 at 06:02:33PM +0100, Christoph Hellwig wrote:
> The proper fix is to check if the file has FMODE_NOWAIT is set before
> using FMODE_NOWAIT for reads or writes, not to blindly disable it for
> reads.
>

Ah thanks for the info!
Now I see that filesystems that support NOWAIT set the FMODE_NOWAIT
flag in their open() functions.

So the correct patch should be the following:

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 1dd1a0fe2e81..bf3f440c98d5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -266,6 +266,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
        if (req->ns->buffered_io) {
                if (likely(!req->f.mpool_alloc) &&
+                               (req->ns->file->f_mode & FMODE_NOWAIT) &&
                                nvmet_file_execute_io(req, IOCB_NOWAIT))
                        return;
                nvmet_file_submit_buffered_io(req);


I'm going to test it.

Maurizio


