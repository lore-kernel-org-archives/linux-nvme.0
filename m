Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2AEC4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:59:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CFA61050
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2CFA61050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/Qc1gdwndJjKNwiLK+yBGeClTTscZWWncPClROeGtY=; b=TWAN8Dr45k+ZzizyevCMRjLqDa
	Z5qv4AkfIfI6708vF5hivab1wTIkxKbpDIxOqLJppJrLZl9Y6Lkr2XTdo1sALdycTI1iJ8N+NFj19
	GFl5QoNy6FKPRvU3QAoN0F+c9SaoZKgIRqdPPWd4AKddAmlIm70+jo+VO7rrPDG90brW+RODSEpqH
	mRJzdoP1ZqhB4liT9bIlP9SFJ1016V0di6DSgv9V8+VodkjkR8eMAWvNFVtN4hDBl2N9ZesgGF8hD
	vaJUWlEmkksVTZNaCuni1jRZ5HcKUDujnlw/JbtmdiUJYM5CBatFBOcBgjhktR4EbFftC+UwskBJe
	sV+v1Uaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC600-00DOgH-SR; Fri, 06 Aug 2021 19:59:20 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5zy-00DOf4-45
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:59:19 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 u5-20020a17090ae005b029017842fe8f82so10288094pjy.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3xIgCNAaZK0sIEmcnOuEBKGBHm8act9qqO5YgCOEC6M=;
 b=MeoawvsnXemgQpHNUCtfuZQzmsdEGU4WapwjZ3g1LnZkrm9StDFC0p2KN+WgMiclkT
 cha6H3hqUWxmOLYOkSm0XlfljdHnW4Qth2entMk+YMQR4uSedKn8bSt+T2efO92cdCMn
 GY1U2+MaJtCKfNloF7aYH7+EWwX2WaF1tLJ8JxoOlzz+LCfXxJei6Gvu74dRXwEUVA53
 HTUr7JxSDhJ8iR7HMxMMjia/P4WCqRuNP6qMFaq8K9RrsmDo6dPxmP1MPHJA6gD6szoU
 Qe0IgQ9Z85pBbQf850f2iXiR/xWAzf31nhV7BXRFIvXZLrHK8n5JBhmlVxjT98l9GCYf
 +Gvg==
X-Gm-Message-State: AOAM5339n2Uv1tAXV93uxNuq1Q/GRb4YGYjcY3dIbh934C4eR8qwLqGj
 DfRROE6JQqHwkF9uZwXn+yg=
X-Google-Smtp-Source: ABdhPJyjtmQrOgrUjWWnqpG1hRQ5cnxUh/NvPNKbNRvyCYxgVMhOqZcamDHfenyBNaNu6hatxX4ETA==
X-Received: by 2002:a63:e116:: with SMTP id z22mr409709pgh.361.1628279957382; 
 Fri, 06 Aug 2021 12:59:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id a5sm11398251pfo.167.2021.08.06.12.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:59:16 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
Date: Fri, 6 Aug 2021 12:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-9-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_125918_219302_B9C4EC06 
X-CRM114-Status: GOOD (  19.60  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
> called unconditionally. When we reconnect we need to pair the freeze
> with an unfreeze to avoid hanging I/Os. For newly created connection
> this is not needed.
> 
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/rdma.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index de2a8950d282..21a8a5353af0 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   			error = PTR_ERR(ctrl->ctrl.admin_q);
>   			goto out_cleanup_fabrics_q;
>   		}
> +	} else {
> +		nvme_unfreeze(&ctrl->ctrl);

That seems misplaced.. unfreezing the I/O queues when setting up the 
admin queue?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
