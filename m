Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9DC4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 10:15:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AD120797
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 10:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0Xc5YFP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zk/3RsKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AD120797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cItPlwszH8lQp7kdNK4kwcR5uApmH973eXtv+TjqRzw=; b=s0Xc5YFPOv1vGtqCxXSk3L4x2
	q0tyJtb3PFzfUBVZlsADKqLi22UR4JYoHMpEkB0zy1m+IiBMs4m0yauzc1FjVaEOalFi1v9PF1Av6
	57Hk/GuWa9h6i6l9xAyNTWwtANud/H4cGTtopWQZhHgyBeSl/ZBIJui13p60YArbZVjj2U6pjkhSw
	Jq0wx5P2ioh7U21cBg0J0yhSKRoRO2RiiJvPAjwb17WyuRCJyJ77WLgoFvZDc4nP/IFqLRQsovcln
	IdFgSnI3IuiotzPP5bRQA10VE7sF8DSo1Gwcj/W/pCnUSt1+iAaZf5+g/Ioa/w302B5oJTgTYIPiY
	5wS9YByaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcQgW-0002RE-P2; Tue, 10 Nov 2020 10:15:32 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcQgU-0002Qf-Vv
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 10:15:31 +0000
Received: by mail-ed1-x52d.google.com with SMTP id e18so12072747edy.6
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 02:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OJOkjF/XcHi2FZlRaU793W8VWHWoTtmd6m46I1hFRlc=;
 b=zk/3RsKuZjCVv0t1nteStYNB/HcBCqzymtN+1ok7gMlowAmPS26fuStaSNdQEgUmv3
 q8T63tFzJ/Ps6TboGv1AiLo27qQOkS1ZvFlurM6xvf34eyGLDFtJ3/vmF3/EvTlE9N4j
 8WVXhSDN04rqjuTHgnF50l2V+IW4xDnBV0HD/DubZsUQX5jWDAfQQeD4J0EXDQqAQuxn
 gY9dOvRkSgaSkce30FGzJRZ55/iCTT4xOWw40EFFSF0ALR1auedfox0GIfukyAh7SgbU
 wqEpfAlpYhvrtPcJo0Rg6jYs6SmzuixrJJA4sGIikoYszEyH73bmeSQTuD41tWdLtI0A
 9zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OJOkjF/XcHi2FZlRaU793W8VWHWoTtmd6m46I1hFRlc=;
 b=YsWr33LTn0rXD3Nwd37bOUjxMhtfnu945NOBZzCr8hYgLWTEfFR1AzmBo69LH4GiHd
 p3GP11x8viKNdhossi4kdXlZ/afybZe7luba5WbT63eiuyd4u5Prn2FbXoVm+3ynXdFO
 4xeG9f9e6td7QCExRx1MGxWJEFlPmELJHgbGjjPSuqJVxYGT+69xQ3U4/kc2PUj1sQmd
 Fprvr6oWU0plbQKmawbwH7YoQRxoobSdEDdxE750i+AW89CpbxBdqZwFefJQdnM4t0f8
 o4e6OKSRURYohaAfZe+GwQUCFEvoTqikqxCIArFcSHUET4CFCMNCrl4w+TdsesR5YvnO
 4mfA==
X-Gm-Message-State: AOAM532cjHGQe9C30gj9lk1+bw4C5+CBAmFIWb8ltgcsInjZ2Pl7P061
 IsIAuoquJh90Vy9VyvlGgoVClA==
X-Google-Smtp-Source: ABdhPJxHLEHhFYa0zWNPnJ6aQ/Hiio+ArZqt+ltC1Wco3+Uc76zuq02PmeMSUSDs+WwuHG7QpdRDMg==
X-Received: by 2002:a05:6402:559:: with SMTP id
 i25mr20784439edx.128.1605003329529; 
 Tue, 10 Nov 2020 02:15:29 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id c5sm10054069edw.67.2020.11.10.02.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 02:15:28 -0800 (PST)
Date: Tue, 10 Nov 2020 11:15:27 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110101527.6bvanzvux4qtnjk4@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110094354.GB25672@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110094354.GB25672@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_051531_075829_BE9CBD0B 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10.11.2020 10:43, Christoph Hellwig wrote:
>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>> +	if (id->nsattr & NVME_NS_ATTR_RO ||
>> +			test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>  		set_disk_ro(disk, true);
>>  	else
>>  		set_disk_ro(disk, false);
>
>This has a very minor conflict with the patch from Sagi to remove the
>else side of the clause.  I'll merge your patch and will fix unless
>someone else objects to the approach.

Sounds good.
>
>Note that as discussed we really need a hard read-only settings
>instead of set_disk_ro for both NVME_NS_ATTR_RO and the zns with missing
>features case, but I'll look into that once I've got a few other things
>off my plate.

Thanks! Please, let me know if there is anything we can help with. I'm
looking into the char device now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
