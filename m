Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0849FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=r7vd1nAsPNef0NirdPGVtyoxqc
	nGWTNuvx9kBvuBqD0rTDMRVp5R5zarxWWVFf9ckj27tBiOmN3GeuPcQRLmZpiop6BxpqVW2hyEK7m
	3jO++6xEwN6kONzyp8J2+4Z5VdBhZyw38XyeXBPNL+DnCHHPgs+0xLk8zxlem+PznYzl6+2rwM3zL
	0eVb6W2HvJPbYDPn33dhdDRySn2fnPKK4IUlScV14rf3vJbrIzI3pe4vhQSIDFmYJ3PrvPNk/nb9P
	OC5I+Jx0MQ4JZGNSxwpVe8shmFyPqWxWp84E9nPfo34fPo2NAMrfzpe6HMEGj7Dvyhd+LFjjf20eO
	0Qher5RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMp3J-00Dhbb-SD; Wed, 23 Feb 2022 10:39:21 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMp3G-00DhZj-6B
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 10:39:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id d28so11056076wra.4
 for <linux-nvme@lists.infradead.org>; Wed, 23 Feb 2022 02:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=w/b4s3v9k9e0HS8Uz0aKgh0iyjVndIxxGBQH46hwvtChFHrLuYOQY2mujBxVFtid6i
 IcZTtCvt7KqKcYM99LhHwQyZN4PQaLhTfi0+DhemT21VN/hoM7wINoFaGCzXbzM6baRJ
 u3/lSuNzhRdcXDvPhQQuTFXdqK/k8m9zB1rTkQQituEgpJT1ClIpuiN6z/fHytjsfDtG
 Z74DQfFUNukMNFGYKBDAOu6oQOkjU1qr8V1f/+Rx5W50cG7AuEWehkH0f6Tu2eyjexEg
 2eSmS282O9LGSpvfRuFvU9ACO89Vnnko6YLvIZkxge9qGAEBSPFD29MBz1D+F/mixDDY
 Obeg==
X-Gm-Message-State: AOAM533AsQ9+U6oHhQ3A11r0+FQ/kXa0kCYWP069OhFNHI5tBDM+cOd/
 1QjeJKr1xwB8jw7XJdCiNbo=
X-Google-Smtp-Source: ABdhPJzh3rK/WHHWD2xHyUlty+Zgkz7HiXpN+3iA1QU1g5SM4bQAJLKJKBAwTRP0tO6zpPuK1Ip2gA==
X-Received: by 2002:adf:f542:0:b0:1ea:9ab6:2c77 with SMTP id
 j2-20020adff542000000b001ea9ab62c77mr4608432wrp.387.1645612756176; 
 Wed, 23 Feb 2022 02:39:16 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id g6sm54596748wrq.97.2022.02.23.02.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 02:39:15 -0800 (PST)
Message-ID: <d8c6e14b-6a26-93a6-c2af-d2e2017b31b5@grimberg.me>
Date: Wed, 23 Feb 2022 12:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] nvme-tcp: don't fold the line
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20220223033657.208747-1-kch@nvidia.com>
 <20220223033657.208747-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220223033657.208747-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220223_023918_245679_9842FA79 
X-CRM114-Status: UNSURE (   6.10  )
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

