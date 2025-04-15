Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C05C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUzxPqWx0OOTz55UfOXXztdPyW6VLPLxKhv6Fi6iz/U=; b=bV98P4P4ds8my5wwOxFf+sJ2v8
	pc+8lKBsciyTrcl6wXt91JDombSCiJOAHiS6YReTEK9pKfko9OpjN1U2RG5IKmAEqONFDOw+leTdS
	zMxyPjRjKCcKu8N0xVOEHXT7RGjIOfBZH9odaNptExWobOTY91u1mzu6WsfFaO2nYOpewi7ca75k0
	yEft+LLNSBfa3j1fR+Oo9/2j0J1hIiQY3eDsVmdLGRrMS8g1MRqGolWP69XIoWu1ZA4b6gOfb1cgI
	TRa+x3SCe7ez61jc3L1qenBXh5q0sXyE+2wwNuyTR3PaKk9NoH9QGHoyIdZzAqUhn8k2NmEPPqqPt
	XkED2NMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nV5-000000078dJ-47nD;
	Tue, 15 Apr 2025 21:07:23 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nV0-000000078cU-0hAB
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:07:19 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3856704f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744751236; x=1745356036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUzxPqWx0OOTz55UfOXXztdPyW6VLPLxKhv6Fi6iz/U=;
        b=GDvgKQ5kuEmfgNYGd0y9fpXPzy6IbVYyXoASzefdnq2ZZIdMewn00IMBoNkDqfHVBw
         4BQJ4CtWO9SAR4/G/wc6hUHXe4e3WxaTL6EOMa/cT9kU8icg7yIy9Nw+OzUw8TXPUd+L
         8WECJjCBx0wB1hvlfeILa0IevnKBQQz/vjoqbA5rZytixcFLwywOiXXLYYENFhsZavDs
         Fd4x7SDGCztgKlwEUR5OOQvXp79rpHQ2jCW5KJ2ACkWw1QMCHq/1XR2rEEByRoBwd1jB
         g+epl0OnHbKBOUidaF0bLI+NyJfpUojap2mSJkdBvprNjt9LDp4uGuvjVdUrZPY475BB
         ATIA==
X-Forwarded-Encrypted: i=1; AJvYcCViC4xZTrYU0ShtX78LvxFy2F+4ciiTI3wvQ1K3UuRXSAJWkJdxyaiI2WsroKfwKV4Yn1perpHjCb/z@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+EbKivKU+uwS4CV5SPaIeQJb6KHTCAVaKxSCt1QJW9vfisfDD
	QaF6pBSgxGFydiItXLKQA3/0cwQ3+ys7zLb/l5rhN+O7DMqltjAm
X-Gm-Gg: ASbGncv8mliIQkOzzWoQPAoxGKpBhEUUfigz44Hmr7ehh+Ff+k1g9tf72QzMlWGaxLN
	SX2+/tC1xuTKjzVri3YQA4+/dPB1AchHJxgJ8x5XXYjl9oUdztw33MOlUgmQSAWONNcwGOVBNcu
	2jVwT1uo1gQ7Nmxe7dnZB7sIYq3cQX0pPFVAv5W3tiyZZPnVHaDjce+s5j0QOvc0pSY9yDSoxiM
	JvbwzbjVf52hT9R866sziiZs9HboIsKxKiv4VjVwMPCBs9EEyo3+SJPoKHytsxCvZj0RS6/SsJH
	wRRdW85R7fw1LPQU6vyuj6HOm0AAyLuqeA9r3Bn2Hv8HYYMYukCNI0+G5D8WiVjgDFmfx88GInv
	peOBD9WI=
X-Google-Smtp-Source: AGHT+IGoKlGczBMcbZ0B4XbTxPXNN0vZ0EndsqEbPuWObfbAvZUHWL3mEdgRaulf37waq5U9OOdBGA==
X-Received: by 2002:a05:6000:2913:b0:39a:cd84:a77a with SMTP id ffacd0b85a97d-39ee2761f11mr719736f8f.37.1744751236294;
        Tue, 15 Apr 2025 14:07:16 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96403dsm15022191f8f.4.2025.04.15.14.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:07:15 -0700 (PDT)
Message-ID: <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
Date: Wed, 16 Apr 2025 00:07:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Daniel Wagner <dwagner@suse.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_140718_207855_0F0988D6 
X-CRM114-Status: GOOD (  16.16  )
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



On 15/04/2025 15:11, Daniel Wagner wrote:
> On Tue, Apr 15, 2025 at 01:28:15AM +0300, Sagi Grimberg wrote:
>>>> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
>>>> +{
>>>> +	unsigned long delay;
>>>> +
>>>> +	if (ctrl->cqt)
>>>> +		delay = msecs_to_jiffies(ctrl->cqt);
>>>> +	else
>>>> +		delay = ctrl->kato * HZ;
>>> I thought that delay = m * ctrl->kato + ctrl->cqt
>>> where m = ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
>>> no?
>> This was said before, but if we are going to always start waiting for kato
>> for failover purposes,
>> we first need a patch that prevent kato from being arbitrarily long.
> That should be addressed with the cross controller reset (CCR).

CCR is a better solution as it is explicit, and faster.

>   The KATO*n
> + CQT is the upper limit for the target recovery. As soon we have CCR,
> the recovery delay is reduced to the time the CCR exchange takes.

What I meant was that the user can no longer set kato to be arbitrarily 
long when we
now introduce failover dependency on it.

We need to set a sane maximum value that will failover in a reasonable 
timeframe.
In other words, kato cannot be allowed to be set by the user to 60 
minutes. While we didn't
care about it before, now it means that failover may take 60+ minutes.

Hence, my request to set kato to a max absolute value of seconds. My 
vote was 10 (2x of the default),
but we can also go with 30.

