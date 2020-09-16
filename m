Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354DEC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A2F21941
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3W6qKs7C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo9JRApw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A2F21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ATVNH+gAepwDF8Hq/pti09ZRAXbZAzvb60PbR5NhLuU=; b=3W6qKs7Ck9JH3bKUinOSrt5wL
	zfObrIgZTdYgpddUySwLOiGtKATq8HHq03IT6jZcqboS1ustZjJdyjEfsKI1qrpTVLQMFj8dtr03t
	5quYo5TM73GIUg1/VuboT2SQonLeEOeMVn56hRd2QWbrtPpLiShaj0oyA1rU3mswTUSH/uQTvaYPm
	V82g2b2eVpGEEF+Yz3yEHdwJjchfe2ew3NilKCbIT0tdWodniA1WiWQF0SWBK7G8K3mtVvDDEDU1E
	BIbjKmMa2AY+/ohG2UHz5DFlFsrpPuvirl3WvkHdTCvGevitjBUTSJXAhxnJ/inWv/LZoA83oNDj/
	CP66HAmHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIeUd-0007SK-9n; Wed, 16 Sep 2020 20:57:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIeUN-0007HF-9J
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 20:57:20 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7ED320731;
 Wed, 16 Sep 2020 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600289833;
 bh=W4Wu8jELF7OY6DzUZBd0rnRK2ouwZ1XDaX0Ot7d21dI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vo9JRApw/uiEpIBhXFKubew+BHzwwyAxBnYVR0vBJfK2uPkwfWcyf58PbEG4zRDeD
 j+Vl65NGLreHOsw+F4usb7g8ZKYGFlhh1j5VxwBI8gzU1iG65dmhwXN1byoCZtCcBz
 ppAWHOSIIa6q3Mt5FbpzjtlV+eUUH2obhgQrisYg=
Date: Wed, 16 Sep 2020 13:57:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 4/7] nvmet: set default timeout for passthru requests
Message-ID: <20200916205710.GA3676296@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915215118.3934-5-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_165715_433189_EB357EE2 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2020 at 02:51:15PM -0700, Chaitanya Kulkarni wrote:
> @@ -242,6 +242,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>  		goto out_put_ns;
>  	}
>  
> +	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
> +

Any reason you didn't use your new nvme_default_timeout() for this
assignment?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
