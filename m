Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBB3C19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ZL6MuGSZ0fbyhZczXSChEhRBJbhpcc1DJVt1TcXOm8=; b=V/p/38p7bVws33+dgf4NjtUGsy
	fUcZlSaBasiCsDEcbM8vBNGwZUq8VxHFBK5OQysl3qjtjwyxsKa91ZJP9Qf0UF/89fSa8cwz2nCQd
	Bg36B4SdmedoRORUBKbFWuw0wYNvw94ffiFXvQk913XFzqvRmfX1vmsRWU6Ho+eIl3WIOoKyZWcUC
	/P9lYjKdF2v+th3z9ZbgFhTNVX8Xb73Z/AVmIc5EsZgGSFj24CJOpl78cMIPQ7kJqzmJp+20xAoRk
	wEMdWeTrzXKzSlWycxnmn7foTChj9YIVm5Pt/kSA5cLNujUzjh9dneFqU/wZg+Wmug1+hJ6UjMY9Y
	XRPKCgJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKZPv-006r3A-5g; Sun, 07 Aug 2022 06:05:39 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKZPr-006r20-65
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 06:05:37 +0000
Received: by mail-pg1-x532.google.com with SMTP id f11so5996717pgj.7
        for <linux-nvme@lists.infradead.org>; Sat, 06 Aug 2022 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=/ZL6MuGSZ0fbyhZczXSChEhRBJbhpcc1DJVt1TcXOm8=;
        b=Qr/O+7zZYUZbgQNfaz96veuhwlbUrTIpwKXmQUW3IG1kJq9vCIaj011+cYvdkOidqs
         bhda3jVAy449gvIZCnuxYRPzmyvFYhx9C6i/OTdUdSteDalkoaI3VPTA7Abr8drAvhU2
         o6RSEMRoueeK3S9WvmCIRCIk6F8wpxAOfTZAiyiasz808jCn7ps6XSPba489tGPc94ca
         WsU/dg+N7+/Q1df0rYeMFd5+h9SgOSKxdtQHuOfY6g1Obj2UTh6z8jw95UumZ8CFgkXO
         +f9PPD/eUcf43G0jV52bKdIGU5pCVoT2yL0l1ebGKChnPUUzNnZ3PTPaDBPKR6wfff7/
         w2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=/ZL6MuGSZ0fbyhZczXSChEhRBJbhpcc1DJVt1TcXOm8=;
        b=H3bWer7qV+3SNScNaL+bvXoiXC3XemlHYr02VW/gN9gOBgzptNaog4pwyZJRJ9Kw3/
         Jvv4bJS5UFUb7jG7W9NZNpKFJi+hvs6WUGvFFB/S5d4wOqC5lSKiLLh+p3Xc2MNtB6DG
         o+et6U2/J1bRNNol5lsNJR3/MBWUEDsH+s8lCbaVv6TSVJHhZu5KMEiHIjFItXbSrKLA
         zsgC4fOSzRufcIjBvcB0Bm2O6C5WEXumhuq86etFRKpZJZ+qG4c0/Xgb8q/EBVAXSakz
         S8hBrH2kvrfVCtqQ8UBqQ0uz7gYbKg2bMCOzHAGMrWNZgzr9+XytJx18st13XZ4taswU
         ++4g==
X-Gm-Message-State: ACgBeo0J7852DJPYPuIOao07hgWZQOSuuK9tr6n2kIsjA+nSoFE1QFaS
	LqaqbJ6FMpDTXXio6TU+DZgHz6K/5QM=
X-Google-Smtp-Source: AA6agR6Q3u5B8WNIU/tO6WbYtJH27XYXP9n5SLKIBmTeBi2uAKOZNYkppANEL7KErWG25fB9+QdUEw==
X-Received: by 2002:a05:6a00:2cb:b0:52d:64bc:9a2a with SMTP id b11-20020a056a0002cb00b0052d64bc9a2amr13556259pft.38.1659852333474;
        Sat, 06 Aug 2022 23:05:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0016c78f9f024sm6158583plg.104.2022.08.06.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 23:05:31 -0700 (PDT)
Date: Sat, 6 Aug 2022 23:05:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: hwmon: Add support for throttling temperature
 feature
Message-ID: <20220807060530.GA4018377@roeck-us.net>
References: <20220806054606.7280-1-ikegami.t@gmail.com>
 <20220806083113.GA3986075@roeck-us.net>
 <ae3a4377-440b-af9d-8033-cbfe2d76d135@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3a4377-440b-af9d-8033-cbfe2d76d135@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220806_230535_241195_56352A9E 
X-CRM114-Status: GOOD (  17.52  )
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

On Sat, Aug 06, 2022 at 08:58:49PM +0900, Tokunori Ikegami wrote:
> Note: Sorry let me resend the mail below as text format since it was not
> delivered to the mailing lists as contained HTML subpart.
> 
> Hi,
> 
> Thanks for your comments.
> 
> On 2022/08/06 17:31, Guenter Roeck wrote:
> > On Sat, Aug 06, 2022 at 02:46:06PM +0900, Tokunori Ikegami wrote:
> > > NVMe drives support host controlled thermal management feature as optional.
> > > The thermal management temperature are different from the temperature threshold.
> > > So add functionality to set the throttling temperature values.
> > > 
> > > Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> 
> I think actually the suggested attributes are not met with the throttling
> temperatures as below.
> 
>   temp[1-*]_emergency: Temperature emergency max value, for chips supporting
> more than two upper temperature limits.
>   temp[1-*]_lcrit: Temperature critical min value, typically lower than
> corresponding temp_min values.
> 
>   Thermal Management Temperature 1 (TMT1): This field specifies the
> temperature, in Kelvins, when the controller begins to transition to lower
> power active power states or performs vendor specific thermal management
> actions while minimizing the impact on performance (e.g., light throttling)
> in order to attempt to reduce the Composite Temperature.
>   Thermal Management Temperature 2 (TMT2): This field specifies the
> temperature, in Kelvins, when the controller begins to transition to lower
> power active power states or perform vendor specific thermal management
> actions regardless of the impact on performance (e.g., heavy throttling) in
> order to attempt to reduce the Composite Temperature.
> 
That happens a lot. That is neither a reason nor an argument to introducing
new attributes to match chip descriptions. If we would do that, we would end
up with lots and lots of different and unmanageable attributes.

Please note that the functionality is associated with thermal management,
so you might want to discuss your attributes with the thermal subsystem
maintainers.

Guenter

