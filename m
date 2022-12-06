Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5815C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kkdpynN3ZZxXXoC+/B2qsqOUkzGgxT1EtXnN9c8yuhc=; b=DIYbKFE9dGeJpgSqsck3hDPfHq
	N+7H6+87OTjb1PF0JxLzKZOcneLf+DRW4scAxRRmiDjzHCibwE96br1KkOWGTwXZcIDturSKgE606
	lbAImRcbxjubVfA7ICy2Z7r0WYnrKRPe6yeGxFBp7WmZmBe+pRtR84K8koI9Td+pqMZrU1fDd8Tbc
	MC5j78le4jGc7Ta33YR+S92JHkXgiVPUAaOUXoSjy6SW2ulF4EwIj072CFy+j3BY0mjnQP/iC7Vzf
	dKFX4jLVpbOD0l9/hFYC/H57fHDC2ZHQbiFMauw8SFAtq+6910aS3l9aRce7xzBPQnrXQdakADZMU
	HR6Kn+5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2cvB-00HROq-3F; Tue, 06 Dec 2022 18:44:01 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2cv7-00HRFi-Tx
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 18:43:59 +0000
Received: by mail-pl1-f174.google.com with SMTP id jl24so14801144plb.8
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 10:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkdpynN3ZZxXXoC+/B2qsqOUkzGgxT1EtXnN9c8yuhc=;
        b=wFFq3TMHQ8TmjpSFof3HtJaDumjkTckKJsn6Qdn73NxQqQkrzQKrYRYRm5Qf9UcTp1
         uLE9F1epPcj2B1Vk4jopmZVpup2e7mTkmjl9rpEfsV25bsnpWpfBEInM1MLZkK7W4Tyy
         bGLf0n0BfPScsC3gGjkGp5CysjBn/2/ZghlJvDYr2l5FAGIbhRJa/FO9EP2RBo0Kb5MK
         RcxLV2192bYdMjY07goVueXeXeIfqM8/ojGla0KXhZPCiUQg5b0x0L4rdUz8Ca9QR1Jx
         Txs4zZSbjP4VeAE1Q8oOVT+g6vJson4smdaN09UU1FwS/Dv8sDlwBa4bqgVvgstAVDYO
         En4A==
X-Gm-Message-State: ANoB5pmLa0hmJkSEITOO9q7w7UXv14GOtJT1h2SqjNS5NTQrgYxYgMud
	asNvSZm2tkV/n5wkuP4Uiq6gMAKJ52w=
X-Google-Smtp-Source: AA0mqf7j+ouvNKByY6CjriE3yqeB9gzC2l06X8kaUAU+HcxR8ONUrkX2oxkDdJixvxaJgsfMp5zJAA==
X-Received: by 2002:a17:90a:bd96:b0:219:3553:4ff5 with SMTP id z22-20020a17090abd9600b0021935534ff5mr45767962pjr.22.1670352235149;
        Tue, 06 Dec 2022 10:43:55 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:6220:45e1:53d2:e1cb? ([2620:15c:211:201:6220:45e1:53d2:e1cb])
        by smtp.gmail.com with ESMTPSA id a1-20020a63cd41000000b0045dc85c4a5fsm10068334pgj.44.2022.12.06.10.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 10:43:54 -0800 (PST)
Message-ID: <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
Date: Tue, 6 Dec 2022 10:43:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_104358_009616_4196530E 
X-CRM114-Status: GOOD (  11.34  )
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

On 12/5/22 08:20, Alvaro Karsz wrote:
> +/* Get lifetime information struct for each request */
> +struct virtio_blk_lifetime {
> +	/*
> +	 * specifies the percentage of reserved blocks that are consumed.
> +	 * optional values following virtio spec:
> +	 * 0 - undefined
> +	 * 1 - normal, < 80% of reserved blocks are consumed
> +	 * 2 - warning, 80% of reserved blocks are consumed
> +	 * 3 - urgent, 90% of reserved blocks are consumed
> +	 */
> +	__le16 pre_eol_info;
> +	/*
> +	 * this field refers to wear of SLC cells and is provided in increments of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/*
> +	 * this field refers to wear of MLC cells and is provided with the same semantics as
> +	 * device_lifetime_est_typ_a
> +	 */
> +	__le16 device_lifetime_est_typ_b;
> +};

Why does the above data structure only refer to SLC and MLC but not to
TLC or QLC?

How will this data structure be extended without having to introduce a
new ioctl?

Thanks,

Bart.


