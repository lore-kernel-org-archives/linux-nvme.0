Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CBBEB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PDyuzcBk6PQbCTpKgz9Tbx7bmTFz75mFlhEzafNtxb4=; b=0yuxO9w6URUcOUyYK8WwJKmwAA
	LI8YaSqVQCazOnyEB3Kxsjqy1LDHeV7q9P42xYcN4RMG79bUld6mLNnFTqTscF+Kz7lIZuD+6X6C3
	2X0o7kWuJvK9GCdi7MZmvS+5/f20OSTlEBQ0lgHyNWcghwP1bJMQPkF8Yzq0wvvzqV2zRo2rNTj6X
	BSbzaO0HM7VLmBUHHaF/dK2red6qg984pVbGUyxProgxFV40xM5Sj86DhNMKqXB+iEo1DlFpTjMF+
	f0Wl12+ymQBjVfM/FBszW5in8sRlI3lnZ1q9TjUnvzcAtLT0N6Yh5C5QWhVIvWmUiGculrtqKur6h
	bVBJAusQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFNRC-004kuR-1r;
	Fri, 30 Jun 2023 23:22:02 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFNRA-004ktm-0F
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 23:22:01 +0000
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-26307d808a4so1641164a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 16:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688167317; x=1690759317;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyuzcBk6PQbCTpKgz9Tbx7bmTFz75mFlhEzafNtxb4=;
        b=cYtSMRTEI5w07psM52DG/BxZxZtXW3XL1lnYeK2rzmR/7fCFBte+66r+cIa5joH/yF
         /7Y5hiAb8G2hvizGUk4inwWRGeEAD33WOc34qHme55ysJBD2VokJN1Ob3eduOvqbux1P
         RZ/Z5Ur9m2omoLbTF8zJQu7p7Q4Jti+/p/ynjDlyTt6JmZSfQqWT6hLMHusscjNTvOc5
         s3FOazoSfFDFwRrvjBlZwfbbUj4DSvZuw3AA6Bd0MYmLgha1mrdRic8lT23JBZZXDQKI
         YC6t0X/V7uOZ76lxGde1H3T1zE9cC1THOJkCNaeqERaJpvrwrvA2SvC3KBMnqpcvhr1x
         ryPA==
X-Gm-Message-State: AC+VfDwrX7MhHZqKvGE4ZtnA6HAYsIq7nN+YvLqtMoV/PYTUj+RnjBqy
	JO0EdlHzw5XduR1JXo53WAA=
X-Google-Smtp-Source: ACHHUZ5xAibv08f6GtgtdZBzffTZAsAoRMZX2G85RMGPvdqLDrk61XLvj2DwXhl/JJeHFw/WNPG70Q==
X-Received: by 2002:a05:6a20:9493:b0:11f:6d3c:5418 with SMTP id hs19-20020a056a20949300b0011f6d3c5418mr3761518pzb.22.1688167317408;
        Fri, 30 Jun 2023 16:21:57 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k25-20020aa792d9000000b006636c4f57a6sm10465072pfa.27.2023.06.30.16.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 16:21:56 -0700 (PDT)
Message-ID: <90cbd07f-eeac-5da0-4786-6e212ecd22cc@acm.org>
Date: Fri, 30 Jun 2023 16:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Improve checks in blk_revalidate_disk_zones()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>
References: <20230630083935.433334-1-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_162200_139237_438A2B0B 
X-CRM114-Status: UNSURE (   8.89  )
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

On 6/30/23 01:39, Damien Le Moal wrote:
> blk_revalidate_disk_zones() implements checks of the zones of a zoned
> block device, verifying that the zone size is a power of 2 number of
> sectors, that all zones (except possibly the last one) have the same
> size and that zones cover the entire addressing space of the device.

For the entire series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

