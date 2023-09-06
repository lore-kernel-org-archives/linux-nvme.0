Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFC9EB8FB6
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KPvKQcU11I1ppKW0Cxmttf5u89JWWvqc2qqFIjOvDCs=; b=ioFq5QuR6FsjMPkDBJPRg7z3l8
	9VamrtR583trf3OYPCDFKyKSfX9MPVQtKlzVvIccDIZ5tc/xoI/MnCvIOtX1kkP/WzULG/5DN9J3z
	rKSGy9rXiQLDTdiR5bOCpWwi34yWt2+RTlEjBCyAKDUEHSni5Z/E7tx1oJX56hRhDTRLuDCHfQ8e7
	7yhx6pxORA6ZVs+4T4hvNCsMyQa01qMjU160j2lz9AVAS3svkdsusiafZLeXot3FhYkIF2W9Uwb41
	uRRiAaibmmxZRANZ9FIaeFEntD0EbDxg6Fg+gBMPXlPAtaB0iasbXtMfjspc5RpkJHLDt/TeUcRJL
	YNkiuzWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqcy-008gO6-08;
	Wed, 06 Sep 2023 11:23:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqcv-008gKi-0k
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 11:23:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 296D121E86;
	Wed,  6 Sep 2023 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693999395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPvKQcU11I1ppKW0Cxmttf5u89JWWvqc2qqFIjOvDCs=;
	b=Clczds3lKdaMEW9LfcujUs16l1nM8d3HLU8ejUWU7gYlPOCSyFbm4cWVzX/L3dYlBWfrQ6
	rBjQ8Ap/bDcgWu1RYRwGiD3rODv57tQPximIDW5coac4FxxTerODAMhjmWWg8XguRLmX44
	ctEVd7Uoas5v9AcdA/tes0zQX5on++Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693999395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPvKQcU11I1ppKW0Cxmttf5u89JWWvqc2qqFIjOvDCs=;
	b=nU0YTpUVY5U53Zd7xksP8dVbYQY61KWqO91FzjFSeoSy/rRPhRjSzRUAJdfYZCkPFj2pUT
	tfU2YxT3gRrVupBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 991351333E;
	Wed,  6 Sep 2023 11:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UItbIyJh+GRXUAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:23:14 +0000
Message-ID: <ba517afc-c99c-4712-9166-bed9958e6124@suse.de>
Date: Wed, 6 Sep 2023 13:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Jason Gunthorpe <jgg@ziepe.ca>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_042317_407355_E9DA512F 
X-CRM114-Status: GOOD (  16.43  )
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

On 8/29/23 11:13, Daniel Wagner wrote:
> The port entry binding might not be existing and thus the req->port
> pointer is not valid.
> 
> Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/discovery.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 668d257fa986..fc113057cb95 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>   		goto out;
>   	}
>   
> +
> +	/* No port assigned, portentrybinding is missing */

Missing space.

> +	if (!req->port) {
> +		req->error_loc =
> +			offsetof(struct nvme_get_log_page_command, lpo);
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		goto out;
> +	}
> +
>   	/*
>   	 * Make sure we're passing at least a buffer of response header size.
>   	 * If host provided data len is less than the header size, only the
Otherwise looks good.

Cheers,

Hannes


