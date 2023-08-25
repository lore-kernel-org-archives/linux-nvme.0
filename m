Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32AFC3DA66
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=locQDMaaxVaHhY5uaRYOvholvuvSJF5DSChbm8/qh5A=; b=kCvu4LcOI9tH+Yis/3yf9fMj1H
	Ds3FAmAhir140rNfLSMZBPy4cbT9awTprpiq2qSZGm9q8Ca1bgRDCmHynPblszwyu9AX7H7RIVg4M
	OLKVZD2/1P8+d67xA+x57m7La0OGXCnM7eFkvmrsmf6BqPK2JDXggtvz8Ivk6rRdZqXGrLTE0S5Ap
	69pcyWWEMj4j7TjBeQOEFWW/DPif/bTi1Dl4mDNPdiQhUqMmelkZY/hew7YFAZZTg4dp0NFD2vM1O
	4+dZY5+caoWK+m47cz9M6QEoq0Xc3FaKBxI3Guchgcuz/rCQPm4PwX5S/hZ3Cd7k/7qLUIDAuTX9I
	QWa5VIqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZX82-005U6c-1y;
	Fri, 25 Aug 2023 13:45:34 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZX7z-005U6B-2F
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 13:45:33 +0000
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so14423215ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Aug 2023 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971129; x=1693575929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=locQDMaaxVaHhY5uaRYOvholvuvSJF5DSChbm8/qh5A=;
        b=A28lTjN8O4/4sRszFk0cmUgLdna1eYD1r7aMFUQKeFMJkDxy7zZjKCTO6uaUqbX/qt
         Ei0fs3v8jaFDCxNt9m8LDPN24wgHA48YDRELNa+5HD0dx3wZpQ90RROOAUQmBxCIX8Zy
         oeaUP+2y1QXPEfCP5xHt5BOIoRpYMzg7e2PI82Tr1pMRq1edg/q4pm2ZdFpW5JrdgK1u
         nyWhpf7nGkGguhHLLJ+6BeeZZIgU1j5zHZ+xF8xe4289eJlzxM7N3d4yl5Sw7ntwWlZN
         YS5LBO/7tUA1CD6hP8OcDzBgYj3NvnrceK7CcT4i51gtvmI7LoA5WuZvAiTfZlE8I16w
         km5w==
X-Gm-Message-State: AOJu0YzQ5zl9cnYk6Y/hVMY7ef3oDzfu6Aap37CMhxTSK58e+fmGNn+n
	sy2nAyDs01ciCU09rNstZLU=
X-Google-Smtp-Source: AGHT+IF8/LS9M3NEQYyGUlAZBHCHoOJ6Tn69CK8LsjyU7lgo4P/sZtjlDQ+JhRAss9UfU0aWFHgvKQ==
X-Received: by 2002:a17:902:64cf:b0:1bc:17ab:8d68 with SMTP id y15-20020a17090264cf00b001bc17ab8d68mr22626425pli.16.1692971129063;
        Fri, 25 Aug 2023 06:45:29 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001bdc209b9a0sm1701231plk.201.2023.08.25.06.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 06:45:28 -0700 (PDT)
Message-ID: <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
Date: Fri, 25 Aug 2023 06:45:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230825_064531_733562_C72D3B6B 
X-CRM114-Status: GOOD (  15.30  )
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

On 8/25/23 00:34, Shinichiro Kawasaki wrote:
> Recently, you actively cleans up tests/nvme/* (which is great!), and introduced
> argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, and the
> second one is this _nvme_target_setup. It looks for me this is a bash coding
> style change in blktests, from "don't use optional arguments often" to "use
> optional arguments aggressively". If we apply this change, we should suppress
> SC2119. If we keep the old coding style, we should keep on enabling SC2119. What
> I see here is the style difference between you and Bart.
> 
> Now I'm tempted to disable SC2119, and to go with the new coding style...
> 
> If I have any misunderstanding, or if anyone has more comments on this, please
> let me know.

I don't like the "new style". What is so hard about typing "$@" to pass all function
arguments to _nvmet_target_setup()? Leaving out "$@" makes it much harder than
necessary to figure out the intent of the code author - not passing any arguments
or passing all caller arguments implicitly.

Bart.

