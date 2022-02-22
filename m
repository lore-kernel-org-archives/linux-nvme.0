Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C1FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ys7mHe6FnSVhYOid+s635onALiH7pEF7nEVAN3W0xs=; b=JPqjr0S1slxwqEUP2OBkV5wiY+
	Qf4S9TRjYi1Akr2uaEYFURD5S+bXtTFBvSKiw8Ec4cltEAIYOkcvLxO4edANUg2q6jWlq20RXov47
	rW6ebhEkicfhKq49iNGFeCu+ho8TwPIIMBc5T3Rz1guHXyQcSD7uhClLeZSYHMAsAolimadjdLSDp
	1wkIl7zcUkzg6ZIQ+1qpGNpwWZGsKjJQdRLASwJDRd92hddaHFA9mdfdbDoYlMfc1oHWmRWLs45SU
	Vzukuw77AHwqy+rN8JZEFHEOFTo/MI8kpEb2GUoXKxxT1S990x9AX+UlMJG39kWqgHC12SoXqAL9v
	dHrDa/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMRds-008nCh-8d; Tue, 22 Feb 2022 09:39:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMRdk-008nAE-Dh
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 09:39:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35161210F0;
 Tue, 22 Feb 2022 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645522761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ys7mHe6FnSVhYOid+s635onALiH7pEF7nEVAN3W0xs=;
 b=OBxdfm9IWym5kJE68xA5QKEjaKsIFzyhKwhUXoSRpThgyzPkGJlgj42iidy4qnJOvngRK0
 2Yqa+KKDkQjU1BIftcMwpalw07Ywgpv6orXjMK8EHLFBirfWEGTEzopd8hFuHtbVur7kLD
 jtaSz+XPJ/SizOMnnrbalg/xeryFZ2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645522761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ys7mHe6FnSVhYOid+s635onALiH7pEF7nEVAN3W0xs=;
 b=iZqQKgmuiS6KDMD1v5sC4JK5dosEyMwCYhJF2E67CyNwZflzLQwQQt2G7MKyFyHJ53m1b4
 MmFiinoNDXJnTiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDD113BCB;
 Tue, 22 Feb 2022 09:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vQdlBUmvFGLfYgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 22 Feb 2022 09:39:21 +0000
Message-ID: <c400d418-8fb2-a603-d669-077b2d09f789@suse.de>
Date: Tue, 22 Feb 2022 10:39:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvmet: parametrize maximum number of namespaces
Content-Language: en-US
To: Aleksandr Dyadyushkin <alextalker@ya.ru>, linux-nvme@lists.infradead.org
Cc: Aleksandr Dyadyushkin <alextalker@yandex.ru>
References: <20220222085415.292729-1-alextalker@ya.ru>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220222085415.292729-1-alextalker@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_013924_658789_B815356A 
X-CRM114-Status: GOOD (  23.87  )
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

On 2/22/22 09:54, Aleksandr Dyadyushkin wrote:
> From: Aleksandr Dyadyushkin <alextalker@yandex.ru>
> 
> Allow the end user (i.e. the administrator) to set maximum number of
> namespaces (and thus NN and MNAN implicitly) via module loading-time
> parameter, without a need to modify and rebuild source code.
> 
> Most of all this can be helpful for mock-up configurations and possibly
> really sparse NSID assignments.
> 
> For backwards compatibility, default values are left as is.
> 
> While permitted values are choosen as high as possible for the current
> code architecture and standard limitations, it is worth noting that
> allocations at 'nvmet_execute_get_log_page_ana' might yield a failure in
> runtime on systems with high parameter value and low free memory.
> 
> Signed-off-by: Aleksandr Dyadyushkin <alextalker@ya.ru>
> ---
>   drivers/nvme/target/admin-cmd.c |  6 +++---
>   drivers/nvme/target/core.c      | 28 +++++++++++++++++++++++++++-
>   drivers/nvme/target/nvmet.h     |  2 ++
>   3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 6fb24746de06..940297233986 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -278,7 +278,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>   	u16 status;
>   
>   	status = NVME_SC_INTERNAL;
> -	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
> +	desc = kmalloc(struct_size(desc, nsids, nvmet_max_namespaces),
>   		       GFP_KERNEL);
>   	if (!desc)
>   		goto out;
> @@ -428,8 +428,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
>   	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>   
> -	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
> -	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> +	id->nn = cpu_to_le32(nvmet_max_namespaces);
> +	id->mnan = cpu_to_le32(nvmet_max_namespaces);
>   	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
>   			NVME_CTRL_ONCS_WRITE_ZEROES);
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 5119c687de68..1b925b40074d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -15,6 +15,32 @@
>   
>   #include "nvmet.h"
>   
> +static int max_namespaces_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops max_namespaces_ops = {
> +	.set = max_namespaces_set,
> +	.get = param_get_uint,
> +};
> +
> +/* Account for 0h NSID */
> +#define NVMET_NSID_MAX (NVME_NSID_ALL - 1)
> +
> +u32 nvmet_max_namespaces = NVMET_MAX_NAMESPACES;
> +module_param_cb(max_namespaces, &max_namespaces_ops, &nvmet_max_namespaces, 0444);
> +MODULE_PARM_DESC(max_namespaces, "Set maximum number of namespaces per subsystem (default: 1024)");
> +
> +static int max_namespaces_set(const char *val, const struct kernel_param *kp) {
> +	int ret;
> +	u32 n;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret != 0)
> +		return -EINVAL;
> +	if (n == 0 || n >= NVMET_NSID_MAX)
> +		return -EINVAL;
> +
> +	return param_set_uint(val, kp);
> +}
> +
>   struct workqueue_struct *buffered_io_wq;
>   struct workqueue_struct *zbd_wq;
>   static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
> @@ -562,7 +588,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   		goto out_unlock;
>   
>   	ret = -EMFILE;
> -	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
> +	if (subsys->nr_namespaces == nvmet_max_namespaces)
>   		goto out_unlock;
>   
>   	ret = nvmet_bdev_ns_enable(ns);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index af193423c10b..ed4873963cc3 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -506,6 +506,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>    */
>   #define NVMET_MAX_NAMESPACES	1024
>   
> +extern u32 nvmet_max_namespaces;
> +
>   /*
>    * 0 is not a valid ANA group ID, so we start numbering at 1.
>    *

Please make this a subsystem attribute.
That's precisely why we have configfs :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

