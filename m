Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0901ED5CCB3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uYsdZYXwwUxJFu3sXtGLMhZDvIX9hIriU8h8aCKckQU=; b=lmI6xX0gmN4cyCX/NV/WA+aWPQ
	jPTCEnM2pLCsUTcDREjC4/wL/lCCB4ksuxXqX21klpquOUsFLXuoVos8NHKZkFDSbrahsNP9kHEBf
	tpCUm5WiC4E6xaSu3qqD+WYYwFUemT2A+JZuA4TWlvhKr+1vaRZoLg/P/GdRCxGq0U+BApyVGCkaT
	D6vwNQjJnUck4I7UB04S7bj5l6EBPblHnXfHk3+G2fUCFY4HeovKPn1aOGKfz+gzR03OCefFngIMH
	X3FGAYg/zHAXht6F2BMR6zljSJv5ytF3XzHoZ37QHNyrP7Odyc6o3cxv4yPQXHQGbyisA/xx/PTFN
	7aZDuHPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ABo-00000000l5R-29l4;
	Wed, 30 Oct 2024 15:00:52 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6951-00000000Xex-3fyF
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:50:08 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-83ab21c269eso266362539f.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296186; x=1730900986; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYsdZYXwwUxJFu3sXtGLMhZDvIX9hIriU8h8aCKckQU=;
        b=uYoYfJ+O96UuAfYzMlOxhH+ZurRTjS4EPVWQsOCBcx83+3ngMyz6HYVpw3nxBnNMKS
         Loc4Hi5SfAzvtW4kCu4thXe4xtpQvEqJEIYWop4T/q71OnEXW3eqiWiGlEAtoGQBf86n
         JHHx7i9lHCiXRoxuuC9XyYJiqrcv+6+mVBtG9/sJnSsK6yoPLirob3IXivNHPzUQ8OTf
         YjeSw9gxSg3tyIe/8VUdKKaE8yXt4xpJyxnsjfINQowao8PDfABVJTH0nFPDbigqirEI
         iyiVZmRvJz7UwRTV1vZlqrnFS3hFgTqz9YVDHXUF0kruwQeOAlJv/dPev1zScCPr5nRO
         lNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296186; x=1730900986;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYsdZYXwwUxJFu3sXtGLMhZDvIX9hIriU8h8aCKckQU=;
        b=VXsIfTMSZjxuZqBdnTrb1XC8kK9MY/cy1af1SvgOWM/DwOoNpUttOi1/snkGpZRqST
         DxfCAy1LmQ/JeYwSbwUQIbs8BdkE8BcrAmE+sKJs3jt1zfnoy25dN4w+2XC30fhyde42
         jGC8gtWqlL8SbkUVXnamAq9CHHDguHzB8WnDXCSK9uqNxEOUw4ezucd2J/2UIUcDBgCd
         jZoAEVyHXHG5BtjoqqqHlObAyunkVBPaSJ16ZT1AgOm5ndobH3nOD/qiEY8/pSSBmqoR
         JOZJuxIEkFSXtcUoQ/CiyVPADV0hV82TrJciFHFYJwowt6BQJKjliUQudppoTjLza5h3
         RqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXR4ngPL8RlpyNJpsdlZJErCT+heHwdNwmThJ5jmKPEDhSSCfs7lF/QX4RlW/02Hr49DXXSIGuoJRl@lists.infradead.org
X-Gm-Message-State: AOJu0YyAc27u5lpNeDrxoUrnyp1enngZm/awq6laeeLSnve/NsI7LjWb
	CBRkKhDwPRewG/HbumsWK0ikyBpLj/2g4voFq6/u3m1udLopV7sCClqSOzPAQHNNIZ3TU/elqNS
	R89Y=
X-Google-Smtp-Source: AGHT+IEDeF+Wj5cyoCVhRSF0C5y84+ToOKN38nwGUehJA5QZqpsqahOdauATyckQYVxiKmvLAf2skQ==
X-Received: by 2002:a05:6602:486:b0:83a:a82b:f861 with SMTP id ca18e2360f4ac-83b1c5f409bmr1752181339f.16.1730296186325;
        Wed, 30 Oct 2024 06:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc7278223esm2910818173.128.2024.10.30.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:49:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
References: <20241016201309.1090320-1-kbusch@meta.com>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-Id: <173029618536.13614.10643805204229304867.b4-ty@kernel.dk>
Date: Wed, 30 Oct 2024 07:49:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_064947_949430_36002200 
X-CRM114-Status: UNSURE (   7.41  )
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


On Wed, 16 Oct 2024 13:13:09 -0700, Keith Busch wrote:
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.
> 
> 

Applied, thanks!

[1/1] blk-integrity: remove seed for user mapped buffers
      commit: 133008e84b99e4f5f8cf3d8b768c995732df9406

Best regards,
-- 
Jens Axboe




