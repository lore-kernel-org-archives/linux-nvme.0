Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808FC25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaqrNdsyYTMFH340gDGudDb4bNK2dGQ8UdGtOAL0GZs=; b=0OKkjs68LNzHWOvVj+5hy8x2aB
	NsX840I+6dx4UVpMfIaXo4W3TL+YM9mFws5ARcUOsLIna9ZUSMkRN4P3HEaX4CKSXqdYIQ0n6FTq1
	HsShTE0IARID4mtKUL3jepBD7SlZiXF9GWG77bM4zzbkhtoA9llqWS0D0IjEu99+jlrTZp/hrPS7v
	4H4YjTOD9FlE4d9huv/GgAtQlH8E/+ObtGpMGgCXVJw0r+Wc7mS0fZabiqhULn/V1i/wK4F2cCTON
	qfx8tIVjcqCAGCW5j3x29ZflIHkPLWJeZp2wRgjnTjzbcI+c4TPK+6N1CMbNCKfY6O/K0zb/ng3e3
	S4rfO0sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCO9C-00000005EHb-2vBw;
	Wed, 29 May 2024 18:35:38 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCO99-00000005EGU-36bS
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 18:35:37 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-24fd96c5490so15559fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717007733; x=1717612533; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaqrNdsyYTMFH340gDGudDb4bNK2dGQ8UdGtOAL0GZs=;
        b=Jyb5wRw1lcQdgqE4/mmZw//pi+RKrltil7nY4RcCRtBJoN2JidD+uLjA/KFz8brlpm
         2giZbz4BLD538w/nfVi09fDhi2ZtlbT0BXnjX1zVJ3dxeowQIfO6yeSBy2vr0SadXt+B
         WubQ762f1eurTnhzF558U3U8x/1sG9d+icwM/b5UI231EAAXcHTDK6QQ3EK6lmhodDDT
         TecT4tB40cKKMVaUPDdjoPWt+RK8huuqQHyc/DHcG+2NNpNl0tW4G/whGU6dUwYDfSkA
         Vu7VfKhW9CZ2aU04mFzZx38goKmeo0gOnrAJbfOYLOeHkVzxPMvLmdOjcxTDukZh5pdk
         08iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007733; x=1717612533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaqrNdsyYTMFH340gDGudDb4bNK2dGQ8UdGtOAL0GZs=;
        b=BR7+KpX8r0GXCKGjzRadkEnHfPedTbCLhEsC0ERUl9X+aDOjgwdABIV2p834sGLxbq
         K+rj3uFnTHxhDNH6FGE43TkqYTBRgCx/7ItTSJ0toqPiDkR0ElAU00UbL3Lw4M+hTEE/
         hi2RAyEGK9SyPUQjHGjblVKoYHldN93oIkNKejdKKa3ddo+S1q5chEYhy41ZZiZ6v489
         evhaTk2gYHOhMl6zhK6+ipPH1mbfRy5C30zQvDPx8SYYSsNWGcp8+QsNgK/wv2Q0sQ+z
         x5DohacW2bNODHWkZuGwCqfE393xr1I0Y9LI+zQQ8zkYXJP1FNaZiNU3uBYL+BPHuiTs
         mlZg==
X-Forwarded-Encrypted: i=1; AJvYcCW05u1fntPodz8kcajtO0hEOO/jrVHzUWFhMfbqkjFm/nReiF2g5X+ETmF79wriFGAYPabOfbvdqVcDTRUctrFvuGQ3woluXel1xZ3vlB4=
X-Gm-Message-State: AOJu0YyBuVTRymv8L2qpMm9BJqSBOlLxavq7cYl8hpWAwu9xLLCer8Y4
	OAwXOnCrCMbRB4FPhCXz9eRGpkoGxW4yDqZ1oYgbAnupk8paoBWe
