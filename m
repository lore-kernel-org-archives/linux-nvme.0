Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E58C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDV3LmIKwtg75gIDK/mcwHQAsQr01hx5XsnYZP7CCvo=; b=fW/unslx/ohEf8nYQkKegBw27/
	L0Y6dl03X9DpNGpl9A5d2PbnkAq1ktyDLTjLfhJe1/SX6VRorXPdd+28KU8xXbZfph9IzuWlvqzoM
	HRUcdrIdOKID1FZ2yNAaWtRrsfOQvlL2ap2kc5CvlKiUhvm1H57v1LjGPAKVphfXEcEdI8eiUS0lU
	3h9ZqtlLX/2ZLXUmtBWQrk26hWxWGmgObMxtp1Wfo56JSuNPvswlLxklndrpPGbTiZ037D25dggsv
	6N6/T9eSgey5Ns4Y0Xvf2nWIUk7xX4RJ9D5FnLfdfuYNnv23LIkl0bz5b/t7KfdbRRyBUHp/HaPA6
	jO381gIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcheO-00000004TZr-0Ysa;
	Tue, 28 Jan 2025 09:12:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchdB-00000004TKv-1x7w
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 09:11:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85FF468D05; Tue, 28 Jan 2025 10:11:32 +0100 (CET)
Date: Tue, 28 Jan 2025 10:11:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 07/10] nvme-tcp: request secure channel concatenation
Message-ID: <20250128091131.GF25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-8-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-8-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_011137_655912_BC331E03 
X-CRM114-Status: GOOD (  29.77  )
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

On Wed, Jan 22, 2025 at 05:58:26PM +0100, Hannes Reinecke wrote:
> Add a fabrics option 'concat' to request secure channel concatenation.
> When secure channel concatenation is enabled a 'generated PSK' is inserted
> into the keyring such that it's available after reset.

That's a very sparse commit message.  What is the point of doing this?
What is the spec reference for the implementation?  What is the user
interface?  Why does this now always select NVME_KEYRING?

> +	if (!ctrl->opts->concat || chap->qid != 0)
> +		data->sc_c = NVME_AUTH_SECP_NOSC;
> +	else if (ctrl->opts->tls_key)
> +		data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
> +	else
> +		data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;

Took me a while to unwind this.  Why not make this a little easier as:

	if (ctrl->opts->concat && chap->qid == 0) {
		if (ctrl->opts->tls_key)
			data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
		else
			data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
	} else {
		data->sc_c = NVME_AUTH_SECP_NOSC;
	}

?

> +	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);

Overly long line.

> +	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl->opts->host->nqn,

Same.  Not going to mention more of that, but please fix it up.

> +		if (ctrl->opts->concat &&
> +		    (ret = nvme_auth_secure_concat(ctrl, chap))) {

		if (ctrl->opts->concat) {
			ret = nvme_auth_secure_concat(ctrl, chap);
			if (ret) {
				...

> +	/*
> +	 * Only run authentication on the admin queue for
> 	 * secure concatenation
> +	 */

The two lines of comment can be folded in one, and it's missing a period
at the end of the sentence.

> +			/*
> +			 * The generated PSK is stored in the
> +			 * fabric options
> +			 */

Missing period and not using up the line as well.

> +/*
> + * The TLS key is set by secure concatenation after negotiation
> + * has been completed on the admin queue. We need to revoke the
> + * key when:
> + * - concatenation is enabled
> + *   (otherwise it's a static key set by the user)
> + * and
> + * - the generated key is present in ctrl->tls_key
> + *   (otherwise there's nothing to revoke)
> + * and
> + * - a valid PSK key ID has been set in ctrl->tls_pskid
> + *   (otherwise TLS negotiation has not run).
> + *
> + * We cannot always revoke the key, as we're calling
> + * nvme_tcp_alloc_admin_queue() twice during secure
> + * concatenation, once on a 'normal' connection to run
> + * the DH-HMAC-CHAP negotiation (which generates the key,
> + * so it _must not_ be set), and once after the negotiation
> + * (which uses the key, so it _must_ be set).
> + */

Another overly dense fomatting.  Are you trying to make up the
extra width used in the first patches? :)

> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1746,6 +1746,13 @@ enum {
>  	NVME_AUTH_DHGROUP_INVALID	= 0xff,
>  };
>  
> +enum {
> +	NVME_AUTH_SECP_NOSC		= 0x00,
> +	NVME_AUTH_SECP_SC		= 0x01,
> +	NVME_AUTH_SECP_NEWTLSPSK	= 0x02,
> +	NVME_AUTH_SECP_REPLACETLSPSK	= 0x03,
> +};

Comments please to explain what fields this applies to.  Also we
usuall try to split protocol definition additions into separate
patches.


