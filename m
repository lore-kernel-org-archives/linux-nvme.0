Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA9F221FD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRuhDWy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA9F221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p7IU2l+HIdF7f/yJ9q9+Y3EW9dTFtLItAPbKZPyHlf4=; b=aRuhDWy1nTBXOcWTV/QOwvgiU
	UvpUMjOQ0MQcpKh1Y8V9/NOzBF6MutBfn0Sm2g9W6N4za+VPDBE0uTOsr3/x0EEAeYgICzaCeAymB
	678XVItuXDGqenueT4EaOsM7rX+Pz5aD9m9SwqJ8uQ5xDQHv6B0SFxQrVjYkMufb8V6Ma6bG32P4A
	sAsI2TnxKY0aKga87sDRCCuLKbgoeVJyVYTTmINQbsDRXzgnc+WBODOmi90WEabQtWOxLiJOgysTj
	SWSnxYXWBkV/ZlGo6n80MaZ0FehNyr5ZCjL1ebT9X87XYNHJiW+X/fx+VyycmdBaz1N/rr6f75bKF
	b3Rmyn3Zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keiIA-0000Di-Rb; Mon, 16 Nov 2020 17:27:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keiI8-0000Cr-08
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 17:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5790F68B05; Mon, 16 Nov 2020 18:27:46 +0100 (CET)
Date: Mon, 16 Nov 2020 18:27:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint
 triggered by request queue flushing"
Message-ID: <20201116172746.GL22007@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com> <20201113012722.GD1012796@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113012722.GD1012796@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_122748_179262_4203D9C0 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Qian Cai <cai@redhat.com>, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 linux-block@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 13, 2020 at 09:27:22AM +0800, Ming Lei wrote:
> >From a519f421957a1205918e9bcc15087d15234e4e9f Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Thu, 12 Nov 2020 09:56:02 +0800
> Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
>  request queue flushing"
> 
> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> 
> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> locking' by nvme-loop's lock class, no need to apply dynamically
> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> lockdep complaint triggered by request queue flushing").
> 
> This way fixes horrible SCSI probe delay issue on megaraid_sas(host_tagset is 1),
> and it is reported the whole probe may take more than half an hour. The reason

There are a bunch of overly long lines in the commit log.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
