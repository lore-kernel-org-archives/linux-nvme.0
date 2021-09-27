Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:39:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8896103B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD8896103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=O5ZoWzNydOweUfg6t27t9Lb6R/n1yNcUuQFvid++Aek=; b=4mfxaJx+irfbfSgH3+Uu/yhU1l
	J5u1FQwDHIEIsjXKhJBiKGEuLHbh/ZOWN370+oKCTNsOSfvaaDD/z+U31zyRqsLAFYM4rPfgqaBk8
	oS4m1COqfAxEvHmhYVrTywHCyZtomq1ZrvKdBpofg78VoZ9SpdRmTqPOkfYMx/YtEiVs11aVZjoCj
	R6jXwMMqivzw2vsZLwrtkHiLTHTOpf+vUEOC1qlk21BRKKyrws/zxpdhW9MxaI/QqoCQODr1lSGxz
	zodaWiogRx5XT8AFl8UusM7K1GDC7nRVxPXWQE5Saldm7YK6G7UttTH4szrw5H3f0CetunW5LxHaf
	KzesuvhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUzHH-004i9s-IW; Mon, 27 Sep 2021 22:39:15 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUz79-004ezI-ER
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 22:28:49 +0000
Received: by mail-io1-xd33.google.com with SMTP id z184so4427108iof.5
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
 b=Ah7jkIIctR0HcnVgB5sWbeUdZwsGT2EehBK4lb+q32xOVavNWfD82zKlDGRJA1B4PM
 /2U90/0SvcC9l1r+IDSlahEN/NC+QMNdf8OLk/ooOlydqwz6QGg8wDViFrkfEGikp/c3
 /Q8A/XGE1SZVGZ1hcLnLB6Er8MX1tmX3kUoUHTd8fZUIlpDxvC5pwUQYipgCc7oJVSI+
 rkiNvqR6Uh37Z5l+Gj9S3tYzBLrJ2DlUD27NmkKUe2vWKFh1TgA7VLVoziOPGtTGPqo8
 dcSrTDLSWV/lT8K2aextSKUoXJ59tNYXOpE1Usf4pH7xnmSPdZY6piFtoxoW38lIHPW7
 +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
 b=6jbGRs1VkMTA3JeJPXYJaKCQBtFBiivxnCWKRLi5SK4kttxVc1z0MGqiKpV5mDTUv6
 VYPsVCoPjMi5JvOO8Chuwzj4x0+48Xlqy9zgAgSuVg+w1v2jP6dL5omWgjMbfLzOQxOt
 mYltvKilkVLgYLywL8V7/BBJnZ7Vmw3skkvxEHmtnqDlG1kAhj4bD5LRPyhSmAYRpmPd
 mglyZCG/g/4LEd31ObzCGdHZNLZnFK1aWRiwYDR0Hf+YB7quXLWUcMxFRY1UOeKVo2bB
 StXj9/8qqa3vFnXi4+f9tMVbaBeWVZI0chH9JdVjv9SdLQkOMIaQDu6vfUuyKaAY1rB7
 CTrA==
X-Gm-Message-State: AOAM531KWOU6G1T99AFbSTDB34WwDsrUPXiaKvfLfgkDZN2FBl2E8k2V
 bxvADcD/dLTOj4YN8qf6h85j2w==
X-Google-Smtp-Source: ABdhPJztY3mK3ksoDQMf3OrQ8dUSONHNyLP4EfHo/dO6kIiAhPp9t/W2Pe9f9RD+PJfpbL6A6UQe4w==
X-Received: by 2002:a02:22cf:: with SMTP id o198mr1814887jao.37.1632781726231; 
 Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id e13sm9446741iod.36.2021.09.27.15.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 15:28:45 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] loop: add error handling support for add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>, martin.petersen@oracle.com,
 jejb@linux.ibm.com, kbusch@kernel.org, sagi@grimberg.me,
 adrian.hunter@intel.com, beanhuo@micron.com, ulf.hansson@linaro.org,
 avri.altman@wdc.com, swboyd@chromium.org, agk@redhat.com,
 snitzer@redhat.com, josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com, 
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-6-mcgrof@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1cd6103b-1251-cc22-93ad-da7f207147b4@kernel.dk>
Date: Mon, 27 Sep 2021 16:28:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-6-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_152847_587662_0F02AAB5 
X-CRM114-Status: GOOD (  10.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/21 3:59 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
