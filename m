Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4835DC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 01:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vwfUtHynezY/v4Yc01/W06xqMDxv8BXKQUIuGIALvIU=; b=h3dC+mwR0zYMSUtuMQ2GVlcyIn
	bFyET12FmstF/ark89+0q9hjMiAQ3WVdvUvtl6O6HgeqaMX8W/9D3RzDvRq9CFdk5ySwv6DVPbdkI
	1GknAYpkXta0fiMj7t0oaMJX7vQb2tSipymwumAF9H0ZhfF/6TkeSY0G36k/e1mmWkYC7tPq72fVc
	F3Pt64RnJbO/oN0cjJk1k/Zc9CCGFi22+TsaWrmoe6dz4LtaruMgbdjkbe1jDP/Qr66p39HlhN9YE
	LmLubcotM7omxBHhvnjkZO7VLDI7EdXBuS6hSf27n9YpAdAJxowRhWDsh002f3aSHBrEKDR9aGV5m
	5f5kM0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4eD-0000000B4lP-2Gtu;
	Tue, 23 Jul 2024 01:49:01 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4eA-0000000B4km-0clv
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 01:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 22DFBCE0D01;
	Tue, 23 Jul 2024 01:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF2DC116B1;
	Tue, 23 Jul 2024 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721699335;
	bh=3D9wf9HZOMAl36iRYLRmC2ZZvwA7HUfg+fd9nltv1Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+RXGdxKG/IYUBu0DTDVtR/tMUAMsUmlHzNyzgm3kKjLBeVFLExt7EaVHn7J5iNO6
	 OJIM2ITyhHGMsADarR8v7wlrdNG+PFVT3EirXlsbswOOtwGaLqZOgAf7v6hxn9ewMZ
	 893nL0A6gKATyurhJT/6W+NQaYU3YKTz//T7C6DFjB1vTlc2FbZhQ4U4TNFTjMtzfE
	 t5uTC2vQG/PY1947RENniG5FRQJRuH69+j6s7BIq7iMM6+pVNHj0LnI3UCq0+VFjva
	 gPvJyXVgrdN1xUYMVTLHTe0TyzQBx59bLOMX0DXDHCgBhmqHSXpJapuilQN7jZ/FAV
	 EL7O2SvA6BROw==
Date: Tue, 23 Jul 2024 01:48:54 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvmet-tcp: support secure channel concatenation
Message-ID: <20240723014854.GC2319848@google.com>
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-9-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142122.128258-9-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_184858_383853_F3E04820 
X-CRM114-Status: GOOD (  10.28  )
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

On Mon, Jul 22, 2024 at 04:21:21PM +0200, Hannes Reinecke wrote:
> +	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
> +					sq->ctrl->subsysnqn,
> +					sq->ctrl->hostnqn, &digest);
> +	if (ret) {
> +		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
> +			__func__, sq->ctrl->cntlid, sq->qid, ret);
> +		goto out_free_psk;
> +	}
> +	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
> +				       digest, &tls_psk);
> +	if (ret) {
> +		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
> +			__func__, sq->ctrl->cntlid, sq->qid, ret);
> +		goto out_free_digest;
> +	}

This reuses 'psk' as both an HMAC key and as input keying material for HKDF.
It's *probably* still secure, but this violates cryptographic best practices in
that it reuses a key for multiple purposes.  Is this a defect in the spec?

- Eric

