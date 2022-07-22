Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B570C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9ILdx708OW7jSObyY5pa58AA+3as2Qya1907y+8fL0=; b=1M9T2Q1YgXS8I4ZrYlX9bvX0lQ
	AuZ1fGw5Hg1CJyQBgKVXUjaVzdbqyPAXpfrqccpMgEQ2fNIe43hCFwOz8CdacFgMV7iA95SLLcZbJ
	ChEA18sxZU548wSyooHJUCP3tVB22wA1LZky1Lk6UAmNs9vQYxEWtjukrOiay7IbfRGmTaIaHcnd1
	dcJaqdDoT95ryH9KQSyNDY48o5Xdsa8Fk2OuEw0uAEQ+fptMxY+DEBtINgQwWps+qnfHJqRgnBNOM
	Q5gV6h/ivDJm/fbm1d2UuOexTkubfbXxQF9y03rLcESvUxwcvg8VNUMgbM1upGouNUM1//yETsu7c
	r8ehJe3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0aX-00BgxP-Mq; Fri, 22 Jul 2022 21:53:37 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0aT-00Bgpw-IJ
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 21:53:34 +0000
Received: by mail-pl1-f170.google.com with SMTP id p8so5581017plq.13
        for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 14:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/9ILdx708OW7jSObyY5pa58AA+3as2Qya1907y+8fL0=;
        b=xEzKriWLQe1RvRQB2RwJlwssfArDz9JYz2M+hJLVZOdB19xaLfrQI8oa/0GA8cMzs6
         cZKM/fwkjoq1znHrb+/V2lZ2dp+DdjSyT83Q0WCJ3gyQSo6FX8CyarCSb1CYTrHTUKzX
         w5rKeQNI0xzFMvvdOt/gV+j0H02YcCC12duP1uV53oSukzT74Mv0BsfmhBzDbHo2t1vT
         dfzTHdPu1OcGMSFG8XkoInla94bJAoSUgMkUjzULoq5+AZpKr6cEyhkEBFg41kbMpuoj
         MRsUx+7YWJSX33EDXDHwfFGp4S1tG8t5K6uPLuiXoSx2+HAvmb2CDVKvUyJhhmZwW2GZ
         pb8A==
X-Gm-Message-State: AJIora9JZBhr8ooZRz9iPNnJgzV6W8pVrWLvusOpnMyGeISZl7beAVZx
	YRbSjMUICb5hCxe/4XCSv84=
X-Google-Smtp-Source: AGRyM1t7imcNuYeIaEv8vICLeZiQnBr59yZPN4mi226Jb3Z9WZnCpwK2veWClFg5W6B+PlhOsRs3ZA==
X-Received: by 2002:a17:90b:4a4d:b0:1f2:5211:e8d6 with SMTP id lb13-20020a17090b4a4d00b001f25211e8d6mr1739197pjb.96.1658526808447;
        Fri, 22 Jul 2022 14:53:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709027e8200b0016b8b35d725sm4262422pla.95.2022.07.22.14.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:53:27 -0700 (PDT)
Message-ID: <ccad8981-cf10-c332-8129-e881096949bc@acm.org>
Date: Fri, 22 Jul 2022 14:53:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 05/11] block: add a helper function for dio alignment
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
 damien.lemoal@opensource.wdc.com, ebiggers@kernel.org, pankydev8@gmail.com,
 Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-6-kbusch@fb.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-6-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_145333_657110_1BDEC2C6 
X-CRM114-Status: UNSURE (   8.97  )
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

On 6/10/22 12:58, Keith Busch wrote:
> +static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	return ((pos | iov_iter_alignment(iter)) &
> +	    (bdev_logical_block_size(bdev) - 1));
> +}

A nit: if you have to repost this patch series, please leave out the 
outer parentheses from the return statement. Otherwise this patch looks 
good to me.

Thanks,

Bart.

