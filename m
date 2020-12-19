Return-Path: <SRS0=BlPy=FX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34ABC2D0E4
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 01:04:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD0C23BA7
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 01:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD0C23BA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JV5A14KkNvUkcRY2o7/kxoIfxIAP5JonXwRwbbdH3Hk=; b=q4hRaiSv8Oxwf2/6dF4oBeVou
	4M8XYCYjdYc8arQGJmzHT7FO2hhxuoXdBkvgXsQdeMP+823k0PPyl6zQK+CNXx7C1cCkBI1RIz98G
	6GTPqCvzoN+p9X1XF+LuHSLR1kMkywAqf8LMxaXkznxlXRAS6q+4YqLyxsNedZL5+O0zzIF+BG7Te
	awWMrI3em965hB1lwVTkg2AMnawGRy8vxmfG6Toa7DMg1qD7/pm5yZgxBm5Sp8UXchhA+VspH8/bH
	E3zQGPovSt+iFsGNa4ypvZivVD1IFLsL2LDYdZBE3WD8IkVYn6e8XVEYcoXD7JnGl4EsgAPdPmY5U
	7cZQUW1Jg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kqQfU-0005vw-KM; Sat, 19 Dec 2020 01:04:20 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqQfR-0005vW-H6
 for linux-nvme@lists.infradead.org; Sat, 19 Dec 2020 01:04:18 +0000
Received: by mail-pl1-f181.google.com with SMTP id j1so2318734pld.3
 for <linux-nvme@lists.infradead.org>; Fri, 18 Dec 2020 17:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lHX2UXM6413Wf4iTuhtPAfpR9dCw8ZxcnlcIfmSPsW4=;
 b=qYFxfcZH9LmIKM2iCYaV4S91x5IWkwQuinA5gSZeCEp/OyR3+lprIILBKRyyhuSuAY
 v9Nu5moTKEGmWmiSV/dHGcDT7BZbSkEZ4ppnUMmTCLrZpJOI58Pgp1IfI5Xq4Y9Fzk/T
 toqvlo+XI8B/AcNie5XiiJVVo7hZ+ZKRVDCOE3d+pB473xVsCW9A7lbMAQxp9U92Mc+Z
 wFZagawOeOP3DsLIcE0ZDNJdD31q4RjkLB347j/SKbiDGTnjCmBHeVuZSp++XygU9KK3
 pEAWtEpOHaUTN6jtntS3Wb26Hq7jD6F9w5zbFjnUpFI4rWYIWNxx4ToRRJi/f07D/kUa
 z/Dw==
X-Gm-Message-State: AOAM533yB795OA4Zo0ohLntTqwqLYVC2r6YlETunKUkrR2mpgrERtN9R
 Vljl4/Wx3x5Xe4iaZ/nQAgvRmpv9gf0=
X-Google-Smtp-Source: ABdhPJwDrunVS1tQLc8VZtPwSMMlbP226iC8GPofMsQr3tlRVdGQZAHoHO9EfgibuLWvUpePcROEOw==
X-Received: by 2002:a17:90a:73c5:: with SMTP id
 n5mr6766731pjk.118.1608339853881; 
 Fri, 18 Dec 2020 17:04:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:ad66:235c:5bd3:e462?
 ([2601:647:4802:9070:ad66:235c:5bd3:e462])
 by smtp.gmail.com with ESMTPSA id m13sm9360589pff.21.2020.12.18.17.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Dec 2020 17:04:12 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
 <BYAPR11MB2869100E0BA40ACB0CDDEFB0E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f6162f73-ad03-c266-0289-4b8eb1c9f330@grimberg.me>
Date: Fri, 18 Dec 2020 17:04:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2869100E0BA40ACB0CDDEFB0E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201218_200417_602351_690E8445 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Wouldn't the addition of the change to io_work() itself result in step (4) above never occurring?  Pending always being set if mutex can not be acquired, and if io_work() then exceeds time period it always re-queues itself.  So io_work() should always end up draining any send list eventually.  Unless io_work() exits early for some reason via the try_recv (ret < 0) return point without requeuing.

nvme_tcp_try_recv returns what it consumed, so it can return 0 if it did 
not have anything to recv in the socket, hence it may not reschedule itself.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
