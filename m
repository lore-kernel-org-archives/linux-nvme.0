Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C6CCCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 01:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbOfTv6aZMJwJYebFXUGpLKkO3C9MvIV+S6DwLivmkg=; b=w+juVuxKC7Ub+prXNoTClyAev9
	1fD4mh1FF1ikm6Y2xlcaT0ihqKwjHm3ncLYLcDCIh2ltvkltd+ZiuT967xmJ+ZVj6wipd5dksZMcR
	iOUY+xh+N7LFtPyp+HflcYys0j7SoxznW2/raaGf4aMalioFRBuK0V7bwcPOR/CdJ4A9D18EnBauV
	PQ1bAyEbdbK1XMVbpdQqOerAv4DU9GvEfmD1WfgCowzP9sv+GGlZgDS2iWGnXl4KqJH/eiycb4nqJ
	k2J/yh2ln+/ITTuzHrN02qX6dFopIQKZKBrrTi2RoXlhl6BxlTqsexfpHee7HRBRhRlhp7SvLs5dU
	STl7FQew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHB22-0000000GUQx-23vu;
	Fri, 07 Nov 2025 01:12:50 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHB1w-0000000GUQB-3j7d
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 01:12:48 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-7ea50f94045so2469786d6.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762477963; x=1763082763; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbOfTv6aZMJwJYebFXUGpLKkO3C9MvIV+S6DwLivmkg=;
        b=w9j13ApuHjP/0LeWr4pss9ds21BOV5P8gBtJeioh+Mb/EjGjKXmJR0POcUYOYHyFlm
         mv3uZZt4y0ArGx3l3XM0nOenc3aLUvvFoFyXLTZiy/mG/CEuB5m3PS+Hm98+cjZrNcZY
         Xb5Ei8SGjkY1qa7cxOD/lixGg3FbF0oZj/MkiS5g6B2jceCgsNCcTohm56m0RLXMskhc
         iDgSNG3svZGqLu5edYB1APnmmIqvm/O6p5jL/2T/a+xuSKO54Mjyxmgx85TIvYyWBO2K
         A4fkZnRFyhOnH0HduvBSfy7Myziy2Db3PvfZ3erht4z9U9qbPtLahSuIRNeJNQuRf9p/
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477963; x=1763082763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbOfTv6aZMJwJYebFXUGpLKkO3C9MvIV+S6DwLivmkg=;
        b=NEB4pwyg9G1sA1d2kHjew55pNnZlvn2+XF4nR9Ia75wq2DIqUCb/Zz+OMe59yfcuTc
         iGFssUfUPXL3Nvu0jxQgI5mLZ3gPqxBHLqhuc7nClrVcqBLm3qY8F6XRezF1mh8nTm3f
         WTK/9Yxe7x6Ahod+S2Bs0QxORYXlXlyswfxhqUF9EDnvV3l9uaTn2lniF99Qm5QmFVOc
         Eo/GB1in78fxbeE+mE9fl6WOP5I2yMS35Eamghy78INMhdhC73GUPIDbGOmyFAtYoio4
         L3GEctOPgvRgt8x8msbZrcVDyVXOgqx6EbrihPsF/RGMj6lXvyboi4hjap2W5aF5/PQ9
         dszg==
X-Forwarded-Encrypted: i=1; AJvYcCWSpxTAj64aV8Y18+kADbkKYNoBWLBUJYCxB+LCAj1ouAudWA1xBCcvBfm6Qr+yj3hDPyKOvrkdVrqp@lists.infradead.org
X-Gm-Message-State: AOJu0YxVqgJFpvXwfN1Szund2ooM2ntqn+ccB5ulpe0H52fFisHN6udZ
	g7Y1+aYOLt8Kqawgxjj6Qf1sladpvV6srGUkBIWjaT3IXTdI+Ib232qG35GCSZP5/Y0=
X-Gm-Gg: ASbGncv3IXfDAVNQztng4R91Yx350Ml3hmmA6vfgpMLyANp9sCOqIWc/w/kQHFqulXj
	Fq+yJxs9Yj6s11cTEMfFzRV88ELAUde/93s4kGRmcgNY2OJpEe5gzZO1XcHfwV/LNQIAZ3dGmhH
	Hj2iytX0t/hybvmMMRFpqAUcmeNAArKQeRRnDH7RpgrAqniG4BBEPMJtt9OqIexmt278BuIAT36
	b/ZnpBwoae3LICydx5EzCE50mt7ayDIUI36EK/kd+ZP1unHuyn171s4w94BvveTL1cCp528ml/8
	7RhyZnFK3XTaw7o0WHEqBRTui+9zOCJoEEFW5BvO3DkYU7TUhSBhDAE6x6bVMj1DVfzWS79Zc9p
	AQvOtpguQeVOeoNQ+qnHXGRULUC2ZueUlmuOWEGtayPM/qds746LJybd5cJnFF0iNFuzCi2TG
X-Google-Smtp-Source: AGHT+IG8/wvtChgl0Oj/AdYZuMbFxSekQdhXD7/Z4xI+xovxQES5Hc+/nbL8jisSWsqgNfQX7l33kQ==
X-Received: by 2002:a05:6214:2126:b0:880:4898:d74 with SMTP id 6a1803df08f44-880829088eamr60575676d6.20.1762477962806;
        Thu, 06 Nov 2025 17:12:42 -0800 (PST)
Received: from [10.0.0.167] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37b9esm29305616d6.52.2025.11.06.17.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 17:12:42 -0800 (PST)
Message-ID: <f12584c7-4f91-4d22-828e-cc64ee935110@kernel.dk>
Date: Thu, 6 Nov 2025 18:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20251014150456.2219261-1-kbusch@meta.com>
 <aQ1Fa7hPssIFOBLg@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aQ1Fa7hPssIFOBLg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_171247_448956_B23A360C 
X-CRM114-Status: UNSURE (   9.20  )
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

On 11/6/25 6:03 PM, Keith Busch wrote:
> On Tue, Oct 14, 2025 at 08:04:54AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The purpose is to allow optimization decisions to happen per IO, and
>> flexibility to utilize unaligned buffers for hardware that supports it.
> 
> Hi Jens,
> 
> Did you have a chance to consider this one? Thanks,

Looks like I missed this as it was during my last race^Wpto, now
queued up!

-- 
Jens Axboe


