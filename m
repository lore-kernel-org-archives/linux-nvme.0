Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A7C43217
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JYC0FP1BEjaEx3a9SQ9y5OjOQq
	EYlV2OnimID1upU5Zbe71htn5MQqi+Y9UVx6lmQe1UP+9AZZUOO24l282wsBCU80u967MgnkDtm9Z
	cL7i0ZCy131UuMs8wH53cdEMvpBnS+i3pX2jUzvQQP+rpTTID6bKrMSr9wDwqeIKSQTT2+B3jANQt
	dn0HmGr5+pcFyREvu0/cBQUeCZb7dVoZav1SB2dknRlXvLgYZfp/2D2DYD41SGFflfh+fwlWrqrBk
	OmL4ghU+NPZDg1LZS6Bzex8m1pp3DR4RmtICKaeoWkfmMkyJOT7Xamc32LuV+HKNgw5WZNUc0/ui2
	N4R+IrrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ospA4-00FkAK-Hq; Wed, 09 Nov 2022 17:46:52 +0000
Received: from mail-qv1-f52.google.com ([209.85.219.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp9y-00Fk4W-Ok
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:46:49 +0000
Received: by mail-qv1-f52.google.com with SMTP id i12so12798074qvs.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 09:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=4PiuuzmOWUAJ++r/RZuYA4QlzkOcHBLG0eODhTNyOr8gxa4i4/PwY01CTDUGKrEoLK
         m662mUifQ6uN6fSrkPOMbH71kbLgq9MVa2cwXw8XtgIBS36ABK4mo615KB0ds+fqAmZp
         MqnhHTNrelYY8hbI92Dfy7b91/EF+tFtTN1h1IP+ZiR/rMxRpO1SnRfJZWyUyozjRj1I
         xlI3JrUrZAiMM3ZB44qllv7eXbHb4rwzpikSgH+7g11DYtyt/ziYyt9VH8kZkez0taUh
         fowo8EXD9PjNH5LyWtFhx1ejINWWXcrXYDgjWoViTVIlqWfBN3jEY2h6zWfcqxKOzboZ
         GG7g==
X-Gm-Message-State: ACrzQf30vmoJpjvfGo0VOwisQo3SLDf2wSFd9oNfFWjps8lJTITTYyqF
	RzdI9X2Yr3arEJBUvNuhRJQ=
X-Google-Smtp-Source: AMsMyM4pnBc4LASdG1X0XxLrWrhjtUoylqMnvlYcMLeiUwbaEJ+6PhBf/2F9/YIc7lxQswYz6lp+Tg==
X-Received: by 2002:a05:6214:1d02:b0:4b7:6a28:3e85 with SMTP id e2-20020a0562141d0200b004b76a283e85mr54677351qvd.88.1668016005162;
        Wed, 09 Nov 2022 09:46:45 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id bm26-20020a05620a199a00b006ed138e89f2sm11300865qkb.123.2022.11.09.09.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 09:46:44 -0800 (PST)
Message-ID: <7dd79dd2-72ad-5185-d8e6-048fa16c45b1@grimberg.me>
Date: Wed, 9 Nov 2022 19:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet: only allocate a single slab for bvecs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20221107140019.1503818-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221107140019.1503818-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_094646_864788_C828F9EF 
X-CRM114-Status: UNSURE (   6.41  )
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

