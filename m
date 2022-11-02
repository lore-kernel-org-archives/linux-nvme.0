Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB343C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhcJfbAsBWcPbIOPhmf4NmsmIT2+nCjFL2diMORdIc4=; b=tdJpRMlIy1drvJ1squxqQtjp8i
	qjDftOocnBlKQxyvOhBqTI4JnZ0xQCmlSVfIpn8PSOU5mFED8HX267hrUU/6q0m4/acV3VQYLES1C
	a2SZrW+dhF6JK3dA5q+JCCfsTgCOL7dQFSbdoI6Gp+dceokiFmvj1XKz+FyQWQh1GEgtTwi4X04W9
	vmA0BiUNqw+Ivw5NLH9F+lB6pMHEVjcTjYnNv4Eo0h5tkkgY+xlGlXRCaUnOedwLZRVXBB3QKbxE9
	P0sl2CyPemZVJqoLHKgAFLFWi94QcUsnsu+mM84RzBCLZr23s8YOzprx6RdeBfn8MQ5Oa7tw/1/2s
	MDAQgeqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMdV-00Eoog-Ct; Wed, 02 Nov 2022 22:55:05 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMdS-00Eonr-CR
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 22:55:03 +0000
Received: by mail-pf1-f182.google.com with SMTP id i3so22073pfc.11
        for <linux-nvme@lists.infradead.org>; Wed, 02 Nov 2022 15:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhcJfbAsBWcPbIOPhmf4NmsmIT2+nCjFL2diMORdIc4=;
        b=dvWF/iop0L1z10hosaEn0TPd425Oo+7aSVysQtroFUZh3AZnvHE6eZ2uPm2T2BHHPN
         oxYlMEvp2biGZxPSSueUVNsI232dctDq97GMRmdSNKsqMWqiRzbarcWYXh9x5tY3e2wP
         lwAh3LpRKqYzBletxndpZU72KCgnnSuFgpsJ0L8aaWTvNE1uF6tPQNBUBgzX+s60vV6r
         lf0FGnBP9HrMv5wgXlWe/6TOJetjY6cUVIZ6eeG5HVGiWbsQvRK/qbjC5abH+qpv4Sj2
         BaNj+fCDIcsUL0av3aS1LSYlQb+UEpzrpiq256Q2V7CDYQi3pXoocDQK0a3ukXj/ofI0
         SV/A==
X-Gm-Message-State: ACrzQf3ar4nhCjx3nkoSmHqIOL09J1mS6wlcb5G0MGGeDKooK2UkuCkF
	qHxbrW2UR4yb6QTjiCvK4J6uPV2CBxA=
X-Google-Smtp-Source: AMsMyM6jm80wXzBme3fqf0bXNSyD8N9iJ7BsvU1v+V/kepBM9YQJbRErCViosW8DEAyldaWwwy8RvQ==
X-Received: by 2002:a63:d757:0:b0:46f:9446:273d with SMTP id w23-20020a63d757000000b0046f9446273dmr20335679pgi.436.1667429701140;
        Wed, 02 Nov 2022 15:55:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:22d3:f380:fa84:4b89? ([2620:15c:211:201:22d3:f380:fa84:4b89])
        by smtp.gmail.com with ESMTPSA id pc3-20020a17090b3b8300b00212cf2fe8c3sm3823933pjb.1.2022.11.02.15.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:55:00 -0700 (PDT)
Message-ID: <1b4bde2b-782d-67c2-62c7-8f5c13721fa8@acm.org>
Date: Wed, 2 Nov 2022 15:54:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 04/19] scsi: Add support for block PR read
 keys/reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-5-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026231945.6609-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_155502_449596_A6C48593 
X-CRM114-Status: GOOD (  10.89  )
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
> +static inline enum pr_type scsi_pr_type_to_block(enum scsi_pr_type type)
> +{
> +	switch (type) {
> +	case SCSI_PR_WRITE_EXCLUSIVE:
> +		return PR_WRITE_EXCLUSIVE;
> +	case SCSI_PR_EXCLUSIVE_ACCESS:
> +		return PR_EXCLUSIVE_ACCESS;
> +	case SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY:
> +		return PR_WRITE_EXCLUSIVE_REG_ONLY;
> +	case SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY:
> +		return PR_EXCLUSIVE_ACCESS_REG_ONLY;
> +	case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
> +		return PR_WRITE_EXCLUSIVE_ALL_REGS;
> +	case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +		return PR_EXCLUSIVE_ACCESS_ALL_REGS;
> +	default:
> +		return 0;
> +	}
> +}

Also for this function, how about moving the "return 0" statement out of 
the switch statement?

Thanks,

Bart.


