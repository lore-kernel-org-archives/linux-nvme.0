Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17938C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itosYFL6gkBI5Fnafo/G5lQnoQOC53Wf3FOXBxEhItA=; b=bMNRgqxwMYihtb5YVBVDqiRL9v
	XzvurvefwGjyU6M9Bfr2WWWb7r/qeyGgnTb3A+tZXbvaxTtqEs40kVkkKoXWdTZHyJd1CSzYCtcfM
	ZTjJT5YcoL3rS0IbKYuBCTk+Ek86jrNfCSTitz2nL7Tv0g4gbiNTdqoEuQWCk10Om2GdKH/2OtSgd
	+3QEgttM0taYSqiSWcr8npa9roHdtjWe1/foqnh7cioueYKPmEmZMKUGaarlkx3MVJV2aKHTBi9N+
	VhUQw6d1kgKli3nLBaz0/jP8ZYF0uYgzX33ibIC8fZUwSgwdnIpUs5wKr0BhVyfAgyIqyh8SDE8hN
	65MLMiBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2ZeN-0031NB-05;
	Fri, 26 May 2023 15:46:43 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2ZeK-0031LX-2N
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 15:46:42 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so5250639f.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 May 2023 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685115997; x=1687707997;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itosYFL6gkBI5Fnafo/G5lQnoQOC53Wf3FOXBxEhItA=;
        b=Tqi6Ho94gwday3GUp0UmV2YXOuF4cS+T6GDNGRrDF8+yp0ex0SySZYNoQ1scZAzuSv
         pzq+M3ZuAaYXfb2MXgndU9cWreVS473NcMoST3bI4B/T01PEXzaZ8H2BBy4biQvc+C3P
         fpOM+i8aZgR76sXYJQ2eEBGt19sNDRs0o/cs2hxIhXvMSF9psLrRb5n1fSoVT/lPQIyU
         x1E9orkY8Bc9OcSUcC+3LvynjA0hCiYP/HfjsAQozFePg1t+iCE9uKhk+a76dB1WAVbn
         mvCtgYsuO2c9ItScKWwX+doa2OqQBJp0c9THK7buLB7WPvp9QxlzaLq7PInPzanQ8/fq
         Eh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685115997; x=1687707997;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itosYFL6gkBI5Fnafo/G5lQnoQOC53Wf3FOXBxEhItA=;
        b=DoyfQJQBNY7gpAsuiI/6w42WSj90GGZj8eOrIBxflHMKGK4SYu2Rj8NQNFVEQEiyn6
         EmMFM4eeV6wMXkNQVZASz/qCCq265zrWOkepUaO7yTMN6qsRPj0gWeIkygPXah3Tl3w1
         DJkH/w0h2m/mmEMmJX8CJK3z5L9odu5HQLxdxdfWxL+51JjsTSkmxBp956qknHtQ3xqq
         JKV97xTSpbOeIqgbxIOQQK2bcH1mZCAuAx92QXMTaAqIjyiu1WWtUeUKNR4CRN6Fi5rT
         eABB28S0JL4vOTGWLQXsuI//lG2lmkUWol18+MnowRCjNI5dCG7FRTFgQDeWkdfy+t3B
         4ANQ==
X-Gm-Message-State: AC+VfDwNRGu4gLjWNigvLYLTGCN8MQkGSPzXESOFGw8WIfhxll6+Skd8
	EKJm+aYWyap9/c7KRvK0lGYQgbNhLPLs4oZ5/+I=
X-Google-Smtp-Source: ACHHUZ44AyaHnTL254qoUuEq+QygZ5MJayUGUNik31Qy6abvHKX+BJ/PNUooTmV5oOmzOQOxaEKHSg==
X-Received: by 2002:a92:520d:0:b0:325:f635:26c5 with SMTP id g13-20020a92520d000000b00325f63526c5mr1084793ilb.3.1685115997387;
        Fri, 26 May 2023 08:46:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u8-20020a02aa88000000b0041631393ac9sm1225557jai.18.2023.05.26.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 08:46:36 -0700 (PDT)
Message-ID: <4c99d028-d4ee-e604-995b-620a05dbaeb8@kernel.dk>
Date: Fri, 26 May 2023 09:46:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL resend] nvme fixes for 6.4
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <ZHDT+I2z4at1OvRI@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZHDT+I2z4at1OvRI@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_084640_973384_3A9952E3 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

On 5/26/23 9:44 AM, Keith Busch wrote:
> The following changes since commit 3eb96946f0be6bf447cbdf219aba22bc42672f92:
> 
>   block: make bio_check_eod work for zero sized devices (2023-05-24 08:19:26 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.4-2023-05-26
> 
> for you to fetch changes up to a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a:
> 
>   NVMe: Add MAXIO 1602 to bogus nid list. (2023-05-26 08:21:50 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for 6.4
> 
> One nvme quirk (Tatsuki)

Pulled, thanks Keith.

-- 
Jens Axboe



