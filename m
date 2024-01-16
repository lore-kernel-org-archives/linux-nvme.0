Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586F9C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUjnNd4KLAllztA1i10ulcFfvTiNTtL3QQRXVBrw52s=; b=kDwY9r0LQJm3qQ0aYz3CClJgzb
	fGrBAEfgpL1EFlA6cqp6EgrogfOxKIcMMY2YuzPNDSFoDbUecV43cMBWamILd7+wOTUPdoeg+EHSI
	BrmH2xTDOfN7mYTWen3uNq5PTBKaQDrwxJLzon22m2ih9VSELjXlhiYWdk6mxJdjF3pIwWKjjCX3e
	PunKFFjljiFqrNw4hJKaRdoDJ5iGxFMr84shhVIyzf4EZ7Ktf7xGZ4dp3I1qiAAkrWPO7ze+OynPc
	GXM22CJVBPfFS0kgwymA2qCWP0Y22pKCy5e8oKgDensP1iUIfVjpRAkfxUreGglsa8+fjoSU0qIKf
	YqzS8Siw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPnWf-00CqZ9-0Q;
	Tue, 16 Jan 2024 17:47:01 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPnWc-00CqWi-1e
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 17:46:59 +0000
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso7339934b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 09:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427212; x=1706032012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUjnNd4KLAllztA1i10ulcFfvTiNTtL3QQRXVBrw52s=;
        b=VWeGc8gbavDlhDFoY/p1TJ1oyCKGMYUdlNm4DZAt+th50z7SpEvoD7Vm7+kQT0fuQ5
         a9806p4oKFYoT0kI08IKW941mIGQWJZEWpKFWdYoIbH2w8fkPykqpy7CbD6qVqjcnToq
         Cgtc+4bkJs/XvMga489qnqJ5WzSna5f+pLv6JpGOLWbwkqJrZe+vDuTjGHVWslrsEHIn
         +tCYQfrG5FmmeYHSWxokeJmooNSNCfU5SdMyCenFDrMrpUkQmwN1UDIisAyNc3KvsfKt
         pv8uz9+7fQK4RLhNGqpZ0UI6Eoe8fWwVn8zID+xY+HS2dWfoPMdkI0d9RKtK5d+wSdy6
         pyqw==
X-Gm-Message-State: AOJu0YxWIeexnHKzZh0xKVL6NK0Hpkh0sP8wCoCww1Zr1f8U8mjGUl0S
	6auJ1ZAoW1Pv4J4B916lIs+M7dp5bVs=
X-Google-Smtp-Source: AGHT+IGC5ymJUoEXajQx59WFe1SfIYFFXKe2mConqsnNsIcfim0Zl3BJ+3BliR2GEHkcT6BXFo9qlw==
X-Received: by 2002:a62:5b45:0:b0:6d9:acc8:98da with SMTP id p66-20020a625b45000000b006d9acc898damr8338102pfb.2.1705427212349;
        Tue, 16 Jan 2024 09:46:52 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:bf53:62d5:82c4:7343? ([2620:0:1000:8411:bf53:62d5:82c4:7343])
        by smtp.gmail.com with ESMTPSA id f11-20020a63510b000000b005cd8ada89e5sm10422488pgb.70.2024.01.16.09.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 09:46:52 -0800 (PST)
Message-ID: <ebe78689-df8a-46ad-9593-05a2f7840f5f@acm.org>
Date: Tue, 16 Jan 2024 09:46:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 a.manzanares@samsung.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 slava@dubeiko.com, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_094658_545266_38749A23 
X-CRM114-Status: UNSURE (   7.21  )
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

On 1/15/24 09:54, Javier González wrote:
> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>> How soon FDP API will be available for kernel-space file systems?
> 
> The work is done. We will submit as Bart's patches are applied.

Since the FDP users need the data lifetime patch series, how about helping
with a review of this patch series?

Thanks,

Bart.


