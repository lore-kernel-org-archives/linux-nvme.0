Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EEC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 21:35:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2865320796
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jufHRDoT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1zOb72D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2865320796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uRMq/hqbL8lHPZVp/eXzwt++5/CB7QWWzskafwR2duc=; b=jufHRDoTTGbHYQhotJTQtdIah
	KSue03btj05WQKZaYQeT++urZ1IfrSQ76jRqk5WnaCePQRReNSF17qlMTDGved0G4jsKjF7pgwvai
	g0UxIebyjpck5OwZ7j4glFec3pC3EcWvIB7IPwlfyPmbGM9Hp8RZSDc6Mo1cZVMsa/YeicfAXvg4e
	kizA5Z6BRZ7/5NXewaWrWrNL8pl9Mq1bEw58UMvv53icNlSqg/uJ6rdycdLHuSeC7c+8xfPGszjdk
	nH+yYYCAnt5rVulRrw/0cLc886ycb6W0GVOlH7S2qbA3xPQv8RzwrIUJx/b2legc7QuDOqho7AbVx
	smOsjImJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO6EO-00027l-Nh; Thu, 01 Oct 2020 21:35:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO6EM-00026v-Ru
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 21:35:15 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9790220796;
 Thu,  1 Oct 2020 21:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601588114;
 bh=+in9bqeNJdOY00AtJIE+Z2/ko6AqeuNU4Bwr96nYKGU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n1zOb72DjUpFtNt7UuB+FDhqiky/ONU2YoU1MFJ745Wyn55tBoiMAokWC9RTOocgh
 Nh14AUEoU9rQjT8L6n5c1gOIvHcWTOORXQ4g8NvXUqqJKFa1hItMW/4iMtdHm2RbTI
 3h74uqnMPsVcq2TM76vEMXHmVxTD85+YRiTTnMeQ=
Date: Thu, 1 Oct 2020 14:35:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
Message-ID: <20201001213511.GB565143@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924205330.4043232-2-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_173515_038624_10545B78 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 linux-api@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 24, 2020 at 01:53:28PM -0700, Keith Busch wrote:
> A zoned device with limited resources to open or activate zones may
> return an error when the host exceeds those limits. The same command may
> be successful if retried later, but the host needs to wait for specific
> zone states before it should expect a retry to succeed. Have the block
> layer provide an appropriate status for these conditions so applications
> can distinuguish this error for special handling.

Hi Jens,

Just checking in -- do you have any thoughts on this, or should I just
wait a bit more?

thx,
Keith

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
