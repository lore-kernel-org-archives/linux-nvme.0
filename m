Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88672C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vv7B7hgnZCBwQ8kBW9KbGsZCuG
	Y+tDDxdH16QlmdyvrTuMDJLVo17/N4eMADsy4c7eSkUmnZhyOwWZQ1piV8hftSPgOzJOavh8psjPx
	GqJ9FqI3U38e32h9MWsTGjuAItTHuWGsGwZdvHf587xBURjt96rGQpaNmZsUF++CS/QU2k5V7FhEI
	pHEm2bL1OpfQ+r2NoNKIxjbwlOZ1s1pu6ZNaFmjNLTpI4265X5eY3ZJxRQOP9DZ3ayokqOO2q47pn
	qZTU6SjRNTNvvw2I+hNmZHlNPgObf5I8+cRNDZpIZNZSH0gPaaqBA8Q/IqwDyhSG7qApDJyj6oM4A
	nUUmO8uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw48-00AQAN-4C; Wed, 21 Sep 2022 09:30:48 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavxy-00AN9P-3w
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:24:27 +0000
Received: by mail-wm1-f41.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so7358609wmh.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hw/NVhSf0B6oCZYyOACwK31r7ubiC6Cp85gHhxRRf8GIbwSG/wIBX8tT2eb1SI7Vhj
         /SsKLcuV1aKttm9FcGCHxge8zjbXFiriWjK4IFlHTeOFEBvnh3rpmlRUiZL1EPa1XizY
         9FnZaFxIPfzwNAFAkSClsxMPFTcdCLO5gRYHs/tEDWGHiQ5PkzOUwTDAenfjuxm5vPem
         UFm4WZ4XFcYYGFcCq1IQx5sVXQk63NYpH16QPAoZihVXyK207yeXk9x3mFJHHEd8cmSv
         bce27f2tRezWBcrgroJc0GCeuOgqFmplVOZpD/gXHn7tccpCknwi1/BpicbB4Cqm/K6z
         nuIQ==
X-Gm-Message-State: ACrzQf2ksClcOQuKj9Tt/rQzpXcROEBukQmLjaEHLVhUI1rx8/tFLlTi
	g67bsIBaqlw55p5cEAbJyEh2Bq9USuI=
X-Google-Smtp-Source: AMsMyM7c9a7QFWudwdtCfmvN8ors0V07cdmIqFFSmCprn2OZEK+P3eKByaEUR4r5VWhRnh/gx2JeDA==
X-Received: by 2002:a05:600c:3506:b0:3b4:c086:fa37 with SMTP id h6-20020a05600c350600b003b4c086fa37mr5436418wmq.165.1663752263517;
        Wed, 21 Sep 2022 02:24:23 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b0022af6c93340sm2007737wrt.17.2022.09.21.02.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:24:23 -0700 (PDT)
Message-ID: <d48b4f14-ec62-c2e3-0728-32c3abd950e0@grimberg.me>
Date: Wed, 21 Sep 2022 12:24:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] nvmet: add helpers to set the result field for
 connect commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171931.1289669-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022426_178330_85D1566E 
X-CRM114-Status: UNSURE (   7.65  )
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

