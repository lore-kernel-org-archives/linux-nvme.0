Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476AEC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WG6lsCqayVOeNypbNBSWPngb73VnFj/sk3YDlZ9oync=; b=RfnTlgWRLYx+2wO1gIFKuuMluW
	QbwkRokEZHDvASxgs9w3EYVtnirL7WuZuU/awJxaDY7g+bWOZI50CfopmTbxFsdLCnZ3mMCAogL6M
	zPVYoxEHPph1b/obUaMvcvn98zWg4AL8F3dRfglSrAcfVVAdCQO/2iRc77F+/ph4pk/AHGWNNSmDX
	20FmFyXVfakA4KINHoVQp9j23q1rB7U4cUjcWO6WcdRffNPqshCZuiEB1A4Ms1kRGg8CTUkGIkCum
	2EpbwleI6patGYSH8+l3AzYuuJ94KEM4XaJmbjUZ/HrgLSXDkK/l2PRgbQorS25VsI7ffOfZBSZAp
	dF5OYmBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEqc-005qfK-0s;
	Mon, 01 Jan 2024 09:44:38 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEqY-005qew-32
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:44:36 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2704405e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102273; x=1704707073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG6lsCqayVOeNypbNBSWPngb73VnFj/sk3YDlZ9oync=;
        b=NI7/AjYJQ377iZzlvk/pm8pvIHbmxeCh0JMRnVyO/Z2LxGpg/BJk93BSWs9Rb8DlP7
         JzyR16AXZdzGX1nKHurbSRlapTW5PwsRHPzSwAknX297h1NXsB4bf+a3L+JOQEY75TA4
         lPBAywCGe3mQv6bHFsj/6dyWt8+FiJ29QnS69asj2IVamYf17mm2ZiB6EubqTX9I+5o1
         XrSUGpRn1B7FG1RKDDVnKD6o91JmVe9jw/2yXMXuXCj98rf1hBPCbxvun3h+Axq02sT3
         hHk49o9r8k8lQMbJ74J0as1GN5xwI87lPA9wyIOmg4X3FlG2PWWB792fKsIaA+vn5EX2
         P5Mw==
X-Gm-Message-State: AOJu0Yy2bHE22gvBWziUXPEF6EzaPpTnE421g798e8/4WQCzMkCi2z/Q
	JyLlWmOTz4DPeN7XH5nDckY=
X-Google-Smtp-Source: AGHT+IE5+H9VUN0YLdKq3P84Zj7Ix1XfZnGtEt4kXecSU34SRQxMibbc1ujcwXOts9v5bW1UPCtrog==
X-Received: by 2002:a05:6000:402a:b0:336:ee9e:fe15 with SMTP id cp42-20020a056000402a00b00336ee9efe15mr11277611wrb.3.1704102272736;
        Mon, 01 Jan 2024 01:44:32 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00336ca349bdesm16258370wrw.47.2024.01.01.01.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:44:32 -0800 (PST)
Message-ID: <df74b753-75bf-4182-ad9d-ad51fb94d889@grimberg.me>
Date: Mon, 1 Jan 2024 11:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] nvmet-tcp: fix a crash in nvmet_req_complete()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20231222151750.655751-1-mlombard@redhat.com>
 <20231222151750.655751-3-mlombard@redhat.com>
 <a2274654-bc7e-4a8c-a7f0-33da8a2147c7@grimberg.me>
 <CAFL455mL42m80_qD9DBFLbAKi1Wi80rydM7v1-=dw1tfE575PQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAFL455mL42m80_qD9DBFLbAKi1Wi80rydM7v1-=dw1tfE575PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_014434_977319_074382C7 
X-CRM114-Status: GOOD (  13.40  )
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


>> This is indeed a bug. However nvmet attempts to gracefully fail
>> a particular nvme command when there is a recoverable error (see
>> nvmet_tcp_handle_req_failure).
>>
>> In the case where the length is arbitrarily long, then it really
>> doesn't make sense for nvmet to just accept it and throw it away,
>> but if this is an offset error, maybe it is...
>>
>> I'm not hard set on this, but it would be beneficial to have
>> allow some graceful cmd failure here...
> 
> But doesn't the nvme over fabric specification explicitly say that
> those offset and size errors in H2C PDUs should
> be treated as fatal transport errors (See
> NVMe-over-Fabrics-1.1a-2021.07.12, page 69) ?
> What is really missing here is setting the Fatal Error Status field in
> the C2HTermReq PDU, that's
> why I left the FIXME tag in the comment.

You're correct, the spec does say that. Sometimes I forget...

