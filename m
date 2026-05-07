Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A6CD3427
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDNwsbil9I9YOAU6ew3rrdgt3NIST1vZZLe5lfYiLbk=; b=34aj2uw7Evmea+20wx8mAxiseQ
	6PihHmDnKMyN4Sqqj2roE2jbqbm5Jk54vN9MtqVXOEJWpWyPPydmRQRsZL7J1oPDa8NqxDiVkMjhD
	Id5AawnGjanhtueJ/fVzU89hLPCcn6a+mHZkYo8tIrmkc1Tpy4WBPrlnITb3T/3jEQbaUMdA1OPA1
	8xSxfO7YBP46SEBfPDX+mt850G65xIfbIn5ek8JykbtHPpH0B3ZYMAsRkJM86OiJhUmMhHqsZ2/9/
	oVHqQlq9rbr6Vt0kzKeKlIKipi/xmIeY/YgkZvYsO+PdpH/E0qM1ChRVclMaoMg1Xip2aPmZCytcx
	Uf34nt/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrRA-00000002pAv-2JsD;
	Thu, 07 May 2026 05:38:16 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrR8-00000002pAS-2pkN
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 05:38:14 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso3373985e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 22:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778132292; x=1778737092; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDNwsbil9I9YOAU6ew3rrdgt3NIST1vZZLe5lfYiLbk=;
        b=hujrHWGR3syNO52WyKCygtcOVuknfFgXvK1aExcrTybfPkmHI6Be73lvpyniViGdc2
         6CbLLN5SXPic1AUYM3xldx2qnxkdB9TNXWquX61D8PWtNG5DB+N9wru3Ic6xwd9VUtSv
         FNWUDDfY831Kmt5HZSECQZqm0t6fRZyCSjpfFryjCnI/dFQ3PjD7AstvNst576FdQIy0
         icqOHcv6SkiBmDKAOze4Y7OYEcVSO8n1AExT0t1+fRVjaqYamGC+5wbo9qtux4uzGwku
         Xn4zPFmmYg3wkty5xeesTd2yFo0b9LVKLNX5lKkw73YFrzn3Ods4pyESs5kbsbU9en/w
         tI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778132292; x=1778737092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDNwsbil9I9YOAU6ew3rrdgt3NIST1vZZLe5lfYiLbk=;
        b=k/4McO1/uLY/aae5jOzLKFpCvwYXbcci9Ry2haVK44hY1SC+Cc2P+fdeKJ/HooPk4W
         kYsRTEe9X+5wcfCxMAmRuBw+axx0XyMGiM8krqcqW+LuZHndtHBkLjtBAgGsTVmOFsxR
         mEfLz9gStH4Kz822Ht6YSP7iIZoJYjC8uK9aGc2cBRn/gx2rHfWJ3j6QjlsHcXKW0szu
         2OtfSPkznGpW3mwUyMagenr3M1hUEVMLQ2+O4TzZxQdhn+Umj9siHrkq1/5FNtByf+e7
         LzmSKRzyMn57Kb1Mlg7OgnBwHC4b+nPv4lI7g2ZNArn6Bmzn9kJNlOaoAPAWkKy9oHzU
         ed6g==
X-Forwarded-Encrypted: i=1; AFNElJ9xvJOH1+tyY/RwQCVDu6ttzWwSFMT3dxYYtSi83TyBqHuxKuf2TAbc8AUOVvq9Wu1GiEKeY4z3fJCj@lists.infradead.org
X-Gm-Message-State: AOJu0YwDw1ifkLHl/C5Dc4OJdmJaa3X40kp++EEAmbqP2UCbpqiOTD6Y
	fypDKdqXMPJnjLepwWDOfQuC3rRCSmRF3gv2AiJmVqDjZmAmfpr1G6YwtKyfX3Hjykc=
X-Gm-Gg: AeBDieufW4rDY/8XV5u1+OvCy5WLwSm+2TCzhuamURWBcBBmqPuQyHsBvTgVvlDnEEo
	xLVsf3bCoDWAgbDoBnn2HO/mfNQbXoVVgb34a48WacjLyKPyf9BKTslyumOwFiDXS03Jcw/RXAp
	N9ephmXzG6yQdJfdtDDVSF53GzMO2X9elIF2AtycjAO3d+yDivo/axpQCJ8T2N3SJ7lZ0XE3pV2
	UMRquyKyXjjfmUuBThRp9ZgP34n14HoYPOSObvghKqdlnwkGZc+IVOOpd68UaRsVZ7NOodjpE8A
	tF90eeh4Pxt7VSyfcsVTuOTUlKW6xDsMlOIId3w9P7mOGZhHDnddEGUObZ60Ju7VXT6nG+UK+hc
	agvQvW77W8+JhrLRMheImSs2g67jQ+TmmYvjtKgxsjoNPujMlpQMkzTWnJuLYubVnxQJu8OXX7f
	LrLCslU1zKgvmVG0cfkwHxY6WyPO1rrFu0DoOkf7LqPPtbev+kirRuY2g3xA9yKPZTOG1Ik60hy
	hzLLBIFl8t5KAllhKRo4J+9Z/g=
X-Received: by 2002:a05:600c:3f0b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e51f37fb8mr123683985e9.20.1778132292022;
        Wed, 06 May 2026 22:38:12 -0700 (PDT)
Received: from [172.19.1.192] (213-209-180-188.ip.skylogicnet.com. [213.209.180.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5314b989sm32434385e9.30.2026.05.06.22.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 22:38:11 -0700 (PDT)
Message-ID: <478d5d24-864d-4c8a-8df2-7d958bdeb1d8@kernel.dk>
Date: Wed, 6 May 2026 23:37:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make prp passthrough usage less scary
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: me@alancui.cc, Keith Busch <kbusch@kernel.org>
References: <20260506131839.2364791-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260506131839.2364791-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_223814_727825_41B9D852 
X-CRM114-Status: UNSURE (   8.78  )
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

On 5/6/26 7:18 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The warning is a bit alarming, and it only prints for the very first
> non-sgl capable device that receives a passthrough command. Just log an
> informational message on initial discovery for every device.

Looks good to me, just ran some testing and hit this too. Neither
are super clear, but hey, this is an improvement:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


