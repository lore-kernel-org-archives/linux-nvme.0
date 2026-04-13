Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AD0F34C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6iF1gBoZcAcV/lfF3y/wXgvYmtrARH6I95ZYJPhk+0=; b=H+iTbWKvcQkIpsL/pj7Nw1ftaV
	pKmquuDKvvBaterMAImHBsJiSvxH82ZHiCMhQ5ihNPK4vPOa+peVxSHjpxl5aDSt34EYi9dldZuMk
	zU+cvwVd2nUwAtBMBb765+bFpGSMw8Aa0ntL+/BQcoJPb75OnrA57pjOiA/R6B55OmG6y0TEXB42b
	02XBwo4Yt0h9YTMPGgRr7npdxzR3UAMS5CMR90FrPpkmEdlHiTymZWsDCh5Del3bM/w1Tvgfh2AcJ
	RVT1RtDCDjNeNSgsqzAPPuLfpTPPyPWNQqccUtr64Gn2OywAzcgOy277bJJyh9VO4TZ3MLRnoK++2
	/Uvq8rYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCJAv-0000000FxdW-1zWS;
	Mon, 13 Apr 2026 15:26:09 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCJAr-0000000Fxcc-44v8
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 15:26:07 +0000
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso2686418241.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Apr 2026 08:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776093963; cv=none;
        d=google.com; s=arc-20240605;
        b=ACx9z4FEiZDQc53If8+ZIKB3ro0avdqP+EOPn6p/ThErpDRRNP7gjWrSzRWqjIaTWh
         rub+AtBoXQDwcxvZs6sWshyftft8RcCtlCKTYbWZHD53ZyAVeRGpcyRzXwsmSwNXIiU5
         oox5sDZRqcc2q+0El+hS1Us8k65rhYn670n52b3kvbFLO5TktqqE9tXSEA3CYprpf3QC
         Azln7il3SRGKAJyYnpiLuaLApFErxF3MAzVsPiMPIUNTsn9nbI/2Ac4inFUYZodiLfaK
         LAlsyoKRMliTjqunxfcAepsj3LvtYnjVWebg9Et5VhHOri4zG/15mixdIhnRIRfcY5vm
         NMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j6iF1gBoZcAcV/lfF3y/wXgvYmtrARH6I95ZYJPhk+0=;
        fh=hNrk0oUOvIIwVvlXeeBlZHHnIcIWVsb2OVLEw04vcHg=;
        b=P+F6wM2c6LZD2ePqouc36GpypKt1xp1ufNEFs/Wc3o9ZpyCD+93b14q6camfrIi1fg
         rzJfmwTovPeOngxrwUwOekPatCUtX5+NUtr+knu8t5OIVuu2VDJlbtIJJKQBmbErlulH
         eEkWZ3kELIA96iOCy3WKu6hcanBfyoyx0055iCYi1hZgSiXU9YIhFU+CazuHjA6+5hFh
         iMw3K0HfuwNbSI0gE2V/ebF2rGv0kv3WJixu3qxU/xLHBEvhQ2BEgAtMYXydPtRI5wTC
         V4hDY72UCtv1Ej12WREugl3HBQZwUnncjB504zz7iCyV+pNHHVGYotuSHdbCFVzwJJxW
         9PKg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776093963; x=1776698763; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6iF1gBoZcAcV/lfF3y/wXgvYmtrARH6I95ZYJPhk+0=;
        b=PBEWDioExjorGoLcysteaZFYcokLkuAZshpSOY+ObIL/MyJ4whr+pl4lXY+CcCVRrp
         PEJUC3N6SH3eGzSxVkTbqbLIpOc286eMPcj3fYkDilruspmzSyjq2w1biruNAeiwj4oH
         +6AoMbDnvCNBVlhXjozrXBrDabJH8KvwZX55ujYTAa1TbDMPOF95o5HtQSddcZNQtfIH
         7nMbEZHXo5rggQ7gJ6AYuWPucXL1VGBc2Iz5Pbmdzo74anhc5Dsb67lb3GHp0quHaQsZ
         lJ0hQaf2dZct8fg9kOblZ92HJW90/rk/fdweJAZEGpcKun74wFfTA2ypkGsqS7H9A2Qi
         pXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093963; x=1776698763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6iF1gBoZcAcV/lfF3y/wXgvYmtrARH6I95ZYJPhk+0=;
        b=TaFgxvvmNSQ1XTv4FuVHTMZpKm3ybV0FAm+K83NdR14GDEBtqqeMRtremxhfrg1Gqr
         PgV65NNRbYx0EEcldN85IkvscF5axLkNrAu1a9ZPJNphZfgZBqVal47neqACMRSJ9/Nd
         MyYk4e6xOOsxJftSuwgMQYpr7IyPxHsCw9Km4oDJUR28uZbh9zr83CCy33iT8Lxn/Aof
         VbWfdhgMSRrpsbnprE2mV8DLRTpiuaYpXWDO4f7cpC2HdjjDAGLNxJTOumyrDYMFYqsH
         FJxkgeeyns0aORy/1GNQvFZ8UhCC5A6LBDQFb02kwpDBzq9ATk5UpOFYUEzG0Ib7C9l8
         Ge2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9fdsAZL0PENYkEfz4VkweWNk50vvwWi13vGkMfFVsMjfzkeggIXxyXvQ6KALM5X1hhjm4SSCQqyfjl@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7EIdqXmsDBYM+7b3qUc/1O7oIleHAdSUNm8tqM2Tp/7mP5QQI
	YpyUC2psKPawqWLO8CR2H73o25Bhw3A5BCz5KNOsGNGfpaWZ8u8Hzq4T1jj9CxToYM3txYVICgV
	ejR3krzu3NlZWXfT/qdLURYRoN6Txj6gmnGDG9SKtHg==
