Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE58C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qLmffwl75hgVbG2gk0tD6CR2NK/r5FWbW6d2Hfhvklw=; b=wbWTem9YmFrrQiwB/qpBfoP0zY
	k5UuDDKBFILn6WfamEb2WEiH/780jvAx/+ETuovtS0/Z/dpygExvHHLXmaRTeKaK35AM2a+1CryS4
	iCneyG0cTo62TGJwqIGgfCgqV2HgvjG5pA3tOYMlAQhgJDGvFIEZrqdinYn5cmrGQQzuMOmM9I4aF
	0x34zY1c2ggOrOVxI3YVAAWLZQ9hu/NZ3Yofbx0zJXRQvWBkwTimo4/+5erv0wr6sB9H4/aTZoVvY
	pN5cmYnQzp4/awKtvex2/fZ/g4fWlIZh1yvFIMgXecElF59Ghr0Tzt10/mI7oFi4TC/sUluMjoMPg
	gEsvbh3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQza-009mA8-Ti; Fri, 15 Jul 2022 19:28:50 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQzX-009m4l-2O
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 19:28:49 +0000
Received: by mail-pf1-x431.google.com with SMTP id c3so4526088pfb.13
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qLmffwl75hgVbG2gk0tD6CR2NK/r5FWbW6d2Hfhvklw=;
        b=tBNflhJG39NNOtRJAnSsZf0Mz1s7O9xDQiesgT8qsidLnFtuOTSk+TbYvdMNItHTPn
         PpvmA9kGK70VxNP2LiF7AZMV54w4qphldr0uoS4HsMGePDL/vlr9tA9u8C4ZK4y32zEw
         PtcAWB08G5Jq81PsYzRlscnqOQS3yK9+qdTF+iuBD7cGbbqJ+Zpd4YK4HaS5xL/JivC2
         XNkTdf+HGR3BkV91vPU3dMChnCOTzOB6tJ2dWRqvkEFLhhrt/wAlYBG6XuNJ9++fM/Eh
         X2Mmem6tjHdZ0kL0PWeVBukomdpxpIvJ7NaBhRPAB2OacrCq48ujcQYvFG9AqBbw8bkB
         4KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLmffwl75hgVbG2gk0tD6CR2NK/r5FWbW6d2Hfhvklw=;
        b=Xy3y/uFxnSLDOTDGKrE7eHXilX1ZvrNoWixmGC8WVUzAmdYUNDEaTfbM6DEuu3CdOS
         uvoGNprbyTFR4q+iKUqQ1Wwq5zz5i/YX7xU323D5LNmJOjS1UKcZkX8j4om64nJa67Uw
         rnELVSCwy2uaOmeSpLEKRZzYEu7M2fgi/0rfkEv7VILteZ0vmWarbVxzbIAMYPMa5dYe
         hf6T9ODGimSOasch4KKuHeJ7YubtGzBsYlKwuno3p4ZBV4KFl/uIgLeP3kdZ4H6LU2Vh
         1JBwDWtg2MGd9rTt5ywULZkhcqqUXXv0dWxACrf4DDgclQbPqwKR7Ve37RKvUP5ND9o4
         CYew==
X-Gm-Message-State: AJIora+3yA6dxAhhJMuWWe1ekrNyvMGljWnnocs26DiCT/eDwMcVN3sX
	IqKGVqCCKbNROqHZ9lD/+PUDIMXEEwIloA==
X-Google-Smtp-Source: AGRyM1sguRsI0CLbyOSQx7uqFMEBO/+wa1uRdB/NxjvCJYWu8rLyJIPfD1UcG2YEKSuCOARPIH+ROg==
X-Received: by 2002:a65:5605:0:b0:419:d863:8d94 with SMTP id l5-20020a655605000000b00419d8638d94mr5229267pgs.359.1657913317875;
        Fri, 15 Jul 2022 12:28:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001641b2d61d4sm3967075plh.30.2022.07.15.12.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:28:37 -0700 (PDT)
Message-ID: <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
Date: Fri, 15 Jul 2022 13:28:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file
 op
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, casey@schaufler-ca.com,
 paul@paul-moore.com, joshi.k@samsung.com,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 a.manzanares@samsung.com, javier@javigon.com
References: <20220715191622.2310436-1-mcgrof@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220715191622.2310436-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_122847_149870_E7BA42B7 
X-CRM114-Status: GOOD (  12.24  )
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

On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> add infrastructure for uring-cmd"), this extended the struct
> file_operations to allow a new command which each subsystem can use
> to enable command passthrough. Add an LSM specific for the command
> passthrough which enables LSMs to inspect the command details.
> 
> This was discussed long ago without no clear pointer for something
> conclusive, so this enables LSMs to at least reject this new file
> operation.

From an io_uring perspective, this looks fine to me. It may be easier if
I take this through my tree due to the moving of the files, or the
security side can do it but it'd have to then wait for merge window (and
post io_uring branch merge) to do so. Just let me know. If done outside
of my tree, feel free to add:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


