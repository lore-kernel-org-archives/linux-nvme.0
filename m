Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3B0C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/in2Zquib1R/suhnfCwLcSUTOEiy16DahN9wbF1GO8Y=; b=0ETW7I83gUw2VxaPYyd9dSVSK7
	J+dCcAuW5wkcvXJa0ovY6UxCJ4CJKkqBEMu4ZRrp3/shjM3yST/+f27pqUeZFxehyU/d7lCW0EOi1
	Qq9x294f7/jdp0rkwcuiuJPudlGCkN2wNRT/xWls0gdD7OComs3yEmqoMTyMEWy/6iAmRkLLIBLOx
	yvYR+z4blAgnJeHUSuUz9C7C3l4DQwlN4n/A9FckH53FEB35TdzJ+Nwt/zA1QMTnhRq+KOr6Ebu9p
	d+Q15W5+Ty8H67PcDjRb8wdyftQBF79Fe8D/pnQIWg1CeHbV2LUSsZbA434GOA4wZtGAPfiWFL9Sz
	xN/E6kjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC4sL-004qnL-So; Mon, 24 Jan 2022 19:19:38 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC4gA-004l3b-MP
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 19:07:04 +0000
Received: by mail-pg1-f177.google.com with SMTP id p125so16262525pga.2
 for <linux-nvme@lists.infradead.org>; Mon, 24 Jan 2022 11:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/in2Zquib1R/suhnfCwLcSUTOEiy16DahN9wbF1GO8Y=;
 b=W8sqHAoblx0DubdTosGVjx6AE8k+f/4SCMH8eM+C1AjqX1ZrmapW8NWGWyfaleE3j9
 DhniTM8qSdWqjeHsOpTuoCQQyh/ABfhCfy/CBdWu0RFED5zqttHFB7OzmZN7N2eJY/6u
 oBi/dOt8blcQ387Opr3u0uqQcfZabx0W/puVx5hixfkhfjOFZnsNdU4yZoFvYIe+t+7j
 DoaLS3wR5URLEew4pmhwVCLJ3NYlSCQcIOVyB2kdlV6NzlJGocUD94qTqvmAhCC6gynE
 SNA8Eogp1cVGnh6hps3qZKfVtIvppuozH4KrSq9pjA/fPo7CTPEaHjQpvsB+0o7pwvCN
 rz7Q==
X-Gm-Message-State: AOAM530AtQ3gQEZ1+FE8Vj7hj8FzBhOjj0IR+vLpp4h0o5p7y6ZhVTVz
 UAeTVcZLoUlhVAjCke77tZs=
X-Google-Smtp-Source: ABdhPJzN1Rt66uSagpGi52DoFvcrRKrO0D3D+xgF1VaFuvMpxo96ESUmfjIkXXXEsC3DFcDIUjMh4g==
X-Received: by 2002:a63:eb07:: with SMTP id t7mr12718988pgh.112.1643051221185; 
 Mon, 24 Jan 2022 11:07:01 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id t15sm110258pjy.17.2022.01.24.11.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jan 2022 11:07:00 -0800 (PST)
Message-ID: <ea04773f-f92e-4f62-34a3-2f97a74dc6fe@acm.org>
Date: Mon, 24 Jan 2022 11:06:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 07/13] block: move q_usage_counter release into
 blk_queue_release
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-8-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220122111054.1126146-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_110702_791522_A43D6BD8 
X-CRM114-Status: UNSURE (   9.42  )
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

On 1/22/22 03:10, Ming Lei wrote:
> After blk_cleanup_queue() returns, disk may not be released yet, so
> probably bio may still be submitted and ->q_usage_counter may be
> touched, so far this way seems safe, but not good from API's viewpoint.
> 
> Move the release ofq_usage_counter into blk_queue_release().
                    ^^

Please change "ofq_usage_counter" into "of q_usage_counter".

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

