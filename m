Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B6EC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mpNPhPM1LO9QInm9E5liSFlKjT3q51L1wYmcK4UmSmo=; b=MeyhNf3malvJYnbIbmE64YJXbe
	+MYBrQK4B+OcpqrYkDZ5FYCXnK+WS8+KN3GgQUb41TW19828Y7Ojl4ws1O68ru9SBupTxcnATVm2P
	OuFRqiHx8KJCPrdcxpSqNly8ouySuHPj2P2K3BLrTCcxkgmZvm/vBmYDMaf3L3DYHZZywrCa7//83
	EWUkJho/yvL1fl0lKFpTjPNCnBUVAJ6qD9K5jvsz83NOB+OVQV6H7OIswr46zw6kEOYCdZ6ZsW0B0
	Sa6NYGGVLszopIvBJ5RaBVYiN6yKCClIs4XnGi9/I3zEJ2GWeKUQnnrb6yq29RaU20VYxopQbFNd1
	4xuAbwiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSsR-00AnY6-2L;
	Fri, 11 Aug 2023 14:12:31 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSsO-00AnWj-1i
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 14:12:30 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bba9539a23so3739415ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691763141; x=1692367941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpNPhPM1LO9QInm9E5liSFlKjT3q51L1wYmcK4UmSmo=;
        b=H8gLov7a0sZgLOlXA4+UgCisSi8VRddHwOavRREwHv9UqPD9uoWnIzqf1zlYr3tb5+
         qIP6+YhW6q/NrGqiPur0wQz3TRLc2CxM9DfKgH02VbXFaBfZ4DikKm48s2wpOuHkkYrt
         RAZ1XMBEL1SdX/rDzEqWZoMMNyfpHMIlYigMbsSQHR4hamcE3UytMSLMWvqzihVMIhJW
         71k45moTj+RrHBd6duqTbtNJN+33FENhoigr3dqJ+SiELV2Qpwr6UAtcGCAVP8XSvLba
         WUqQpBoJlK5tfF7tXxB6VBsptZ5V+yEXi1AXFCaIP3vLW8bFmvI/1J1BXYZrQd7nhH7h
         0tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763141; x=1692367941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpNPhPM1LO9QInm9E5liSFlKjT3q51L1wYmcK4UmSmo=;
        b=MAE/VKrwtOObMcDgv6kh4F6XbVOhnVSEWsbMw60srDsAGzb9Y3wfEHhCskIBrh8Gzt
         H/8PEoZ1y2Akyo8wM4Nu2Ka1qD3P9EK4gdKJy8c+Ea7ysEVHvQX0nrdkCnLYcgXcOxLY
         6mYHe80b455oLGvz+kEF+/FxBDNjZjb+J7AwCr2n03wd4pqikLm+B5O72zokCoIRJStf
         Ckc515rDiiZmwwB/D2GQWnqJT4TuXLkogQzSjjpVlj0MuHKtjtAjIw7J061kpPhgmU5C
         2/UwQketUvPdJsvQtcGXdc/r6mdU8Y5UP66Tl+GoU9/+6+OY4k055Mi1qAcLIbllpUdJ
         gong==
X-Gm-Message-State: AOJu0YyOk4gRttEPg1JD0bGeYBe4t8SY5uc7GyFolAmp6IP984LmnHx9
	hmfEdrkqBBpS87lRsf9H30Z9vA==
X-Google-Smtp-Source: AGHT+IFz3NGpfOGW9CaxB7VH0crSSXVkd0iD7wPCzPSEzLkpsXgBw9ItNZ2Z4eolLqiokfRNIou1OA==
X-Received: by 2002:a17:903:22ca:b0:1b3:ec39:f42c with SMTP id y10-20020a17090322ca00b001b3ec39f42cmr2369903plg.5.1691763140828;
        Fri, 11 Aug 2023 07:12:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001bdb85291casm1611852plk.208.2023.08.11.07.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 07:12:19 -0700 (PDT)
Message-ID: <f30f2133-d0d7-48cc-b8be-6766e6ba2626@kernel.dk>
Date: Fri, 11 Aug 2023 08:12:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Guangwu Zhang <guazhang@redhat.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20230809020440.174682-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230809020440.174682-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_071228_753354_EC88136A 
X-CRM114-Status: GOOD (  11.07  )
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

On 8/8/23 8:04 PM, Ming Lei wrote:
> Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
> polling, and the associated NS is guaranteed to be live in case of
> io polling, so request is guaranteed to be valid because blk-mq uses
> pre-allocated request pool.
> 
> Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
> isn't needed any more after switching to request based io polling.
> 
> Fix "BUG: sleeping function called from invalid context" because
> set_page_dirty_lock() from blk_rq_unmap_user() may sleep.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Keith, I'll just apply this directly so it can make this weeks pull
request.

-- 
Jens Axboe


