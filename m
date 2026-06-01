Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F395CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+jyiuU+SCQAyIivBHe2swtxOQRM9xshfwvvQ8aKBgI=; b=VrATbO0Cs7PBkMnBgOWGBy9Gcj
	WbolOhqIn5GsypFDQrr1nBwUdm/wvBEVUc3WAt1RdULcXT6lXsfX5R3mq6gC4qk0GEQvi4+YImh4c
	4bXb25Dh3kPHqR+UFJ8xh9sEce7XIylFNyNyqV+mMTNoJLBFQzJlT0pj4dYbdkWOkzLJXwkpTi4nv
	keZqt6sI8WveUlbHaknYpRv4r98Ew0phE0CaMpVyqH7IrQbR0PvZsrH+jZglX5riYBfheHlc9upem
	t1C7oc49OCIxoa9qTPAR8U3ecZ13314Frtg/SdDhBwpCb0hloMcFc+n3rywdwXq6+PjcT/7iXcT5v
	H5UhI31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwvo-0000000AIJZ-1PvD;
	Mon, 01 Jun 2026 07:19:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwvl-0000000AIJD-1ZlN
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:19:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F5DF68B05; Mon,  1 Jun 2026 09:19:22 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:19:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: validate reply message payload bounds
 against transfer length
Message-ID: <20260601071921.GB7582@lst.de>
References: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001925_592868_D2AB4F73 
X-CRM114-Status: GOOD (  25.17  )
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

On Fri, May 29, 2026 at 02:18:39PM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> nvmet_auth_reply() accesses the variable-length rval[] array using
> attacker-controlled hl (hash length) and dhvlen (DH value length) fields
> without verifying they fit within the allocated buffer of tl bytes.
> 
> A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message with a
> small transfer length but large hl/dhvlen values, causing out-of-bounds
> heap reads when the target processes the DH public key (rval + 2*hl) or
> performs the host response memcmp.
> 
> With DH authentication configured, the OOB pointer is passed directly to
> sg_init_one() and read by crypto_kpp_compute_shared_secret(), reaching
> up to 526 bytes past the buffer. This is exploitable pre-authentication.
> 
> Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <= tl before
> any access to the variable-length fields.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index f1e613e7c..0a85acf1e 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -132,13 +132,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
>  	return 0;
>  }
>  
> -static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
> +static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
>  {
>  	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>  	struct nvmf_auth_dhchap_reply_data *data = d;
> -	u16 dhvlen = le16_to_cpu(data->dhvlen);
> +	u16 dhvlen;
>  	u8 *response;
>  
> +	if (tl < sizeof(*data))
> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +
> +	dhvlen = le16_to_cpu(data->dhvlen);
> +
> +	/* Validate that hl and dhvlen fit within the transfer length */
> +	if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)

Can't still still overflow?  This should probably use struct_size
to get the size up to and including the rval array, then
use use checked subtractions from tl.


