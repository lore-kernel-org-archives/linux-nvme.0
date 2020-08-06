Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698EFC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:45:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEB122DD6
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JAuS1gnY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEr9wZma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEB122DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tO55PUpjmeJ5SNaZGd8J9iz2FNA93u7jMVGBOtSbzq8=; b=JAuS1gnYeT410spgI9JvH6GbX
	25JaGZV5RrCQe11Y8Es6CFUhb08TsCgz00l5eH1b7yVXOj2g6imrJwPdI0LG8ibX1dkkaOk2pHDjj
	Ui0okiasAwqF9EmUtW3xuMOEQKnTeKLf0a5sLSUqDQIk0R7dTQSjxG1DjGMnihGgJYvbzmlP/OiVT
	MW3+gsbMKLprSZjKSGUyZjXcpurc5A13QEFqidg4uzjOeB4uR8qoPuFBPirMr6ZV8/Jk59+BHGFTR
	/tDPwfElM0vnO7QEyU2cR2KGfGysyz7PiZ7MjN+uNPSpY72i3AN2A5gCHJ181etsZrkr1/rGwPPi/
	YBSnaZTOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3i5b-0002lu-EK; Thu, 06 Aug 2020 15:45:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3i5Z-0002lQ-Vv
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 15:45:54 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3251022DD6;
 Thu,  6 Aug 2020 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596728753;
 bh=dqHceTypRAvdl9O1TapfJ2fDq44NtS4tKZVbS9B1cWA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XEr9wZmaBFHGgsHV+drVgpT6CVIwhn1Uu2GyuKZqXPuZy0G4hBZPYWCtnEFHi2Q6R
 sP7hVpFYp6qSUD1+4JO0JAGN/fIX+n5thwV+EBNbTfzZX4xM2QVxUlvSGnx4eER4Ue
 mdfKP5FhpRmHgCSpkPVJHfhtOZTBjzjdDCD501vM=
Date: Thu, 6 Aug 2020 08:45:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/2] nvmet: call blk_mq_free_request() directly
Message-ID: <20200806154551.GC3075319@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_114554_109066_D09DBF0E 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:31:51AM -0700, Chaitanya Kulkarni wrote:
> Instead of calling blk_put_request() which calls blk_mq_free_request(),
> call blk_mq_free_request() directly for NVMeOF passthru. This is to
> mainly avoid an extra function call in the completion path
> nvmet_passthru_req_done().

This is fine. blk_put_request() is a left-over function before blk-mq.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
