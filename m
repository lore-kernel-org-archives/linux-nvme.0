Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBCBC197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 23:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MrW9oYu7MINLs/fTPWfiPiv9Pd0BlSPYSGo4GMsrr0=; b=nydBA8/KwNyUeYZPyxWfwz/A0M
	tNO+4Q1eHQQrbT0G2LYjIzVVwXzoxWE1SbBlj/aiJmpiTFQubIgTKtgKIxVbYUtj8kM5dIheXO7fg
	mthyQMXnaG+pnZEL2Z920H7xIGTdhaDS7PqbGrZ4GSn9JZj7bXxmx2UXvqQdkAAKFzWD5TGZGnN1d
	/DF/Nz97LnfrWbY6LTW34QNlNstjFkOBw4IUIAAwlOBh0rf5NoBTU11oM2r5wuXZc4XhdgIkUvR6D
	rZr/KrZHADt7AJqAcYptSRR9ZxxL7w2XoAsANp11UmRjhmXyJIKtinmy+pHDMFGaQ+ys1m02DFxtG
	YsXZ0tDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnneK-00000009D9p-1DbN;
	Thu, 27 Feb 2025 23:50:40 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnneD-00000009D8b-3dwA
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 23:50:39 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so117092539f.3
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740700232; x=1741305032; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MrW9oYu7MINLs/fTPWfiPiv9Pd0BlSPYSGo4GMsrr0=;
        b=q7In69hf2aMMp+Loi4jiprijUB5FwDik/nNuzFBwo1TDK0LhXaY8nbHaCZEEwSoh/6
         sFSviwaSsmN1HGIuHtiJJWjUjIweqxyLMEvAVF7Z5+JDHIdfTaj0YP0WXK2aFGR5WTOf
         ljdz3F2DsoAILtjACJ7zEceb14ts/pbh3geuqnPHoBL0mQPSedNZBmQL8hOdougm2T0O
         I2Lv9AQkWNsLEPWWVkn90UDoKz82sOcMr/1TsQGC4grCrVrgOrHLQPKzSYsxpJaaTsRy
         Ps+8waKWvDCBCfRezAd+Wo6A5xv8gDY98pAtQPqSSwvMluN8DLrSvcq/O4LSdxolAUeJ
         blUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740700232; x=1741305032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MrW9oYu7MINLs/fTPWfiPiv9Pd0BlSPYSGo4GMsrr0=;
        b=neiFBdo0gYcUIZW578c/JuGZAbfHA/Ihytt2LljwC40MEjOqkJYrJQqxVP9UMT4kQS
         sCPLDzRK/0bTKITeUqK+eNubHjYm/zHYK8N0pnS5s0srCwoi+vwBULeHrNQj8QOL1XUa
         pmIuojmEJoD36aUSpDhclsuWgIR07iEn2EN+I8vH4qgLD1ptXITjxSjYfnuZXzK1pVOm
         7ZNhGIMgEcD/oRD7AmsgnXKAxkinghU7P4nUEc1Wd+q+jEkCoj5NwC8/f6tThdv5WTTs
         iCprDvGqTHxSGXd5Aid4eAcnsWYvQvEFZ1TGXFU91n/W19lFeP3TbEX+uYJlJ/39lThY
         /yOQ==
X-Gm-Message-State: AOJu0YzR4CxpGNyu9FwvtdeneA0wV5drkJvjx09kf25FdMLICX3TQwhc
	LxtDnLzGPv+w0I/POQHdK6XyUhI1YjgK5kKAbPHryoi419g+YI4yGgpmq0DhoGg=
X-Gm-Gg: ASbGncuvoVuSMvC7KWlnS3SNvvhaD/QiVixYdCV08+Fcc+QegqXQvQqZHTXepYYwCIq
	XcKQZKGEWZFD1/fT8KJ3rDoT6G64j8l+SubsiRt6V5erBcxp4OCvifikAkG5AAgmc75nzvfOUvq
	TR6FFiyvLgcddpa6dpzqjaB1evLgoKSOnWjbIGl6L/eyv9ucOnSaibzmAmmCOPMlddFPOEjCnjp
	0hxa6NOFh0GfkF/BNsGX/aWFK/pXO3NLvMHGV2zGACdKyz6to6UI/FKyrGyEGvX5Vkz7zhxtC+O
	kFRDLRejI1Gf0UfP9RK/y8Q=
X-Google-Smtp-Source: AGHT+IHSRlM3w45VHLLMK6HPiygexZv4dV4SqmsXYaIZxGsowPQTTGBfz1MH1pCv0maLCVB8fNpkuw==
X-Received: by 2002:a05:6e02:1a6b:b0:3d0:405d:e94f with SMTP id e9e14a558f8ab-3d3e6f51b7fmr14092215ab.17.1740700232541;
        Thu, 27 Feb 2025 15:50:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c5053bsm601823173.38.2025.02.27.15.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 15:50:31 -0800 (PST)
Message-ID: <1855c57b-13c9-49fe-b7af-a277f8c8b2c6@kernel.dk>
Date: Thu, 27 Feb 2025 16:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, csander@purestorage.com,
 Keith Busch <kbusch@kernel.org>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-7-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250227223916.143006-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_155034_171239_726C3B65 
X-CRM114-Status: UNSURE (   5.81  )
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

On 2/27/25 3:39 PM, Keith Busch wrote:
> @@ -119,22 +137,44 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
>  	if (imu->acct_pages)
>  		io_unaccount_mem(ctx, imu->acct_pages);
>  	imu->release(imu->priv);
> -	kvfree(imu);
>  }

io_free_imu(ctx, imu);

?

-- 
Jens Axboe

