Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FDF606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VXZDtQ9w;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhCRCbmQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=; b=VXZDtQ9wNGFBpC
	Na4iSV5ZXDBxg6HNmhJM/vtMKpcADw8VtpRAKUS+gaVhIjeGMoYoBmReNdfhY4I2UoQV3I04p4F1Q
	ua6NvWN/Q5LPF57mVYuX84hTN4zwEiLuOiBru28UrZmLv3ZNPbsZaEUgnTFbJHS82ZPC0eIFVbpSH
	2rN+4kmebIgJyfz0m9IC6SrFNHiYOgJEPYES+S87t6O9Wt8+cVxBiorIh7HaLtWRqyFaREC74T1ZS
	ZCOzncga6FGcwDc16HLR55g1qzMa6Nf175Y7qHnpgbZPZo9+oP9NvKl1/9DaK5MbKi4wuODyCHhXd
	pJ3jUPY4xRKkyHEzK/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNbj-000000090L5-3E8t;
	Thu, 29 Oct 2026 10:43:43 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNbh-000000090KK-1NWm
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 10:43:42 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so23428545e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270619; x=1793875419; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=;
        b=jhCRCbmQX/GnIjpDTzVicMY1PRFEzSAyNRmsnRap72qEnzZ7M3/nPRvBU0Sq/IDhEZ
         bGWtmYc3PdXj6j7mvaJNJc1bmj6aL39yfRgDVmNnMM1tLKD0u1PooLwNW02xCht+dpiw
         YRE8FKfR4nRZUDd7+iQBU76bZMEvQ/EdiBRTtg9GASPBk+YmJAXz0pyf+IEHO6QovtdC
         +vwok5ABQjTbw7Iz0MJRL6RjfsbMi+pG0Mr69jza9QqnuF5f01VfpvlR6N6NcaGAKY73
         T0aXYc33PDoPCoYhR0YLgpERWkeBB+Xi24t/6b8Z11AWOYaztwwMRYn+5t9b7slAegPp
         FEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270619; x=1793875419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=;
        b=B2RQPNS0L+WcP//2VRbEShETvzWdcu4IAKd5sG9uGEWxFcgaqmDyZ03GcwIabnPp6o
         nStkC4xOQQl5h5eLALAaw+joSJOdQVuXLuzhhqLhwwvjgicmwyD+7QkjcJ+UfuLUojjM
         3sOaTLWizuG7fwHeiphHeWAFlzhn4TfGAiuObQeXUlqkmLLOIwWkIE1KH2vX7EH608m2
         NDqhEjCwLZKrnXrFiIK9ODq8Wy1nNbEESECpZuq+YXLtULstGnXfqCnqFrklN0OxGlGW
         h618xVCdacLrB3vwbgQ17iOizQgLcmsmEknVJlQ15VgvSw5Oz1wi7cZtA7yjwjaJiwlF
         OXdA==
X-Forwarded-Encrypted: i=1; AKwUvBygxDiAzGDPS9nrhtwz2sfsFX2aFqfyURe+JggeEMa8AcyuBWrJH+5DE4sALdf8PQw2tDr9hsnfchaw@lists.infradead.org
X-Gm-Message-State: AFq9FYJwWu67LmaqyGjJUHsYpm/cqJ5dz49RTOgA9vTF8hZijhlBo/FS
	zecrJJO3jqkW/CzNaDnwvLreJ1yzgVRvl7pcmruygYczqttylTpcM25t
X-Gm-Gg: AYBFou0Vv2iFyCYSAFUZPdxgstmX3UuSXbJ5ba4LkO7xMiicvHl2HMxYbJ416VeWptu
	yQzLRRxeCeR/i7Lm7uErOfNVsE0yRbYBfV4j6vGbOdortOMiRJVwpbT4cqYbbQcJrGsipbPW9n4
	dnyB0fpN0fxlMemAFfkTIBIX84cnyONGcvZWzuQ7un/oLsAiLGo2H1PcrmT8KV2hIavf7NAIdwZ
	11oaxjp7vW/vOhGKW+w/K/zb4eBe2xyOQ9RP/wa36z6MGU6gLUew02nVFMuS5IcKz3nRl0/x2lj
	XeTVusdWTKAEK9I0L4YbXdCN1DS7VDNWChtPJgBzmv050SPDHt+Jq0yIgjx/YpkPeNLCdsEwJLJ
	/xAjb8Dp8kUAwwYJKERacEoT5+wU7M63VxntgfuIdAyQmIvl5xwtL3SJMQ099dI2STmPaEB2e8H
	8k5VqYA4mgWgIujHxim/y4c5dUBLTJMDV8LDm6zEwRQCn0aWTAq7rYCNH2EpGIwCMV0fFzZtTj9
	ViRNbrM9C2lD+6thMwVVXHSf3NwXWkgN3fJ8+7G9eTlXytsO/xanE32DCcuom9Jo6L7AVA+KnmS
	pSdJiNDCKaaQx1ubTc9THqp2kF8nL/5wm/sMeC0tkqjmS/xQtWGI6AFk5gQYe7hpfTrj2mchPBQ
	GI3bg0lMXOSuxaz3Jwqmn6ZPQVFWDeT3w+GD1TlqX0R+64UPEpSoUPNvM8iL4bTj0b2dnJcHkBG
	6FDQ==
X-Received: by 2002:a05:600c:34cc:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a963ffc267mr124682955e9.2.1793270618838;
        Thu, 29 Oct 2026 03:43:38 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f629d5fsm47165475e9.3.2026.10.29.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:43:38 -0700 (PDT)
Message-ID: <e6b98a2e-a9da-406e-8969-3eb73b6d71b5@gmail.com>
Date: Thu, 29 Oct 2026 10:43:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] io_uring/uring_cmd: add import flags to
 io_uring_cmd_import_fixed()
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-3-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-3-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_034341_375200_5919679D 
X-CRM114-Status: UNSURE (   6.64  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Add an import flags argument to io_uring_cmd_import_fixed(), so callers
> can opt in to buffer types they support. No flags are defined yet, and
> all callers pass 0.
> 
> No functional change.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


