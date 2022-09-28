Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B168AC04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5BzfU1Ctin05aGCszFYs/HZPFJIFqu4VCfUEaRWslY=; b=SMTCeJAVMwdSrFz3Yw5MzseO9u
	8dtGfXLp1NuBHPOlBzQudV8TnBXMXygBHti92GtU1QEToPmVPdtQuXFvm2keAy76GEU15oLQuX2ej
	ANBGPNGz2qgLgvSKVJA3aqaVFGeV1I463g8aujGnpjclRMnpH5h8JniJ/Ih74AkfGIRkDJ0iA83Px
	g/ux+Hq8z5/EAcqn3jXUkf+xzX7i3NPfnDadVlVVSZOKzz+jPXiPLnZ26VZiM+PWFz82BJb51/XW0
	e5eNJIVKqNvDIy8oxf6vQf2FOZYNO2ODDG/cHUmUC+muH8OSGFeNj6NT87onPjOGvFFY/C1Y30vRj
	Dmg4mPmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbG1-00HTbh-S0; Wed, 28 Sep 2022 17:54:05 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbFz-00HTZN-Kv
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:54:04 +0000
Received: by mail-pg1-x535.google.com with SMTP id e129so6804417pgc.9
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=g5BzfU1Ctin05aGCszFYs/HZPFJIFqu4VCfUEaRWslY=;
        b=IshhxIUEVKUCgXM5zkpHJwazY5WYQlr72ei1K5sG5UzdsZVkpfEW2Mw+iZ9kiOCOE/
         gdKjiMVPLD2m+N52gToWtxVgV/AGbU8rh8aX3jGhXRQC1g1yZ0SK0QVzs1T8x47oZmxW
         RXRzgvB3myoFJztcU4PbIcMySGXWG0nwzqHkx4qkx8TiQMELbss4qLIC0lByyf+N2s9q
         MNrdhM9rWgnHVko/RkDKsbQMWBVSVyk+9ZiB65Mm0Sbr98mBZjD23Gnc2qKafznwjRA0
         wmzWJUgy0SE0JxKy5ScBEvz+srBNhKq/qr/dGl92x2SVAbssA8wMUlLB+XxiLdzSLd/h
         8Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g5BzfU1Ctin05aGCszFYs/HZPFJIFqu4VCfUEaRWslY=;
        b=SdVDPAQfD+d2yMakDN1tLY6N3pT+Bc7o0KUukq+Xla2y2xtAEZzeDA8EZ7MXJ8SvAp
         MECpnUcSoz6IUvilsIjy0IJfiAcFz9kG6Tyfy5cKOF4wlQdR/4VTgXRh0qgL8lPB1cdL
         omiwYTqXoPtg3A3IfFsveqNHOyf8y/WU953Xg3BY3q7xjDpkZZrjUZ3XFDSnghetD32g
         Sx+y0/XOXd1WVY0eiBml6+mQGQt6x8T/NpIHIohlxKPGg0dDKODPbONUe0uxhK3kZKo+
         QuNAQb46LTuHa6ECELHeAjlnnjcZnoJRui9SoPtxUk6Pon06tgzHtdJ579mVMsNFKPjm
         Q84Q==
X-Gm-Message-State: ACrzQf1NbL+LwrmLfFByWEZK0h0Ow/bvUvx59hIPsejbcPEXNbTCgwkH
	loczmC9RaNXT7ub+62DeuEENkoDtdNHpzg==
X-Google-Smtp-Source: AMsMyM5TNVPcFsDxIqgpdI3sm1ULmxd+i3nI72g5FVi49MX4X80NFGYlg9gXNWAdjgnvJJqiUpfFOA==
X-Received: by 2002:a63:1f12:0:b0:438:fa5b:ff76 with SMTP id f18-20020a631f12000000b00438fa5bff76mr30448629pgf.390.1664387639098;
        Wed, 28 Sep 2022 10:53:59 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b0015e8d4eb219sm4131010plh.99.2022.09.28.10.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:53:58 -0700 (PDT)
Message-ID: <40eb2cae-ea17-e1f8-c2f0-2d747ba05c91@kernel.dk>
Date: Wed, 28 Sep 2022 11:53:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 5/7] block: factor out bio_map_get helper
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20220927173610.7794-1-joshi.k@samsung.com>
 <CGME20220927174636epcas5p49008baa36dcbf2f61c25ba89c4707c0c@epcas5p4.samsung.com>
 <20220927173610.7794-6-joshi.k@samsung.com> <20220928173121.GC17153@lst.de>
 <6ffd1719-e7c2-420f-1f9e-0b6d16540b46@kernel.dk>
In-Reply-To: <6ffd1719-e7c2-420f-1f9e-0b6d16540b46@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_105403_712440_6E4CEB1A 
X-CRM114-Status: GOOD (  12.46  )
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

On 9/28/22 11:49 AM, Jens Axboe wrote:
>> Not really new in this code but a question to Jens:  The existing
>> bio_map_user_iov has no real upper bounds on the number of bios
>> allocated, how does that fit with the very limited pool size of
>> fs_bio_set?
> 
> Good question - I think we'd need to ensure that once we get
> past the initial alloc that we clear any gfp flags that'd make
> the mempool_alloc() wait for completions.

Either that, or just have the passthrough code use non-waiting flags to
begin with. Not guaranteeing forward progress is a bit iffy though...
But in practice it'd be no different than getting a failure due to OOM
because the application submitted a big request and we needed to alloc
and map multiple bios.

-- 
Jens Axboe

