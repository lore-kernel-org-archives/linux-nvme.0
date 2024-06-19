Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBDEC2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqBTKUIkDMWrrV9BblVdHJH4Bj8Ava4UrdiXMFjAAOA=; b=w+gLMxOONCRp/4+0ww7h3NkLuI
	pPXcIHH5st3N1kIQeIjuHlpuUr09DlGU8DqvQNRAhtqOHZmMGWr2X/kMULhzJqP0s7GwoN3i5bPS0
	/YkyniF3tk1tqSxejkV2PyHUwIz47SMl0jCAGQFiGI2aaqpxWqzYa4Dr2V6NVbJynKFClFijhA/cP
	Ipx93P0oRaDZCiNwBt4heAijIwjPpr9L8GEbg/K71rA+S3e9e3GWZRaW4l80VQIrTrxok6BMmxc4K
	RfVhIxkDOYBuhr0/MRkC0LBggxhtb6vppSg4RRuqWa0foU71egc3xJJO9fdIrb73yoKmsrciNiWAy
	JYmhwVZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrSc-00000000XqR-0VsB;
	Wed, 19 Jun 2024 09:18:34 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrSY-00000000XpX-3uns
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 09:18:32 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1c7d1286so467038f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 02:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788709; x=1719393509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqBTKUIkDMWrrV9BblVdHJH4Bj8Ava4UrdiXMFjAAOA=;
        b=Oli6R4YopO1DWpeX5eTwy3wHlrkW9nn/JciNMieqOEJ9JJMe5wY1d4/j4x+pd7o1B2
         3OOUZLFQXoDwgkfHImnxcAlugKTimMSoIksQ89MxS901GdRpMQHFdMASbvF/HOMuBVvQ
         s2Xy6eu2nkbuuomnvUEHXBFQLu+KI2nYqMuIKsxVbu1fhpApljtQO4FwyeK5hJgI58Rm
         plnDRwtZ3isARBPSDNlDSq3fF9/H1LUhwLeYUSS2HEKTohh7wh8htpwVyPq4QZ9EnvOD
         9fJRkEA+8LqgRYM3aKvJWd85edS1AiE/mw5sUEgNT8tDEnl3K+dWq/wLdxzxon+EHcQD
         TtZg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Uu2IYAK/AXI41fA4AsqksQPMtpotBYevDl86MYRJv8wewS6zS3rwxF0MwCojuBEGVjiXZ26LrLdPgUNVRU/OQ8ZFl88BqT4QZcCCFs4=
X-Gm-Message-State: AOJu0YzATQF8nzLJPhvXrXetH/hSfS4lsA8WONZZMz+4Cmx/yVlvZF4D
	Kyjrj7icXswBMhsgA9YWSZ7BcKTYOWNmuLNbu3E5TQyHO64wClQx
X-Google-Smtp-Source: AGHT+IFNOithI+CHKmPz/Md7IW5UDaxr+VAVXKDzXdXLjDKwa8ZVwWk/9vIkYYoVgniFWW3pR4L3kw==
X-Received: by 2002:a05:600c:1d1b:b0:421:7dc3:99ff with SMTP id 5b1f17b1804b1-4247529a5d1mr13303145e9.3.1718788709236;
        Wed, 19 Jun 2024 02:18:29 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm16387252f8f.59.2024.06.19.02.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:18:28 -0700 (PDT)
Message-ID: <66d87932-eeb8-47eb-8c89-e1f10cee32d4@grimberg.me>
Date: Wed, 19 Jun 2024 12:18:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] RDMA/IPoIB: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-7-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_021831_006291_377AC06C 
X-CRM114-Status: UNSURE (   7.58  )
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



On 18/06/2024 3:10, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.

I'm assuming that this patch is well tested?
Looks like a fairly involved change.

