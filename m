Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13213C28B30
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 01:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mg7MaShCaHVel04UjfQ05hzlkvIsmGwXx5O0tLD+kLs=; b=v8FXOj2H5+4Jm3gx2mzVnJwTfQ
	r1IEArCJ+eXchjYKQ0s3t+Z0GKXvUkaZyudOPEdKfDmlyUdPua74Y/XKCkjl4qelWegxlCujM5rQt
	lm3CGXoHgnitIHasSwJet3/5kwFSyurW++DW4jCv4ZhTROjXYKB+lsF5nrL3YZv/YsZe13s4+LFz5
	XLfi+oDFCZ+0gFPP78w9NesVgc+wX0fwxmcxex/ipvS3EXUgTTGLhcAIMSM0VFthUR7beG5PZ2ENA
	xPrk7Yw8wa8+b1PkASn2H14XeFyeeCtBlggAz2TrH7OX7NZuNav28sVdWjsgY6CUYpufrGSAhEZYH
	rZ9Esgow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvQo6-0000000Dbtb-3Pq6;
	Fri, 21 Mar 2025 01:04:18 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvQQd-0000000DZoT-1YBi
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 00:40:07 +0000
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so5195985ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Mar 2025 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742517602; x=1743122402; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mg7MaShCaHVel04UjfQ05hzlkvIsmGwXx5O0tLD+kLs=;
        b=P92A9f7zE09c7htif3qj5npCRtjwHvTOJkg5y3YlplGjjXloJHDAxCGuiT5JyFwo4X
         m/pczbwStUunblxUYEt2+kTz6giydZZB0M4OZFf32qlljyc8eE87Cd9nEIF4pZ71d8Bm
         phu6OJZ1FAvdjfyNxYBVk8G0H5d+QiVO1IW7bD+mhEmCDAVJ36m7mccNMvjBSaM104Un
         3X6I9yfsH2LyQhHvopodLlYdvoO1dlziw/g2dUEuBM/rZgyQgdvEZ2jwdvwCEoAkZ+ac
         PtFeBPBcKdKSzexl0Cl8F54sYXbJTn5HnJ9aMYiqdqEgt5JIxlTIoE2bhymM/wl8AY/R
         eZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517602; x=1743122402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mg7MaShCaHVel04UjfQ05hzlkvIsmGwXx5O0tLD+kLs=;
        b=tyFh5JDgn+Dpwf99cZba35MQPiXp2/WE31krdH/jCrSMwOEURhlBVSCCsLDZ6hyKMg
         1Y+9qB6Gg5Q6KGGUmsfNQNlK+6sxNBwMnQ3/HeKiROxIDuMC3ZxTAjqfwk1ZeQ+Y/nLW
         Kgu81GuKh+dzkqtQEwVDwRhMpKvzrqoeXheblofMuorBO59LM0IjFlAVcbTF+Us1adg9
         HuuyqLCB9pU8MlGhi8XVykb8b7azZuaUog3kQbrU6bzC+3cwuZXvrp5hi8bRH9knE6DC
         17xc6dGiw/9btHE2DShNWhkRxzPz79YfqI8TVKFtpHKWApz/Ws9xwyvn2AoppSqZZj0n
         fFig==
X-Gm-Message-State: AOJu0YwXz5cQmYQx4XawoiNAl3911yD1D1Y6GZ+m50JB4L6aEvHp3k6F
	jVxQXT78i76luYpIvoAS98WsPHMfT5GudqxBQkRO80ok3f6fszUkkf0h/IWY5xQNJJ/IN4VgCeW
	A
X-Gm-Gg: ASbGncussSH7ZxGCVWS3JsNTKc950jfDsBc/lRy2qtmHlIWBDvUUGOhb/YvtI2Xugqb
	UiGUAWepWQ5TSQqlaUOYWmQt+2RvzqMS3CfZ3pQCnGE5gIN2UWen72fnLbz73AMT30ENAnlziFS
	2PlC0U5mBqgs4H6GdZS6ZuZJrFGCQ229kQ6R/xY0L7Ky0dXfCtrZ1EHJO4EPfV319glLEV3Q39K
	n/Ha33OQUjhHUdsBx76jx1kJI1x5brrxwI4amnyl0N7DzR7l7c3teOrCfL4dHzn2uBX+f1IOG7G
	/JTYM+id8WAOUWOm6Fxb2SAeRo8GP6PwJrFtTcwduQ==
X-Google-Smtp-Source: AGHT+IGU1KHLJyGpKdc48QPbg97CVsF1wiZ+yxB7HHZij+R8pVsutVVmOqdUXvHlpzHoKdwBd1jTQA==
X-Received: by 2002:a05:6e02:19c8:b0:3d1:863e:5536 with SMTP id e9e14a558f8ab-3d596167f01mr18993495ab.18.1742517602280;
        Thu, 20 Mar 2025 17:40:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdeb063sm185476173.74.2025.03.20.17.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:40:01 -0700 (PDT)
Message-ID: <5d0f0ba7-e499-4ffa-8e39-7c8fe9543488@kernel.dk>
Date: Thu, 20 Mar 2025 18:40:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Z9x9U4DQA_a2erBK@kbusch-mbp.dhcp.thefacebook.com>
 <Z9ytHt3tpEMsTcbN@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9ytHt3tpEMsTcbN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_174003_693756_C16976D9 
X-CRM114-Status: GOOD (  10.76  )
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

On 3/20/25 6:04 PM, Keith Busch wrote:
> Sending a rebased pull: our trees were out of sync in the previous pull
> request.
> 
> The following changes since commit fc22b34e95ce0a294c797c397a9db671e6ff4448:
> 
>   docs: sysfs-block: Clarify integrity sysfs attributes (2025-03-20 05:44:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-03-20
> 
> for you to fetch changes up to 64ea88e3afa8c5b6c3f9c477da304b7a56149612:
> 
>   nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi) (2025-03-20 16:53:56 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.15
> 
>  - Secure concatenation for TCP transport (Hannes)
>  - Multipath sysfs visibility (Nilay)
>  - Various cleanups (Qasim, Baruch, Wang, Chen, Mike, Damien, Li)
>  - Correct use of 64-bit BARs for pci-epf target (Niklas)
>  - Socket fix for selinux when used in containers (Peijie)

Thanks Keith, pulled.

-- 
Jens Axboe


