Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F63BCD37BE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Lw0yuK8Xa1J6CeNvYlFZsbJuMdL5DLl0jqGO0gvRl4=; b=L0ZfQR9WhgoHr/GjPRvGsdm4/0
	8h2K93WImverb9JrZ5Q/z7HHhJpRasgOGpef7AJvR0VwlX4p4+X7xlC4krCyGkae9P1ykWrrB6fTh
	TYEI+uLc3xbz/yFe1z1TnNX19d12D1jz+DI07xVfefRsN2kW1unuM5GiICKSdvbYl6LAKD8ZHctRl
	qhUzb4D519F9kBiaXNzRjWCV1Ny9f/J5urz+sCv41pMJQKO8TvjQ0fkVuhQ/sZpZu8aIcGicQLOSf
	DueJJlcNSsw7ZpNKSnn+l5pk2KWDbhODLWiB2OiB/hH/sdEGeJGpY9ssBxZ3ZXWjfH9y1Ox8K65FV
	xmsNPJTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQ9G-0000000DdXr-15DJ;
	Mon, 11 May 2026 12:54:14 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQ9C-0000000DdWf-3OsL
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 12:54:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so9307235e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 11 May 2026 05:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504049; x=1779108849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Lw0yuK8Xa1J6CeNvYlFZsbJuMdL5DLl0jqGO0gvRl4=;
        b=H8hNC4KysSdtFCuToPQRa3R4B5i7FZvepppsybAgec8X6YGW1OjacRSBtDlraq4eki
         cgZyX9CFhImocgW74K7tFPcF0SZGSyneDrD4znG9CGUftH98RY77MKbl8XX4zUmRhUak
         iBbR10X/FM63oj4PZ/yFSToIxjjgy+rt+tVgqTxALZ8Gla1rbSsnSM//6jG3MrcIBwPG
         DaeVIZj1+QDy6vqDxKagkyiMwtOnBGtMN3ZWKk+BvJnw2Jqt8z6GPu+3Jx8bVc4uwjS1
         sF3VkqU12SGUO3pN8tXwX+8yP0gtQD7eBJuhmrRI5hG9N46zpSWwFXcoy4oRN0MmCMkZ
         qEEw==
X-Forwarded-Encrypted: i=1; AFNElJ+Kq8eIbDeyIH+QMK4QySg+b6judtStjwy9vNSCoyLI9FGo2o47xVw5JAkRnrKsVaima4DZvuQ0OjC/@lists.infradead.org
X-Gm-Message-State: AOJu0YwX6QgBfp/s7qtKFsx7rQKEIk/tVz2OBSecuiaOvvedLY8IBGJu
	GfP1FLOvWwPsnHTNUNGgerRodQlfEM7q3WqF+INLDNq4ndcGhwcIG3Ys
X-Gm-Gg: Acq92OErxvt6qjhqSdc4l3P2Q+bSk57yF1bxfcLmu9GLAfsoj9poKokvSR1gUJoiH5E
	ayk/yARhfuM0x27/fBFGfiD7gwyEdDShD6jno8KK6jluK3n7BQfDvzHp+vX4nxlzOr8kh7Jmu5Y
	h1BlY/yc6GajA8WsWayST3hzJe2emgYd3NJl9FU75qJoWpC41INfXCFF8mhNJj4wVC/UqqSFgLk
	MmR3T7UZi16MP3g9edwJMio+p3iW/8JUO+A8BeAtxRx6b4buTOUNkyu9ozrbSm+Bp694v80nEUo
	ST3BMBd63GQsD+vvx0g53URRrNcqmdiVs5aWvf83G4/7LdhpbMVeOezrbizYuOzCLZJhank5vr2
	ooAfHzMraY8FVCwi2Oc8rPfg1Dy9jkoRChq4TbffrDvRo7tKDSrN52kzFEW3Ulp8L8olqg5n/39
	yGH+BwIRKIROLZzZZSCfPbdLdiKs3jQcOFW0nvBu0FWnbRrXGBODIzZuvYxi10oYzN/H5TlA9RJ
	vQ=
X-Received: by 2002:a05:600c:8907:b0:48a:65ad:1881 with SMTP id 5b1f17b1804b1-48e51f32a46mr315625815e9.13.1778504048662;
        Mon, 11 May 2026 05:54:08 -0700 (PDT)
Received: from [10.50.4.100] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0b08asm85326725e9.8.2026.05.11.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 05:54:08 -0700 (PDT)
Message-ID: <8074044d-291b-4ac4-acda-f27e94f3243b@grimberg.me>
Date: Mon, 11 May 2026 15:54:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org,
 mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
 <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
 <20260511080746.GC29677@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260511080746.GC29677@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_055410_888107_60E03A5E 
X-CRM114-Status: UNSURE (   7.91  )
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


> On Mon, May 11, 2026 at 01:10:34AM +0300, Sagi Grimberg wrote:
>> This should even go as a separate patch:
> You mean a stadalone fix?  Because it already is a separate patch.

Yes, this is a race condition fix that can go separately.

