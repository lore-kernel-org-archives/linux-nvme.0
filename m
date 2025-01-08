Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23B1E77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhENU5uwL/F+8pIJp0NZRVBdpH8A4Se4PkDlEAPVKRs=; b=AGO4+OFgbHFEjhgGrYkxOCAsp0
	T4K7c5T2vZnBqmiUbkFSvW2K5h3PtB3hvsgp+wpqGFNzpXhuQAKvWzSQDsMsIB3RfAKpaw1ij7kM8
	2MZ12PywtFwCh+so77MgMjUf+Q8tBbCycZGyC8PJLXzBF7bOjE2njaD3aikqvvXrXDKb5eRzlqbVb
	tFti27jVerFskoW3eE+++j5/hKaMufbQamxaS+0cKaGIOikfAmgNvqpwjSVtE5S4erWIc9QIn66ko
	Uc0fKnYaashpd+KmWDVrkWOq1mU/+FxdEk0nzUqRX7HiE3UzTuGV11qZPAqyYDnen0PziwY04MOrW
	8jokZIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTmi-000000086bD-3y29;
	Wed, 08 Jan 2025 10:59:36 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTfM-0000000847t-1yMs
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:52:01 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so172361045e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 02:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333519; x=1736938319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhENU5uwL/F+8pIJp0NZRVBdpH8A4Se4PkDlEAPVKRs=;
        b=JNxzqC+dpt6vrSIwp7N80MXDL3HDWLWkbcrcxyLLJXRH0IWAJQwCJ8TLZGEKiDlAp2
         H6w9gLGeWhRpTu4CbyKtDqxGL1QvT5FYOYxtjMv/zUdOLDw0cSzLNjoaNLvTHsTYBhH/
         eaCGel7iHEidxOTzBhalryaPOe6xW2cESLVTnc5PvnYaRdQrIwLBWFtOUOgZntSDN+0p
         393g8tFuw1k2YETfEirYVctuAxdxFm9u6/2GXqBCMYt+ZFFYSlHW17Gx+fKEKurYIklN
         Ohnf5J/bZfkKJoo0s6KuvV6oRqUx0manp2TmyxvFPU36ozkdgHcef6pOlRjZkHKfsAge
         mppw==
X-Forwarded-Encrypted: i=1; AJvYcCWUsJXtlyLghctbGT8R9CmdRCpgg7xeKuh56Y6kcGEOBLC4bPOzbhhhC6kjUzL//zhz6zQ3BhwQ3nVk@lists.infradead.org
X-Gm-Message-State: AOJu0YwvoTL9onuPtZtKGffwc1bZ+/kaDOltHpaq+OTuN+BWpYaELpie
	6hrnfA6QhRGtat/gRTmi+fB33FyGmDBMquNFbJbyZi0FKSVr+1eO
X-Gm-Gg: ASbGncuY5vpbPha0vMzX63Ci9yjlnQGSXOndu+F22vQUoO8TLEEBoSWQnig8E65cCLO
	LiO3irr5/j3WPWTkeM/SR2MAoJVGfe5DNXdYBFb837CfMtOaoC3TN/n5Ci8k7nQZ3V1uVZDWjfw
	Goe/G5IRxhsFfPBYVmFioQr79CVWYJY5VeDJWOWMqVsb15C8VG0DKwgNSUeGn033A0CMMpOhI1A
	Lz5WHraiCG8Yh6ORv9C3xLFptNehKrd5uKDVsfcaA977/+ENMhrxKeT53Q3JVjhi0fPqjfG6Xfi
	JOe3JZpCO6uTARuyBcZsqNA=
X-Google-Smtp-Source: AGHT+IFZL4M4kgcPPbIOh2khr7VwPqAhfwET0wiN/09hyxRAT5lxFHupzADYYjBSfRDAorxOxjNSwA==
X-Received: by 2002:a05:600c:1f91:b0:434:a8ef:442f with SMTP id 5b1f17b1804b1-436e26f6318mr14447865e9.32.1736333518684;
        Wed, 08 Jan 2025 02:51:58 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm52717530f8f.68.2025.01.08.02.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:51:58 -0800 (PST)
Message-ID: <f55a339a-9424-4f67-b7ef-b97167fc42ba@grimberg.me>
Date: Wed, 8 Jan 2025 12:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
 <feeecd49-3dd2-4c23-a4fb-dc4a43e58ff7@grimberg.me>
 <fe5f7ae2-ccd2-4b5c-abb6-a5619813ed5b@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fe5f7ae2-ccd2-4b5c-abb6-a5619813ed5b@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_025200_516203_8D00954F 
X-CRM114-Status: GOOD (  13.58  )
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




On 07/01/2025 16:40, Daniel Wagner wrote:
> On Tue, Dec 24, 2024 at 12:35:23PM +0200, Sagi Grimberg wrote:
>> On 17/12/2024 10:35, Daniel Wagner wrote:
>>> On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
>>>>> +	/*
>>>>> +	 * It's either a kernel error or the host observed a connection
>>>>> +	 * lost. In either case it's not possible communicate with the
>>>>> +	 * controller and thus enter the error code path.
>>>>> +	 */
>>>>> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>>>>>     		return status;
>>>>>     	/*
>>>>>
>>>> Hmm. Maybe checking for NVME_SC_DNR, too?
>>> if no one complains I'll update the check to:
>>>
>>> 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
>>> 	    status == NVME_SC_HOST_PATH_ERROR)
>>> 		return status;
>>>
>>> okay?
>> Why do we care about the DNR? are you going to retry based on it?
> I don't know if we should care. Hannes brought this up.

I don't see why should we care.

