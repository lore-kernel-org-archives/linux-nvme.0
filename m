Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52CED3C935
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJz7F8Svhcyb8pwbc3oF2aU4l8YOR3cM3kmy6IimVHM=; b=M/nkrpTMDvpRjIO01b3ZCnfCsO
	If5U/78+SFibRjxmZUFoOFq7iyzEHNveEjMJrSGHIwQDOBqJc/adeXmd3zRrBM72DCKk8/Xgix3RW
	5Qr82Xw7XwBCdD0aA/b88N8QSNsqKGk1tXby1uM+rOVfjlVMD0ue5m4rfWnmW1YEXVCN5So1ssMP6
	Lz8cvL973NJ5KXCL6iuapHDkWhpJfTkGyc2n7/kkUSa2joI0TMU9NYtuVGZVEM4f5mjC45r8DrtQf
	B7paO9qkkXD7uWV2nuxKu/xecUON30sDU+Be9+kJ9nRaPWytTBg/18aB8OQ7ioLcpkL1jVXLjpZ7S
	uKLDOBEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2g1f-00000005gNB-1izn;
	Mon, 21 Oct 2024 00:11:59 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2g1c-00000005gMM-3vsB
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 00:11:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso34422425e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 17:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729469515; x=1730074315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJz7F8Svhcyb8pwbc3oF2aU4l8YOR3cM3kmy6IimVHM=;
        b=BwWZeq+u/CAJBkqLH02Xg9aHoM6oZ3LU+WCoBLe0RTzV3KMI87ptrsN7L4t1rM3kDD
         Urfoek17ARCfSqG3pqLc5GEO9XyX/4rOHjglqqBYv5lP114cZA1uLAt0q52CadBuYx87
         SlKIQpty9RKURNYzRBf1qnraSbrwIVgo80Ptnrah35wmHTq2VF1qMSy9TjNrlOMxKMC6
         YeXKqDiKbRU957UhqD/xcIS1VAKTFdK2IvRiC0nLbeR5qR5kPRzyHtrZlFcNFij+jCmE
         /bP6yK7glz6ze7dybCPHkXcoB61N2dJ9Eh6j4dT0nVOvsjJQga0J0IJglooDNWJN5vH9
         DWmA==
X-Gm-Message-State: AOJu0YzO108zhjywug7s4owN/tRNmLRFKEy8eHPKt1wW+idsiKddSVDV
	HoxMKQ7/7VT57k3hj543zYqrzjz7rMpDLXU3te8bn6xHkN9daoMZ
X-Google-Smtp-Source: AGHT+IHfrsz8X0mpQvtg/FHZJ4E5rJcvRsTBZdlJ6Xkm+RwUIQNZDm24NT27k9Vo4tMX3YGVswU45A==
X-Received: by 2002:a05:600c:4ed4:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-43161669e34mr73844195e9.21.1729469515299;
        Sun, 20 Oct 2024 17:11:55 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570c79sm38831325e9.3.2024.10.20.17.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 17:11:54 -0700 (PDT)
Message-ID: <0dadb3b0-4aca-40e3-a476-47427a9d7bab@grimberg.me>
Date: Mon, 21 Oct 2024 03:11:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: tcp: avoid race between queue_lock lock and
 destroy
To: Keith Busch <kbusch@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Akinobu Mita <akinobu.mita@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20241002045141.1975881-1-shinichiro.kawasaki@wdc.com>
 <Zv77BPZnS2hJMUjZ@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zv77BPZnS2hJMUjZ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_171157_011399_28592C7D 
X-CRM114-Status: GOOD (  15.90  )
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




On 03/10/2024 23:13, Keith Busch wrote:
> On Wed, Oct 02, 2024 at 01:51:41PM +0900, Shin'ichiro Kawasaki wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
>> error recovery") added a mutex_lock() call for the queue->queue_lock
>> in nvme_tcp_get_address(). However, the mutex_lock() races with
>> mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.
> <snip>
>
>> The WARN is observed when the blktests test case nvme/014 is repeated
>> with tcp transport. It is rare, and 200 times repeat is required to
>> recreate in some test environments.
>>
>> To avoid the WARN, check the NVME_TCP_Q_LIVE flag before locking
>> queue->queue_lock. The flag is cleared long time before the lock gets
>> destroyed.
> I've applied this to nvme-6.12, but the existence of this queue_lock
> seems strange. It looks like tcp is relying on blk-mq's timeout to
> individually complete requests after the queue is stopped, but I feel
> like there should be a way to complete everying in a single batch. We
> have the generic nvme_cancel_request() for this reason, but fabrics has
> it's own other way to do it once at a time?

It has traces somewhere in git history... the original introduction of this
lock was to make the timeout handler and the queue stop mutually 
exclusive...

It may probably be reworked, but the dereference here needs to serialize 
with
the stop that is releasing the socket...

