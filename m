Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 17:36:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2555164F97
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 17:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2555164F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sHxpQdvBqDlSf1cEopKLaCQ4B2M6O1GNWvy9WqfIMeE=; b=Nuxv/aQeYxV5PosrvJ3oMt0qk
	Z6jkTgU6wZJnS0+yDymFdVoPNbdSPTBPaFh52lTHKqv8WjTaEcxke6IBoj3Upva3yX4xeov7tm5N6
	o4AWH9lAQ6e7PkcLGqIUYFjpjr/XUtOha+sD/YHG020SrpqNDMYqwJqGTTDlaA/5j72xdwBeaOMNg
	3y1BNsM7Ei/vwF3YrXirkpgyFgIAgglE4k5I1VGskiK750layECDOx31iK8KWGMeZykLFieq33YSu
	c4qCXX0AXpYTyCFV0uPIrpqpekrqJI0DLpmWSj6lOnzanDq5f0RrI1Z3d9n4hJCUxY74EmFdt9rSp
	f0Qq01f4A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKPEL-009kIg-Rk; Thu, 11 Mar 2021 17:36:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKPEE-009kFY-FD
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 17:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615484162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqfVvgDEaeVZgfA4fm07c5tH+yOQh34HrNoi9gVsjLg=;
 b=a9OLcgcyk2OdSNFDkJelgt9swm9I/+YTXngrYqCIe12wZ0KrM/9ZIThSiX3axq9eV5RskQ
 Zl5kFXIn+E9ZEeeJh4mrji+MbX80NhZV5KkhG3Q6FuoSBaeFkKfCz43055O/I23sYOk4ei
 Sl+2/s3KDCCZceN0r0Tp0XwQRcZXy3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-3xkXpRKgPoKAF7_Cud4tBg-1; Thu, 11 Mar 2021 12:33:41 -0500
X-MC-Unique: 3xkXpRKgPoKAF7_Cud4tBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479A81074659;
 Thu, 11 Mar 2021 17:33:40 +0000 (UTC)
Received: from ovpn-113-87.phx2.redhat.com (ovpn-113-87.phx2.redhat.com
 [10.3.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2E2C60C03;
 Thu, 11 Mar 2021 17:33:39 +0000 (UTC)
Message-ID: <f9bdd225112d79cfc3854cfc52bfea441b547b95.camel@redhat.com>
Subject: Re: [PATCH v2] nvme-fc: fix racing controller reset and create
 association
From: "Ewan D. Milne" <emilne@redhat.com>
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org, Nigel Kirkland <nkirkland2304@gmail.com>
Date: Thu, 11 Mar 2021 12:33:39 -0500
In-Reply-To: <20210309005126.58460-1-jsmart2021@gmail.com>
References: <20210309005126.58460-1-jsmart2021@gmail.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_173606_798034_A3489039 
X-CRM114-Status: GOOD (  21.18  )
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

On Mon, 2021-03-08 at 16:51 -0800, James Smart wrote:
> Recent patch to prevent calling __nvme_fc_abort_outstanding_ios in
> interrupt context results in a possible race condition. A controller
> reset results in errored io completions, which schedules error
> work. The change of error work to a work element allows it to fire
> after the ctrl state transition to NVME_CTRL_CONNECTING, causing
> any outstanding io (used to initialize the controller) to fail and
> cause problems for connect_work.
> 
> Add a state check to only schedule error work if not in the RESETTING
> state.
> 
> Fixes: 19fce0470f05 ("nvme-fc: avoid calling
> _nvme_fc_abort_outstanding_ios from interrupt context")
> Cc: <stable@vger.kernel.org> # v5.10+
> 
> Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v2: clean up typo in commit header
> ---
>  drivers/nvme/host/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 20dadd86e981..0f92bd12123e 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2055,7 +2055,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  		nvme_fc_complete_rq(rq);
>  
>  check_error:
> -	if (terminate_assoc)
> +	if (terminate_assoc && ctrl->ctrl.state != NVME_CTRL_RESETTING)
>  		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
>  }
>  

This fix resolves the frequent -EBUSY / -ENETRESET errors I saw when
resetting the controller via sysfs, as well as the eventual hang with
the controller stuck in the _CONNECTING state, thanks.  Looks good.

-Ewan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
