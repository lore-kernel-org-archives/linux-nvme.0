Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A3C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 00:24:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BCD22253
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 00:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oTtCJX2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BCD22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=//6aZRU9McCbDRf2zfUOYNAV4Vu434+8owWZS04+Jes=; b=oTtCJX2QIgCQwRKs9vhQ5b7Gj
	RE9QZblQ1TpvcguhXTi6ZRPv0BiGyLKaSEjr5bt2v8ytr60VdLwZoKZ6Fp7mCmfB5o7dzhe09Ou8U
	wcd1VLCTG6SfVr2hZqTwdYkWQ5XRePYhiyQzu2DOTHFyXcuC4sAhIbPdnT2XhGtIzBRCegaqTBFOF
	CCrd/cwmE9eDnICf5W+yAhqoaiMuD5uR2r26FQcBI5vpelbehk4YQ5SkBEAh/er/ah4BjJpDK/UHs
	bIB/00of6YgUDzvfd0aXkJx9qIdCiThzEh4+nCq5FkUzxe5KJpxt4x5lYTC3t/w7nSkWTAjljDzAh
	cCeCQ5Vbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQgCq-0000wd-5Q; Fri, 09 Oct 2020 00:24:20 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQgCo-0000wI-2l
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 00:24:18 +0000
Received: by mail-wr1-f54.google.com with SMTP id z1so8431208wrt.3
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 17:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xPInIBYZbFdAzYH+dLFaITFzWxQiCDyBd9Oo4i6epPk=;
 b=eucqwA2dPWyHiATJkuz5mxV9Ro6CFv7IMhpybE0jwGjWaXA51rWPgmNX/bvWMZQFYX
 /NIhYqpv3MlOA8RnKOlB7ryfwX7EyFD8nyE2+DM1aNo8TWd/NYW4iH+RMThMjDnaF2TP
 0mPLEjOq/TBReXldzgFdhBxUoGmV8drWXevmqQ+zpusS1RyTAEmVVgcIsIJQS5WNePSV
 m0QQ4IA9KwYG3fBWJa41tYTsJEJfGoQXEoGE4++OzvR4tC6QMkwKomlYr0PIeXxUiy/V
 IzfraCajDbnKUDKsHeNk7CZl2hew5a0feYKv9MxB5vtM7kNcW/Yi+PgpLpDSF02CoVw7
 zrgQ==
X-Gm-Message-State: AOAM532Udtt7fOvmrDft9VmXl2vX/UQrgWF0KbHHnv8aZxFvDANHkUbm
 r3+R0GhmooE0jEmqbmBbCJvdDutH80Y=
X-Google-Smtp-Source: ABdhPJysJRnUGuVrMLMJ++LSKcmRaFqYH9CrWqDxdxtOqPNRA7oVQDwt3E6iwvQ3Xfo9d9E+5F33EA==
X-Received: by 2002:adf:818b:: with SMTP id 11mr11667596wra.74.1602203056390; 
 Thu, 08 Oct 2020 17:24:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id u81sm8737456wmg.43.2020.10.08.17.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 17:24:15 -0700 (PDT)
Subject: Re: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Mark Ruijter <mruijter@primelogic.nl>
References: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
 <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f4445536-ed3b-203c-95ee-bac737e5574c@grimberg.me>
Date: Thu, 8 Oct 2020 17:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_202418_125085_8092A98D 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Unless I am mistaken the NVMe-oF target driver does currently not support to export a device read-only from the target system.
>> For exporting readonly snapshot devices I am currently using the attached patch.
> 
> It does, have you tried using nvme cli with NVME_NS_WRITE_PROTECT feature ?
> 
> we have both host and core patched for read-only mode, if you find any bug
> 
> please let me know.

Chaitnaya,

btw, I just noticed that 1293477f4f32 ("nvme: set gendisk read only 
based on nsattr") breaks BLKROSET ioctls.

If I now do:
blockdev --setro /dev/nvme0n1
and then I will write to it, it will override the disk ro as
invalidate kicks in when the write fails.

I think we need to start by reverting this patch, and then
add it back in a way that doesn't break BLKROSET...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
