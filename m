Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B2C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=orX5QUTgPRuBv1h0YXTGRA108M
	4oK1JBT6/lM5a7I9H///N5O5owJSAtxPntg/2tsbBKap4mkOEsnRbGtWw0xufJq3kcOtwzCd+7icj
	VBNBQFgLzdP7V7luH2nBZFo89XK0EFgQ4P7rQ7j7046ntvkqPvLzGIGj0l7o8A9SnTjhn9KTy+TqB
	54vQ/UNVx1htzBG58Q94jm22fDuyFjNDrTTcjXSEuVg1QORVQg0BRhJqiQrqOi9tfWUnk3mjKpQ35
	Hycsf6y/QrKU+qCA6ROv648ViuRkj45PHMHpNn6jkxr1x7rrUYRvhDDG317SaHcNBMV3hXvtO4NIt
	zHLl30ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxGa-00Awz2-Em; Wed, 21 Sep 2022 10:47:44 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw6p-00ARJX-Oa
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:33:37 +0000
Received: by mail-wr1-f48.google.com with SMTP id y5so8907026wrh.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BJIJ/LUv4ked4q9QTrwN2Wm/yThZ7j7t+x/xyLkv/9268VIYBB75DXviyT3Dbc4m+l
         1C2Q1/f2kj9JJVfZgFTU9jHPlAcuDmMB4vHzJrLX8oT5dJmUpCrXNq9I+LGp4PwpBkuS
         3DowfkY0gPocf/bTmjzakPNR9FFcttsP1qVLLkCiw9qV/cKl9t8iRFyAk48dAt6+zXlK
         cCFhTks9xLzt+/0BbnmeLbAyy82o6HPLd0cqP10HZB8AFRhGmZ9srenardRVEwslyfv+
         eyYv/oi4KnGZPggAeVEO1rvNltxg75dMBU5bsHY9gWvEQiP+LxxXHcNMAqe7NOElWlvx
         VbqA==
X-Gm-Message-State: ACrzQf0vWizUSqw0sxjyZ/cy2s4qHB0qj6CPXLxGdq1urT6mdgsdbcGy
	DY4hgz9YuVXoJ0warLZaOrULEgsMgMc=
X-Google-Smtp-Source: AMsMyM5YV1Rnt2UYx9yUQhBK1V/JHWQbM2TItJ5ugVokQ6kMCKJsrQWSY7Ez+I9jaYOuUeThJKryxQ==
X-Received: by 2002:a5d:6d8c:0:b0:22a:e993:c37c with SMTP id l12-20020a5d6d8c000000b0022ae993c37cmr13195112wrs.592.1663752812963;
        Wed, 21 Sep 2022 02:33:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bv3-20020a0560001f0300b0022b014fb0b7sm2026620wrb.110.2022.09.21.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:33:32 -0700 (PDT)
Message-ID: <8a54dbad-9b23-81b9-c505-8728eadb5087@grimberg.me>
Date: Wed, 21 Sep 2022 12:33:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/13] nvme-fc: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023335_818175_ABE6A8B0 
X-CRM114-Status: UNSURE (   7.43  )
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

