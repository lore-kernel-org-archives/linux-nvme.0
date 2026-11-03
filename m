Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DA606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jApZvA9N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7Eq/LNl7W2EfXusJWxns4b4oVlO/rzGH9he1duFnpGA=; b=jApZvA9NhieWSi+oik4EraNAAG
	IwVqcmANnCo5kHv5pqP7rSr1qLa21wI5lNHmiRdf7QxsqVN1zr9MN3OmY6UV8dTmqwhIovugcJhnO
	fOruquD7sWcKfSyAWgMOxdyvz/dcUrZ55l44cBBmOxv66sOXBYW63Y1QQfugtrF5KYHrfLdu9C3ri
	mN8f7DYuMwbBi716WSmUTyFKHpnQeZEznA6U3m2sKJYCpBVPdqQS6naM+e+KBPXX1SPgNWwz5cOoE
	Cud2z70iXq8sN1PsUIrbD1Q2o0Yp1RjREutUSR0mIt798yNqJbBbpNJq1ysas+2wzPDRmyTYbxjCX
	NX59/m4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7ar-00000001Az3-3VZv;
	Tue, 03 Nov 2026 06:02:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7ap-00000001Axx-31DT
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:02:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43FC468BEB; Tue,  3 Nov 2026 07:01:56 +0100 (CET)
Date: Tue, 3 Nov 2026 07:01:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Josef Bacik <josef@toxicpanda.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 06/19] nvmet: check the host NQN against the TLS PSK
 identity
Message-ID: <20261103060155.GC1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-7-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220159_915525_5363F57C 
X-CRM114-Status: GOOD (  27.66  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:52:39AM -0700, Keith Busch wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The identity of a TLS PSK names the host and subsystem the key was
> generated for. The target remembers which key a handshake ended with,
> but never compares it with the host NQN in the Connect that follows. So
> a host holding any PSK in the port's keyring can connect as another
> host, sees what that host may see, and isn't asked for DH-HMAC-CHAP
> since TLS queues skip it. It can add an I/O queue to that host's TLS
> controller the same way.
> 
> Refuse a Connect whose host NQN isn't the one in the PSK identity of the
> queue. The subsystem NQN isn't compared, a discovery subsystem goes by
> two names.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/fabrics-cmd.c | 33 +++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index fc626c2fd2c92..b950000696c2a 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -267,6 +267,30 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>  		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
>  }
>  
> +/*
> + * The identity of a TLS PSK names the host that the key was made for:
> + * "NVMe<version><type><hash> <host NQN> <subsystem NQN> ...".
> + * Whoever has proven to hold the key is that host, and no other one.
> + */
> +static u16 nvmet_check_tls_host(struct nvmet_sq *sq, const char *hostnqn)
> +{
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +	size_t len = strlen(hostnqn);
> +	const char *id;
> +
> +	if (!sq->tls_key)
> +		return 0;
> +
> +	id = strchr(sq->tls_key->description, ' ');
> +	if (!id || strncmp(id + 1, hostnqn, len) || id[len + 1] != ' ') {
> +		pr_warn("TLS PSK %08x does not belong to host %s\n",
> +			key_serial(sq->tls_key), hostnqn);
> +		return NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
> +	}
> +#endif
> +	return 0;
> +}

#ifdef for an entire function body is an anti-pattern.  Either stub
out the entire function, or use IS_ENABLED depending on which one
works better here.

The rest looks good.

