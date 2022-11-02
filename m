Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DC6C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4wIJC4qmLD8sZv7FELeKq1bWLCLMI4X8kEQubd/l6g=; b=TsvbJoGpE47qTfwd9a4/BHJx7I
	IuasZrDkgH3M2PcvfJIJhPAaVb2E1d0iZKnY+oQRFMl2jzwJLNUeTsbHC9aJzBdbjEUCxi3p50ZP8
	Smc0gbr3a3mbHph8OCEJENdU1XeB4MZt+vHAh1BtTk+x40writl3eYEJNGu4AWR6SR8q89kLh8Xb+
	Ih15LFHvrX79L1asuVfS0HKR9+wdeyDeicqY/wGp6riRtwtALHYIW7bMjMfJT9XrhZbQz8Zr69Oh3
	j+xPZcShdjpfjvYbue+PRjdSlVFe8K7uGEuvCRAD/C9Y88wC90J3mNFRg2BPI7vl1mdkpRRb6GO+t
	G9ZamF/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMWT-00ElqI-WE; Wed, 02 Nov 2022 22:47:50 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMWR-00Eloo-L9
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 22:47:48 +0000
Received: by mail-pj1-f43.google.com with SMTP id p15-20020a17090a348f00b002141615576dso3490059pjb.4
        for <linux-nvme@lists.infradead.org>; Wed, 02 Nov 2022 15:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4wIJC4qmLD8sZv7FELeKq1bWLCLMI4X8kEQubd/l6g=;
        b=nVFa9lAt4mVDTLi0wNbXQmfjjn5nNfSb4S6P2himTgf+R1egWdJFU+nsodPY1osB6u
         RQ+v/1eewNcv3Yo5w062QTMMSVm+kfqQTnyq1FsiGLgQCSmQyIzzwHBLbq/THlwOpWhe
         z/5zBCvRjqIjt0lJvynTIAZHK4ncXE5pwUY6K7/5VQJgoqXFg9Yjvr6kVO3j5ENgsOsa
         Vkn0AnpysWOP7IZT6uvsKkBylJb4uBoqobcMu8w6hkpkhyL73Pk4q8rX0EIdFrxcGKW7
         b7CUilfqZDnggTtre9xNOzuuZoIYA6Ah4KackC3G0H2zBJu46zci+B168v7kgEB8aGNZ
         AaQA==
X-Gm-Message-State: ACrzQf0BQ7/vY2Lm1dh39CpTew3Hy94uYmUN/mvQWCoUqLD/zMydzm2t
	E9AO4PgiiE51oVhUGAWEr4dCdvnVJT4=
X-Google-Smtp-Source: AMsMyM7oTR2d5lchMffcmjpS1vJGXh4SAt69GYPXVjFJ2dUHdIGIroDKm3Sonab/kAsDMsRgrqXqvA==
X-Received: by 2002:a17:902:bf08:b0:178:90fb:8cda with SMTP id bi8-20020a170902bf0800b0017890fb8cdamr26566977plb.9.1667429265258;
        Wed, 02 Nov 2022 15:47:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:22d3:f380:fa84:4b89? ([2620:15c:211:201:22d3:f380:fa84:4b89])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b0017f7628cbddsm8842988pll.30.2022.11.02.15.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:47:44 -0700 (PDT)
Message-ID: <0123db70-6217-135a-4101-0609512e723b@acm.org>
Date: Wed, 2 Nov 2022 15:47:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 03/19] scsi: Move sd_pr_type to header to share
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-4-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026231945.6609-4-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_154747_717934_6328FFC2 
X-CRM114-Status: GOOD (  11.41  )
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

On 10/26/22 16:19, Mike Christie wrote:
> +static inline enum scsi_pr_type block_pr_type_to_scsi(enum pr_type type)
> +{
> +	switch (type) {
> +	case PR_WRITE_EXCLUSIVE:
> +		return SCSI_PR_WRITE_EXCLUSIVE;
> +	case PR_EXCLUSIVE_ACCESS:
> +		return SCSI_PR_EXCLUSIVE_ACCESS;
> +	case PR_WRITE_EXCLUSIVE_REG_ONLY:
> +		return SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY;
> +	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
> +		return SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY;
> +	case PR_WRITE_EXCLUSIVE_ALL_REGS:
> +		return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
> +	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +		return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
> +	default:
> +		return 0;
> +	}
> +};

Please leave out "default: return 0;" from the switch statement and add 
"return 0;" after the switch statement. That will make the compiler emit 
a warning if a value is added in enum pr_type but not in the above function.

Thanks,

Bart.


