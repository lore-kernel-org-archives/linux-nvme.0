Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17A606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CRgXUDDH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XjeCqmG1CeC1xEug7Hx51pSG2eLgxELY9Lg3KjBfarg=; b=CRgXUDDHoTyL3VV4i0kdVmKid9
	wT7DdSQcp8+ctiYbFgBfpBLEbr3hLMNVRiycrURKVT4C8jwbOIT1zlfsqDhtdxdPHoTCUt4+8zEF2
	s4k5BFVs5KcLazw67GDENrGd/W18ug/ye+iYL1wUtUARkGXJPXpljNM2w9Pah95Y72Z4o6BOsifmB
	FZvSAdwGeIWS+dQ17cEpRT/m4yyFAXw5PU9bU41d46ZiX3gOEUM3vOyGnPzTMMbMopzKXrVnG6XJB
	7aJtl13wbIONVlxOtPl6/O7//gi4c8n3q5pGl3hN0Ug9nXdVA6R9AxQ0vTkRwEmOFJ2CCYDVA9LyR
	xUZMkESw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7Xf-00000001AXC-3wdN;
	Tue, 03 Nov 2026 05:58:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7Xe-00000001AWf-00Aw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:58:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4DDD68AFE; Tue,  3 Nov 2026 06:58:37 +0100 (CET)
Date: Tue, 3 Nov 2026 06:58:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Josef Bacik <josef@toxicpanda.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 03/19] nvme-fabrics: reconnect if the association is
 gone
Message-ID: <20261103055837.GB1772@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-4-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_215842_188659_27520BB7 
X-CRM114-Status: GOOD (  19.00  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:52:36AM -0700, Keith Busch wrote:
>  	if (ret) {
> -		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
> -				       &cmd, data);
> +		result = le32_to_cpu(res.u32);

Nit on the result assignment:  This can just be moved before the if
and shared between the success and failure cases.

> +		nvmf_log_connect_error(ctrl, ret, result, &cmd, data);
> +		/*
> +		 * The controller ID we got from the admin queue's Connect is
> +		 * not known any more: the association has gone since. DNR is
> +		 * right about this command and says nothing about the next
> +		 * association. Don't let nvmf_should_reconnect() see it.
> +		 */
> +		if (ret > 0 &&
> +		    (ret & NVME_SCT_SC_MASK) == NVME_SC_CONNECT_INVALID_PARAM &&
> +		    result >> 16 && (result & 0xffff) ==
> +				offsetof(struct nvmf_connect_data, cntlid))
> +			ret = -ENOTCONN;

I really don't like this.  What real problem is this fixing?  Do we
really see setups where the the controller goes away before I/O command
connect, and the caller expects retries?  In that case we'll need to
describe this scenario.

And the condition above should move into a helper clearly documenting
it, and the decoding of the result should use common helpers with
nvmf_log_connect_error.


