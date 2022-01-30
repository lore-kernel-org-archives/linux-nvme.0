Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F1FC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SiG3pyIqKaL8JjZ3SxbDo09QKZ
	4SegrHN36nxfodCTu5k786R57cPxcQHmUME8M5hB2lHHGQCPZVyY4vjAHUuTkcAFqPdLwop1Wyz+z
	X01Xu2zEwghy7x7Ku1FFWBIyRVPz0+MWnN+9kdJj5M+ZNBaUk0Vr11x42akRJS5p9h8Xl4vqssEbs
	SQCJwVkvcwdV4EnapRodirWVZAGju1ba18Cofuinu4TQNv4u7paNKrCcLDqB+iLwqo4AAK3WcEgEx
	qqydBE3bGMroiS2Wq3dh8uM7e1yfCSHNaALYD+ZFgMyuVGmmP3HsiynT99hUJYnlpB0hIibs5GIAq
	N61kwAZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6l2-006HNf-4c; Sun, 30 Jan 2022 09:44:28 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6l0-006HNB-6W
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:44:27 +0000
Received: by mail-wr1-f50.google.com with SMTP id u15so19642363wrt.3
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=1AICk+WDTRyUUTAxnS3JZkMETqLS2BY6Gd8dHFxzIo+djby4sFLUCUVS2R94azzx4E
 q2F7X8hhO3tWWOtyR724rhpyXp5K+NNVPDhRCj0inBq7zQegq3vlizBO8ctmq3kvPE0K
 xzb2WaTOdlSi52HUH8U9CNhSEhQDN0T40fhUcG01ePTmKkJveKWWUo3VIHNSJlXgTGxb
 yiknHgH7G9RD/ZHL3sdhrAg36quAug9XRJRx9FMI4wWB5feOMO0NNEra4IDhtiIsnRC3
 /sCkrqLu1r9lI2Q6LLtuK3d4ao3wcC+M2k4lTynCnZzjd2++8GgkeoOff/s2Fe8GI+hO
 00Ag==
X-Gm-Message-State: AOAM530zM7PyJyRUEs5PYMg1Ui4WCMZsvg1e9oCOzDV0MvTTu1xth+Hu
 jLceag5qllfi71C8hGnOdnI=
X-Google-Smtp-Source: ABdhPJzCP1fe0eF6FxK2whGD3gbV4vdZfyHtR5DH2HvF3ZgMq6zstKl9aLBrbFr8k9mZAQI5mZ6klA==
X-Received: by 2002:a5d:4406:: with SMTP id z6mr13272156wrq.544.1643535861934; 
 Sun, 30 Jan 2022 01:44:21 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m5sm6295432wms.4.2022.01.30.01.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 01:44:21 -0800 (PST)
Message-ID: <9bfd9981-92c9-6f43-82fd-8fbfff1b3cad@grimberg.me>
Date: Sun, 30 Jan 2022 11:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/9] nvme-fc: add a helper to initialize connect_q
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-2-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220128092015.19289-2-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_014426_295802_013A5820 
X-CRM114-Status: UNSURE (   5.65  )
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

