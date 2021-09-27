Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF0C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:40:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706CB60FED
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 706CB60FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=O5ZoWzNydOweUfg6t27t9Lb6R/n1yNcUuQFvid++Aek=; b=XLUx71Pw+3a3DL+imBuuWTwNPo
	lAoXeD1jAsTFuSDyrYJlf77IeXf/NK+RbP11rfvL/HIznKgXqPrO3qocJ5VYIlg14yeMtejCJr/lI
	i+Nz3JOJlSgeC1YK0vzbJnZpzuslLUapTCAd191FUF2hG7263+JgGrV8xnC24Efoot3Rv/1K9GZHU
	yegDb0K3dbzXsTyY6gE72HE5GAcPX6RMRxEkYPrq7u8plZBW6yiUUiUvQJYsbgX4Sp+m/ydLuBcsL
	zRn6OOxKQ1cUnveg2+ytVXnCSqRFPM75H4WDWG+saeb4Ur6WQK6eGqYCA+HUJamaPINh68Zf84ke8
	Rg1meErg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUzHq-004iJb-4G; Mon, 27 Sep 2021 22:39:50 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUz7N-004f45-Ac
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 22:29:02 +0000
Received: by mail-il1-x136.google.com with SMTP id q6so7100524ilm.3
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
 b=Ffjc9XDV39XVuLIm8DJDvOIHuyWwHa/JDveqkJIq4EPQcwwF6i2IwXvqTayH1Zs+J0
 zBBIHTdeujFBpyTsi7j+hLC6dG1lmzreXcsCJibD0ZHuJdAABtpVv3xmIelWiJg4Kiwx
 y74YiDFOoIziOuEp0bFDeka+WbUijbofv2enBSkOGJFIlEwWIxbA3L0TdOIDNHbvW4s3
 UX5WZ/WNqYbm3RB9OdDLcEyEdxxaBYh8+Ce09lqPv5Y/yeoNEYf2H8gl9ZQ2Gx73QUuz
 bK1mNwQj3yvOA8l/cfkBNHF9G4YJ0ALLNw+vW7N07eAC0HlFOVJ1jxEY1tUin9ivF4Jg
 GOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
 b=4xJfSvpTlqCwY/a1gs4Va8i4+8H1M0dzHuzhGVXPV4R2FachWTABArJSKbu2oEdbS3
 s5FgsN9PkIWuGdyLspUzUtvuW1rG8mlVIKnhHnCbDf+rvZ1nBo3hoR2EIHKAHO9MLajy
 nwtSp6P1YWPNBtoUv1dCdQJw3amU/K03KuU0j1g3AKtClqz6JSanMwCQdnBfvaaYPndC
 yqaABHhTqQtohWtHCRanBFjryDhBbEiSKn9IwY/sHpkD8PKsXk9hXshdq3x0r2evUtH7
 dHdTn3vksHjphq2D49OOYaX9dmbnKebXpqd/zrp8KHA5bnsXUKFfLq9Xep+GHhTfH5DO
 zOQA==
X-Gm-Message-State: AOAM533qRCOehR+wq1fO9iR8tmM67OPP7dpSblWfa1gW9dSMlQdAw71D
 BKxPMSFTPW1/06zS7kmRjGYVDA==
X-Google-Smtp-Source: ABdhPJz2QpC01URNtiA6TI68tVS50xc5AHbinQF2wOnvWrWvzOWk+mcoidVwrUAWxR5vBmrTJemKng==
X-Received: by 2002:a05:6e02:661:: with SMTP id
 l1mr1855976ilt.122.1632781740297; 
 Mon, 27 Sep 2021 15:29:00 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id z25sm7614559iow.20.2021.09.27.15.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 15:28:59 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] nbd: add error handling support for add_disk()
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
 <20210927215958.1062466-7-mcgrof@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc945e14-498b-2cc1-8ef3-8dcaacfb948c@kernel.dk>
Date: Mon, 27 Sep 2021 16:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-7-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_152901_399371_476BE450 
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
