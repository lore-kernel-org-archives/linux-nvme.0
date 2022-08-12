Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC2FC00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dQDvbXA4ACVH6lKiqYsZS3iO0xWPWnVknLGF5XpG7bw=; b=ken4LBS+ET3Wlktlil2SPmb48U
	8P0dSClyUxa76skMKhiI8gV2WJT4xLY57PfSEiUbBzf9+LOQ6zrN/r4ogQa7XumZQy1L8g2Ss5Whf
	z3dKN4VwQNz7eyrcxcibzzmQTCNuAL2Gq2pgUbNj1XCdN8Y65blcYQmgMZmJIISORQrBb2g0AjzHA
	lp3NxMvcBv6R3DHTL6NhYZFr/m7NW5QP6Dl8sR5K9ar+o/vJ2KMKcpO7B1nGQeCBKHyqB9nu0jOLk
	vOKlNPR2mJJpUncdLzmm6V0sZw/zeEJmYGPF9KUVg+VqlVhd+ttGqpuKhhndixCZFLXrSUNB2Ih/p
	CDfXalFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNkU-00G7Jw-Qu; Fri, 12 Aug 2022 06:02:22 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNkS-00G7IH-T0
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 06:02:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52AAE3F609;
	Fri, 12 Aug 2022 06:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660284139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQDvbXA4ACVH6lKiqYsZS3iO0xWPWnVknLGF5XpG7bw=;
	b=tpgzse9qR18GW0Fqa26kdNaAB2O3iPrL2CXM9IWFhJR88ezzvYkITQNoWDgbYrTiESGKUi
	D9S4qnrNMJeh0j8Ysjjjnn/T3uLuYiyAv88+GHG/Odca315t00DYAnKLyXq1eJ3hO7q0mC
	9ihYMPKh5WEOxBwSL1bQAp+g9++xYHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660284139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQDvbXA4ACVH6lKiqYsZS3iO0xWPWnVknLGF5XpG7bw=;
	b=f/duQWrGW6DwszcZm5ZU8blBbrVa5H+f6tpk+lGT/eWBPqkt8/Ix/lzo1L86ior7rTQf7Y
	2C7BDUaW7VRFoyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 341A813305;
	Fri, 12 Aug 2022 06:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EoJ7C+vs9WK4ZAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 12 Aug 2022 06:02:19 +0000
Message-ID: <794e287f-d863-c450-dc50-b3a27a7b4b15@suse.de>
Date: Fri, 12 Aug 2022 08:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvme-auth: remove the redundant req->cqe->result.u16
 assignment operation
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>, sagi@grimberg.me
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20220812031231.3386953-1-liu.yun@linux.dev>
 <20220812031231.3386953-2-liu.yun@linux.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220812031231.3386953-2-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_230221_113947_E4D6EF87 
X-CRM114-Status: GOOD (  16.26  )
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

On 8/12/22 05:12, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> req->cqe->result.u16 has already been assigned in the previous line, no
> need to do it again.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index f91a56180d3d..c1dfdfb92ebf 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -332,7 +332,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
>   	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
>   
>   	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
> -	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
>   	if (nvmet_has_auth(ctrl))
>   		nvmet_init_auth(ctrl, req);
>   

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

