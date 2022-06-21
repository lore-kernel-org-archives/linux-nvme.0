Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B27C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=tE9hgIT66fDVXv/AgASVZYyB7D
	NPf0xl1u2a0Pv2xpdMX56A+BA//0yyMcuCvttrlSHA1xSoxNN0nz2jOhD0NJCpKdFN1o3snglnzok
	bnAtZYzw2tcbzz5YVGTGvC4KTiEV3s/YS1w33qpVVMUhrY9kXZzikds3DoK+N5Zu1BQdcKkV5uXi0
	z0DDiYbKGXfK+jWrBtcYOcspEYJxd8dtdIBDDUiVIm3VmXlpXPdVwh/7Y/gQRiRKLh2UdwwkPrTfp
	02mZt+6OXAYn/b9eShBhf4RJH6X+6taAVKFuyPfH7bxY2gmPY98sKxGQXnwTVZkq7I5t9yehLMZtL
	H+53uBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3lLv-007Jej-JH; Tue, 21 Jun 2022 21:24:03 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3lLs-007JdC-9O
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 21:24:01 +0000
Received: by mail-ej1-f47.google.com with SMTP id u12so30118521eja.8
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jun 2022 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=xsGaDGiRpHieW1DOfQG0K8bvooekv5rBBp5Ab/glVnyooFDS8GnrwWK1cOdjejYzcq
         aGJmMmspyg05xoWD6NEjj1Wqfr1x8s3gCCMfF0oUszdO9OGz3cAxFdOHWtaf1nqKBzJZ
         LGkC4viCct4stGvEPOWxk2hzlbVcYYGctWERh+Aq0Ddc7guOBCcUT9QocNZ0RqwPllYU
         AKMMCqYVYTQBhfxnUIRnXm5zT0U6Ik31BFtZCiR2ikUSOMSQhPAk9ywaXcWNTb8NGn5q
         sbWD/QtfyHfcvaqkKMt6MOhUWB7WoFTfGayDvKzC2BvftdgzUfw+dsA7eJVnGwm4xZ+x
         207A==
X-Gm-Message-State: AJIora+4VfIwIw0MjDuYt4WvSiTzqtWxZHbE2iuQ4/+ZOuQw8hlTEyaF
	Gn/SuvlE6l9y0V1VeNRHAvA=
X-Google-Smtp-Source: AGRyM1usY5g1Cjawz2dCP7Q6YO493T7ugBcMxHng7gYLv88wU9l378UiR+I2fpIy9xQ9Qd6Gxaeaxg==
X-Received: by 2002:a17:907:1ca3:b0:705:5a6c:d113 with SMTP id nb35-20020a1709071ca300b007055a6cd113mr46741ejc.535.1655846637481;
        Tue, 21 Jun 2022 14:23:57 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090614cb00b00712057b037fsm7890860ejc.167.2022.06.21.14.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:23:57 -0700 (PDT)
Message-ID: <87db917a-90ab-af5a-e94e-b74a2efcf4ba@grimberg.me>
Date: Wed, 22 Jun 2022 00:23:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: gost.dev@samsung.com, linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com>
 <20220621070500.1381155-1-j.granados@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220621070500.1381155-1-j.granados@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_142400_375217_68CB0779 
X-CRM114-Status: UNSURE (   5.51  )
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

