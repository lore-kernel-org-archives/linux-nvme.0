Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD43C49EA6
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 00:48:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1713D6137D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 00:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1713D6137D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gqX8PPBqmCWGPSDXOS7tvp+SWUfBYffK/qvQDUzfAjE=; b=GD1n7VoH71MRj0zxFXSERVw2Gp
	QB5KtGK7r6UdI0kWtLrhjiMNxuFsswBisBkDvF+CAnzsk23uSGyL0Hxbr/+Cyf7/2XmHEBbwGEzzH
	wadCD5tCozQnbHYeyPyIcEDjz8PjwMnBopoWyMUfpLuoCCZShwKhWmFxHACzeBR+VUrLKgzDKnxdO
	cGsQFxyV26gZpKvzVpe7H9NtCp3a5ntcrX1SoY8fxdCvQ8NDnpm2OTxwiEETSXe5aIUBbtH9UNY6G
	+Bcl/KzzGN9bPHvg8/Lp9686oFb/F4vgx2CcY5Xdt1I3xb4Lu3rgBbEueyG/EkVYQIo0Dsa1OhLlX
	cg62x46w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwa0n-00GuzE-UR; Fri, 25 Jun 2021 00:48:01 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwa0l-00Guyj-MT
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 00:48:00 +0000
Received: by mail-io1-xd31.google.com with SMTP id s19so10603555ioc.3
 for <linux-nvme@lists.infradead.org>; Thu, 24 Jun 2021 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8nSJpWYHGCpkuNBOhQkSMR2oaoPzxAOpHnbMVy+0cK8=;
 b=P3alooKh/efB4RQG5GaJALO3lY9ThVgtLlrwm1wUUa9sxoaJjMGm1q5OR4IK1l/j2I
 rvNQbylzYx/oU9pNqkCTv68GhHmhJKYqwglwzPy55q/b+XmUlhKjN2CSq1OySvbhlSnV
 W/PuxSUrURMJPWwE7JqEaqhE7Vio1h1hI42BfJ7eQmLLUEzo1x31X7oeardi2s2oJF1n
 y6YeuQLY3yFm/bukZo562ue/ALj4MfIFxIaMbh8R42KUokh5LXfdLYC2fL5GZxuzK09n
 lCjKW5EYjWY7NudHpzUSRaxWY5QCynetbGaJ8QfPRRVIk81inNQqc5+z2lo4VAf9gxMj
 3dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8nSJpWYHGCpkuNBOhQkSMR2oaoPzxAOpHnbMVy+0cK8=;
 b=WPc2nLJ9FMX8dwBOwQKNSDF/4ZjIBrsS2HIsZAlAPZLc+8gmB1/NSVTR4uCoGoJq31
 DQ0SQqoPNApOMrujjNbgpL8L19/fxN2GUrVivx5phIxAkoEfRsmDktR1y7SxdNC03/o1
 +kq8u/k3wcPCuRJJ+PURtvtHUjuzC8m8Omg2m8eAajqPPwIVRVmYLiy9FVR+MkNYSVVt
 IQ/Pm55MWkxk2oBsWrZ28oe7ZutTE78EYNesa162/p6cab3YuEUEeq+NYut56MOZ1gE5
 EUnYwQVBcqhhHT2ytWDST56JW5r/uQaF7MgNlshfId8dNZOcoBopP4zhZCaNczOqlUKx
 5TfQ==
X-Gm-Message-State: AOAM533upqb3Gm3GzHteABDRWKuIP4hf4fqqBJXDgyEU0Km4KYcUsi4A
 hU+79n+Z7Yxcsd1+iDwfAqfidQ==
X-Google-Smtp-Source: ABdhPJxpcWjhp/ELSXOF9gQiJ26hj0rLvrj8oktAvPr07ek67h2zv74inkQ2etInABitPqQWi31raA==
X-Received: by 2002:a5d:8a07:: with SMTP id w7mr6338421iod.154.1624582078752; 
 Thu, 24 Jun 2021 17:47:58 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
 by smtp.gmail.com with ESMTPSA id m7sm2661303ild.49.2021.06.24.17.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 17:47:58 -0700 (PDT)
Subject: Re: [PATCHv4 0/4] block and nvme passthrough error handling
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
 <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f6df0d6d-9315-7a16-545e-9f752f65df00@kernel.dk>
Date: Thu, 24 Jun 2021 18:47:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_174759_782668_BA1B8425 
X-CRM114-Status: GOOD (  11.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/22/21 8:57 AM, Keith Busch wrote:
> Jens,
> 
> Do you have any thoughts on this series? I think it's good to go and
> have received reviews, and just want to check if you are okay to take
> this through block.

Looks fine to me, I have applied it for 5.14. Thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
