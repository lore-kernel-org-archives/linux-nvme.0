Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB27DC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7gouQvWx6QNoqOIMmyI0JWOcykZkfTMcDroLrlbiFs=; b=GPNAAgTO5onrOHU9I+cnAXWweZ
	hpl9HavyoznpmwkZrNXvycDV+B9IVkYmWHEzziWDam4OKjMwUPyk9JtdteK0CsEuSC2m/sClhyzCe
	DEYVEko6oKdxp+QC739lxDdw5s/RP5xxi0HE618zYpVbtiis+X3HmKzk86kfM9rOxEsT64iuEzIG1
	iGXBeyMrNEbJ1vVsK6IPVH+o0T6O95WIW5YetM3zj7aQhL9xNOJShDf+JW6EXyy4PbM9qi/AfmxTH
	qwm4BEj/vhXwzE+VhDtmje3FCmfaz5Eo5wcFPPLKmENME3PPCzOhhXtWKlCQO1sNDYd2K+XO7DQ9q
	puq/jgaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDJp-00ClRN-1T;
	Thu, 07 Dec 2023 12:17:29 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDJm-00ClQw-0u
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 12:17:28 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1d48f0223dso22600066b.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Dec 2023 04:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951442; x=1702556242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7gouQvWx6QNoqOIMmyI0JWOcykZkfTMcDroLrlbiFs=;
        b=PFsvxrLww6KEeSQYw1H5rEI4EsWobnwEbJe0S+A/VA9FQrldixaaWhrY4a4tEuPGzq
         nGYZouwTdDrwuqcMcEm8tx32SOotGklPkNjNrWBZJN1feHLWE7kQD+opP4jRIoxeBo9G
         jI0M61Nv88uU4EGuES5OmmmH5lQTFFuDJDAsizwmhcicv22C/boB70wgluHdHX3TorBs
         3r/dKSvzjps09MCp4FVG391IV7A7gTTeEW6CgFpsTN8pEvYTbcp0gSgfJDN9obiOWaDe
         kXXSZyPmq8t6Mo3XsUUeg8AMEdMQBIewcNSog2zYVd6FSZe1YY4eHAL9LiQelcDmQrgU
         wDwQ==
X-Gm-Message-State: AOJu0Ywu8vsggB80tkpcK4VPZdaSO8gQKCxdsNgVXcBqi39Sl7B018VM
	NgfPEVIT5cUbGKaxLAvCnYXl9TdlQzs=
X-Google-Smtp-Source: AGHT+IG/ZehdKc4ncVAO8hgBFj83zLRk5vHXRZs+huqwDtv4oqF8iikN/dd2r6H5D+zOLIm/3qmLsQ==
X-Received: by 2002:a17:906:7f08:b0:a1d:1c71:8158 with SMTP id d8-20020a1709067f0800b00a1d1c718158mr3066093ejr.4.1701951441926;
        Thu, 07 Dec 2023 04:17:21 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906314c00b009c5c5c2c5a4sm748946eje.219.2023.12.07.04.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 04:17:21 -0800 (PST)
Message-ID: <5a3aa3ce-65f5-4be4-a4af-04a4dc7c998f@grimberg.me>
Date: Thu, 7 Dec 2023 14:17:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
 <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
 <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
 <e3fa3584-47e3-4712-a2ce-7fc59e603898@suse.de>
 <8cb5e071-385a-4332-af97-cef4ddfb4720@grimberg.me>
 <6nmywu5e44fkypykg27lctjmmd6ottw4t53cxgt2rmdlqgvem2@4vi5v4pbmgsv>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6nmywu5e44fkypykg27lctjmmd6ottw4t53cxgt2rmdlqgvem2@4vi5v4pbmgsv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_041726_338556_78C8B47A 
X-CRM114-Status: UNSURE (   9.81  )
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


>> Yes I think so, we already place a listen backlog, so maybe we can reuse
>> that as NVME_TCP_BACKLOG or something. The same should apply to nvme-rdma.
> 
> Thanks for the discussion. FYI, I modified the patches by Hannes to reflect the
> discussion above [1][2]. With these, I confirmed the lockdep WARN disappears,
> and saw no regression in my blktests runs. Looks good. Will test again when
> formal patches come out.
> 
> [1] https://github.com/kawasaki/linux/commit/dc58819d07b02bd54dbcd5b15d2600a517fcbbff
> [2] https://github.com/kawasaki/linux/commit/20fb65d145152562d0e11a9c8065e64405c31b0d

Can you/Hannes please submit them?

