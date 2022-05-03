Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E25C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1eh4gXcwKDJaVq28NyDGAP5u0RiukLhIIz4+qOM8ls8=; b=2K1QvvCuyBsdHqWSGWq13WGA32
	8AKQMBGYcorzMa5hrKZcdpQi/1Y6odLcic1mz59Tqjey3uo9F6Oz+nuVgEerYcR88d/S/nCPoO46L
	QEaS8gSo3YpUI7S38MckyWUVZgOEQ3FaUjDVrzesQyTyQOWWzvvSNLdToQNpSXitpDcMsZrx/N8oT
	dNG8P0J9dFvI7Qffjc0wXZtKwvNxOjAzdalBSwXXf0ZtYrdWqs3T4clVROUWTQoabdufZ4wWneObC
	9LNbHYf0cG47dG8iqYut+e3jBo9W2dJRYP2sreIrqyl6bQ2i/10k3ol4lumrLTwhdZ+RkadasC/im
	0G6FkZcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvn4-006qsU-2c; Tue, 03 May 2022 16:54:22 +0000
Received: from mail-oa1-f46.google.com ([209.85.160.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvn2-006qrj-51
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 16:54:21 +0000
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-e5ca5c580fso17757114fac.3
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 09:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1eh4gXcwKDJaVq28NyDGAP5u0RiukLhIIz4+qOM8ls8=;
 b=hM+biYrEebtClWJ9Vv00LgDC6zW+TPoXElqS2MEwpA6B5TN+LcAvHP5QxFipH+f7ab
 9y8DzDd5egPr+egz26+LfoOOo3PLo2oYlNrkdqWoKE5XZ+CKUpqQNEWz79UtM/lIuIbm
 m798sV6+JwrSxpBiCMf91wtVsJ1xnazjyVCrNXjrzl55zuG9nTr89ONCkavJQfASAPBJ
 78uwjUA9fh8D4CS7Al4oS3FGYN2sXzmTF5Wc7RvnXqeIqC9bd2k0z1Jv371g5LhcSnE4
 dqnlvhuXZwfDWVymb65YPJ9aQkBj/qjDWTH7Trf7gYWiV6KNuYChwBF8lqfHLlnlRdJH
 oXZQ==
X-Gm-Message-State: AOAM530HZveRt1u7SQ7GlMDiZj51oADLULSe3y11ZzSz+sI6b1bckCgS
 JTM2LJsONU6wU7mXAIeRoB8=
X-Google-Smtp-Source: ABdhPJwIYsdQ5p1P5Q1mznCaYxjTnd/hJJG6oVZ/Lc+drskzCLzSd9wtxgyiNOjNc1Eeeh2wyOvvEw==
X-Received: by 2002:a05:6870:b693:b0:de:7356:a3a3 with SMTP id
 cy19-20020a056870b69300b000de7356a3a3mr2077698oab.24.1651596857587; 
 Tue, 03 May 2022 09:54:17 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
 by smtp.gmail.com with ESMTPSA id
 v186-20020aca61c3000000b00325cda1ffa1sm3506854oib.32.2022.05.03.09.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 09:54:16 -0700 (PDT)
Message-ID: <78730bd4-a184-e0f0-4634-d09dbaf59958@acm.org>
Date: Tue, 3 May 2022 09:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 06/16] nvmet: use blk_queue_zone_no()
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
 dsterba@suse.com, johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035@eucas1p1.samsung.com>
 <20220427160255.300418-7-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_095420_242736_25AA0C25 
X-CRM114-Status: GOOD (  10.02  )
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Instead of open coding the number of zones given a sector, use the helper
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I can't parse this. Please rephrase this.

> blk_queue_zone_no(). This let's us make modifications to the math if
> needed in one place and adds now support for npo2 zone devices.

But since the code looks fine:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

