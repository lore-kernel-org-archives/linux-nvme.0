Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 04:59:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCD420899
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 04:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sNUqHfjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCD420899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FlyFberYhZr+1X9QfkQvX4pZC3n11D/J68RKhza3S8A=; b=sNUqHfjX/5rE57
	yD2o/DGJP+igRrWRGXiIuN7ZPclA3dPU2x/V+E9fvRItrQ+Pv1XuOaZZf8Rgl3UPXMA6eq7gbAGv2
	HEb2MXiC1Do8OGywOsq1OgNgUVmEtTd0R0fMfN0YmaF/1CoscYTiG9Ff5KdO0rSOHl3kvvJRAQuRP
	9OfYaqIW9Llt9E9Vs8r+w9BhCso0fTcylY0f6TrJ1h94JcmtQka6mndRmBhvJjMbddhkcX7qNFnln
	xTzzNm0r7OFF2EPeHjdtHLsnY/XR7ZUq/9VRR3C5WcE7kfpsd5jAJahgx4e3Lx8y4QOMkik/WKKGG
	8R3l9pGITvBjBSLUPBUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAdQ-0000u6-Ho; Thu, 28 May 2020 04:59:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeAdO-0000tp-80
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 04:59:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 54A3768B05; Thu, 28 May 2020 06:59:12 +0200 (CEST)
Date: Thu, 28 May 2020 06:59:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: cancel requests for real
Message-ID: <20200528045911.GB28678@lst.de>
References: <20200527190913.3461503-1-kbusch@kernel.org>
 <cb108e7e-d386-883c-4d4a-64e517891220@grimberg.me>
 <b8a076a3-62e9-a878-f11d-7116b1848caf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8a076a3-62e9-a878-f11d-7116b1848caf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_215914_437181_016C7EF0 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 27, 2020 at 01:39:21PM -0700, Alan Adamson wrote:
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -22,10 +22,10 @@ static int __init setup_fail_io_timeout(char *str)
>
> int blk_should_fake_timeout(struct request_queue *q)
> {
> -=A0=A0=A0=A0=A0=A0 if (!test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> -
> -=A0=A0=A0=A0=A0=A0 return should_fail(&fail_io_timeout, 1);
> +=A0=A0=A0=A0=A0=A0 if (test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags) &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !blk_queue_quiesced(q))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return should_fail(&fail_io_t=
imeout, 1);
> +=A0=A0=A0=A0=A0=A0 return 0;
> }

While that is way better than the loop I think this encodes too way too
many assumptions.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
