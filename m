Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E29AC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=VQ8ZHh7qRb4+EKcB2DsZjYYyEB
	CNAy1nVGYoSdLVh53JBPFoKjQutNkhxOzMkfHSVg/fRPSy0cqkodj5LrQNbtcfeyeDjt/aToXjJpQ
	nFTW0aThwQOMoxbGKx/OlMW1nBDeGwTy/twirX8eLi22MnKGTLha4KTH7WfWZ0dfrPBZVEq3Nmlok
	JgTApRYPLnLt0ZWz5fVz5LQ43n+gLp85BG3QrrMGF83DxWWVWVITaTVTLj3CdB9kOFhXxiOxPBGS3
	+sEio/3nm2k64Q6hWJlDrtvhR89KOIhQ6t3nUiEfTRXt1lySNF+bqhKmzlkJk+C3zNskeaPFzECt5
	iCb5Xkog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxGP-00AwrS-W0; Wed, 21 Sep 2022 10:47:34 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw62-00AR1E-Pi
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:32:50 +0000
Received: by mail-wm1-f41.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2025735wmr.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FOHGKEI/qI0lt7BXmGNKzY+7fXpJ3Z+IbC7Dw2Ymp9YmuJ5VBh6L8q5a4SHwrfJrrH
         9G3H7aXLPkudRpPf+0LnyTL328CvzLHdBaJ0UBMEd3fPfubpsaxrZ3xJqwhkAjOHHyLj
         iP5v7JTD24HbKTa4Juu7aOzQ9azmv8HNYBSV2Wq/se8w09Bj/WraV9b1Q/KjzOg1g8A7
         TbwxzplJEgHcG1l74jdeM5F/ELnrmcvTRQYECPQgQo8eW+EKRlPDMATxYbhOjrwOp/q5
         5r3YYMlBNg3j9LK+1c/EYrI1D87Q/LXFqzRT9hsZDr9kjCbX0+7QdxAR6lSkp9t+hvNn
         FDHA==
X-Gm-Message-State: ACrzQf3IoYME5n2sdKtKkWRKmNDKD00lb/UESrJs/y73ZckdYuWOAjcc
	WNz8ipkMQlnuEiu+H/dPcvE=
X-Google-Smtp-Source: AMsMyM57u0rR72qzh17KkwkCYFEA7jDNyhOZbk8GEh1rPG8XibaJ5AYdAImZGjTq2MSj2B5uvnAOeg==
X-Received: by 2002:a05:600c:524d:b0:3b4:8ad0:6d with SMTP id fc13-20020a05600c524d00b003b48ad0006dmr5384549wmb.194.1663752765413;
        Wed, 21 Sep 2022 02:32:45 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5302000000b0022ae8b862a7sm1985077wrv.35.2022.09.21.02.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:32:44 -0700 (PDT)
Message-ID: <02339cd5-cfdd-2560-8d33-9ddf085e56ef@grimberg.me>
Date: Wed, 21 Sep 2022 12:32:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/13] nvme-fc: store the generic nvme_ctrl in
 set->driver_data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023246_930718_1A3FAC34 
X-CRM114-Status: UNSURE (   7.29  )
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

