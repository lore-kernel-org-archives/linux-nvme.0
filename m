Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286DC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDJIyWRJxxyEc1PDsmkOW+Tr5RdxZDK4YmviorpWb4o=; b=W/TmnGLk5YZo1S6G930K+sNG8D
	qO0PIQqnl0EYTAqmOsbLJ16TD4NGf416NFD7+Ww1NYHZaM7vBWShVhEOYURkDP0HTunM6h+idf1Uc
	MzUKp1XggauRtlXCkuUqqd2s52cd5+/MuCh7O/+qotRkf7dyn1NOG2iz6OCoYHvPTuXXbFCcwjc4d
	3QNdPNxAoRvxxlbVcxbk1ChCtWbGh8FKSX2wEoA84tvQraUp6RBPR6i4/Mg7oc4pJd7GT+5XKvDhZ
	xBMykWcW1i4je1mGkKblKIKJcySdI27oEVopXE+QdvNsXY8t16NBr7ZRzARuRThvpuhZ+IGOByaPy
	aKfhAt9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN02C-009g5Y-Ko; Tue, 31 Jan 2023 23:27:28 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN029-009g52-0u
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 23:27:26 +0000
Received: by mail-pl1-x62a.google.com with SMTP id n13so1216630plf.11
        for <linux-nvme@lists.infradead.org>; Tue, 31 Jan 2023 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDJIyWRJxxyEc1PDsmkOW+Tr5RdxZDK4YmviorpWb4o=;
        b=CsaAiIj/Fy41JiNKHCuBHhKWrlD7FNQxcxoJdJ+KnSNrgmSH22orjG2FjdYwlyVJza
         miB7uIhmGmaZ3JReC2IIl/leWYFPYwrZ44OSRR3HRiNgNDHVr6GD9K5fzF+PeA6Htmh2
         1DXL817EU9ogKjKwSdxmyGc1K5BVhU03WrF0ukZ5IG2Yiw1oueatsz1p0oOZIKf5oDYy
         76TUbXliW/faRLyeILlll7r3OvYwEvPsq0go3aoRXBfQhiSeuTM9DgzUVwWSZE4lYyho
         BLxPyR3kRbGeiQx3/NXlFvVphYA+ivPJc6O6QiZ5TjGbkZcQ9kbWV2KGkRR+9TVMsTTm
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDJIyWRJxxyEc1PDsmkOW+Tr5RdxZDK4YmviorpWb4o=;
        b=NHKo6C/nxmM62W97loW/sjnwKEZz96WbLHka8/WwOvDE64y6VJvkX11k1WNHgSe+QR
         SFKXYqwARA9N9xzLXiulCupU25d4XGJmUFCuW7d0etrI/xhiZA+Sjn2TLGLEOtfHfP6H
         rLl7FIJCAwGmSdXYSknec5MHsFzzwDmZNMcPR99xvZV/lI5JcqMjt4JJYG3AB4es0zia
         9iH97/NRsGjzWikuSxPNz+blKqOTFYbBWxF8QCn4rl9VJGb9+Rgrs3uTpNItlYHRbQi8
         p/5hesfsSIpTIm4IoyGKhLFAlYxlOVUGfEQsk7Q7iODfA6+QHlSSXjdf7jOG5TsUH+6J
         eMvQ==
X-Gm-Message-State: AO0yUKUAgpb7i4d5A9ysHWYqGv34mJfqLOD3lxIWk8lhKLE3t8pUMcgC
	BNVOvcvzx6m5gJfS3A5/4h1CyCv7vbg=
X-Google-Smtp-Source: AK7set/6M1j54v2wX0+fXv/dZfC+VdUTg8GYE483FhD2qXq0X+hoIYjFv58I9qKoOczcMzG3Rxj7bQ==
X-Received: by 2002:a17:903:3014:b0:196:7f9d:7009 with SMTP id o20-20020a170903301400b001967f9d7009mr611399pla.7.1675207641882;
        Tue, 31 Jan 2023 15:27:21 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b00192c4055e72sm10271728plg.173.2023.01.31.15.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 15:27:21 -0800 (PST)
Message-ID: <40b14fe4-7d7f-b4ee-b058-d0d39b9fa6d4@gmail.com>
Date: Tue, 31 Jan 2023 15:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: nvme-6.3: blktests nvme/003 null pointer for fc transport
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_152725_094847_4DFB4401 
X-CRM114-Status: UNSURE (   9.67  )
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

On 1/30/2023 3:15 AM, Daniel Wagner wrote:
> Hi,
> 
> Hannes added support to blktest to enable the FC transport for it. And as result
> blktests is able to crash the kernel. Haven't startet to look into it yet.
> 
>   run blktests nvme/003 at 2023-01-30 12:08:28
>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 3 PID: 14200 Comm: nvme Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:nvme_alloc_admin_tag_set+0x38/0x120 [nvme_core]

bingo...

The cleanup patch "nvme-fc: use the tagset alloc/free helpers" 
introduced it.

See the fix patch "nvme-fc: Fix initialization order" about 10 days ago 
that corrects it.

-- james




