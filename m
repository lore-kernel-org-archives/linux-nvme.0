Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E40606A329
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GPIpTggR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Bi+CJHKTH42rOrekgZbHeJm/l0N+DkJmP+65LZ/UnmU=; b=GPIpTggRwFv17F6VAloxpuggYJ
	9TBjUQJTFLw8fBG6YQ6dqCAJ4giPzPr1o6jdTUgcjYaJwBa2/1v3dRHWb62by1N1Xrc7OO81dCcHe
	qmxivoJ6DHOJZ/MzpWo1hew4V/tC0Vwmdhw5sB5xzpBh4uMB+W4q0fNjPl65Ay52dG7+UD1e3b1GM
	TVpYqkQJVhJ4XfrJpCNydxKEy5PfxsEyLkjB7wH0iaKgK6XeIuQGJ0HFlhGkOGkPUlpc1QzSvknjO
	IbFDaOAUM2FWNDx6oAn007jSFrM+Hx/polXEErsK1Bvdc620aI7M0cjCq5kJ42TzbqdUFUtl5wpdu
	OOxa7Mjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHJZ-0000000Bxm9-1ygT;
	Fri, 06 Nov 2026 10:36:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHJX-0000000BxkS-0LN2
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:36:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB13368BFE; Fri,  6 Nov 2026 11:36:51 +0100 (CET)
Date: Fri, 6 Nov 2026 11:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/9] nvme-fabrics: remove dead hostnqn
 already-assigned check
Message-ID: <20261106103651.GH5453@lst.de>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com> <20261106022736.3582824-5-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106022736.3582824-5-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023655_268881_717C0F84 
X-CRM114-Status: GOOD (  14.09  )
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

On Fri, Nov 06, 2026 at 10:27:31AM +0800, Guixin Liu wrote:
> The opts->host check in the NVMF_OPT_HOSTNQN handler can never fire:
> options are parsed into a freshly allocated struct, and opts->host is
> only assigned after the parsing loop completes. A duplicate hostnqn
> option is already silently overridden by the strscpy() into the local
> buffer. Remove the dead check.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


