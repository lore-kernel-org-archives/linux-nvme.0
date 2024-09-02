Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407C1CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KeSwfyvEoZrhGanqUvTmjyLcSlB5pmbr/ctUVatnsBs=; b=v6+fJE75unrwcFx4MYs96ZO1K/
	acXpsgm2lIgiirjJW4oEEC2NojnLS0LDZm6YPy/E1ZXoHDT8oORbytr7Iwa3rmp2fn7rKYEs3h/ns
	zmDP8WWO7aF+/iPO/Ws2WuixwwXztRqRY/76/mO8OuNntpT1nPITrRbOIiVkrZnvtIESNWA4o/qd9
	qiRDBjaoM3O0W8MxPXgkmL2P0hfP4fEdNeKyNO8gQ9dhpngl+OJhn7e5Toe6XjU6cC+3wykdv2to6
	b8fMzau+pjDhonKSV+7FrXLWV5wu9pOxXoR2HhEt9VFdl7OgCnSqc9i0ydPGwgwM5HFckiygw3cob
	1eGigj2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAGA-0000000F5Kq-3OnN;
	Mon, 02 Sep 2024 16:50:34 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAEQ-0000000F55h-2wGY
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 16:48:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so19155185e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 09:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295724; x=1725900524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeSwfyvEoZrhGanqUvTmjyLcSlB5pmbr/ctUVatnsBs=;
        b=MNJfTvIKDvfUhmeAWyKARCjKaibMogDpvg+1PlQTN4sfmZbtwIvI/QfOrEae7mRINZ
         JqrSB5pfMSGA/cosR15wwSzaQvu9eyghpaPgVRavGfIR33IK8WF56aJhfgvU4ySFk71j
         nSuYqyVQ+cDAHudbFY4811eMECjUihhRaL1yYEcDW/oHfqpAgqfsVdJVqsSTrXH/TT1f
         VD5L2WhG3mjzzQEnSP7gK/LroPstJBGVAe1eZxu9DBH9TwCWcRxYAGwY3iqTOBVWOTc8
         ZpVqb8t0e6wLUQaOlG5uYnnohhCQ22R7X5Xa/vrPn0gAJ98T3Sb9Vl9M+VWEKlPu56Fn
         XJGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxM/ZRR9ASFtzYMF5R5d4sZ3lXXvGCJKvSfK0r5B06/p6ylBU9BQm25uBGJYRsDfHergBI6H6RlxfD@lists.infradead.org
X-Gm-Message-State: AOJu0YyOd9Fzp+rksMic6fmtjTyHG5AElL8tkycVZrLIQF3TH7mFP6vm
	904ta/Ub/MKYfyqDxHBq4Qil6j8wJ/5xtpsCuc8o4KT7rzOvwFjWqMICoA==
X-Google-Smtp-Source: AGHT+IGZI62s3zOf+wBZ7fGZHKjNLq3KCQaswEBFy6vqmrb6OQYgyW0q/7mryAqORQA5v6qSbffmKQ==
X-Received: by 2002:a05:600c:1c12:b0:42b:afa7:801f with SMTP id 5b1f17b1804b1-42bb27a9c91mr90879995e9.30.1725295723666;
        Mon, 02 Sep 2024 09:48:43 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9c692sm11908668f8f.53.2024.09.02.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:48:43 -0700 (PDT)
Message-ID: <efe0dbc5-64d4-42b1-abcf-addc7be6ca69@grimberg.me>
Date: Mon, 2 Sep 2024 19:48:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-multipath: fixup typo when clearing DISK_LIVE
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902111548.41430-1-hare@kernel.org>
 <20240902111548.41430-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240902111548.41430-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_094846_772479_D8E3581C 
X-CRM114-Status: UNSURE (   6.83  )
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

This was already sent wasn't it?


On 02/09/2024 14:15, Hannes Reinecke wrote:
> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
> 'struct nvme_ns'.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

And again,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

