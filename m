Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5FCF436BF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uggwtCaVcvROsjHgtNbbX0w2gXo6VNc2FeHwEK+fpGM=; b=uc8mBY9nZaeCSeeIJDo4FY+41G
	csb/h6OIXxvOlRs7SLFwVbY9oF1njB6vrnq7FxpSFS0fA8YGef4rt5e1rTM/HP8oKt3LiWuisoxrH
	NTfdCQAgtnNG851RZF9TMAj0P02M/VuzqdrKP6tbx5hMHa+nI7Ie5UA9ExEoBz4K/CsXKXiL2rh1L
	iVh2zWOCci3Wz8XXBwJIT8rBa8krxiWDPFrgwkZQIXRrY17jsWnTFwiRKNSgrgDdmMFK8z3iAzgXQ
	OQC6OuWodXglF6h6IV5a4Z7dBzmUw4UKn3Ov/jSm1Pw1AZqMeZfKcLKADfsgqwLS8Y7kziU1f8Dt3
	SBWId8+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDmVb-00000004Iby-3pVn;
	Fri, 17 Apr 2026 16:57:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDmVX-00000004Ibd-0F4c
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 16:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776445048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uggwtCaVcvROsjHgtNbbX0w2gXo6VNc2FeHwEK+fpGM=;
	b=AWh4Btrr4zvzwcmNLaeefucOhldpnaeSg6X1yzoYAKxMQel21KwVMSUckZW+g9CZ8I8v/A
	slr7AA7rgI8f7xKliAHmlxXz4wdfxTqD5HtVLbVl/BmhNxuXo7H7RaIDX/9xJAbZvBp5S5
	5nlxhbNRHPsoNW+ZcbUgIRZU8cD/d6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-t342lx2MNom6j8EvNJYTdw-1; Fri,
 17 Apr 2026 12:57:24 -0400
X-MC-Unique: t342lx2MNom6j8EvNJYTdw-1
X-Mimecast-MFC-AGG-ID: t342lx2MNom6j8EvNJYTdw_1776445042
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B761956065;
	Fri, 17 Apr 2026 16:57:22 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EB1EB19560B1;
	Fri, 17 Apr 2026 16:57:17 +0000 (UTC)
Date: Fri, 17 Apr 2026 09:57:16 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication
 success"
Message-ID: <20260417-a6559d5a9906f8b2da2b9774@redhat.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ZF4KNr0C9J_d4j3sSU2Eoa9FeBiCEdQEs6Y-6siZmic_1776445042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_095731_184011_B938C09E 
X-CRM114-Status: GOOD (  16.48  )
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

On Fri, Apr 17, 2026 at 10:48:08AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
> successful connections. This resulted in memory leaks in the kernel, so
> let's revert the commit. A improved fix is being developed to just avoid
> clearing the tls_key variable.
> 
> This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Closes: https://lore.kernel.org/linux-nvme/CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com
Reviewed-by: Chris Leech <cleech@redhat.com>

> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index b9ab80c7a6941..f1e613e7c63e5 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -395,10 +395,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>  		goto complete;
>  	}
>  	/* Final states, clear up variables */
> -	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
> -		nvmet_auth_sq_free(req->sq);
> +	nvmet_auth_sq_free(req->sq);
> +	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
>  		nvmet_ctrl_fatal_error(ctrl);
> -	}
>  
>  complete:
>  	nvmet_req_complete(req, status);
> @@ -574,7 +573,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>  	status = nvmet_copy_to_sgl(req, 0, d, al);
>  	kfree(d);
>  done:
> -	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> +	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
> +		nvmet_auth_sq_free(req->sq);
> +	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
>  		nvmet_auth_sq_free(req->sq);
>  		nvmet_ctrl_fatal_error(ctrl);
>  	}
> -- 
> 2.53.0


