Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68738C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qffc/qF45xQUUVX0iLvakRS+0SCnFCY/1DsKCxCMUk4=; b=c2SKyxlcVI9y5kEFOi3pusZDQH
	A8Z+1Yk5XeLw7mowdPd0jEAMX+YWlq4mj9bFgQOF52aOel9AVRh6kWZXUpXXj7vBbZrQZoib9+cYo
	fJxZbGtdI/MBBFjEhDvOy0lgSeAHdVGlZFNwKiZ4mCDmuMmI2AiXPWZ1R5H1OP1RZEvWRQHDqbQKL
	Al9wLGVeYzaOJJX04Y4Ua8Q43SGPigqj9n+CbC/gstTW2aD9a91nOXBEvPEO58cW6reTvVKrU32cs
	0vS10BMZ7Pi8wgh3YBD16YHYLJOz6csrFI7E6wYCa5Z4ebe5x0NmV/qP2mffRoRtuE3PxNxswzal3
	QPxvtzrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Emo-008EgG-Nx; Fri, 17 Jun 2022 16:25:30 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Emm-008EfE-Rz
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 16:25:30 +0000
Received: by mail-pj1-f46.google.com with SMTP id cv13so2008688pjb.4
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 09:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qffc/qF45xQUUVX0iLvakRS+0SCnFCY/1DsKCxCMUk4=;
        b=wAIO2EDWPt9yJq/x9HEEskSR3C02F+pRpAErX7nKpKS0imG0sIqFagb1YsDkEC1D3k
         GESZLMQl6bVMoOytWlfsnkosUqmwwy2ny3c2sLA1x3VTm80m0GKTq1p1IQaE0w/ISQQ5
         JK729AWpBRGNNnm07TyCRKJe6Tqnbgw4uo2B6aj5MbrC8nyVu+noyAeRO8NZ/e3b+x+0
         235egKwDX0QEJHaIXpq0gZo3dwjlecctJh91hYY2bn52q260l9fF+wysd9TeM9u2eS9E
         ei86ws5WT6mRTrDms806lf7XcWBFTkWoQc2wWMwqR8h8/vbB9CUBh7fk7I/gkgEATY2E
         jozQ==
X-Gm-Message-State: AJIora++gOqsy+JwKPZH5gfsMypPU96meAuY8LfpirAostgHpe9+tXp6
	MHszFHekc6QtA1XsBBkwSGs=
X-Google-Smtp-Source: AGRyM1v0wKaWpD+fRkQWYGcTmSFjnZvqVDvDVjWy1Fw5laZHlNFrGY0kvjKc1A9gYn6s9UIarDHnZg==
X-Received: by 2002:a17:90b:1b49:b0:1e6:a23:69c6 with SMTP id nv9-20020a17090b1b4900b001e60a2369c6mr11379208pjb.124.1655483125778;
        Fri, 17 Jun 2022 09:25:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001637529493esm3804323plk.66.2022.06.17.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:25:24 -0700 (PDT)
Message-ID: <f559b5d3-cba4-4dff-7db0-5dc24b4078b8@acm.org>
Date: Fri, 17 Jun 2022 09:25:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/5] scsi: core: Remove reserved request time-out handling
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-2-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_092528_951419_2C23A07D 
X-CRM114-Status: UNSURE (   8.35  )
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

On 6/17/22 03:55, John Garry wrote:
> The SCSI code does not currently support reserved commands. As such,
> requests which time-out would never be reserved, and scsi_timeout()
> 'reserved' arg should never be set.
> 
> Remove handling for reserved requests and drop wrapper scsi_timeout() as
> it now just calls scsi_times_out() always.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

