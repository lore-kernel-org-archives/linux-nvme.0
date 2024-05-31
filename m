Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D61C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 04:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wMhU6ONqx7VzpejGc29mu0haH8B25NLSo99kjECHleA=; b=wDN/TM8VdVa6nXD0oXLa0yXy1D
	Sxf13N7l0/801oxx9mAG5WYr7NIEyIuvSdzexjoqZWMggXnk28EsmvWUwx/eOXSnFuccuzjOffsfn
	ecHVZVjsGGRsi/wUQaJ8IxtDHUsrosC8UCXnB6xF3yC/tK4YQ4gyCwRGACP1+h6tLHPEbzDiH54FM
	xuZfe/hXi5KzPjTEu8iQlQk4Qq0EvInVq74UBkco8de7v7LAE4ahPODt3OAVMFoXBivYqmfUj1NS/
	dIGI0p/wH90sD+r9lclgVmmmfJPgiw8UleMyGG+AMrnLLDXGn4Jshfe1d3vxZu8UjDyYiYUP3ixR9
	OTYJbxNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCtrM-00000009Asc-2zzz;
	Fri, 31 May 2024 04:27:20 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCtrK-00000009Aob-0APi
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 04:27:19 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42129d4e7bdso550555e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 May 2024 21:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717129636; x=1717734436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMhU6ONqx7VzpejGc29mu0haH8B25NLSo99kjECHleA=;
        b=NfZPZYqu0Y81RFhzMFZS7B/yHr+0x1SNpzjaOCpeiGzFyDpXzLdSV0asozLd5Xf6PN
         DpygfGZppoyPXW5JO/AVwgatvzIWUW/V7vcQ4ZAhZX7uJF/sWn4KC+SGDuk9Oxs3X4ax
         Jjsi4kdk81W5O6f3wvwSXKoA60qIsCzppF2bTglOmzasYvjycv5ufjL6a3KVP+4RbaQV
         Ehfdwn9L/7YtAOO2clB4KzvDmfu57ihzrDe5NFDyJ3LvyGO0is00naJZeO9fulUiiUis
         p7ziTITSvM/czm9aK1LpKk4HaJWhpg7KtupYQy0vry5FLzdvh3+eGgdB+jy8TBVkpEMf
         6+vA==
X-Forwarded-Encrypted: i=1; AJvYcCVs4P3UVU17fJzR84nO7iS4ifx1TSkWSvlZrWsPO+TPqgum0YA/MQgOuSP+q18BMOZOYF4tA5JGG2C5CkcFVQc3WljqfRVI4rr6Hz18gvA=
X-Gm-Message-State: AOJu0Yy6fWMyvqcZQZixubkM+sedKMfpcBinTCr4HAmCTD1xjqtRpiy0
	zC5zhhZ2egzZgbH4kmrxEUgIfgr4QF/FvTBE5+RIYrsz+QiE79+y
X-Google-Smtp-Source: AGHT+IG6YzXnayr3//psDaQ5EjQJEh/NDUfKm5ouwEGMHvrVzW1s62TBKYxs9iwQB6AjvGO/Xrwqdg==
X-Received: by 2002:a05:600c:1d28:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-4212e0c158dmr4509695e9.3.1717129635707;
        Thu, 30 May 2024 21:27:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c10fdsm885124f8f.17.2024.05.30.21.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 21:27:15 -0700 (PDT)
Message-ID: <7c1792f6-dacf-494c-a6a3-04b48596f903@grimberg.me>
Date: Fri, 31 May 2024 07:27:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
 <dfb9074c-d019-4a19-83eb-00d93da8dada@grimberg.me>
 <BYAPR04MB41514F3EA640750D6C68AF56BCF12@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB41514F3EA640750D6C68AF56BCF12@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_212718_114918_68CEA17C 
X-CRM114-Status: UNSURE (   6.88  )
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

>> I see, what is the mdts?
> MDTS=3, i.e. 32K
>
>> and what are the r2t lengths the controller is sending to the host?
> r2t lengths are 24 bytes or 28 bytes.
>

Umm, so your controller requests 24 or 28 bytes from the host at a time??
That's unlikely. by "r2t lengths" I meant r2t_length field in the r2t, 
which tells
the host how much to send in a h2cdata...

