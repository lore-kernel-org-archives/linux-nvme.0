Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F1606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=monOkC4F;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xciGgwMB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=; b=monOkC4FoH6xyC
	aijRJr3zXh+eivmTciQY5y82yTpdY4di/mC3jhvHsfgLliu/mv1d+GAPxFvC3xkNRoIPMO47D1zBT
	CsBJM3JA4b7ZGnQoIpw5xwvih0L8HejD7FYNpQ5gS4e7UbomdozZ7gF+EhuH9IkbFFJ9FbbEbsR/l
	tvQ4BuZzHCeHQaCGt5dCzbsT8ar3xO2AdrofEOm/FKoY+m6mUHTQAR0ktyPbOE4HQ1DtQrWc/8LGN
	SG7aiSD5j031DVB9kztzdTJQU3ZcjJ8Uc7PUluO/SN5GuPd7dvbF7WKUaopyKC0u6ObK4YGfd0BMT
	mPxu4SuQMhYu0SU0fC3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNqz-000000091vU-2WzU;
	Thu, 29 Oct 2026 10:59:29 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNqy-000000091v9-0In3
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 10:59:29 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a208d93758so20349785e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271566; x=1793876366; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=;
        b=xciGgwMBmLFkx2FqPHiAJxpsCU0xFfrH6BX3jmyzcIdzAKHrO0tjnK91PQF4GkUeyK
         AOqDj9k3qQfCjDBrJULV2HvevQxlZy4UHvyqrsdsWD4rbBRhf/aEECqM3D8PJiCC4til
         VBodbHyP6fSbKOrX21Ow883F+i95vC4zqaMjp5RG+ZX40P6epQigyerummP/0emam5GO
         /T4uS9fr3d/fLFk+9miYuCkDbm3ieSwP8GDVo4KlEtywfKsV/n403xTGtncV3UXwAAxS
         7/5VBAe1fhdCKSYzAj55VVTlti44/2fnfr8KXGV4InhTraaIMxflUMoRV07LbzpjzTdH
         /xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271566; x=1793876366;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=;
        b=vidbz5avas2cEr0GCbR6CL/CrWIrJQS7hKqzPS8fxoFYVpeCY7tCfDkoiKp8KFUn3Q
         KBEGKLbgCA0mdaj0IiVbktxeOv4GgrONk2UyyCw7IaKu6rXaCRXIgjmC9nhp5wIVW0E2
         Rf/cJHmJ8zccUDJgZBKBYBtcJcRP4O1Sal6snzMRCYJ6MdBSqDjvKlXIInqan+Z1CKoj
         88PXNm3PYitWqObkimyrdYE1n4fxn8ypueWEWqN0l0xsIha1BMGDs+Wa01giJaMri1Xv
         EadLRpAfi2URWEyT5EIlFRqX0aR/JuLhpL0IAzIOaUiE9atcVNHTTgTFWKRi/uUIe2AI
         OLZw==
X-Forwarded-Encrypted: i=1; AKwUvBxxJWA3ydwFabxjGFRGWApsXm/qHs4EW9z72Be22hAHGlb5L25DLHo0hVPvgi8gdClOdVaWyRB2Gs4g@lists.infradead.org
X-Gm-Message-State: AFq9FYKVcoJDcntmMqCUpyzyWeoIBD6pTNdkj9kaStrVCOfbSiZR1SAl
	CVIYDpm9pMvk40FQTLsvBjEC4tleyHIV3y5b6vtuFEy4r8enQORhktK5
X-Gm-Gg: AYBFou2MB4B94ZGsqrDm9XrbZ/fNw02TqTmx9jhzJwES90BDAxF2JMmBr9XSjF1rslq
	oc5JnEXMxYmt6I7NIsN1FcagZWIo6xQhWLhHJ/kcS3cU6HT6O+zRnuO+pkqfEK5bF/uHbEYrQY+
	Uo31QYQpyxJaqxPCxuve2KCzidd+O/WWA6+mJZpOUoXl/qbM3oN68anLf1zi2HGfpepmYVZyn8n
	M6NBkJhKNGH3QUG6aD6zWODQJPcvyOmqnJwESrL2oqgTYu4I6JRmjtfQhiH5dcQa7nA0FQdUI6D
	JD0RFHLuHkAf7tFJC56Z1DyeTu4alP8dbg6JDdZqev1FL2Y+2AeYGGXoPn4beW9JuNqg6t1aRPo
	WXkStVKQVps0SoJKdOmaCYVw6ISSi6O7UJcnjM9ISsV51iqI11EjqJVWypOBWUCXlg8zgnVxmyp
	ii5c7lBzP4PdoZ8b1egayxHfBYO5bJ9pEqlkI2gkSij66YnE1cC9P028sh9JiXi/8hI1Bl6/o9F
	ofKaLBk3GimImw3gK/nwiHDAzpOehRdq8IBQrBLLis0V3I8dPaABvWy7rJhnhkvJnzijsbP9UY3
	V+vUP80xAVQwZFYUsIQIoqrKeAk4qmqSD+MDSdU0u/UcfhqMdqyMvLxu5IZlKc/6meq5IYbOr1i
	ikmTyUvBywhk4TMvbiWPvOcqaa1MsQi+DUQz/uCxpYjZaFFnhtzwWJh9E08bCS8OZu21BhTsV9W
	OTqQ==
X-Received: by 2002:a05:600c:4f89:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4a966c41836mr125002085e9.19.1793271565710;
        Thu, 29 Oct 2026 03:59:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee575e2sm58301065e9.1.2026.10.29.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:59:25 -0700 (PDT)
Message-ID: <c4acc3b3-be8c-49c6-b1ec-b25431d28d8d@gmail.com>
Date: Thu, 29 Oct 2026 10:59:26 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring/uring_cmd: support dma-buf registered
 buffers
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-4-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-4-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_035928_121354_A15CDE1A 
X-CRM114-Status: GOOD (  10.10  )
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
> Let callers of io_uring_cmd_import_fixed() opt in to dma-buf registered
> buffers with IO_URING_CMD_IMPORT_DMABUF, and attach the current map on
> import.
> 
> The map has to be dropped at hardware completion rather than from
> task_work. Add io_uring_cmd_hw_done() for drivers to call from end_io,
> which drops the map and queues task_work, and warn if task_work is
> queued with a map still attached.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


