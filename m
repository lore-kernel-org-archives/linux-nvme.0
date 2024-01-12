Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAA1C4706C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 03:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDiATViGYPJHZv3qTCOphZ9Lj2x7128zuJp/8zdZPZw=; b=QPR5HC0pMHcOgNi0NR8Zkygbj4
	qU6SeAa/KSDMyDd2q7sKv2BWM0afYeJrt/6t6aL0Ds1HXs79Zk+NJEYl4HL/N/6oKjP6+r2g18OFs
	j7MuKGEKRXmG4CxJ1t3CT2FPyRowvbWNcUn9zJ1pnYgpL97hMz6cJwRRf/q7Purp8TFlzZSTKKrN6
	URgxJCWI+T1hURCObXxsODnZ9YwwdQ7yZuvYi+zAV6pvFsYcNFixS7+eFweImpjs6EG/8B1GBuOGU
	WWxW1MQXpCIDtMPsRJZTkNypkQHVbLtvoB55H1OBQMfJhffCWvca9wopL2Jmn9gtyveeVbFljGSMD
	xzROVIyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO8VK-001nAR-22;
	Fri, 12 Jan 2024 03:46:46 +0000
Received: from mail-il1-f172.google.com ([209.85.166.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rO8VI-001n9u-16
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 03:46:45 +0000
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3606f507efeso29204525ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Jan 2024 19:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705031199; x=1705635999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDiATViGYPJHZv3qTCOphZ9Lj2x7128zuJp/8zdZPZw=;
        b=tu63NR5nCojiCzz4TF3v7qT5l8SWaUyjcb0oSqZXfi8y3VhNANpJifpqKNHuSZyuDc
         MQrPmpAMizqyRDukB5VOAxnu3BuBnIAmjYOPYLGegDSc2qFSuZFLmjRzx4NoTSKbMCqa
         8l/ZwEJ7xHN/wV9gZv37YdpjxtgvwoR+76RSExGMrM+E+gDe3FI7sI62Gsqyus+VIMbK
         eHPfStQWVoXTZ2QA+5T2aoW6oqj4+HdXgKVpftPI5KjfJb4hdK4tgz5DVNgkvfAgHnm+
         XCsrOzcalOGNhDlSvIWs8J1HttgtUW0Xtaz7FaK6b1Z+H/cm+W2DGM18kGgL/uFIeRhn
         BnNg==
X-Gm-Message-State: AOJu0YyJj6tq6X5EGTIc7BAtdC1TYygnSON2sspME3ANSUSyGSn2DaMW
	cVXXKe46Hne/KiK0COGevXY=
X-Google-Smtp-Source: AGHT+IHq8tQC7rJ5B9DiB0fTiCcYZmZPgo5KeNAhU4wNZcyAqXEhds1hklyUDsSPgmwKRYy36A5H1Q==
X-Received: by 2002:a05:6e02:491:b0:35f:af09:23d1 with SMTP id b17-20020a056e02049100b0035faf0923d1mr414504ils.28.1705031198810;
        Thu, 11 Jan 2024 19:46:38 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id i136-20020a636d8e000000b005cebb10e28fsm2059768pgc.69.2024.01.11.19.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:46:38 -0800 (PST)
Message-ID: <5eed1649-135d-445c-b725-c6ae2d76b699@acm.org>
Date: Thu, 11 Jan 2024 19:46:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
References: <ZaCSOH7L+Nm6PvcN@fedora>
 <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org> <ZaCyC5RIAcbkBYeL@fedora>
 <6fe89190-a8ff-47c3-a6c4-7d69296c9883@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6fe89190-a8ff-47c3-a6c4-7d69296c9883@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_194644_421178_F01C6749 
X-CRM114-Status: GOOD (  10.88  )
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

On 1/11/24 19:34, Damien Le Moal wrote:
> On 1/12/24 12:29, Ming Lei wrote:
>> Just saw Bart's work on supporting non-power_of_2 zone len:
>>
>> https://lore.kernel.org/linux-block/dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org/

Hmm ... weren't these patches developed by Pankaj Raghav from Samsung?

>> IMO FS support might be another topic, cause FS isn't the only user,
>> also without block layer support, the device isn't usable, not mention FS.
> 
> And if the FS requires a power of 2 zone size, that will create fragmentation of
> the zoned device support: some devices will be usable with an FS, others not.
> Not nice at all. That is *not* something that exists today, for any block
> device. I am not very keen on going down such route.

F2FS supports zone sizes that are not a power of two. Recent Android
kernels have support for zone sizes that are not a power of two in the
block layer since UFS vendors requested support for this. We prefer to
have support in the upstream kernel for zone sizes that are not a power
of two because having to carry out-of-tree patches is painful.

Thanks,

Bart.


