Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC0C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 23:54:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18BF20672
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 23:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jI1Wf15V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTBrvB//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18BF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=og0wUvvxbHlP0ge43eNiy3qEsGIo+Adxj1cfklIyw1U=; b=jI1Wf15VUnasTfPE1IWgSWTrQ
	2R3esM3zCVHbTMyNXvUQsHqcA2ymMgjlveXDS+g8Tq/ZMPwxtyadgLFlEgDgXGZ0C3yS4YRHbEtQI
	uTfuYiuXLfhRzof8vqjPdal3+32nEfetsIkKm9svlhxuvOs2DNdftnAqqShtmwJetW7aef5Da9IUB
	nHlSPxuC5h1IAMxP6LqC3LhJGuQ6VRbvvOqkc/BSQ8QTyIUgeVqNMINQbUFeI57/D+cBe9MG6qYNq
	jQ4Rd/YhfojdjrMuLqZVqN8v3R7P/t9jfDxgkELUo5M+FdAFtLf5zKQWhiBQuwxpHJtwV8I3XuMY1
	cbovdPL/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joFE2-0001Je-J2; Wed, 24 Jun 2020 23:54:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joFDr-0001EK-JU
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 23:54:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1146C20672;
 Wed, 24 Jun 2020 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593042870;
 bh=zhzvxKTu4Nos4Vq0enqy8sI8qgZX/6cGhDrBlOn5kLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cTBrvB//Chcl+4aOUwFZkNN6jEygPOAVqVE3jDkhvWuj/8P7eQz8wCoHD+5FXaqN5
 ECxCplqFy2+WEILh6z6W12J2WHdbSBkIm6eOSH5C9wKzqqn1Fp8xnKXG/uyVklaNbV
 jQgpTSD8/0ObCt7vXf6GueBBrr3FcEQyOJAfTnAw=
Date: Wed, 24 Jun 2020 16:54:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200624235428.GH1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
 <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 03:54:05PM -0700, Sagi Grimberg wrote:
> The code needs to be:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2afed32d3892..3e84ab6c2bd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl
> *ctrl, unsigned nsid,
>                   * Don't treat an error as fatal, as we potentially already
>                   * have a NGUID or EUI-64.
>                   */
> -               if (status > 0 && !(status & NVME_SC_DNR))
> +               if (status > 0 && (status & NVME_SC_DNR))
>                         status = 0;
>                 goto free_data;
>         }
> --

Aha, I was assuming the code was the way you wanted it, hence my
confusion :)

The above makes sense walking through different scenarios. I needed
to reconcile this in order to understand how we'll address it with
Nikla's patch that start this conversation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
