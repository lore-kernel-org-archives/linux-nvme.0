Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF84C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGyhawv5lvAz+jR7b+4J1tPg3EThTh3JtzLNgN/2cvM=; b=dOK3VF0U7eewdDOlK6X3pH22sL
	FZ+imgaYOe0RwC98uXu24zS+B7kJJnFnzAmazYelsYWgIht9TGihyQhi0ceoHX5oYNC47RunAf9xn
	vPws9CldDibgbI2T6S5X+QsAz9PBoUuVzHG73tYWxb6Z7anqMDAWQM2q3DImVMjf3LybKHQTMlMfZ
	BlR9F2zm2eAQ6+slDRdaUuNd+h3ErE50aIdZHvFkk1dz+w4I19kk1Y1NPEh3DAeE/pe71QygzfQ6M
	UK6yoz7q6v0ZRf5pqPHH8tL0MbVoimxAQ9/erg0dXQSV76Rms5YVMjlDjhorzcG5Q8+mq9kpoERlO
	93xHS/UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvjc-006qGt-6n; Tue, 03 May 2022 16:50:48 +0000
Received: from mail-oi1-f182.google.com ([209.85.167.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvjZ-006qGK-Pl
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 16:50:46 +0000
Received: by mail-oi1-f182.google.com with SMTP id r8so18774000oib.5
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 09:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XGyhawv5lvAz+jR7b+4J1tPg3EThTh3JtzLNgN/2cvM=;
 b=O3TI/z2U2rdNirG8LJGx0tZEsDWJ8LiybeXBt5Iiw7dlssSj0NuLEzeOtsF1Y5zPtE
 eNdGKNcA5Kw5hxpj/JH4b/+qoXb0rW2zHaHtEboctFhMLTlntSAOzGGN/E7j0exmZh/z
 xTHhVTJhYSf4TqsEYbJj7DLnkJ9YeTajJqnRi4nRGDOtyuR+0SJrqFmnlBYXr3+IGVuo
 tNkxQ28skA1MexQrBrizpFXVo6iC/aw2phUr4jDKjcuglz4VF96FfrxPL0LViJEI2FQG
 doAG+53TMnWowF9ZfDp6D0PIVIYTb9uWyi9dbV+bBo3w5q/Q7fxpzs/y+2E46G/rjW9P
 3aeQ==
X-Gm-Message-State: AOAM530JUZFpb5D48Of6i8ao/Y36Ry6X+w1WxUHfziIHFckzYJc2sGnr
 F7ESfi/mlYGghxK9BGHa0fk=
X-Google-Smtp-Source: ABdhPJy1OCeyAd/qiMByFFTTxHMId2iF4W5yKbLjTMlEc1yur0rFxDRZF7LK/3VXrAqw2kuZPRsPmQ==
X-Received: by 2002:a05:6808:2126:b0:325:c9f5:46e1 with SMTP id
 r38-20020a056808212600b00325c9f546e1mr2356270oiw.239.1651596641690; 
 Tue, 03 May 2022 09:50:41 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a4ae6cf000000b0035eb4e5a6cdsm5044278oot.35.2022.05.03.09.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 09:50:40 -0700 (PDT)
Message-ID: <1e3afa38-0652-0a6a-045c-79a0b9c19f30@acm.org>
Date: Tue, 3 May 2022 09:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
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
 <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
 <20220427160255.300418-6-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-6-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_095045_877023_D4418E83 
X-CRM114-Status: UNSURE (   7.66  )
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> -	sector &= ~(ns->zsze - 1);
> +	sector = rounddown(sector, ns->zsze);

The above change breaks 32-bit builds since ns->zsze is 64 bits wide and 
since rounddown() uses the C division operator instead of div64_u64().

Thanks,

Bart.

