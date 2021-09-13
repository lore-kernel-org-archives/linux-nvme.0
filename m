Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD192C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D01E60D42
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D01E60D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9RWCxeTh74N3CCYYf2/+kJJUdMxeXt90QevdIiAPhsA=; b=zBsQuzIgN/Dgo1EqQteZ8z9N/R
	H3zm+UlTFsFACBi7HQt4UhSENdahIGISr8JAVmXUCRpzRDGZl6nCnoQ1CZeE4874b6GcXDAPEkyUh
	g5csyhAoNUxhShboDkL5pIV+tsctEO/TKskfhbIk/3H5tr3HqUKin869g6iba0hvrjTnmRr2pe295
	eW53vssQkpqhM+RbK0okI+N+k2sCf95ybYRZyVIN0sc42lSglQ5Mj3AfgWbc2MAaZZQNrOey6UBex
	nj2DfmuXhxoxgJSNwzUv0cffUg+5aFz5aygS9BxfnKWnj5rAJ/9PKLUh8kF4Qbmwdo81z8PRGPc96
	/fMCCfGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPiEG-0013MH-Lf; Mon, 13 Sep 2021 09:26:20 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPi3n-00109y-GD
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 09:15:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id i3so6095488wmq.3
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHpLWJ8H/fkNgfU88lj/JLsBmLoWewM3ZWg4XfFKR80=;
 b=n0ANkoXnJsWm+vaLdomLY6aTa6VcdZz6DVhyXIBM0eL/63W363scTNIWnVqPzVKEZ7
 XWvax6yhbFDxZBFkMbp7mcIQrTGc3luDDLY6Brum/zOEH2LyIuXgkqSkRJ5nsXtW9VbR
 4dUgk3cT8seL9n5hClIGKWVeE8bDlPmBeNIURz2EeOMZxFHF35CgDmDBp4R2RwRh9Y3k
 kQypI+kr4ecGapj7WRIPP+cUQGP3Dom0j27P73jfNaBCI+7tGHNrMEVkp5MYzZQZURte
 bvl5gOXBlKbD2HvKtS8P/pzlTRsT6gBSLvzFz66P8Fn2F2L28wbA6rq8XPQJth9Qlk3H
 +IUg==
X-Gm-Message-State: AOAM5308/gVpO7tTUONcWXv3ESNQXdq0b/RGCNRL6UyIIGjOulEWVqkc
 B6zr9en3T027+LS0m4oo2xaabUB+0T0=
X-Google-Smtp-Source: ABdhPJyL8mbCOOFoXtG599svx2RAQGcSw6iBQZNtz+iBNBgp2MYXb9Lg0mXtWOS3+wO1bU7zo9sSlg==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr10379544wmg.132.1631524527053; 
 Mon, 13 Sep 2021 02:15:27 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k22sm7138707wrd.59.2021.09.13.02.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 02:15:26 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Samuel Jones <sjones@kalrayinc.com>
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
 <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
 <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
 <7e313963-b377-74ef-2fb2-650e15cde2e6@grimberg.me>
 <1387247003.6552417.1631519054752.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cec5db7f-a785-e219-b502-5aa4ed1be880@grimberg.me>
Date: Mon, 13 Sep 2021 12:15:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1387247003.6552417.1631519054752.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_021532_128669_BABC1A69 
X-CRM114-Status: GOOD (  11.79  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Keith, can you send a proper patch with a Fixes: tag and a descriptive
>>>> title so this can go to stable.
>>>>
>>>> And let's wait for Sam to do some more extensive testing. Ideally we can
>>>> also hear from the WD folks that this doesn't cause any regressions.
>>>
>>> OK, I'll do some more testing over the weekend and let you know next week.
>>
>> Thanks.
> 
> Hey,
> 
> No further issues on my side with this patch.

Thanks Sam,

Keith, any updates from the WD team?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
