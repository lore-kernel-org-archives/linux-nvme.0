Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F6C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:23:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DB2207F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MspTjJZD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qBBef4Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DB2207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eR1DsQZD49w/2IQYgPHkaQIVLuJYyeCEldtsEPa7p4k=; b=MspTjJZDFzqhUGv5/WQeW963g
	Jkjzs/cVsIO1hQ9pM7aVs2DbDItInbekFL4MurrxFNcTbKbJ/OMgjkC4SMX2son19qY+Um14j0tjr
	oNu8+0s7DkAqOOJutrB/G+6IDvXtZjADNmdTvVhZDJ15ECJ6r4AD7bLga6mRiD3tlbIsowYWXAMwH
	iKzxnFl2wx+lqKt2fTkHSuMen8pBv0+KzBt74ZRF4hc1pNks8fbeZA0aivlm6J7UJsze7595LGGop
	DTWNEU6WR5VqMDIIMFLnr8vCNwsjY4aJW5KPqVq4RjqNOjG4JSNUFyb3Q6BZlexXVLSFpZ6/zFU5M
	cjpC1AZLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0pnH-0007fC-1Z; Wed, 29 Jul 2020 17:23:07 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pnF-0007eJ-MU
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 17:23:06 +0000
Received: by mail-il1-x12b.google.com with SMTP id c16so8285900ils.8
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r5j5Y8oTddaFgghXor3+5c5b1GvGHTVAH7g8aQIrlqQ=;
 b=qBBef4SpKxzPViluEeCB6LB2Q++UHIqFNLYulCEVR4sdJEvYnoiDPHUzyN/UAWwPmn
 73tgnHl9SulwuFuR/lBtP479UCSlgz0mYoCuhayDNqzBDgmYGuGlZFVcYrbOYG1niDZe
 mDHslJ2NYX7/CvL+Oq7qrFmZhGt+KiR3IyTlhe9jntwd76o2XFOJOQ+ZO6X15h0XlwyD
 /wllqifxvpDutVP3XQ1uEquuahMkkUpgYKXKmcQjNAF/FeBWXvA0jCubOA4mT/Dexall
 4uYBIQS8WaEI0Bh0F5L8XvQvLRDbaFJpZ8PfKWCb9ECDRCirZk36h2zPVk0TGJQW4dMb
 yIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r5j5Y8oTddaFgghXor3+5c5b1GvGHTVAH7g8aQIrlqQ=;
 b=OGSn3DDglMbh8pRU8rL3zPRwa4e66o4lNdkFnOZUurqW/Hg4rayc0PEML3xGuMlXRT
 dD4iDnvx0yFc6F7TGN8iLH4GeH5JC8jylAF115FbWRjH47bpzHO2CvkveDWJLkhNyIMh
 WAaMXF1CNwe4s5eQi546SFFL/ht34W20p//A5syiZbcHWCIzLe28rnt8WBl5vQT6re6E
 u+zKCQVPj2rLH8YY4XSIUUbODtU4Htx6JGc+EjW2mfwmVLuzdW2Aap69KYYmRKzQmggq
 KDQ3m77TIrF/NcdFUlj6V5gljCQuakcfhTjhH/m2Uvd1oU9p3cghJyIsrZvafEexS0JV
 5pIw==
X-Gm-Message-State: AOAM532Lomr77dli6qcIFSazoy8S884zvDzIuexGh0wF5d8ScmSPhttl
 Rfp0FXhY+RqRqiV0qJxtkAG9D1QpnnY=
X-Google-Smtp-Source: ABdhPJwRgDt8tMkAQyMeDj8Fv5J3WZJQ8JLGe7izO8gvYu3Jx6aPHLYZQO0/9M3q1rFnPnW6VhFHIQ==
X-Received: by 2002:a92:a04e:: with SMTP id b14mr36056630ilm.261.1596043383642; 
 Wed, 29 Jul 2020 10:23:03 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s10sm1485481ilh.4.2020.07.29.10.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 10:23:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.9
To: Christoph Hellwig <hch@infradead.org>
References: <20200729171125.GA21194@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d50ca734-3f52-6399-b62d-7a401a53e320@kernel.dk>
Date: Wed, 29 Jul 2020 11:23:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729171125.GA21194@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_132305_762240_7F05ADDF 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/29/20 11:11 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git nvme-5.9

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
