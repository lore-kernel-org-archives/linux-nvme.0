Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B4DC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:42:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8610650A9
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8610650A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Qps2v+PKyALkVNdJjuwPBSebH
	Y2g+zAnLr2Vl74eOEXF4ElVOPKReOTGvk9NXidPR23+KPGwWI0tM+tQ90oWzXT5rZLODPW7eSNvoO
	lEAbJo/SYhkeArXuPaPilv+JykBpyHHkWiXAGwLpk4iXTgu6MG9LoRtCGwVWFdS7kL0Kv6JpQrdzF
	AK+oKjB9YZZ2/eMJy714GdoVWxYzuYervjWVMR+Pq/moGOJxdwvvu8cVkHFh7DjcHw2fh5np7xJDE
	Yf+t64FgWefOefNQ+Py7PvpeyJIqsPOglAqRLQFRjjR8zPkdkoM/wdyN19pDg6iU/knl+Gf5FsXuE
	qPCIWN3Eg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ9J-00Gtcr-5K; Fri, 05 Mar 2021 22:42:21 +0000
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ8y-00GtUi-5M
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:42:02 +0000
Received: by mail-ot1-f45.google.com with SMTP id t16so3368407ott.3
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=cIWAbklHzzczgPve5GX5Uvm1esqdvk4+Gm5SjLIMnOry3BacjU13vD3r5e1Ba7LggB
 5JmVoFFYuf1jn1BoDq4kY66X3AkIs/86y0PGB0VugVXUk4NZRyCM8daHwZ4GwlOtHpqy
 nzGY5LvK9E44yOh0bCqPr1+nP3cq9nYwBK1Vsy7/Umyc9AZ8q4dQM9gjoc55XfQccJlE
 0yLWP4A1i8SLRz1onjx0NWm2z+SjO2qwUOcnz4tg480i61FsAT5y7gC6ekDP3Kde/uhI
 pI6eby+On6r4EXTxxGYLYCAvMyzyl29FxX64ykGpofM7HFGpUt/EfysfiPYhKnXStFmn
 zS/w==
X-Gm-Message-State: AOAM532iHckH4696VHmtYR90kK4twQoYF3Hr3iSs7w9xWIhqARiNT04I
 1+Z3G6N6Ax2dxwdRkNsnTFQ=
X-Google-Smtp-Source: ABdhPJzYAIksJN93ynFQnxU162qjaO3naJnUMdL3J17m162X2Kv15E4fUBry9/c1WU/Y76wnsk3x1Q==
X-Received: by 2002:a9d:2622:: with SMTP id a31mr9802245otb.205.1614984119156; 
 Fri, 05 Mar 2021 14:41:59 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id a1sm866160otp.68.2021.03.05.14.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:41:58 -0800 (PST)
Subject: Re: [PATCH V2 6/6] nvmet: replace white spaces with tabs
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-7-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aa6ba0d6-afed-01a9-fa48-929568d90eb8@grimberg.me>
Date: Fri, 5 Mar 2021 14:41:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-7-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_224200_767411_38965D5E 
X-CRM114-Status: UNSURE (   8.42  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
