Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA85C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441E20692
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/cV9W2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441E20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vmD68XirUNv4iptbPgLbfFcf5vxr5ymJKHEJyDkfY3I=; b=R/cV9W2V13Bmh2IzVUs59rZWw
	fiFytimL3/i69g4JsSydD5zqiNUo/DASC14ygZ7FO+XLE8qQjJ2paK/qso3JqdMwd5ytyOI9G16rM
	1Vn2Y/7NbXs4wyiF96W2f8BUISwT+QxXKkXec4uyR9ojwug0hQpYO8+6T1mCGiDFWRGaKRtuWQsdM
	A6/l2WYL59FZnRIg1a2aKgccbHltm6ofoS5KZdnD0Kg1PjNed9GdVZjOb40jhQcgIhW9mjzSyPa0/
	shJegPIHPiN8OFlRHQTHU8dqD1xMJE1ULaQMEkU0BF/UjUqGV+PLfGSpkDNaWg4Mv6174qKzrHUOX
	aS4+257+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5y1i-0003FN-AK; Thu, 05 Sep 2019 20:06:42 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5y1f-0003Ez-TO
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:06:41 +0000
Received: by mail-wm1-f48.google.com with SMTP id n10so4531040wmj.0
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 13:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wEjkXdffDqQRSiIAfvcrB3bgYa6SV/zYgW/165yf+Og=;
 b=ejWK6Tbwz0yG8sZ/wb4a/ivc9RcsZXq/p3bJ0m7OJfZaq8KoTEuKbzHnKe98pClwwo
 UKF5lK1qP+TisWnuSHfdP6XvOSH8I2Zh1ziTqG8XmJWBOxvfKwNAAoqDgQ92kkQVANoa
 ZWd16tsemMMwNWuaBzZFdvZ6ujodM/RV7cELQh1jX24/PIL0hEuRwg6xI5FpAGfqV6xU
 vkBIr0iohgeZ2gLH+Rd7HTfhQusC4x3HVUouPzqMVub9LPrPa2XmSji97y7Xv2wDE/fV
 3QqDX4nS/ZIHSexN7Txt9h+ksgX0vAGSre4OWm2ch1Jli0jH79QeT3Yn078fWp8mYzqc
 rNOg==
X-Gm-Message-State: APjAAAUC6vE/hKlstYxf+Y3rb54WQJQAbOCTKb1I+nuOG0NMizqhEFrS
 tdvdJSEW/95zcOiRmegMtxY=
X-Google-Smtp-Source: APXvYqyjZjSYUb6UXah5w5rBYvYJgNU7RgWpdYo69+d+RrjqGik5ANx69A8dKEDKbBjtLL4EQNglOg==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr4221909wmc.83.1567713998403; 
 Thu, 05 Sep 2019 13:06:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t7sm3541453wrr.37.2019.09.05.13.06.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 13:06:37 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] nvme: add uevent variables for controller devices
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-4-sagi@grimberg.me>
 <b0e3f456-4071-abb8-5af9-26354c1a5356@broadcom.com>
 <1c073c6f-468f-a3d5-8990-99774779011f@grimberg.me>
 <9edbf220-d9b1-0431-d22f-9909ebde187a@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e6e500ee-5237-2f9a-f26b-fa2bb67b1128@grimberg.me>
Date: Thu, 5 Sep 2019 13:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9edbf220-d9b1-0431-d22f-9909ebde187a@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_130639_942528_83C1492B 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Overall, it looked good to me.
> 
> Reviewed-by: James Smart <james.smart@broadcom.com>

Thanks,

Christoph, any feedback?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
