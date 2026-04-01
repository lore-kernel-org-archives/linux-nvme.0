Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAB0107639C
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZYH4KrsEQI9d86zJjKtXp5kyQjMarfre7K6Fqt/Na8=; b=LJR9zVD6Ndxe1r6EG0s4kNW2Oz
	TaqABa+ACyT+Wf8BDH+5vNxkMNup8Tcmy+RfaYYQSEoalp03EWgcQ0oDqYoGutOzvIToj6lvUBAyp
	YF0ZmXfikjm6TUFqrlKqWA9ME3aLd/1R77hvzO5v8R7Y7PTlL5lMVFx8UoJMSJJJPLB9HaSbO44Vz
	K5KXrIPzRdJ5gel9o6/Z/PjdPdJ11JMv2M38FdOg2UT18wcDdpzN9BUo4SQeEiOHPOTedJkbdB8du
	aWDbzCZeFa8zQ9fr3UM/PmIfvXHXc/EoY1A5uaFiI2ItcOvWaRP/7vROiqaELCmGBM8801rAeS2Ly
	c4D7caoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w80R7-0000000FyA5-0B4A;
	Wed, 01 Apr 2026 18:37:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w80Qz-0000000Fy9a-3son
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 18:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775068616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZYH4KrsEQI9d86zJjKtXp5kyQjMarfre7K6Fqt/Na8=;
	b=VChNKpQimprDfKZ2qkiqxs+sUyUmjX+Btx70whRPAszEP5TASB9Sw0vpDW+7DbIt4xhmG7
	/ioSq2icQssvOzmcDCRI1DyM7itMFJMJ6/fpBlsUI0+35ht+SykBjMxxbQKk+Rgw7PjRvq
	p5Kp0C4vzJeaaZxdo/u80LOu+BAAUWM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-UCijSIZ1N-aXWMEb5f6lyQ-1; Wed,
 01 Apr 2026 14:36:53 -0400
X-MC-Unique: UCijSIZ1N-aXWMEb5f6lyQ-1
X-Mimecast-MFC-AGG-ID: UCijSIZ1N-aXWMEb5f6lyQ_1775068612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9CD219560B9;
	Wed,  1 Apr 2026 18:36:51 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.17.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 46087180035F;
	Wed,  1 Apr 2026 18:36:50 +0000 (UTC)
Date: Wed, 1 Apr 2026 11:36:49 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-auth: switch to use 'struct key'
Message-ID: <20260401-dd12748d3ce7d56bf6f24fa3@redhat.com>
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-4-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260317130103.107360-4-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6qkXOZK5_FTWG3zpawgBP8iOWaGZztWGcHnbxim5HA_1775068612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_113658_312126_9CC805E1 
X-CRM114-Status: GOOD (  21.36  )
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

On Tue, Mar 17, 2026 at 02:00:58PM +0100, Hannes Reinecke wrote:
> Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
> handling function to use 'struct key'. With that we can drop the now
> unused 'struct nvme_dhchap_key' definitions.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/common/Kconfig   |   1 +
>  drivers/nvme/common/auth.c    | 191 +++++++++++++---------------------
>  drivers/nvme/common/keyring.c |  98 +++++++++++++++++
>  drivers/nvme/host/Kconfig     |   1 -
>  drivers/nvme/host/auth.c      |  28 +++--
>  drivers/nvme/host/nvme.h      |   4 +-
>  drivers/nvme/host/sysfs.c     |  26 +++--
>  drivers/nvme/target/Kconfig   |   1 -
>  drivers/nvme/target/auth.c    |  40 +++----
>  drivers/nvme/target/nvmet.h   |   4 +-
>  include/linux/nvme-auth.h     |  17 +--
>  include/linux/nvme-keyring.h  |  22 +++-
>  12 files changed, 256 insertions(+), 177 deletions(-)
... 
> @@ -180,42 +181,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>  		ctrl->shash_id = host->dhchap_hash_id;
>  	}
>  
> -	/* Skip the 'DHHC-1:XX:' prefix */
> -	nvme_auth_free_key(ctrl->host_key);
> -	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
> -					       host->dhchap_key_hash);
> +	key_put(ctrl->host_key);
> +	ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
> +					       strlen(host->dhchap_secret));
>  	if (IS_ERR(ctrl->host_key)) {
>  		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>  		ctrl->host_key = NULL;
>  		goto out_free_hash;
>  	}
> -	pr_debug("%s: using hash %s key %*ph\n", __func__,
> -		 ctrl->host_key->hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
> -		 (int)ctrl->host_key->len, ctrl->host_key->key);
> +	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
> +	pr_debug("%s: using hash %s key %u\n", __func__,
> +		 ctrl_hash > 0 ?
> +		 nvme_auth_hmac_name(ctrl_hash) : "none",

Use of uninitialized ctrl_hash, should this be host_hash?

> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -18,9 +18,14 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>  
>  key_serial_t nvme_keyring_id(void);
>  struct key *nvme_tls_key_lookup(key_serial_t key_id);
> +
> +struct key *nvme_dhchap_psk_create(struct key *keyring,
> +		const u8 *data, size_t data_len);
> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
> +u8 nvme_dhchap_psk_hash(struct key *key);
> +
>  #else
>  static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, char *subnqn, u8 hmac_id,
>  		u8 *data, size_t data_len, const char *digest)

This looks like a mistake, it changes the signature of the stub but
there is no change to the actual implemenataion.

>  {
>  	return ERR_PTR(-ENOTSUPP);
> @@ -38,5 +43,20 @@ static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>  {
>  	return ERR_PTR(-ENOTSUPP);
>  }
> +static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
> +		const char *hostnqn, const char *subnqn,
> +		u8 *data, size_t data_len)

This looks like a stub for something that doesn't exist, it's unused code.

> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
> +		const char *hostnqn, const char *subnqn, u8 hmac);

This stub function signature does not match the real one.

- Chris


