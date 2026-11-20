Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E9606A33D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z6NdieUW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EYkR8mhr0msSh8nFwUE6S8O58BnOVMw5zVtGj1CTw38=; b=Z6NdieUWfuXkpGDS7ljBRZxYIS
	EXiHDOqjolrh/M/vZr++Sm2z5oa2HZW2wltB+dvxOEpRdq7JZgrbbQInQblC3PQLCIMytay2Wiee4
	E54ME9O67+zxPXLDJmzv+fmj4jhADjfnUKx2fO09aE1QkpszRhZjuKVp9XxQ7EGEwAaAS77yRBk4V
	vJuMGxRv4nxDTsBxvzY8HzUFxtxnsS2YTvrcDLSj+PnHwBGd/r0Vkg7r6Bgb0hcSt4q3H0eSouLf8
	d8nIyII5AcYaeuvI/PwCrGGdWf4p+XXupx9Ur4/sjAV5nNKoua1THltrvvTLtRrW+nFRZRzeCOJMc
	AIFCm9HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSrc-0000000FpmJ-1yAL;
	Fri, 20 Nov 2026 17:57:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSr7-0000000Fpe0-46lc
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:57:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6BFE6732A; Fri, 20 Nov 2026 18:56:58 +0100 (CET)
Date: Fri, 20 Nov 2026 18:56:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gleb Chesnokov <gleb.chesnokov@scst.dev>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kch@nvidia.com,
	kbusch@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: report backend transport errors as path errors
Message-ID: <20261120175658.GD1622@lst.de>
References: <0099f610-a48b-4557-8515-e4df444262e8@scst.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0099f610-a48b-4557-8515-e4df444262e8@scst.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_095709_707547_2B115284 
X-CRM114-Status: GOOD (  13.09  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 02:02:47PM +0300, Gleb Chesnokov wrote:
> The block backend maps BLK_STS_TRANSPORT to NVME_SC_INTERNAL with DNR
> set. This discards the backend's transport error classification. A Linux
> native multipath host completes the request before considering path
> failover, even if another controller can still access the namespace.
> 
> Map BLK_STS_TRANSPORT to NVME_SC_INTERNAL_PATH_ERROR without DNR instead.
> The transport failure is behind the controller, so report an internal
> path error rather than a host path error. Associate the error log entry
> with the namespace, as for the existing access-denied status.
> 
> This allows otherwise retryable native multipath requests to reach path
> error handling.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


