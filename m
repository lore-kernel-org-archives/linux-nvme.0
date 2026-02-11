Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA201ECD6C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cKCjb9/+xt93VUi9qHeZo5wWA7PUsZ47aTa70QQkgbc=; b=3ioOj+QCdbjSvt87QClTwNl524
	S+J/ClHLHyd0QU/EgghUBwz8TuQFhzqb485GylozUtP998eWvMqD+FDYe5nlPzq64wZ2KDtrhPmeX
	tT3x7DxGzXIICEq+cN8CdQckI8zHE1M5KbWHxrtOHuq6G2R6UhV8Mv9FsRHXGmbg05Biz6HNVVkzH
	M/GkwFcS7/fiO543z6mO2Kfjq8WFh4F6a9qj6sHxBkDmXfe7Ma3wVOMIBrn89ykqAB0Ap1HkqOpdL
	coJBcnaDByEtQpkDT3aQZlvauVNfqpPaKF/s+03bHRYbHvur2XXnn+FWaySwke0ZOtTSzx/VMQF56
	fda0ha9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCm3-00000000pTQ-3toQ;
	Wed, 11 Feb 2026 16:09:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqClz-00000000pT4-3Npo
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 16:09:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5AFE68C7B; Wed, 11 Feb 2026 17:08:59 +0100 (CET)
Date: Wed, 11 Feb 2026 17:08:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Subject: Re: [PATCH] nvmet fabrics-cmd-auth.c : validate negotiate payload
 length(KASAN: slab-out-of-bounds in
 nvmet_execute_auth_send+0x1d24/0x2090)
Message-ID: <20260211160859.GA11869@lst.de>
References: <20260211055036.2675866-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211055036.2675866-1-ioerts@kookmin.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_080904_058230_BAA5AE27 
X-CRM114-Status: GOOD (  17.72  )
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

On Wed, Feb 11, 2026 at 02:50:03PM +0900, YunJe Shin wrote:

> < snip>

Please don't spam the commit message with the entire backtrace.

> index 5946681cb0e3..2bcee44b3395 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -289,6 +289,15 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>  		goto done_failure1;
>  	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
>  		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
> +			size_t min_len = sizeof(struct nvmf_auth_dhchap_negotiate_data) +
> +				sizeof(struct nvmf_auth_dhchap_protocol_descriptor);

This should be be using struct_size.  And all of this is way too long,
please use the chance to split this out into a helper:

		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
			if (!nvmet_restart_dhchap_auth(req))
				goto done_kfree;
		} else if (data->auth_id != req->sq->dhchap_step)
		case 

		struct_

> +
> +			if (tl < min_len) {
> +				status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +				req->error_loc =
> +					offsetof(struct nvmf_auth_send_command, tl);
> +				goto done_kfree;
> +			}

None of the functions here uses nvme errors returns, but instead uses
dhchap_status.  Should this be NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD
instead?  (not really an expert on the dhchap status conventions,
maybe someone else can chime in)


