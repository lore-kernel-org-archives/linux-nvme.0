Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3167EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wuGhny5hsKLzce/C/qbgMqj8TH9cCCK1tE6kjfQ+WY=; b=pTrPvxVEG5RQmy3xwLUqP3FfNR
	pn/sxeNZTZogb1gWdNRoTxvrwjxdB8ZBtsRkhJhjxwWbvhgF3wFdeTsxXRsCq9iLoBnrNzKhIHot0
	P7J1vNpRVP3/SaF6kKwIvNKW7kV+iFIMC7CHlGXe1/j+Y+59/0pyPFKckkJFWe3ZwJ+WLXPG9ZbSC
	ZHTqQZ/VcBrlNg5nbmf9oGOlAjTZnvSw3Uiyi4heyZWEHOBvNgbwEhF1brpWAVdo8Lt8svhmemSBJ
	DgGHdmWHKbrLTPUul2pmpTF6IlsGpaVVqxRqsueiXCSQ9cWcwrZlCbO2l0Nkbx2ncQFlVfzQUqdxb
	keAJcq8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9AiW-0096ly-2Q;
	Tue, 13 Jun 2023 20:34:16 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9AiS-0096lA-20
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 20:34:15 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f642ecd8c1so1149266e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 13:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688449; x=1689280449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wuGhny5hsKLzce/C/qbgMqj8TH9cCCK1tE6kjfQ+WY=;
        b=SvvSvpntecySam04ecmIs3kVE8QVTZIOd+6fCMlIZA1bUIfKKqnbGTmzH25pQiMZsJ
         cPcJX9h2EHgxVY0drnu30drAquixiRycnN406DHfINhTC4H+CUWj9+0UziYB3vnnAJRX
         kJdpPjBKKzCdPlKi7S8NE0rmNi3Zh45E5OgLG9yRaSVFfJuIm12ZXkdexFGSyTw/JenZ
         oFJ/i6CL5fPdwnIjmyWojQwZe4gxk5/QeyVf5xSWL7hN8JYiVM9PHk2M5TwtIqJUtsov
         laGNh8GmaRj/oo8mX397Hdp40clKdqVHdQdhAi6aDtJATMa34CnX5Lhh7NKB7E+YqY09
         jzmw==
X-Gm-Message-State: AC+VfDyT3uj7npV6OL/yiN6mB1dMdc0oc/4jfPYHXzxFgl24l7+tGxRF
	G8cTQtQ4/gLK+pcId1kCGLo=
X-Google-Smtp-Source: ACHHUZ7CbPWFbJl1TsFH/qBGM3J6KaEiV3j3MUWjw1DLl1z3gWHod6EgSPbJTxX1J+xKFaQioQViZw==
X-Received: by 2002:ac2:43c4:0:b0:4f3:ab15:aea with SMTP id u4-20020ac243c4000000b004f3ab150aeamr5837044lfl.2.1686688449009;
        Tue, 13 Jun 2023 13:34:09 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id g9-20020a19ac09000000b004f7642f638csm41050lfc.192.2023.06.13.13.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 13:34:08 -0700 (PDT)
Message-ID: <4c40b502-4309-d601-d8bc-18042c3f490c@grimberg.me>
Date: Tue, 13 Jun 2023 23:34:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_133412_682388_6C67EBAB 
X-CRM114-Status: GOOD (  13.52  )
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


>> And this way is correct because quiesce is enough for driver to handle
>> error recovery. The only difference is where to wait during error recovery.
>> With this way, IO is just queued in block layer queue instead of
>> __bio_queue_enter(), finally waiting for completion is done in upper
>> layer. Either way, IO can't move on during error recovery.
> 
> The point was to contain the fallout from modifying the hctx mappings.
> If you allow IO to queue in the blk-mq layer while a reset is in
> progress, they may be entering a context that won't be as expected on
> the other side of the reset.

That still happens to *some* commands though right?

