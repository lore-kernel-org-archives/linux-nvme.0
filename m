Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B1C6FA8E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fSGg8d2WZAco/zwHNQAt0gUqUZ
	EK9E1NVUTONJWTKxSZtkkWQx/m5p2H3KsizP5QCgxjgMbevSs2gXvljZKBjyyhBmKAq+JVitgWi6/
	MTvQtlPJCT289Lgi+0u7jcc1EvsJR18pk0wSdi2NFhtP6PZzjCDMkTf8ctMdDfZcFeAXkczLwCJ9s
	C97wQB2nmGP8M5gJlnv9Hx6D2ovSqunq4MBjlsKBoP7eTqj5/xgdzm62+cOlzT+C2yO0uHN9d80pK
	hE8MrEP4mUb218mopb9slsRIcr9G4QTL0xZwdRTyxbxTXKCQ2oqhmeXels8sHFSyopIlFt/XjxP2v
	MnV1Y8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw4g-00AQP0-Rj; Wed, 21 Sep 2022 09:31:22 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavyH-00ANIR-Hb
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:24:46 +0000
Received: by mail-wr1-f52.google.com with SMTP id c11so8777078wrp.11
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qeTUeuAfoQiDaWeFB74JIUAnOlaBauHOZx/f25ao2mdPadMhpjoQQNTBOTdrSouRnv
         KgMMWX6EwOi9sdFZQ/XiMaU+xLVHka96c7Qp7Nt2G4gDWDix+dIQb6D9r+3j6t+irZll
         RxAQ3RPSg7Jr6MR1cZe+u4UOrhR66eVnNvV2v+FXWIGgmK71n2ynRpYrBDTIEqrHRVfZ
         4/TTwkUOB57lHfbjETNy41NJNHGn35qVL3y/Hw62BW1Hy8sjrXh6gSFtPKRx1rxGszep
         Ppv0pXIJdOdbxEdjWXEt0Usv0nLmKZBOMHnmMfvaHz8QP77gDlbzMWA3pXRBlW4aAgX1
         s8VA==
X-Gm-Message-State: ACrzQf3QK3xXy6Mvpgi+9nERsWaLVWZtaVsl9w8WstXu0pXeB+cSLZNF
	y0tsnaW1nd5qUO38hXfUOxM=
X-Google-Smtp-Source: AMsMyM4+TIG5SEnHpcGZc2+/JvkxSs3iWKq0M7Z2mZrhZBTOWDNJ1gzqWvw1EIgqwY47OqQjVa1wjw==
X-Received: by 2002:a05:6000:1cc:b0:22a:e8c6:9f57 with SMTP id t12-20020a05600001cc00b0022ae8c69f57mr12270442wrx.527.1663752282899;
        Wed, 21 Sep 2022 02:24:42 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r9-20020adff109000000b00229b76f872asm2462794wro.27.2022.09.21.02.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:24:42 -0700 (PDT)
Message-ID: <39ec5d19-f31f-9031-e7b4-cc3b14b907e8@grimberg.me>
Date: Wed, 21 Sep 2022 12:24:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/13] nvme-tcp: remove the unused queue_size member in
 nvme_tcp_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022445_622578_EFB17C7B 
X-CRM114-Status: UNSURE (   7.60  )
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

