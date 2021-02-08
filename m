Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38CC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:16:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429F360232
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429F360232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x3tqDjT9fqb3jnVIBefN5u5GKX05WLlNgQbl7c6jWW8=; b=cCJ/jlN1Vu0AdEMhwgNJrimvA
	GsZoMRUlJub3FR4noo+fzc7YAsHsGNYVVgh0RGtGdH3pCNC4T9SMoJowsHJ+fkrcprJ+lum66Rylg
	kK2hU7Ygl2BRv2XP41QL/j5VG4Af9oQKMVNSjE9FQ7vNBD2YKXJUME9J/fu5GRaMJOn8Lh38RV+3Q
	57pWW+5k92QI09fQDtvV/J6cCzL1HrnoiStVLPsWrKswkDEdHZhN900EQrTFz1+PlVFTg28JBjmPd
	g8dNC/Wg1YYkfZecShjLCsLlT3av+DcKS3dW2Ayyy31fcYm33zlt5oyOk37gBtVMyVnRrKsfkLmPn
	a5TCPiJHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9B5g-0004cm-Kq; Mon, 08 Feb 2021 18:16:52 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9B5f-0004cJ-A1
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 18:16:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id 190so48459wmz.0
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 10:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SzIy7yjt9xMSg+znZrUjNaGrdCFHsXh9XA8ACGJMw34=;
 b=lJLb9VXJuPvv2eQ1EDZai9FC/yR1TUBp0ncjg5yGFEE7Me/Tqvzc9hW3JU96z4FNOn
 C8XeXCcSLU0Qy+4LCCC6F8OA1gy/J+x8WCmL9u3cCgrqAkHB/H/eFoaaKsNIuaPFvvlR
 SW3b9PA3fVX7y/k8cHpEAjYu4cMRoKPBLKwxmefaw+BXmnEzAz82wqbz/dZEbWtXhnre
 +znwx3sxhnr0jyIkfgXc5Ack7ozky0p8aDX+JarzCvnLnYW/bkA/QX51UWACk8dv0S+d
 3IOo9NoToV7qTxOjlIURT2JsyrpulEk6/D3oZQvvI/GPtw/PWdeEnn1ivrLqUbtsS7Sx
 ZDIQ==
X-Gm-Message-State: AOAM533zoWbBA9UDDX715/FWVwhfItdrfC80gmptrIeiygBh2a0Q+QWE
 EVqYPWhlD9BSQ/t95oS5jgea5Ernq8M=
X-Google-Smtp-Source: ABdhPJzKzNLn2bcdhXWHQcrrWR1HT11lGw5O5wl061XMyZEIYhVmnUwvnYY1nvpd81zaZbci9R7EPg==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr68173wmq.18.1612808209609; 
 Mon, 08 Feb 2021 10:16:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id v5sm10359094wro.71.2021.02.08.10.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 10:16:49 -0800 (PST)
Subject: Re: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4608296a-6c45-a252-8b49-88cf25cd7365@grimberg.me>
Date: Mon, 8 Feb 2021 10:16:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_131651_387007_0A476034 
X-CRM114-Status: GOOD (  15.43  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I'm using "nvme discover" to retrieve discovery log pages. And I'm using nvmet-tcp as the target.
> 
>  From what I understand, "nvme discover" is supposed to set up a connection to a "Discovery Controller (DC)". During the exchange between the Host and the Target, there is a time when the Host must set CC.EN=1 to "enable" the DC. I'm using Wireshark to analyse the packets sent by the Host to the DC. I can see that when it's time to set CC.EN=1, the Host also sets two additional parameters: IOCQES=4 and IOSQES=6.
> 
> In the NVME Base Specification, Figure 78 - Controller Configuration, these fields are defined as parameters to configure an "I/O Controller (IOC)" and not to configure a "Discovery Controller (DC)". In fact, it says that "If the controller does not support I/O queues, then this field shall be read-only with a value of 0h".
> 
> The way I understand it, DCs do not support I/O queues. So why set IOCQES and IOSQES to non-zero values?

Its probably an oversight, and the fact that the existing discovery
controllers simply allowed it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
