Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C976ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pS8HV72n+6aEA64r11V5G3Ot2M
	auRiugJh+lWL0DjNpP420imQ8GXdZxwc9OJYpmO7OvMEDXw3NyY8t0npBkEcki/W1gu3CIfX8lmRq
	YhSv8Z+hRo2iKFUlItCxF6NnArTGgfCwLOF+JmYdICiOYJhUjY0JNyg2k8wYfQa3wOH7SOCKf+ByX
	wd+NNLIpupfepzN/pVMNFvUDa/Ir9J+UIqEqPMW3TjGGmO9XchTjD1FhYuG21GWWZdUKPEbCpr5DL
	Nd65XL/AMnws1LoVDCjOQ6CZ4tM0f/O+n7KFWpyZHyDiCFqjCIW9d80zI4BGm4Rg5yWjigSo3izND
	Wq9Flwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oax15-00ArV4-OS; Wed, 21 Sep 2022 10:31:43 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavxb-00AMyD-B3
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:24:04 +0000
Received: by mail-wm1-f42.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so3386688wmq.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=6TmwDW2KSNVtq4ZlhtsL5BkD7AiXRc4wEvQ0d+46b3NA1g/niffDMPEgzUPaJ+4vlL
         NnvlUXEsw1ry3+n2j+uYMzPUjcnpop375oS9ioyF0DeTASZhqt94OnZv8pKIxiBRfd/2
         8v0gn1BNpao3DWhqD1aGxQNxztW17J8fiKHRsvlpkd5iRHRVdz0zQcalaEvTGuQ3+ZUx
         1MsPGmcrMV+LOjC61LPZl3TJGA+mS4Mnutk7SF7ZBzUWiUz7AkxvgClol43w+NHxNOMZ
         EjksnsstUdVXC8gwVYR3aue/BZmGZFvS6PXRG4GhYhMoEOZlBLoLmbFafkd+3kqIBXR1
         vW0g==
X-Gm-Message-State: ACrzQf3MAIDAR2ljabD1/H0wjdDfdXqFvw07bLnH56yMs8LGK2yiwUo5
	3Rf+WQUFmpAShk8/FYVFdoo=
X-Google-Smtp-Source: AMsMyM4KZisYCSMNv989SnjlovYRx10agsySKQtGyCrkKOedaEMjS3twWDmcnPYktETvgzsHJdyL/Q==
X-Received: by 2002:a05:600c:1c8e:b0:3b4:9247:7ecc with SMTP id k14-20020a05600c1c8e00b003b492477eccmr5371494wms.40.1663752240423;
        Wed, 21 Sep 2022 02:24:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c059400b003b4a33a7d08sm2331859wmd.9.2022.09.21.02.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:23:59 -0700 (PDT)
Message-ID: <2588cafe-7e60-a087-ad42-bd790b14e79a@grimberg.me>
Date: Wed, 21 Sep 2022 12:23:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] nvmet-auth: don't try to cancel a non-initialized
 work_struct
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171931.1289669-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022403_497485_C20EA95A 
X-CRM114-Status: UNSURE (   7.20  )
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

