Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048DDEDE9AD
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=; b=1+YvWR2QN7Sf2Rw8Ojvla8tRv5
	9NW5MeW66Cn0OU+7KXTdYTn5YfJw1ZAYg+FWFi+Ji8B51w8mA0bLBgp4eyLCZWBYK5hnJmpf6GtB2
	b7CY/sHOC01wfzkGT7tFazbzijiDKRkAlMJIk+mwRHTOaQtZtMUg/H7re5E9UYiPsLYF0OPCIVfHC
	NGgwoaU1AhIopzOn3GGehwcpegKBGKiz5TBO3/ChoKycPd3pRho4sAgezTPhziS6ff2wOwiqoCMBK
	QfKA+dSos479xspLrIU60PvMFrXmKnE008zVRmtuhRIv1cLRzpUVOcfkMfntIJdA0rbKYsz+N65yz
	bKu/S9Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so5uU-00000006nJ6-35AT;
	Tue, 10 Sep 2024 18:48:18 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so5uR-00000006nIj-2DiI
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 18:48:16 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so19048625ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Sep 2024 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725994094; x=1726598894; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=TEFIiGTcBeBrqA7MUckdE954L9AW99pluKFKPxOxUpG42HEeHnJkzZNe180JjK25J0
         x8o34TGQ2BZNkp4itMjDx5V3yrCgkkucSPdAwwcffICDQfViwg+J5D8D3deKBZxl8rSZ
         S9w6eGK1CMVfLR9bj+n9cOTX4z3l31Y0ovGDxKeh+nxyrlfuZBCkyio0G7zWDelv+5J2
         52vwapHRrOSbEya2tsUtK8n94fDBdUleCrTOojxK5fqTB11zX+rF+VFHlVjphPA9iUpn
         AUybkO2NLZIliUcwag6Lm0UeHx+KYs7eNNhrRcnRxC5q2yyZhml0tqrhxg+JfsZba8YJ
         3w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994094; x=1726598894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=gBclZa0qI5KsNG4ajRKX33tHveAYFEp22zNjNMcW53SGX9X0wR/AxajUBq0jFFH0qa
         lrU7PyYSpEtjI9EhVcNTu9wPu4astGthr+2lcBVdbxwdNpe97348bQ1zq2PcqvUTMJiR
         hVaNQPAfLrmfvi8eJ72+snsQZCp08DEhZPENanprfYgGzISSyQ7q35jYikrRL+KmTYY1
         ZAXkn6pqQOWKpkRmhJIl7K0wWKyNgY61CxCGhcpzF3yFfZxDQ3bKrrCd18IUAJfxpq8+
         QVD0xtGMdEQgi4I4+uMfn3a6g+/vWANWgliJ6g52TFrBoYW0V9P6YuOE1Gx/SSRiMQHK
         WmHA==
X-Gm-Message-State: AOJu0YxKOUXLug/ShVq0IUBloCFfydS66+E+zbTv4anSUNsSlHJIjP76
	WkqOAgOlIDUSe3wJhlr90l3ySU5jv9tvAKmXoqZZG+k9KarT6u9x3y/cF1r9MK0=
X-Google-Smtp-Source: AGHT+IEbci4bFKk4qyfG7I+1DUOrdPWBQtYa+ssZc5w3NRdfD9WSHDse9oCgXPz7cY+ZMf7HVvKJ8w==
X-Received: by 2002:a05:6e02:16cf:b0:39f:5d13:9491 with SMTP id e9e14a558f8ab-3a05745eb8fmr106220205ab.7.1725994094344;
        Tue, 10 Sep 2024 11:48:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fd5c85sm21473895ab.23.2024.09.10.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:48:13 -0700 (PDT)
Message-ID: <e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>
Date: Tue, 10 Sep 2024 12:48:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_114815_601421_06DDE66F 
X-CRM114-Status: GOOD (  11.26  )
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

On 9/10/24 9:01 AM, Kanchan Joshi wrote:
> +static inline bool rw_placement_hint_valid(u64 val)
> +{
> +	if (val <= MAX_PLACEMENT_HINT_VAL)
> +		return true;
> +
> +	return false;
> +}

Nit, why not just:

static inline bool rw_placement_hint_valid(u64 val)
{
	return val <= MAX_PLACEMENT_HINT_VAL;
}

> +static long fcntl_set_rw_hint_ex(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
> +	struct rw_hint_ex rwh;
> +	struct inode *inode = file_inode(file);
> +	u64 hint;
> +	int i;
> +
> +	if (copy_from_user(&rwh, rw_hint_ex_p, sizeof(rwh)))
> +		return -EFAULT;
> +	for (i = 0; i < ARRAY_SIZE(rwh.pad); i++)
> +		if (rwh.pad[i])
> +			return -EINVAL;

	if (memchr_inv(rwh.pad, 0, sizeof(rwh.pad)))
		return -EINVAL;

-- 
Jens Axboe

