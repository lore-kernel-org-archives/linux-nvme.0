Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F640C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:25:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DE82100A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QHxr6/0g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fr0xb02J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE82100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ie1HeLw2vVVGLPrhnyia7smbXpoiQoWAi3CmF4sdBeE=; b=QHxr6/0g+BeeduCz2Kovqoh07
	ehCFJuTjAUjt6q2gyoTqU3XCyxzDxtz8hdW2osxnBYx1OnE7L6qlKDZSAXU5BW2/49JUb9XffzBXx
	lzUe7g4U9FLy59jo+INjNBtk3QQ7SY97azyiCFZeUFySs+IngTvPQ0ZBEJGC5Vz4wF91e+fFZzJBH
	uJWm1W6Sv1cGNNeAaVT86kU136qWoRcIVRBivrdfsr3a9KbpMk5VQRJIllWb9BOsFe1kLefw1/u8S
	59FQdbU2EAr3Pw6YMZQQfMfEajweT4AQsV8jTQCKdh+oyam5/sLT+Ls9WW//SH0yaYc/bqQAGd/fZ
	KwaTPzsFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLi0-0006Xh-5Y; Fri, 19 Jun 2020 18:25:48 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLhx-0006XJ-1A
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:25:46 +0000
Received: by mail-wm1-x342.google.com with SMTP id f185so9953548wmf.3
 for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2020 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=V51fa+JnxcBTxEQyN+hbyfp/TDZpfijc/JikllL3zuA=;
 b=fr0xb02JTxNqgcy7gLvuFHwJ5HbOjTSbskCgotnroFgAZ++YVS74HA5gl3vQdHtzxZ
 Cf8vruM3RitqaJHomEJoHV2TW2dpevtnYFITcIgRC70M9xACuQdordLUl6B2gxGIUFkQ
 Tiun0fIECyhTR+bjmpK4KCK+cof/hcdO24DW3h2OqHQJYZ2eSlg95bMMZp8zdBH0+HNY
 rYjRmCsOUIeVmtCzpFZhtUsJ5cJbIeSXZuGCLyybmlE675cCIxKxe+jwCLQpcczCnwEM
 ruIyddu6BWri9YVFEa+ODf7Zh0giW1Rpt9qZjcwQuoGA1qTXvSqetkQlksqcbhaWwldE
 9E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=V51fa+JnxcBTxEQyN+hbyfp/TDZpfijc/JikllL3zuA=;
 b=BmTjMD5ZS6vk9ozsatAy5CakyNgcoU13sBr34BvAIiOGFqXXrgNj+cddnm0PtBiYDE
 zvMVhIU+6fKWmiz9wOX2O+fCHVk1DqXrAZs2RzymK2e/B5Y/3kEXV4cWDHuSE6kFF/Wa
 ZhR4ALRR0levrgYDkhDHTWqiloOKu4CmDx6d+Xzm6OuTtQJGWmOMtFMgjeU7ZnO5VyTJ
 X/4mlW9otaNiNEy6aP9Oz5+zCeroSAyantao1iObCE9nk6gr7DQNmumtDEJQQn1Rks71
 3Aj51F5QXBvED1zF7k6ajGQPBwf/VerCkWfOhzSY5S5oYfAJTRxDcJhXEA1bOHlex1eY
 jpwQ==
X-Gm-Message-State: AOAM531kYlsLp5+Trr7cPHJFoNjc2O4GEKgUgV0+Q36GZNsAZdZ3Sl+G
 CXIZPsagD2XlwGVGZgCzCIANKA==
X-Google-Smtp-Source: ABdhPJz36QKLxdCCqVrkY2TQQ2V6wXtUPnO2kQPIUoA09WguDWNX0Exc+Fm/5JnHpWq7O9v1EIo9Fg==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr5271639wmh.175.1592591143836; 
 Fri, 19 Jun 2020 11:25:43 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id o15sm7588292wmm.31.2020.06.19.11.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 11:25:43 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Heiner Litz <hlitz@ucsc.edu>, Keith Busch <kbusch@kernel.org>
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
Date: Fri, 19 Jun 2020 20:25:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_112545_073073_ECCA0FD3 
X-CRM114-Status: GOOD (  16.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Judy Brock <judy.brock@samsung.com>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19/06/2020 20.17, Heiner Litz wrote:
>> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
>>> Hi Matias,
>>> no, I am rather saying that the Linux kernel has a deficit or at least
>>> is not a good fit for ZNS because it cannot enforce in-order delivery.
>> FYI, the nvme protocol can't even enforce in-order delivery, so calling
>> out linux for this is a moot point.
> How does it work in SPDK then? I had understood that SPDK supported
> QD>1 for ZNS devices.
It doesn't. Out of order delivery is not guaranteed in NVMe.
> I am not saying that Linux is the only problem. The fact remains that
> out of order delivery is not a good fit for an interface that requires
> sequential writes.

That why zone append was introduced in ZNS. It removes this constraint, 
and makes it such that any process (or host) can write to a specific 
zone. It's neat! That is why the command was introduced.

It is not only Linux specific - it applies to everyone that wants to use 
it. It is solving a fundamental distributed system problem, as it 
removes the need for fine-grained coordinating between process or host. 
It allows the SSD to coordinate data placement, which historically has 
been done by the host. It is awesome!

>
>>> The requirement of sequential writes basically imposes this
>>> requirement. Append essentially a Linux specific fix on the ZNS level
>>> and that enforcing ordering would be a cleaner way to enable QD>1.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
