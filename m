Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A92CD4F21
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=W7ocx9ePAFIpbTqx2Wp+gk7/vx
	+l9xoNNjwiP++Kj6ub/4ky7qZVfqDxd89vd5TgXVy+nnAR9LL5meCDeFnDH4ptaRWl/JzreZ5E++Y
	wKXHijUe0KXXKf48WRNl+tI6ZWlUr2kSlWNyrv05GAfJxQjjViezC66vdBk/5oHklEEXntFjwUojK
	7T2bcp/8a6wafLjpoyCN8ufB9mE48+g/ijmgpkVelMjER+fGZRu9f1R0EGxu9s+NQWWVoN3GgqH9/
	PDzQ5667H8VF2My8wIQ6DIgfuwCXJSBU22374Ao4fEVk8IVj3Y6ozSczX/wo83GTCBkkbWT3cCIVl
	evHHgC6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNHSD-00000003rTi-3dTs;
	Wed, 13 May 2026 21:49:21 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNHSB-00000003rTD-2bZz
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 21:49:20 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-90d1f03238bso194263985a.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 May 2026 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778708958; x=1779313758; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=GRKJxNayhIqKer5dZGsDW8acb5QTAuaGUckwuwT5bb8PLTPkBNgaBpRa/PrskMlPQK
         kj2axzi8jvB0i3J9KBEeNnOKk1szrFqyqeWUyTrbFScSwknUadQHqkBqIXnLJAcaxfcu
         ruqrCfFfBf81Px4GNdff7IWXBt6A1UKPazjumpwWdvW4FHCa9XfuQEyy+yX/dQPz9c5C
         7NQZ8lRKK9xp/haBWjHURQDgbYWbsLx4JHW5tYcSUsTpOEgX8zdkkqCwQXDAU7czdWQD
         p3SDB4L3gJh6BOyYvV8LuLTmS157nyAO49MfHlmHLBUrZahqSFqCCY7U+iYG83c9TpUj
         HEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708958; x=1779313758;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=ePRVTnTjcCLYhzKFReM+wxRjgmDtwYlMmjCZuz+9Y9RRL/hm9U8Jc5KZsASgMgZYXP
         K+zSM0q7V+ayKZBL5E8dYFzPLW+Jq//xRyAvMTJwqZwhA5b6VTJy8bVFYWi9bQrqB4/O
         9TXQtyzVCz2ctoXn7Vv2PEmIWE9vqXSGmsvHJDjC4hhgDUoz6BxSI2bMtzeE3VJQYSog
         V6xaRq0+jiKhxqbqOc5YfQOJF0GHGRuxx+0ilQkqU470HDhha8XBMMu936wWdcLNAj/5
         zdhE26w/RuezVX5orAFuKmivwaKo9ACCdEl5g/MebjykVuJw5SEZBvEYGSF3+Rnc7gKF
         5QHg==
X-Forwarded-Encrypted: i=1; AFNElJ+JO0G8mT6Ern7FmiB+U8DAq8ub+ffBjg3SVL9SRq8dPT3pAKl5VLxlFdgpLigxHNj69bKFHPof6RjV@lists.infradead.org
X-Gm-Message-State: AOJu0Ywuqpsj+yicFxMrF6Krs6T/q7whtUHvXJU9ioKAG75roB84YuZk
	wxnbzxypkcomlfnBrYXZXgdMKyo7AJqUQrSrV0Tk29QCD+XKg3jnfwAC
X-Gm-Gg: Acq92OHTgbNml2rAKvv91jMiQ21+5m3zGDYEOazkV+kDLs6DMcnqg/y8t+/B1i85KHu
	sNx8yfb8X2YS7CtpsZg2d+xqmdzQIjZ/iGUMOu0f6SOtlfUYQcQnU4p23pk6JtxOvXDpfVA8VAD
	hiWnjESjpTHS04uauzUSNFnGiH+xxhmnsjIXj4JkCSkD/FFUdWqjpn7A14sR1avydyGisTrqc+3
	JRFIzba9vs4OtQbx44r21AQ8lU43moDwT04IPhZ5/h5Yq1BoztJaYbI4iQzJHvB/u2mE6KUIKMp
	Kxu0jmwfHVsNHYo12LvmDyUeWcKCEmEVQExoucfTEMPHTZ+wcdVOAhMZ4OeQAQmkFrgv6QXmgZn
	Y7+gGVRg5caa25Hub1GsaBsQulHMsUHHdK8zkenpOuWI0gaelC7ZO8bPFKlMu7FsT6c13wtTuaM
	UnHI8IyR4nkos1noRA82kwy9mcVQn6Xf47kgCkaU8iFXu9QVK/5mXLb7AgOblb1br9By6J/8aOB
	fyPNv4=
X-Received: by 2002:a05:620a:4710:b0:90f:163b:d6f6 with SMTP id af79cd13be357-910b082c34fmr192894785a.24.1778708957969;
        Wed, 13 May 2026 14:49:17 -0700 (PDT)
Received: from [10.230.30.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910b785935bsm75287985a.0.2026.05.13.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 14:49:17 -0700 (PDT)
Message-ID: <33611e88-e4fb-4848-8569-c4a1f3040990@gmail.com>
Date: Wed, 13 May 2026 14:48:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue
 deletion in error path
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
References: <20260513192551.892309-1-emilne@redhat.com>
Content-Language: en-US
Cc: Johannes.Thumshirn@wdc.com, "paul.ely@broadcom.com"
 <paul.ely@broadcom.com>, james.smart@broadcom.com, justin.tee@broadcom.com
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260513192551.892309-1-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_144919_667893_2FCD00AB 
X-CRM114-Status: UNSURE (   4.62  )
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

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

