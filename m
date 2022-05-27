Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1912EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5hktu8j0F7wrck20QbaV1prawoLt2YiMG6D+A5gB3U=; b=pEpqqjxl0710KovPu0wrd3Duwd
	7R0kf2wch865UXYlfuAT46yMfF36MP9Q7MrhQXlg2eQ1OYmobGCxHBxgw7MJ5q3yJgnQP0xPYaeA3
	CYZcZ+a5QgkYj0LHvFCuHvtj8Eo9XEPp42437/eFtazU022yuauZQoOnA94vLxctVQTBReufDQaMQ
	VNNpJSLj31G6JKkCTvNPRRmQc2aOY/NOM3A7lNWOBwuuLLlwAGjRwkVn744OKVR/xa/FEqHls71I5
	Ls/OGOAYcZy1W11PCtKH2rUyMZwoK3xJSBYt2+emTPfeNq/pdgIU+g289VXTVLoirDkTM0F33UjIX
	JYZ5fJXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuWrc-00HI8A-75; Fri, 27 May 2022 10:06:36 +0000
Received: from helcar.hmeau.com ([216.24.177.18] helo=fornost.hmeau.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuWrV-00HI67-7n
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 10:06:31 +0000
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1nuWrB-000YOU-IB; Fri, 27 May 2022 20:06:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 May 2022 18:06:09 +0800
Date: Fri, 27 May 2022 18:06:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 02/11] crypto: add crypto_has_kpp()
Message-ID: <YpCikbaFof/+eNhQ@gondor.apana.org.au>
References: <20220518112234.24264-1-hare@suse.de>
 <20220518112234.24264-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518112234.24264-3-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_030629_313290_43DD77DB 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

On Wed, May 18, 2022 at 01:22:25PM +0200, Hannes Reinecke wrote:
> Add helper function to determine if a given key-agreement protocol
> primitive is supported.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>  crypto/kpp.c         | 6 ++++++
>  include/crypto/kpp.h | 2 ++
>  2 files changed, 8 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

