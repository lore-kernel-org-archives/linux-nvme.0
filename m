Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B4C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 20:04:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A66613C7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 20:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A66613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GbTgiR4LK8+PEvsKlLZKRhTHm11aHs0lnNxO5eOUHJg=; b=MMzH1clU5D139bRwGwKvOs5Il
	21rVbrcIaoM60g5k2o9tAP2NMXkdEtGlIyo+4Gzs0HXPKDExMtbe++B9Go9cfTPKqbtcMcplO2qGi
	RImAJchRifBBMHVsY+J0pFSlEjnaYjFBWi0SwFkmAOaXssNvmE0bChz16gdQLd5vOqUPVHZjQVsYU
	XkJBmVT6kgi/4iWc3irs6Jkscoeh9zeEFea+gO1c1zBJeObycNGlqJU7VWqoqK1wOR19uOrvqS3ks
	1V+IAUAVvX5qUJak92J5cRsyhPP493qQt5EQnpyIminwc7aCPW1qtFv1tQ51+n/chPg46xQ4iVmoP
	cyaAbz1Mw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXUhN-003IUZ-C8; Fri, 16 Apr 2021 20:04:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXUhH-003ITJ-1y
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 20:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618603433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kqwxsx+MRBYBkqvR2OmLtUQzOcoajlA/yVwvOd9pcJ8=;
 b=D3Zr7pUQOjNNAs5PG735pBAvwVRBATHPIfChooAni/Nw8yI+NuAzVvQdd3JtBaC3/N7s99
 pi4s/mlz4VuMyIi6Ljo5gtpYge0asHK5/mjd0i8KB165G4jtMtV6tDVr146Sj5DOtJDojj
 O+ZkN93YIdVIbN0MvxCHTHzhCgb3Rqs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618603446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kqwxsx+MRBYBkqvR2OmLtUQzOcoajlA/yVwvOd9pcJ8=;
 b=ctECskWNEyVmKJ1s2wEZd329wjSRjBdV0ZQOc9RGfBeM05nqHXZbMgGdPolxoeLFoTtx+w
 Rir/Af7QS0d+I/SlDV1FWtLG6mcc5kWYJTnNfARbpA1+oqDxCUIjsb6rNjb06JZHnfpX3U
 7Z+J3in8PcC5VSBNWDiyed0rkbXURbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-yKzm0bVCO0uK_P3y-e7Z_A-1; Fri, 16 Apr 2021 16:03:49 -0400
X-MC-Unique: yKzm0bVCO0uK_P3y-e7Z_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4647280D6A9;
 Fri, 16 Apr 2021 20:03:48 +0000 (UTC)
Received: from ovpn-112-203.phx2.redhat.com (ovpn-112-203.phx2.redhat.com
 [10.3.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF73107D5C0;
 Fri, 16 Apr 2021 20:03:40 +0000 (UTC)
Message-ID: <01f223290184e0b2301c8dadc435520594c3dee9.camel@redhat.com>
Subject: Re: [dm-devel] [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
From: "Ewan D. Milne" <emilne@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>, 
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com, 
 linux-nvme@lists.infradead.org
Date: Fri, 16 Apr 2021 16:03:40 -0400
In-Reply-To: <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
 <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_210411_501771_8D04F0D4 
X-CRM114-Status: GOOD (  13.29  )
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

On Fri, 2021-04-16 at 16:07 +0200, Hannes Reinecke wrote:
> 
> Hmm. Quite convoluted, methinks.
> Shouldn't this achieve the same thing?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e89ec2522ca6..8c36a2196b66 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -303,8 +303,10 @@ static inline enum nvme_disposition
> nvme_decide_disposition(struct request *req)
>         if (likely(nvme_req(req)->status == 0))
>                 return COMPLETE;
> 
> -       if (blk_noretry_request(req) ||
> -           (nvme_req(req)->status & NVME_SC_DNR) ||
> +       if (blk_noretry_request(req))
> +               nvme_req(req)->status |= NVME_SC_DNR;
> +
> +       if ((nvme_req(req)->status & NVME_SC_DNR) ||
>             nvme_req(req)->retries >= nvme_max_retries)
>                 return COMPLETE;
> 

I am not in favor of altering ->status to set DNR jus to
simplify the following conditional.

-Ewan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
