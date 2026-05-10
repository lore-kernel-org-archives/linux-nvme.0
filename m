Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDEACD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=b7Fa1PazqWIuxkb1rH3SCPRZij
	aT1OLNwR9VKezAAFFEGQOG9d0QL+aO4tlmOf2HF3PJuB6sHrq1hmId+eSeJ1OMqk25AvUGrUwvOAl
	8EEJdavFKSGu6LGpjXuCLqhBYdYonp1iK7i2+YdlqEENJALXMfIS2gUPWYn7DGs4Wd5qJp4ggvQVj
	O4GYEGOxL+rmP+8ts56yY3+yhOgwCK2mkfRv2kVl6GSq2Kct/YVx3D7cz4tlcBReawIN/BUmsCQdc
	Pt3hilBHB1hj/2hEu/e2nStug+T6jXTTqpQs1TpDn1HLkdh1gA/qyfhv/rVmaElGo+6/hcITow2gr
	v8e/oA6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBWK-0000000BdIO-1YBe;
	Sun, 10 May 2026 21:17:04 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBWI-0000000BdHc-1Gpp
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 21:17:03 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a044cb827so2862226f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 14:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778447820; x=1779052620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EcwPFuuUDN0soxuo0EVLzCwZRgXwSa+VgraCYiU3YG0Wec11hnSYCf4XveeAmFoeLZ
         Vlqnsu/SMMMY3SObl+rDPtXhU/VvUzG/n38W5eR0uu5zoFSYSSEbtxMtTWaU/UUBy0lC
         5NPd0UIuq9I1FfnnbHBsV82+i43Iuh+bFDUWDD4K3ijfdC/8EJh0jI0AbCaC/kWA1pru
         sp69lZjUPIqolRF9KeYlE4ZuZEIvLdcjkoZ3lxL6gmhrhMh0+nyvmb0B+z2E4sNhOCW3
         SvQLZ64tfx1Trc53uM4CLFvRjIlQoMQeq8mkQ10uUxovX42+e8tr9aAYszXU/iHy08AY
         SIJw==
X-Forwarded-Encrypted: i=1; AFNElJ9TvAMVNZo3nsCFQP3AFBfs00RTXmyRiF0v0pjfaCKMhVpzPnsAA5QUx3T7F57dPyw6rwDsV/A35nYL@lists.infradead.org
X-Gm-Message-State: AOJu0YxqfsUjRVuo19YjAsc8N0qhJtPm1Ob6M/qyK0SmgZZ8qmYIRxlR
	ghcinqq5/kYDuzBRvItDWxsxgJ5DfHxjDbcFc+JuiySl/nR95VPbR4ro
X-Gm-Gg: Acq92OEX+k9DFyS/cRaIzAUcrtgHd/+Qpud78WZVQb+d0nZc01K8hGt0zxNN1pDfMj6
	2qy8mBC2bad12pMBUJhOh2DM0qxy7haKe9ZG5xaFtzMKVijNSdH7AXCyr1qSW8opxALQ1K5PnuY
	LJ6MGb4e3U7vRNgz0K3l60vP6nNh33XrcZ5mWb7SuI0QvJjUWf2r2KJ4I45DVXvDQhvbh8ZFpiH
	j428MlWDzpTAAksHf9WTrW+vV2QoRfMs8ooss3WfexL4vSH4pgw19RG9QKibHIrBGn1a6BhvGqN
	VplOVtDQOFtFt5yaO1/OsQDlYh/HNVJgmtKxgQiOCNxTVHlSR4NosmXkvi83MdxTz/7qqeFFW4U
	GB9clBH3CJaklGHN++icKSrPL/WGtyTascVy5/steB31QPl/cEd9unFsHof9m54cJplD1NEwxaA
	DBI5sIz6BgWjOYQ0rzj0k=
X-Received: by 2002:a05:6000:40dc:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-4515b056c90mr33856929f8f.6.1778447820304;
        Sun, 10 May 2026 14:17:00 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eab7sm20199922f8f.23.2026.05.10.14.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 14:16:59 -0700 (PDT)
Message-ID: <dbdec07e-1567-4107-90dd-530181a7d369@grimberg.me>
Date: Mon, 11 May 2026 00:16:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] md: propagate BLK_FEAT_PCI_P2PDMA from member
 devices to RAID device
To: Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de
Cc: linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 kmodukuri@nvidia.com
References: <20260416212633.72650-1-kch@nvidia.com>
 <20260416212633.72650-3-kch@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260416212633.72650-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_141702_341328_D713D794 
X-CRM114-Status: UNSURE (   3.90  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

