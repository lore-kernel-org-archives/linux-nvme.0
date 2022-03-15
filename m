Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F003C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLRYlW+ovhG0CrseKSNrla93igJgJ+o8+kPY09swh4Q=; b=BwV9ZGwt23x4VsLVVtxu1ZBk4v
	S/rm/cGolmCiiw8JFbeVCScQERkY+eeBws/idDd7TPy+CpiW/7SBd7AMbXGUZnJawhkZSHE/Nh4Lv
	dRd7OFCWRRmkKTtlSaYFdPyCYWMqOcEo0u6qzfmP8XlGdczupvvmjBDA/WBWu0Pqe7RYdexAOxKns
	fDlWPU9HwWVAOHWvs/2xsDYDtgagxYOAPEwDssUVgx2zjEY+Pdwqhn8TCRTo+QDoFtbXuVASytEzy
	4i48idIt8LHR2e8u9AViOMP7Jzv+j0IX/GmV1IP0lShCnIWYQ5QmL/VE2Rm61CPVMWL0QUJKKTTL+
	VzseOfUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU4LA-008iWS-7z; Tue, 15 Mar 2022 10:23:44 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU4L7-008iW1-9g
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:23:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 bg31-20020a05600c3c9f00b00381590dbb33so1173745wmb.3
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 03:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mLRYlW+ovhG0CrseKSNrla93igJgJ+o8+kPY09swh4Q=;
 b=3KoHU0W1AdSl24fw8rFZHrVehnG/axtuRdnRu6QRF0TogxDeQB8d+84/5Oohx1XNdu
 S2fyRUTPiK4oxLtXGWdIQjVFSF5eeCGpx+whME4j82fBxaJ34ggKPCUl3axckvWgv10k
 dzABzlh/keJWW/mqf8aDf7LLtwex+hSHHxyD2vdB5ZCC3q5FToddZ0QU2mtlyB1K3tRJ
 o8K4X8iht2aLS6wBTpISMvWx8izDtCZ3R2a1yhXi9c1CAT4LNKNG0hUUUaC+754cPKxA
 EA7CvviDuVVbmNykxvUziyNA/CNiYj3oIsVC8xSb+Iga4G7aZSKVAIJw3cE6o1FPI7l6
 J26g==
X-Gm-Message-State: AOAM532ofUa8yMdSlyBAUBBA8Sj8hSipVaw0aeI9UkGM6g3IaZzjrecz
 hQ2MZ1oIp8xtTVjU3toVzMEQCzMfN54=
X-Google-Smtp-Source: ABdhPJzwwXjMio0B/va9FLBTZILBoS+3+me1YKPAEqGw/ELGzBjtfcMUqXcujmligZoXlVOakhs3nQ==
X-Received: by 2002:a05:600c:3b89:b0:389:cf43:eafc with SMTP id
 n9-20020a05600c3b8900b00389cf43eafcmr2674482wms.205.1647339819133; 
 Tue, 15 Mar 2022 03:23:39 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 k17-20020a05600c1c9100b00386bb6e9c50sm3308794wms.45.2022.03.15.03.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 03:23:38 -0700 (PDT)
Message-ID: <2a09e3ad-9b83-7c4d-1a03-154684ea1600@grimberg.me>
Date: Tue, 15 Mar 2022 12:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315094950.GA5322@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_032341_377426_F54D9BA1 
X-CRM114-Status: GOOD (  26.66  )
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


>> The core question really is: do we _want_ to expose the discovery subsystem
>> in configfs?
> 
> Well, if you want a freely configurable one we kinda have to, right?
> 
>> Unfortunately, exposing the discovery subsystem and trying to configure it
>> with configfs does _not_ match with the way discovery is implemented today.
>> While we currently only have a single discovery subsystem, it will only
>> ever return the subsystems visible from this particular port.
> 
> Well.  The original Fabrics spec had this concept of that magic discovery
> NQN, which implies that there is one subsystem (or many pretending to be
> one).  And that is what the implementation followed.  The varipus 80?? TPs
> then made a complete mess off that.
> 
>> Hence this rather simple approach, having the 'normal' discovery subsystem
>> exposed, and let the admin configure it accordingly.
>>
>> I can look at keeping the internal implementation, and only expose unique
>> discovery controller (ie those with a unique subsystem NQN).
>> That would remove the need to having the 'discovery_nqn' attribute, and
>> address Christophs concerns.
> 
> I suspect if we want to support all the new mess from the FMDS group
> (and maybe we need to question the why a little more)

IIRC there were different reasons that we probably shouldn't care about
that were related to the centralize discovery thing, but a side issue
was a problem with authenticating against a discovery subsystem that
have a universal name (not exactly sure about the details, because we do
also have the hostnqn in the psk identity). However assuming this is a
real issue, then we probably want to support it.

>, then we should so something like:
> 
>   (1) keep the existing global NQN-based discovery as-is.
>   (2) maybe add a per-port known to allow disabling it if people really care
>   (3) allow creating additional discovery subsystems with non-default
>       NQNs that do not automatically get anything added to them and will
>       just be configured as needed through configfs

I don't think we should do a discovery subsystem that tells you about
subsystems in other ports, that is most likely asking for connectivity
issues. Unless the log page is constructed based on explicit
configuration.

> But maybe first we should take a step back and figure out what supporting
> TPAR8013 even buys us?

Hannes may know better on the authentication aspect...

