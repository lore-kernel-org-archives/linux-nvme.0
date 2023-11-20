Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C061C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fxba1kYMA1eupI9Avrj6/S3g58MdFYbeVhsqFUI7604=; b=FEZpS0K4NAGDE1n/+8+NAte1gQ
	o6fZaqdZpE0mTkkkYip2CMwbVGY+4Glk9/YbU2kELmbRp3WZ1m98zfzmw51/U9vefKWEWyJvyBURp
	V87ZatQ/Iv9X5JCuaRXaXRuDoxsvr8N0/BOfjR6NjmWCwCdprGuexeuW7VUHktMouH4jcWKsLO9pG
	dnN30KozFziNdjlouy17hSIcUayP+PtJJJQjVSGim5Zzdky9cTZ1QHm3Hf+4KJV24hWVPKF0jsM4z
	kaILKVqaINdAVz+piBqmoyTWOwe/XG9LbbzqvX/sZJpQ+ojurJX35TR50SXcVDp4IWxaoj3kfEpBG
	Q89dsbVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54iW-00CCWs-09;
	Mon, 20 Nov 2023 13:53:36 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54hs-00CCAG-2H
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:53:32 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-32f8246103cso1193134f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488361; x=1701093161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxba1kYMA1eupI9Avrj6/S3g58MdFYbeVhsqFUI7604=;
        b=gakV+h7crDuOrWAkcN5arbRAtcROzk073AVsKOELjaMa0mKlV8/yYFZRvb33HqpdvC
         X2IiK/lEEDwJzHs8FpvUKHwYp5mst8yfNvMCh+bzpfEIfh/0cHwMwpP7OGINrcGpcQzw
         L6xNpsrFDa0dbQwXfiHTTXDu/9M65oSoVwiHQzRO7lFBV9GoO5gHSHf8WupP1TAL+exs
         KptbQAnC9Qk/07YS9ESPyH92n5VMMLePGQ/w6GxzpSXiTnTO2ZYh7/ijbWEFTtdHRFp8
         5GxMHaCGsldpGsLcZ1RZ92+/+1fuQhfUkLV7O9ozXdfy5Tfe1vgV80Cr9uxt1j6yqFEO
         LLCA==
X-Gm-Message-State: AOJu0YwAdTj6QEzJPHCU4IR39FrTsQfoautoU/wmMi/ZehIJmZ77WGa7
	/sAs+/y1p4pQBrGOARTlWGg=
X-Google-Smtp-Source: AGHT+IEy8NttNiWl2hs/0iIXCgz1D94GnYvZjoMwY7xOM9iulbhxahfrXi1Qdv8nCTj6zfHToFZGdQ==
X-Received: by 2002:adf:e7c3:0:b0:32d:d932:5848 with SMTP id e3-20020adfe7c3000000b0032dd9325848mr5111777wrn.2.1700488360967;
        Mon, 20 Nov 2023 05:52:40 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm11249805wrs.84.2023.11.20.05.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:52:40 -0800 (PST)
Message-ID: <3a304aea-23a3-4ac7-beca-f814624a466d@grimberg.me>
Date: Mon, 20 Nov 2023 15:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: Fix a memory leak
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
References: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
 <20231030145220.GA28484@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231030145220.GA28484@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_055257_230253_D4FD6166 
X-CRM114-Status: UNSURE (   9.65  )
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


> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
>> Personally I prefer v1. Pick the one you prefer :)
> 
> I think we should be consistent with one style or another in a
> given function.  Otherwise I wouldn't even have mentioned it.

This looks good too:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

