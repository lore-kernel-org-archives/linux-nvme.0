Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DBE64019
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=; b=ga8TZKSFtJriUz8UpyGyEYtDe5
	rl8iFeLm5AoqiKSMSS15lcsWlGq+a/cjamM+zOvdp0x9cVq0uK/KpgWbxPmNuyu2Phk4UiNZlcUTr
	dPzYsn2CyAnzOGuf/hVKmmzT8xOvuz9kkv/z8ZVsGDt9bbE7ZOFrcQ4MjysDL9NXAp9vKI4z0JgxN
	lNSGZMD88gyWGTWzpsKGNW0b/yi2BYGDLOnbnAcyVnCf+JkI/zZL5QlzyHq8662uSyGg9VYrpqJg6
	hZA3gzUGjEuxNoku80q9nd28cWq7r8OSvAefT8qt2BoKDy/lDRFNJ9liT1K56tz+9UPtpS63mioYM
	6I8Oy0QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9Le7-000000049mE-13p9;
	Sun, 05 Apr 2026 11:28:03 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9Le4-000000049lD-3k47
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:28:01 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so4162117a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388479; cv=none;
        d=google.com; s=arc-20240605;
        b=F7yHSnvgz8pirwCchbaPT5o1DMLt/cLaHTvCZj50bEie1jilUA14zqoGuRrGtCr02T
         njKUpGVP1T+ukFE5znmJBpCpIkez5m8np4JSX15nODKo9usVWzNm1GT3KLSHG3yNwFiC
         Z7Jxj69XpxVElpoCaDQ4MSM9mztiGU8wqQOfpvTp3edSLlfzy/e3xUho8TE+18gva+RR
         kqILUMhD336e3n47ZOKDstEBGvnWI2vDlpSEUx5bIO57a9NkjFhv7d3Rx97v/nf5giti
         6LgS741h/sWcdAELMHETlPCJd4jBEGErMXjIre0wA5OMUZf3jrbAyyCHyKV/ppDdTEzL
         N5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=Z0QinsNViRstgBqFUPoRim0aBXmS1Ivk8Rl2Tkm8/cA=;
        b=Rmpky03/FX1hfu9N6YJJOVjfhEC4cEHLVxJTR3R3nSb1jHTtuiXwsn4mXCYZs7+H70
         LJZRAufq8JjC91jbCN2ZHw1sSxjVQIbxwp7vvd+cbkNHCe87/QNQuQBNMyegdHfj8ZFt
         936UmZ/O7xA7ny91T0837zYJyemuvqQrQD4fumBaLuyt0Z1NtRpOwZ8luKBLyh0i2r6h
         CdS4Pky6OepgFX9jTu58fc+MGW0UbrM6iPaU1RdmFnS/Y8xZL3mYCSRltbuCoo7h6Vnh
         TnYNEHFk8Q0T3hzncIjlosHIjtkY1I/s+JxMiW/wIkefAvIaOuFyP8m6scztpsVnPAnd
         wlaw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388479; x=1775993279; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=jsfFXh2PQoz69vr98QtjE/xcSMvYnvEBZzIqWS9aE6ye/IexVQcdGKpdfnqW11OHHX
         B1Mdoj9mrm1dry8uqYsEHcp+hUvPWPJFzmRrhRTU5TpyL1meD9X/Tg5yfTmggeSl1bd7
         MWb2mzzdbrfpP/Kjs7mQkhvSbIyxm8dhSpx7BWrrXlTiSXmiK6PaUMjraQiEgH713A6Z
         BRHiz4tNQlwZcAYfYnzLitp3K4no+iowMScRG6sxBjkCrmw/d5qS5fV07lbDJhivBYM8
         Aq99wyDIog4mFOmltUuGLYPClPPLhuL1TcVXb4Le+O0JMjII7MukuZhiZWLZt6G3Rk4J
         xt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388479; x=1775993279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=TnPkZ4c+FVpC+bgMceTZvG/M99oqkQWXUpGvoUt8YZMq7cQnkVxQdeT7GPRFP0WE/R
         YTNl4ACiDbZvXhQlX21osupe1j/UDDwTd/kyxUt1yMgUXhtobFJ27J07z/+kUYMuferq
         HSTzqo8tp9lZ0Dj9N16Y0QDurn9qnxJYkzsB1+R+u2ufy1Co4hhUd8cho6m6o6vsHZ+d
         pmb7xp4LXJhiU+pScrc+XBCRVKs5E2DGpn1cUfAejr4lEseQpvpR37fZZglnbKX2jnjy
         SPm3ot4vtG8TGqppmVUJLtllW6PDKYoGxRE15xTQjryJmkNtbD7GA880jSfS5I26DttP
         qI+w==
X-Forwarded-Encrypted: i=1; AJvYcCXHIot3kDUYaUPqsFncXJrT3vxKAEQWes9OzNfTRmurrjONQdkAWX8ICiIyrHOI6UCyOKPKY1p4HRCu@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0iu+bYj5/mLTLTp9M5aC7UFCn71M+Rg+SzbY2zdzaI6gLw0Ti
	3f75ic68K2rKnO7OaMPFQntupow4L9UtCG7kZkxaXONQo8+O73f7Rs8X4kBSCTxfq9iTZDInghP
	mq9EdTPsCbiYLB5PhziudDH1YkkIQJQ==
X-Gm-Gg: AeBDietiuvficBnbEkL0yXS4+nW1lesOoRd1d4kYebK8AlVsY0xx911RAx4vwuNj9qZ
	nNdFZ5vHBr10Z2JZt260o6s22mdZLGPdxW9aLdG9LOdSei4NdMq1vIEJ93u95iz9pcgze/zCGHX
	ur5Nh/1BN/8gyXq5fuZQtWBrSeqE9Q+kElLdez5dVWPjsQoP0KeJNYghc/qbFZe5JpK/IW1qrGg
	ljgqIkh+o9QUQNCqd/K9Vazy8H86W8yNmExWMN2Wpmk0g2ORP7Vhm6wPUc1GCTdfzuaMxZN/F0B
	+1DsEVrJuT+f1bz4n9yEyuf0RZASA97RQghFCGQir71ADIbErDVzSnIO4FPY5b9n1Oynnw==
X-Received: by 2002:a05:6402:1ed6:b0:66e:d57a:7023 with SMTP id
 4fb4d7f45d1cf-66ed57a708cmr577928a12.6.1775388478798; Sun, 05 Apr 2026
 04:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-2-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-2-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:57:19 +0530
X-Gm-Features: AQROBzCwSmUwg2hzQ9ILQEZ1j4iBp-ZNL42-_yQcEJYC_dnQvWOfGvOnI16w6Bs
Message-ID: <CACzX3Auxb=D1PabMdVng1N7G_7zmn5poknRR-k5r-iJU7aWrGA@mail.gmail.com>
Subject: Re: [PATCH 1/6] blk-integrity: take sector_t in bio_integrity_intervals()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_042800_939865_2ABB18DE 
X-CRM114-Status: UNSURE (   6.38  )
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

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

