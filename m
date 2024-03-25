Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE8CC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Mar 2024 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWt27Rhb8cX1CP3aVjopBlcb+dUHX67210tB9KA0yKQ=; b=bjq+whwDE/wfnsIUuOXfg5T9GC
	vsehivaIOv7EalBViLDIT1CDAGvklla/Sm/usQq94VthkPMZhqz39EE5jItiFQ3qziJO8sMb7Nt0Y
	xGqAJA06bNfk6PBlKYxIvHpnjXLKBzTCeFdsYC2o2RO2rlOS7WgaQ9jWYDZJFlT9nbG7yy7zyx9lf
	7EccgfZTINmMTZQ5RopZG2XMZrbYomec8xicr3L5w6w8V/6cAZMQ7AzHROq6s90WsZIA98UjDZX8f
	Pxrbp3fBNrH+4lTxEISRwNG7k9nGw0SFF/EjSlvsWty+lRFvpXrlYJtn0A67PpLeyGaRcu9SMmUM/
	bsTIRZog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogIz-0000000GLZc-0MOD;
	Mon, 25 Mar 2024 09:07:45 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogIw-0000000GLXM-0bWc
	for linux-nvme@lists.infradead.org;
	Mon, 25 Mar 2024 09:07:43 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341bba83366so608585f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Mar 2024 02:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357658; x=1711962458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWt27Rhb8cX1CP3aVjopBlcb+dUHX67210tB9KA0yKQ=;
        b=bdz24t5hrRsQqQC8v7hXvpfCNi1aRHNkyLo8kGdRyitHxu1hGCXmkCgvegkFjI2Dwn
         +vmxPK/j+/T9n1p5Rbcizx14YB2w1isVBR16u0AZGE3kAPwxnXu+jLUNjZUV+o+C1UyF
         z3TIT3CVKWFog6ZB8/62DX4Xfk6Rh+o+djg3tlQV55VQjGuA0/fZbMEjSLUVnARVHU0v
         1V2wUOsrxBipinqjcwdUeQacODxXCF4GKllKx8+PUt7q8agWEdc3357yBd0wUKJE8g0M
         2OluMrhcP6fYk8rfWKJTaSi8FGawBZT3qsVCAsgMzozS6W83RWSDMqHGJXo59AMgql3h
         +P6A==
X-Forwarded-Encrypted: i=1; AJvYcCXvPRFvdInKvph+sh5EsrEkpMl+WCudbSxIbN6r34G75ucnxgEpDxkcr0h9AuyB/O+xQOSgmve9BiL1IcQAcdu9PjJc28gQzooiZNpsdb8=
X-Gm-Message-State: AOJu0Yz+CKWaCqUckAswKLuP8XthmA/k3JSR9iZffc1ML/q64uRYXBe+
	o3LpgX0AOu+PfQ5JMF+KZDAkJHUc0J2rL5UpEt9H6ozjxc0+FcGkWbMitnN1
X-Google-Smtp-Source: AGHT+IGNP6/bhyNeKpYKJc3pcwqrXvizNNAYeFd8jA442Yc921nsoqZ48jDBzBjR1hOrxMwHZ3IMRQ==
X-Received: by 2002:a05:600c:1e11:b0:414:8876:ff4d with SMTP id ay17-20020a05600c1e1100b004148876ff4dmr2257937wmb.2.1711357657975;
        Mon, 25 Mar 2024 02:07:37 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b00341d1aa0245sm643668wrb.106.2024.03.25.02.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:07:37 -0700 (PDT)
Message-ID: <b1edba76-b9c5-48c3-aad7-0f2c10f93fbe@grimberg.me>
Date: Mon, 25 Mar 2024 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: add debugfs support for queues
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-9-hare@kernel.org>
 <efd797cc-2c6a-4d08-9100-762052a9c788@grimberg.me>
 <ce6cfd9c-10cb-4690-999b-f738cd376fc3@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ce6cfd9c-10cb-4690-999b-f738cd376fc3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_020742_322078_1B30E5EB 
X-CRM114-Status: GOOD (  12.43  )
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



On 25/03/2024 9:25, Hannes Reinecke wrote:
> On 3/23/24 21:31, Sagi Grimberg wrote:
>>
>>
>> On 22/03/2024 9:03, Hannes Reinecke wrote:
>>> Add debugfs entries to display the status of the controller
>>> queues.
>>
>> I'm questioning the value of this. We can possibly see lots and lots of
>> queues and I wonder how a queue entry will this actually help.
>
> One can inspect I/O progress via the sqhead attribute; also one would
> want to know the number of queues created.
> But we can leave it for now; main part of this patchset is the 
> controller entries and the possibility to trigger a controller reset.

Lets drop the queue debug stats for now

