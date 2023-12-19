Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6077BC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVGzG+aeOFyDI9T1nVWaIfCj/vapT4VstkcO/UUysQY=; b=46VbGuvnbAphprrHSiVpuDvsbq
	hAjZBlejnmO1Y7Uaoggl7aOdKzZIce0M1Dr3ldTPRWZbABwiloWc+qF3aT1jsLQ1GAwdH4ntWsjNT
	JGRNWrS0g8zrEYrwfki1jKCQFUGO1SKK+qOvwr73cmfbAO0KPnAB/kIdIOgmVqt9USzqZ8XmWnwsd
	V+aVK3Od/j7iHbN/Lge7JJfyd1zhUz7+713v6a57HKXZZrznB4zE5NmkAMnE7W78kPN6+E8Z0sVms
	zA/NyJEHieOh4I6QH8bOMs6rVJB5Ul+x+sAWWP4Q1NaZat55bjaU56/Q5wl18YKD2XWrPbLAWUB30
	XE3GuqrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFav2-00EKXl-0q;
	Tue, 19 Dec 2023 14:18:00 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFauz-00EKWR-1x
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:17:58 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55378cdd5ddso561377a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 06:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995474; x=1703600274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVGzG+aeOFyDI9T1nVWaIfCj/vapT4VstkcO/UUysQY=;
        b=CuCpHasO5PYz3/CugiGdssxNXG4eHTGKwGSxEj4ku+IUsoMETBaeDQAkTM6WTTLJHP
         LFi2cssmh0bzmvo4+sWJR+VqpJ/ASWOf55h+Y1IibXi+qBp8/VgpmaaT/mw6orMxPtoy
         gf1EQv07HxH1bsqQwLSMtV8pehH28sM8U5xms4ZN2f9g6SckYJCsXk7Vp/CN0Tfoz/YP
         un7Wt75Oh71LPQG1DwQvn9z8stsd6OTGfVrD8xEWPoIdPgHxcqBnANUwBvmZX5S10EUk
         a2KVWdDgOyNEFLLfIwgtCLuJzvWfjgP6yX/u6fV0+JWKBdLY/2fcWfvN7XJX7B5oBL6H
         NLeg==
X-Gm-Message-State: AOJu0Yza4LFkYvSAUxMDJV+ziTHbABE2yecu8A6yLe8puLWQQlkRrVlK
	Q5ES/UlwBhHoBdrFGfyFgso=
X-Google-Smtp-Source: AGHT+IF3fp4n78f8oLdrYyFcHNEzhh4idct6L3ki5yXota4dxT05QZmCAmN5f/95Om8KhEh4dm6ypA==
X-Received: by 2002:a17:906:f586:b0:a23:5c9d:4233 with SMTP id cm6-20020a170906f58600b00a235c9d4233mr4967725ejd.7.1702995474356;
        Tue, 19 Dec 2023 06:17:54 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170906a24200b00a1e04f24df1sm15444570ejb.223.2023.12.19.06.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:17:53 -0800 (PST)
Message-ID: <c59b84bd-db93-4190-8940-b5491c8ca1fe@grimberg.me>
Date: Tue, 19 Dec 2023 16:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet: implement unique discovery NQN
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20231215123929.172940-1-hare@kernel.org>
 <20231215165920.GA3642@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231215165920.GA3642@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_061757_639151_0BF3EB4C 
X-CRM114-Status: UNSURE (   8.60  )
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


>> Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
>> directory to specify the unique discovery NQN.
> 
> That's a bit of a sparse commit log.  What do  unique discovery NQN do?
> Please include a reference and a bit of an explnation.  And tell us
> why this feature is useful for Linux to have.

I think that a unique NQN is better to authenticate against. That would
be the motivation in my mind here.

