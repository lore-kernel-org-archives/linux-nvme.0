Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F53C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqW7zvBAkMd51AgVSVsJQFVitcUOc0dr0M/KiG1Psiw=; b=ys3cNGJ/0wSEZekxdXvC2B3Ina
	kH59Kg2dPi+dn1L30ZpxNoXdFLg8LBf2QWXjp7+2A+9cRP3yrag5616baTalSK1gou2eiqIRNW0G2
	BPHjkAgQ99IQ8I+vv7N6ppm95Dyk1s2kDHsW2VkIySrEDELl5DtaZ8bB8KcsbW2KZZ0xhgWBEOyWB
	SAm8R+rPGqR1VXV1SWbjqJOms9s60S9fKaZF0HKdpfvKtR+/G86v4OOuzbblAJwgjlK+SUPkhccGT
	MNYw5psubjqU5cpAkOLRQR9vvtZkAt178cbDI2shoVEumQ0HYcCEOh43tDpqeRSTzdMrcJP/6btJu
	7+lX8SoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njKrH-00ERo7-E7; Tue, 26 Apr 2022 13:03:59 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njKiM-00ENfh-KF
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 12:54:48 +0000
Received: by mail-pf1-x430.google.com with SMTP id i24so17867210pfa.7
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ZqW7zvBAkMd51AgVSVsJQFVitcUOc0dr0M/KiG1Psiw=;
 b=ODcY1qBX6Jq+yj5zj0HaI/wmj86npUEaej2F8o1gOQnRrPXw1zqDu9Ax+0Y/QTG+9T
 YWwBiNe3fIsIYg6UWfFQIfo27clvFYHBNj7nxyYSAVgCEQRwS4fqBYVkQZa38ja17arl
 CPPbMbUGC1vD/agaiaKnXzJWvjupHwXJxWf4zJTkj33kYbRIpBaLOvWA3UN5KmagjYKK
 GZfSR/Wy6Wv2bCDhewowP/Nrd1Fx48sKl0VhJ8qjQC9e2XEzIFfRIFacRKXJkhWyf8mx
 Q2rVyXctRIyxNPl0u50UWN0c5i1wgUY8vTvmUjGk2t7AlMlUWRoIPbSXvxI/yxrrR2+x
 iLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZqW7zvBAkMd51AgVSVsJQFVitcUOc0dr0M/KiG1Psiw=;
 b=AqbOcYBu+0yvs8vobeqDN17IVw/cDZC1jQXFRnc3I9P0GmLP0F5su6RmeKrzLOgGSG
 uxe2VgBgPdl9mE5v22sMRll74NLUsq63pd7/WB7aNGsfojJb9VG5sht/EYqmrs71TDpe
 HBGu5FGM44EfxA8gyHbHsumFj4UAKcFhKLA2gvGOQE8WY4g/9VBt9hVL7JS1H8X0d5AI
 74v9J6k64N/U8EJQExV6/JM1ZOd0R5cciWxYzX7bJLhWKojM9HtI/kY+biPINzRqPto6
 jLUhUdTpJ7kTYueDHE6IauQKK6QKF25w3YepREnZz9aRk/QnyCO7pb1VGBfIJKUBUXb/
 rbFw==
X-Gm-Message-State: AOAM532pN1VuauZxRXE9Wl+FHwSSHrlH5WojuuC2hqhrkBMDMZbmPSGb
 hjP1Z/KbBXPToL4EKrQQrlaRBw==
X-Google-Smtp-Source: ABdhPJxhyyQ2DDiUpHZz1TcTaVa3xu5irO0mNpVNFYiW2LXOJcclBaQ0v0hEZa+PUPh+qjKSRnv2Uw==
X-Received: by 2002:a63:e355:0:b0:39d:7956:6d3c with SMTP id
 o21-20020a63e355000000b0039d79566d3cmr19527497pgj.385.1650977684229; 
 Tue, 26 Apr 2022 05:54:44 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 o34-20020a634e62000000b0039cc4376415sm12803817pgl.63.2022.04.26.05.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 05:54:43 -0700 (PDT)
Message-ID: <9c8c0f8d-3495-b411-7ef4-27bbc0dc1141@kernel.dk>
Date: Tue, 26 Apr 2022 06:54:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 00/12] add large CQE support for io-uring
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Stefan Roesch <shr@fb.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 kernel-team@fb.com
References: <CGME20220425182557epcas5p2e1b72edf0fcc4c21b2b96a32910a2736@epcas5p2.samsung.com>
 <20220425182530.2442911-1-shr@fb.com> <20220426113741.GA22115@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220426113741.GA22115@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_055446_796089_EC93B3E8 
X-CRM114-Status: GOOD (  11.87  )
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

On 4/26/22 5:37 AM, Kanchan Joshi wrote:
> On Mon, Apr 25, 2022 at 11:25:18AM -0700, Stefan Roesch wrote:
>> This adds the large CQE support for io-uring. Large CQE's are 16 bytes longer.
>> To support the longer CQE's the allocation part is changed and when the CQE is
>> accessed.
> 
> Few nits that I commented on, mostly on commit-messages.
> Regardless of that, things look good.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

Thanks for reviewing it.

-- 
Jens Axboe


