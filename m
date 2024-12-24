Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8EDE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/pA54kXaVlMpPLAY6bEeTkG7mL6qyW4U3X8jyQcC3w=; b=Lmo5O4D9MJxLy/CGKPQu+BadOT
	iJzkwecFpY4fr245uvR7rW9m1yzXyURvD4eH5PDbZmu8ml6B+i6DbUIrr6D+32QpS0D1w0nqWgH4E
	aspawPHtTJWsYh97yOluqBZ3U2E40MqmaUSMZ2NXP+749Xkz6hLoAgI0EMfWHGwFv6d6U+MTo0T+E
	xyNcLmzPFR5ZtcJr+0sDtc6P16gE7wLGRlEzYCWjjjH3V5pVh4XPcR9UGOYKfOeemSGp9WyvGfeiJ
	WUeVMX85Ik6D0JxoGemsa7qtORXwL2KhyDl6IBecxwJnY1IsH33mC7maD1nI4HG+1G7EbePs7ksVp
	SsDhBtiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2G8-0000000Blfb-46Pi;
	Tue, 24 Dec 2024 10:35:28 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2G6-0000000Blf1-2FwF
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:35:27 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862a921123so3430369f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036525; x=1735641325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/pA54kXaVlMpPLAY6bEeTkG7mL6qyW4U3X8jyQcC3w=;
        b=kzRK4bFR33cT26oLcaLOZxe508IGuspHHYj5tyVvPRi66M96HQ+UMkYJzA72+fT2zv
         m++waH65AcLX8dqIp8Gi5qKCzXHKyeCy6L2dR9j+NwiCXLumtMBvXuAm7KAGsp+8eRvH
         nlbf721EizuzVQH1Q2EkQ+zWgeFPtuc7+sCm4aBx04EEgPhXycCl0bBvSrrN37319VvV
         K8KHUOv673uJA8+KxbZ5gayl4hv5jh9foA0to9ALQ/w7lYOXWsLHhjxERz1IeZjqz3Mr
         D6Mn88Ng9/+pQN1soc+ixdUIZ0M6lR/MsI88S4sGjxKw8AUUpMvyHgWHMv7mz3R8C9xv
         eNsA==
X-Forwarded-Encrypted: i=1; AJvYcCX76jDj6P+sJhzKzlceLjev5IOJCOunylE1DNCcRA5N0mVQ1PQzW7t/HGxaatEo4JtdnxY+wimak15E@lists.infradead.org
X-Gm-Message-State: AOJu0YzHhvaB0Kv0jVam+V0du8zqqlcZGVnISwBMuw5sG65j/U+MKJW2
	kXCWqxasKZrckdu1cCIDFBue6tTqRr0HkucS0XjU90fTF/huun+g
X-Gm-Gg: ASbGncuXKr03WTb/POACqhvuuAoDp9XAl8smXB2aUHSxr13+Vcohgw0n7BYF0ZCXx5z
	F+l/SmGAP9LHSLxslQ/uQKIGj+A4BEY/StEZJlhSw4SZaM/QGFjHqxu3bK75KUE2tdm9BkQWe4h
	TEOEO6Q0AaS0Ar6NtggyWrodeazenO9SVTa6oIxhFTLO0BKrXa/YsFPGvVcbOpVmUD1cdSRMVTJ
	ckDxDj9xxpp5OWZeHVy55h+vUckuTejKf8zU4roHZ7VkELS2wtok0gMS7KSl30gMIY96sPT6TSB
	pV+yhsg32KxRjn+MTjfQ7ZQ=
X-Google-Smtp-Source: AGHT+IGjlMBBQ5mbUvWJxLS9WOsVAgGr6Ok1wKVYmx1si3IW/8zJlisQvLwdqqP5YevFYkuP3B/CBA==
X-Received: by 2002:a05:6000:1ac8:b0:385:e8ce:7483 with SMTP id ffacd0b85a97d-38a221e1fe1mr13473685f8f.4.1735036524644;
        Tue, 24 Dec 2024 02:35:24 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e375sm14014339f8f.73.2024.12.24.02.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:35:24 -0800 (PST)
Message-ID: <feeecd49-3dd2-4c23-a4fb-dc4a43e58ff7@grimberg.me>
Date: Tue, 24 Dec 2024 12:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_023526_582610_5CC1978E 
X-CRM114-Status: GOOD (  11.72  )
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




On 17/12/2024 10:35, Daniel Wagner wrote:
> On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
>>> +	/*
>>> +	 * It's either a kernel error or the host observed a connection
>>> +	 * lost. In either case it's not possible communicate with the
>>> +	 * controller and thus enter the error code path.
>>> +	 */
>>> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>>>    		return status;
>>>    	/*
>>>
>> Hmm. Maybe checking for NVME_SC_DNR, too?
> if no one complains I'll update the check to:
>
> 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> 	    status == NVME_SC_HOST_PATH_ERROR)
> 		return status;
>
> okay?
Why do we care about the DNR? are you going to retry based on it?