X-Google-Smtp-Source: AGHT+IGPnyjeMYDMobT12yUVZKOsuHbzfF/7EQCu02r/X3uzjPiVBRhclEvU8GPGP/5sv/TcyQzW/w==
X-Received: by 2002:a05:6870:c6a1:b0:24f:e3a1:1d21 with SMTP id 586e51a60fabf-25060b6f818mr83581fac.14.1717007731726;
        Wed, 29 May 2024 11:35:31 -0700 (PDT)
Received: from [10.69.43.60] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fdf8c2528sm13126301cf.83.2024.05.29.11.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:35:31 -0700 (PDT)
Message-ID: <c342ad40-5705-4907-a34b-dbd9aa878c0e@gmail.com>
Date: Wed, 29 May 2024 11:35:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] nvmet-fc: implement host_traddr()
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240527051525.762-1-dwagner@suse.de>
 <20240527051525.762-6-dwagner@suse.de>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20240527051525.762-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_113535_830798_2C25DB35 
X-CRM114-Status: GOOD (  23.17  )
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

On 5/26/2024 10:15 PM, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Implement callback to display the host transport address by
> adding a callback 'host_traddr' for nvmet_fc_target_template.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c       | 33 +++++++++++++++++++++++++++++++++
>   include/linux/nvme-fc-driver.h |  4 ++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index fd229f310c93..b4706a8a9837 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2931,6 +2931,38 @@ nvmet_fc_discovery_chg(struct nvmet_port *port)
>   		tgtport->ops->discovery_event(&tgtport->fc_target_port);
>   }
>   
> +static ssize_t
> +nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
> +		char *traddr, size_t traddr_size)
> +{
> +	struct nvmet_sq *sq = ctrl->sqs[0];
> +	struct nvmet_fc_tgt_queue *queue =
> +		container_of(sq, struct nvmet_fc_tgt_queue, nvme_sq);
> +	struct nvmet_fc_tgtport *tgtport = queue->assoc ? queue->assoc->tgtport : NULL;
> +	struct nvmet_fc_hostport *hostport = queue->assoc ? queue->assoc->hostport : NULL;
> +	u64 wwnn, wwpn;
> +	ssize_t ret = 0;
> +
> +	if (!tgtport || !nvmet_fc_tgtport_get(tgtport))
> +		return -ENODEV;
> +	if (!hostport || !nvmet_fc_hostport_get(hostport)) {
> +		ret = -ENODEV;
> +		goto out_put;
> +	}
> +
> +	if (tgtport->ops->host_traddr) {
> +		ret = tgtport->ops->host_traddr(hostport->hosthandle, &wwnn, &wwpn);
> +		if (ret)
> +			goto out_put_host;
> +		ret = snprintf(traddr, traddr_size, "nn-0x%llx:pn-0x%llx", wwnn, wwpn);
> +	}
> +out_put_host:
> +	nvmet_fc_hostport_put(hostport);
> +out_put:
> +	nvmet_fc_tgtport_put(tgtport);
> +	return ret;
> +}
> +
>   static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_FC,
> @@ -2940,6 +2972,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
>   	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
>   	.delete_ctrl		= nvmet_fc_delete_ctrl,
>   	.discovery_chg		= nvmet_fc_discovery_chg,
> +	.host_traddr		= nvmet_fc_host_traddr,
>   };
>   
>   static int __init nvmet_fc_init_module(void)
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 4109f1bd6128..89ea1ebd975a 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -920,6 +920,9 @@ struct nvmet_fc_target_port {
>    *       further references to hosthandle.
>    *       Entrypoint is Mandatory if the lldd calls nvmet_fc_invalidate_host().
>    *
> + * @host_traddr: called by the transport to retrieve the node name and
> + *       port name of the host port address.
> + *
>    * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
>    *       supports for cpu affinitization.
>    *       Value is Mandatory. Must be at least 1.
> @@ -975,6 +978,7 @@ struct nvmet_fc_target_template {
>   	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
>   				void *hosthandle, struct nvmefc_ls_req *lsreq);
>   	void (*host_release)(void *hosthandle);
> +	int (*host_traddr)(void *hosthandle, u64 *wwnn, u64 *wwpn);
>   
>   	u32	max_hw_queues;
>   	u16	max_sgl_segments;

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


