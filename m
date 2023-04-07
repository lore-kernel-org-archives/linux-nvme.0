Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F201DC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=H9JD6uObG+7RTU5t0o60rCiQDZ
	5MT/JtwFYEU13LGn0Gm/7olJ/UdZ86f8HcE5bevTBObbJdyJLvm4X7gDcKUTyVAWtrNcD1Jsueve3
	MKbr9g80vvI8htZCaOmetdTStIzJgLqA1nyFBa5NE7j+d+Owy3PsdbjAvkn5vMKbKfYcvYW+4fsy/
	zPD4KTDY4fiR6v+isplEZgB1ZD60eBxLeVRF7SdDmqynBZMEgzxf+rwSvMxEXHHYlH5njnfiRzvvV
	8feOynfe8hPDN+tdFCU4IJStWWgftwAOSYndJ0X+U8nZE2xvzn9fw7IaLfGZp2/AfIuiiiW93ZVTW
	wFVTf7rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pktgn-00BAvE-2R;
	Fri, 07 Apr 2023 21:32:09 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pktgk-00BAuU-1y
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 21:32:07 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2ef1e98d6bfso285625f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 14:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903123; x=1683495123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DS3RuBW9fpilYospi2GBJ6udhcG/lwYqLl72RUE/gth01CQrrfyce8N616guiy32Zz
         f3I0B+g1zDJZxGju4DCkaR1+5Gy7D+ThoXGV9GyoBBuJjaaNWDvbzPQAX1XdbOSm8+4K
         Hv8gXjO3jGIAIj5sZ4w2LJoRVTzzmpfVtR8Fa+lJH8hdQ32fr1DbkO0RixyNJW2ym3Tj
         Dax0TXv1rYc7HFRQ1FoOlMXytOhshvGqnEY6JknPK/qmN3NSYlDY9YvZirIvNM85My5a
         NQeI0eIcHF/al/ToPN9mPbCt4wVSWteNLz5yHogb4lK3YxY5d8yqJqki3EYJpnjSGVRH
         LR8Q==
X-Gm-Message-State: AAQBX9cfCtmWrnRSMK3110UyUmAwxWpj6fG2ySJS+VIqzQTgsI+Zyd1T
	J3UK8S5FQJg0t53gewY/yT8=
X-Google-Smtp-Source: AKy350aftVjN+RI2QhsfXywWC6MZ04AYV1360oc30Ejp+AVgw+KMlQ4KGBSGQ5r++P8VmtnZClKL6w==
X-Received: by 2002:a05:600c:1ca4:b0:3ed:d2ae:9adb with SMTP id k36-20020a05600c1ca400b003edd2ae9adbmr560042wms.0.1680903122683;
        Fri, 07 Apr 2023 14:32:02 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b002efacde3fc7sm3106275wrw.35.2023.04.07.14.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:32:02 -0700 (PDT)
Message-ID: <8dbe0d82-992d-d42c-20e5-c20fdc65f03b@grimberg.me>
Date: Sat, 8 Apr 2023 00:32:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme-rdma: minor cleanup in nvme_rdma_create_cq()
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Yamin Friedman <yaminf@mellanox.com>
References: <20230407091557.258669-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230407091557.258669-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_143206_645230_FCF779FE 
X-CRM114-Status: UNSURE (   5.59  )
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

