Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923F2C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=onJ0mUzCgIMwdFF6be/0q1xRUG
	IWm46hf+1N/2MGGj4+M63UpuwEF0VNrQcAC1hNMgASmaKR/b0Fm7hwhpIRXeopexwn+Ea9hQfOJre
	MuxsEitjw23nvz244Xki3t/1kU2eBExe5yRT4DuFA5IJyF/A46ucSogDcZ2REt4TjvapYnDrHBlZL
	hI3yiwwYaQXm/TNak/hk+YUsd1DxA+15kAke24m68zDPNCoBKnSTfv43bnR0JTy0S+sTT2/uQ0Mje
	eiv0Rm4BmzQPrmqx/Au4DaIy4BEO9RGNC9PDoCcmpXKs0YTC1ono/z9QyyJu1UKAmQDYLXaEyy/sT
	PJIcEEjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3BY-0000000FASi-3Yjq;
	Sun, 23 Aug 2026 08:04:08 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3BW-0000000FASL-1tSs
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:04:07 +0000
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so4092580a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787472244; x=1788077044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SdmtwihM3VZOiHW3pN5b8y9hO7pgtlqYufcuDUHWMQhzro3j1sVVRUYDCsWYvh1uLB
         PI9n8ZExkUDxwv8O8aBDPAByI2dwT6IU0NEK9geXIh8pxu/GBL3+fxokcJ4H/n6ZUP7y
         pEuMsx7j3S9qAjirkk+QgqVUo5i619sat29IMKo0AD/8E2VI+lXaRVWer07Ds28j6PmW
         1m85PuNQaLTQuaGR/sEzUd2O9em50L8avRi3m8O8Iqul/uzb5IFlCtU20m92zbECUBf2
         oouHI6gVt19SV/5SGC5tXszjKuZVC1Efh5Gr3OKp1u3a/CweP2uCUg5dpwcViiib6XDx
         V8GQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz4L2Ow3rscrVSrpsYdKE9D+6Y+ICvBEzszBq5DiVIGkvesc3cBhFn8b5sL0CpzhNvgyYHUXG8+7xY@lists.infradead.org
X-Gm-Message-State: AFuF++nt44WIPqgKyhSP0kOnk3VjREW1ch6QrP2HHQcc/Ucj/KFcGNRM
	OasdpWcOxRVIm3TPbTwef0yZOFcB3mlpyxdqfsOO/iTlibhyhmyEQ4y2
X-Gm-Gg: AR+sD11RSYg2gA/1nKPoZ63JC1UvocQaANZMR0VQ9fv22JzqKJwJ03V0j7yb0MY3Z50
	XnIuiJo7dtThKwB9AXu1N5jeqcesiEd0zgq0mNr/yTM75q17xhVYgRcWAB7qc36y9Oi5abmbWsp
	wHMhqXnJIKl5DCnQvA6oqUrZ9tje4YHE1wLGLuZwlY8QmHqx9+3Z7HKSUn5Hm4w6HWeMj2413VZ
	j9TjfQznwXBe+O/w5oCDFUvVldFR8dFKKA8Dmole9KV7PdBfQdTozlgzFmEMI+N5YPT94f0E4su
	gpr/0nSL2TF39KsmM8iVc8rkdhzExAuH17qKytAdMOX05Olu0Kr/O6PvrK3+LYQarYww+G1yf1A
	e2QeCXP1F9MTRtt5BkJZesmIDOZg3u38WmjZQtBgaJ85af6Jj2+Ce8aAluq4J94noCcTWZK60hE
	wpc1bDCAv2gCD6udh9bNfqYMVXiFmBw+lDZQGRlBqSR/LezRqmuHGrdo4Wb4C2L2G4odEGrf5Z0
	/LTrrOvzVGgOWQjIXtpwsESF/vDKQ==
X-Received: by 2002:a17:907:3c83:b0:c21:7584:fc58 with SMTP id a640c23a62f3a-c246a60cd41mr2001879566b.12.1787472243950;
        Sun, 23 Aug 2026 01:04:03 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm748737066b.46.2026.08.23.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 01:04:02 -0700 (PDT)
Message-ID: <647bf669-c03c-4bc1-945b-36b65cf00bf9@grimberg.me>
Date: Sun, 23 Aug 2026 11:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: return -EPROTO for a C2HData on a write
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, kbusch@kernel.org
Cc: hch@lst.de, axboe@kernel.dk, linux-nvme@lists.infradead.org
References: <20260823074616.1996509-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260823074616.1996509-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_010406_494528_C521565E 
X-CRM114-Status: UNSURE (   4.42  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

