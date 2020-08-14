Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614E9C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:49:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECCC2074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9l8P+vv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx+CZz3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B+PDunWDBnErQhtVUUOmJphocUzrqjvTEO01h++dtYc=; b=H9l8P+vvIhZXkcKCEL1zNIoiK
	3q6DKq8mcNClEeB4prxRmLADryCAZXcK0G4b+gSsZlfzDISwncw0hwWCvqrtOFVpMtP2flznO4DRV
	suWvwBqxpYcCeK6wArrJRYMuKZLcqTiX3p4Vf0Nv6RBCDd1mXtBcxqJ4BMUxosIaMTX3RY1ER/WJB
	7BB1C4giGvJQMDj382rSQzV80CxLYm5zqnNuOefjvb7aYPhzg2LX/zzG6XMF2zvHvmHkJ2/SuE2hb
	ZChBIkkQosSzt9ZzYfPhCVznNr07heNydf2RYkUD/Q7OEyavSxJCYt1h3EOIQqJ5opc3XsptFiEsj
	QyvSwIGqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bxd-0000M4-PK; Fri, 14 Aug 2020 15:49:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bxb-0000L5-GT
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:49:40 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6FE1B2065C;
 Fri, 14 Aug 2020 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597420177;
 bh=nKMB2n6h4H07i5MOFAlmOIgxd/q+six6L2vpUwy5jBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bx+CZz3fLDRBLGzM/6BNkOTVSb8YrcUs4/ZqqRdTjJvZ7kuJbWEiV8YfSKfQcv+0e
 NR+4SvAPHpL5tfohmUeYweSO9zOffLkhfb4cOf3mmKYmeVE4Q/C4NSoFgxkisvsBdx
 j4sfplKo8mCwger95kM2iHh4swLhTLJ8BuqTLraw=
Date: Fri, 14 Aug 2020 08:49:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and
 nvme_queue.q_depth
Message-ID: <20200814154934.GB3772144@dhcp-10-100-145-180.wdl.wdc.com>
References: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_114939_832989_6DE09905 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 11:34:25PM +0800, John Garry wrote:
> Fix by making onto a u32.
> 
> Also use u32 for nvme_dev.q_depth, as we assign this value from
> nvme_dev.q_depth, and nvme_dev.q_depth will possibly hold 65536 - this
> avoids the same crash as above.
> 
> Fixes: 61f3b8963097 ("nvme-pci: use unsigned for io queue depth")
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