X-Gm-Gg: AeBDieuFCbg9H3Mb30eOPsGeA01UoYiJmatuWI/nGhyNJnCm7VOg/a2AUn/pVvRlhfK
	o1AKwRuIbYfeQPb44vNgIsTTsuvRGJKH97/W9KVTubCO1b8Ok7jTipUKTddIcuPMmZW0muMspKA
	+k9cUCavF3/9quqIBDen+k2v5yae3NI0Ck53i9hx/FNm6K8rNeBFJJzoK3+ZHugDicIwMw9k0cJ
	en0ROvYo+MHSw0pNS895MxkX2TrOLAtwYRlm7cPe9fAo83e5RPndUzTQj4ItIf47Vx2rOZ9/w5l
	MaH1IDAdzMlmOB6UIiCu/1QCD43/B/N+sz2vbdsjkpoLSuwnXqVykWmo6N3MajZ76g==
X-Received: by 2002:a05:6102:c0c:b0:608:9c0:4908 with SMTP id
 ada2fe7eead31-60a01271472mr5934088137.32.1776093962735; Mon, 13 Apr 2026
 08:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-9-mkhalfella@purestorage.com> <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
 <20260331164733.GC2861-mkhalfella@purestorage.com> <5d3fecf4-9101-4028-858d-bfbbccf3d8d3@suse.de>
 <20260407204653.GG2861-mkhalfella@purestorage.com>
In-Reply-To: <20260407204653.GG2861-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 13 Apr 2026 08:25:51 -0700
X-Gm-Features: AQROBzDd_fwTFb8TvDJJX0lsehJlK82UuZhw8-yBW5yz7MuuMIBLgs9lsl9TQvc
Message-ID: <CAPpK+O0HjHRJyNE72UCahi9Hs+Pv3v8BNmAXOfMcXgzYPYo+Vg@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_082606_056830_B2D2E645 
X-CRM114-Status: UNSURE (   8.64  )
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

> /*
>  * Source controller accepted CCR command but CCR operation
>  * timed out or failed. Retrying another path is not likely
>  * to succeed, return an error.
>  */
Please do not add "Retrying another path is not likely to succeed"
because it is not true.  We would need to check the retry flag to se
the verasity of that statement, and I would expect that check to be
added later.

Sincerely,
Randy Jennings

