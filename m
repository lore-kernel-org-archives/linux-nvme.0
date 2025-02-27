Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D277C282C5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hw6wJjdWo9Wiej484setvR6DkQWMZWwSNxLdWQ1MFf0=; b=lsLJkkeCVO9ZvUJycRlY7fxwAl
	UYZV8aVExKLXEPYJJyPv2m9Tfe8i8dqLjm3qHZMmMgX/AoEv2CU5DEcNZPbc5lY5QfuhN8k16EG1d
	6JcqddoWtyn5CdUU9oirWOFm5ufB70HMsQzB9Z4a0mm1wt3pKpBT9ZYv3Cq7D3jDtsHtr04XBpLnI
	zm9s5jf2Q/hGVS/ULE/5NMUkkASxez/N2SwWoSesk0zXelZJ0omRQWg8gwyWqxM0YCm0YbsaO3+yx
	8czl4dhQrdhiLL+Z/naplid/jzqQzxdV1xqFzQJh0HUmCsED1aHTjQJma5KIZxO9R3c/26rONrHLw
	/DzYAW3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjiy-00000008XFE-3b0Y;
	Thu, 27 Feb 2025 19:39:12 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tngCf-00000007y6Q-2UY2
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 15:53:38 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-abba1b74586so158266766b.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671615; x=1741276415; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hw6wJjdWo9Wiej484setvR6DkQWMZWwSNxLdWQ1MFf0=;
        b=hbqmaOvB8Yp+5D497PYdnxl3ZsnH1z/dUZnlH9NdCmC/fur+7gSEIKWnruvNOo3Gw3
         FduXizN7489g67/48Ntlspao+uyHv3tuhxityv9qjRffDtZHfOCe2jGSMB2JE2bfHVrX
         1e/DKwDOdpgRMHqRUyASUAWJ8JPOP7TwgQa35vvKAnGGXSjdYE1GSs6x8pKeXfhXQuwl
         /+lLybDtj12G27n2yg83LyDFFK77Dm/i+m7FreOcwNAEJ0NEI7ZtuuQiJjcqeL15e+6a
         Zu46JXwwAgE1cBYIRGXyulYFkQarE6ewRUiRtFIu2p0vfmsXr2BTPlUDBDzsr2rul6K3
         /H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671615; x=1741276415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw6wJjdWo9Wiej484setvR6DkQWMZWwSNxLdWQ1MFf0=;
        b=od/ybN2JT66qQAgAdh+tKqXhGyB9zRsybZ843QEWI5LbCi258N+qBjj1E2sNfjkEDm
         XQd9C8ycMOHXS8D2SJxTdroiJ6kzkqPEi7LmGpiWcpewQUH/I7SR3VKvmqLcmDRaQE9x
         01sGZWSX9mTyqrNED0sqdCDrH8/XS1Bt3KKyrNr/FxzNMTcrbliqIcd899S4z9bJiz7B
         r6LTbAkba5HxGoRUCvteWE5OEjGOE0xFtsp3nKPxlGLae70Hq/tHhvcwAhKs7JyAibws
         B4OycMFsE5wItGYl8+frS4tDQVC3z7htotOWxwYrgqOZkad9/8kVfuV6hQ4ISoF5Pfsz
         DKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWE6qaEuDc3iE4piRQF/CJFnd+Lt1FwttcrrGu2zzlimpemr1FrTeoVV8Ft0BgqY8kvHs3KKo/pIe@lists.infradead.org
X-Gm-Message-State: AOJu0YyiesNEO88p7Ijqwg3hoEAJIk2INxehJ8KT59a8M9piV/P+vciU
	5sPsJb3nm5Jwj4H+uFOWQNVH/+iTgdAZbgP5Lw2S4SYSVIm09u3q
X-Gm-Gg: ASbGncv+0Xk8AGbkjzgsUtsVQnPuEL8VxmReEnB1NYZa6DGL8YV8yp58VJ2Pyk88eIS
	vcJplL4dfGP+LbCPFE7Rt3nCqJ9GywcromtqxZPO6bhdFKdKFz2+v26+8NWaP1ZqC5uNgrHAW7D
	mNNjELuGGgxMxEHuQgBHSIuQ3C2/LU3+gnTQd+7X1AMl5VQ82q0kRPSGsU6NvPlHuqr9tMSHRVa
	8lz4WzBSdjWSoi4erNuVkWotaQ2u5EjW0okIv0/8MZOX2E1tsEhAfyBmhHxWp6EyWhAbLyRX2Fq
	Xh/nSh8y16k3XcNzQAExOqYrTKY+McTZ0aDOjjRadSZ+xn2MzgykXkGZwGY=
X-Google-Smtp-Source: AGHT+IF2NiaSjB15duG/MSduEve6ftOKjyFFg8HbNOjOGeFn8DcHTxCu0iO3xhPOLmOyRIiS0FP7Ug==
X-Received: by 2002:a17:907:2d25:b0:abb:b0c0:5b6b with SMTP id a640c23a62f3a-abed0c7a055mr1542926366b.7.1740671614964;
        Thu, 27 Feb 2025 07:53:34 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7c18a3sm139766066b.185.2025.02.27.07.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 07:53:34 -0800 (PST)
Message-ID: <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
Date: Thu, 27 Feb 2025 15:54:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, axboe@kernel.dk,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250226182102.2631321-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_075337_633639_3C4799EA 
X-CRM114-Status: UNSURE (   8.29  )
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

On 2/26/25 18:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.

Can you also fail rw.c:loop_rw_iter()? Something like:

loop_rw_iter() {
	if ((req->flags & REQ_F_BUF_NODE) &&
	    req->buf_node->buf->release)
		return -EFAULT;
}

-- 
Pavel Begunkov


