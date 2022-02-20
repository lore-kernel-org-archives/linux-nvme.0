Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C35C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M3WqtHJfTzVvuoEM0iTPXATkQOqTEP/cvHNp8lPltAc=; b=oN+YWRwpPl0oAwHfNQz0HVC2hd
	P5Mjun/Qb2JsG9thbPIKP+sua82IWWOEAqXDJ2jt+u9wL6ACsk0NmyQmzXlLm/aC9t6hFTc2b5PJX
	0yqw6lEzDFEDUF46CC9Kg0c4TbFaqS3IJibgvKn6M0r3YGc2Z4fvi6ZdoWq0PQYNMpLb+JTCukkLA
	4OYXdVluhsh8XY/59eJ1MAzw/jCnWqhQxzPkv4AUh5QyJEx10v/s4ILSELl8kiPQUheicmP5IpXak
	f+R9X8ef6F2/4nk/ux1YLDSvh0ZXjk4p4NL/CPXRxih5URlNenONksBY5zddxWYaI8P4GsO/gd2zd
	Frq6evtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLltz-001O3C-6l; Sun, 20 Feb 2022 13:05:23 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLltw-001O2F-Ve
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 13:05:22 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 l123-20020a1c2581000000b0037b9d960079so11827507wml.0
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 05:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=M3WqtHJfTzVvuoEM0iTPXATkQOqTEP/cvHNp8lPltAc=;
 b=IB6dmSWAQsb7VXoGi38iCGpjOLX7OpsIKodGIH55D90KkqC40JL8ePVmVshKgyERO2
 IUg20+psYSd+wxCdG0TUHbQU+sdJQ2JdOG4tS+PIMa97Oo7YB5tHdsHrS8S3BlGPd4ZW
 7smpR7r9y8k7erRiW5Fk0VtrA3h9v0zmIkSGMpTmPusHP2HlXXZR1S4M5CbeHHcirTaJ
 EAxUCX2DJzIJoVwaECAz2KuYG/PDG9dFXSrOO6bQ22wl8RGHVkHRG5ae4/ikM6qZ3/Nk
 WJVJNV1nCf3P0nG+6nZz+Foo2YqHo9qaofbDhWMsSowEhaBbN1iMVONjpcURgTZYX8Wb
 jX4g==
X-Gm-Message-State: AOAM531b0k44T0SZU53YJUCt8Wkz0rpeUSp87YAZxqliJiRpP++yC6vy
 nrOh6s6umvoU6NfN1j6mfMvuZAvFniw=
X-Google-Smtp-Source: ABdhPJzYi1xj8BuzDX7W0kWsK2BNDkYEyPPam2aO63CGwLW7cgmg1e/yrCWho1jh5V548OvUkjy0YQ==
X-Received: by 2002:a05:600c:3056:b0:37b:bbc3:95a6 with SMTP id
 n22-20020a05600c305600b0037bbbc395a6mr17371959wmh.46.1645362319759; 
 Sun, 20 Feb 2022 05:05:19 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n6sm28991638wru.114.2022.02.20.05.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 05:05:19 -0800 (PST)
Message-ID: <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
Date: Sun, 20 Feb 2022 15:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org,
 Ran.Anner@dell.com
Cc: linux-nvme@lists.infradead.org
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
 <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
In-Reply-To: <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_050521_057178_DA432DF2 
X-CRM114-Status: GOOD (  10.83  )
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


>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Let's wait with this for a moment..
> 
> Keith,
> Is it possible that you guys take this for a test run?
> This is the area that exposed a few issues in the past
> working against your target device...
> 
> Ran, maybe you can run it against your target as well?
> 
> Would love to get your tested-by/acked-by tags.

I think we can move forward with this patch. If this turns
out to cause any issues we can address those as they come...

