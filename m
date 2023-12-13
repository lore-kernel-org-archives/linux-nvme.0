Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D2C4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=RNxdcIN1/R0HKSHb0HIdOYFJaE
	fN5FXONesrZRVkkcoOJ4Wxiuivz6/5sLFjmr1EqUtFSSmOToMMx9GIMl+rwNu9yXKnMDRGu8dV/la
	SLxwwR0aFGoFl6XcUp3yS3hi54lu9nKwbMePiFm+8KLczejxbyghJN7IOjROz33O0CtaG4wtEDRMt
	RTgkmxPwx9vr/Z+QtlA1OJh4IMJkp4/zvykTwfxWHUHGkYw+2q4PrEtqm4HIlK28pLxkVn3CHFDF1
	rBqGAuiN0hozAixkwaoa3ItDS3eIkI1KyffQa1vEr17a9dq6r0RJnVvBGfzJHfakPZDG2qI7fS61n
	1FFW9wiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLD-00EowG-1m;
	Wed, 13 Dec 2023 13:31:59 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLA-00Eote-0V
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:31:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c1e8458b9so11489635e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474313; x=1703079113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cWqjdPjQtYkT+wxGZys93CqJ1FT64+SnIFA/+OVp4J0JCPw8kS32S0QibQZqS4czRw
         QEdUIJ81bklnYQ9huRFTC4aMuvsYxuQomsYTh+FCJDQoAXtGnen1oS4EnAoQLS9lDYsu
         ZtDyYqL7aBB9Eh6t4CFlfvOFr2vU3HkrDqMUSiZGN3eyTh12pjcG05aCmvebOBcIUKHf
         gp1iFK0D91ScYP6uvYPAPv5GJx/NZxmyxKJ4f3sMOUSqDjUw5IKTp31sPRG268dB0OhS
         +EkKv1G5PipmIe3vA3YjR2VAtuIs3cbF/8GXyNHccPLgIOo+wXCSeWQtpHzguU4uBbnG
         /V3g==
X-Gm-Message-State: AOJu0Yw888eEVxhvlrHaEq8W0wpX7CAxIjy0XeBjLDL1HxACF/imJXF6
	YOwJ7N9H92sTi0geF7FMUpbpt4tjuUM=
X-Google-Smtp-Source: AGHT+IGh1eaw0Hl61JrzotywNG9+7JxMrT618PD/xeUqmNoCx2I/ZtN+xxfRtsLhCb5l6GKFmeSsaQ==
X-Received: by 2002:a05:600c:1d9b:b0:40c:2960:9603 with SMTP id p27-20020a05600c1d9b00b0040c29609603mr9826466wms.3.1702474313260;
        Wed, 13 Dec 2023 05:31:53 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:52 -0800 (PST)
Message-ID: <26c02e67-cf59-4eb4-8dd0-c8f7f2a2b820@grimberg.me>
Date: Wed, 13 Dec 2023 15:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] nvme: repack struct nvme_ns_head
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-7-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_053156_455020_30CEE7D6 
X-CRM114-Status: UNSURE (   4.91  )
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

