Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0175606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jFc8CPah;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRsR3Fup
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=; b=jFc8CPaht48Fh/
	ecjuLWtefOpO5oJb5E8hxVnZ8ksMNJqQ8bVUPat5W5y5PHFgTITNI1SLY99B95pf2SjylCi7ZpodO
	4XkmKIiIJG/eQRywUbo2LdCVfVol0WJYbjHvE5hYv48abX3JDKpgLM1ZOWFMyAZIUeRZNSTkTaI14
	TdXoR3qH06gdpyl59hQmZqaOqWu+dqMXeuyBGGgUn9XYquMDqvYLpKzJRbyzENDIEbPPv2uUNYQlR
	no4oAWYu1n6nEV1mavUOhBuEAmMYnFfL/yuSY8x9+ogbS8xPBJi6h7N+xuFSxX+rtMLFgmCo6QOto
	I9wehwNQdeSvdCFUAbgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNZH-0000000902l-0IHt;
	Thu, 29 Oct 2026 10:41:11 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNZE-0000000902H-0AjO
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 10:41:09 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1444243f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270465; x=1793875265; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=;
        b=fRsR3Fupa1noVYlVTiNvfWbe6EFvCJM63tEvheP9wwtKlEpXSahKXOqOJE69ctLn9t
         iv8i4gF9t9/B+T1W00VGjT+y8ln5nLVf7paTbxm+iFLy5VoA1q/AAGfD8fwnrsMhKgb/
         iOR40A6ZBAlZ+1PJ2U0OgAUmRIojeWhigGmHb2lHaupni20W8/PNMHPHuS8OzNyWMo2R
         IudKHuCNGT1q9PtkE0TwODAkNIuCUxjRnQ/Uy2Otp8be9ttGjGt+9uSikrWrXF1wKvzv
         VlC8Mk1wiOHSrvKLuLIQDHQIwaBB8gCsHwSSniIYlfXnvlrfPjmn3bjkCAzHzM7fy+7b
         PQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270465; x=1793875265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=;
        b=0snmZobUj9R4ucwf3hgSSzuMg2zTsbkfw/42TBmzNOH9SQIfx60NETshAkNSs+4AIb
         oTiuco0PdgwZVhVLhjDl/qzD5Y+XeJeDjLJ6K/RIUF9mSs0ptQ3au4Zw5hBoarD1XesE
         OUfNU91bonqK+55xQbz8YdUPnyJUF7sqfNnrYOMbCGg6ybeOxFheQmOWRQRJJ2fv1dgw
         JALhxpuF/udWei/M/dLOxHkg6NNUpA5r7Iu0oRE/SgxsmR9Zr3TgYEZDhwGwVAxCTEWb
         vBXoWhjMRA/wnldw+C6XndAkCORhTEmZC8/xYFYw7+YypQsBZym1c8nfmK09sNFMzdlw
         x/Wg==
X-Forwarded-Encrypted: i=1; AKwUvBy/IscragNzx3dKFVIfF8mqr32DWxSSmp1Qy8ZCZFEQGwxgVqXGwiJzVqYG3J+wHcOEYwRuLnbC/GOm@lists.infradead.org
X-Gm-Message-State: AFq9FYIaZQR0sZ5xAz5nrB6HOfBdOOAsiIvm/5GhqQhYOLd39FnN+mIs
	VPfw8Pm6gkS+9zDV/uuYSIK1W+I0n3XRSFoENroyk7nWPTskvwDxxR6+
X-Gm-Gg: AYBFou3yjcTt5cFF96uYo0/oOmOQONUa5suyG7uBSbQ9zlixZHGlC8foCWmWQgkdLMi
	bJDywvo7wYEcwj0NVN7jSSxmetQ4s+XPfRQDqWyBxVnHJDCSAoqedxN6TrCppxHlcCrWUStQm5K
	/5Rcs2kKr3BTpatsTNXCTxamOgwPm2vGcVaH+KKMoggBxKIwvaokspr8U1Yf5IIePZBcdeVMA20
	HTiSuv1EZrl9CchSYHv5HSh0KezJHgernxd2s/lHvdbjVPD1/Ka2n0A0g19d7S9DOBRxiDehZW+
	/i17tWage8LEXyGUOn27gsPajsWOQiabpxD7Qbbdrsd9LjDqnrpmRGRtAFYmDn6rxthPrhQNo84
	5bwtcFHjAySxxYK/RYpMEVvsa3KTmg4xPE/xEz1a5jOQpSXiH7fI6R9R191D+IIp4UiN0Jefu+q
	9h58RMkPtlL/50xvGw5IXjjCEUBJo2YXkLR5qhQhvcbH9P/xoErNys2fSRGJnEaHG05KIsZEdZ4
	RwmMNko5f1ys4yhvy+HfzSpn+c8MW5qp2H6uR/yqqDQ8u+SQXQh11AEnS7dXwOi/oE5Ai6zg/Ba
	9Y3MRK+78RzPqCWsJEvOQB6ipJ82wdKcj+ERbN1C4B4LNbRAvJFj4qeFyZT9FPCVdY6UPuo1kPI
	eDlXLdFfFCGAj8AwLUSRKCf2xReU2JNpSwi1IZC7iM2GpvhIzzdGJ5wU8+mZxMFc332w6Vo3DRE
	aaCg==
X-Received: by 2002:a05:6000:29d6:b0:48c:5304:5e50 with SMTP id ffacd0b85a97d-48e5d331691mr7785077f8f.0.1793270465337;
        Thu, 29 Oct 2026 03:41:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48fasm33467703f8f.31.2026.10.29.03.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:41:04 -0700 (PDT)
Message-ID: <a0a9ca65-a28d-4361-9813-99b584b9148f@gmail.com>
Date: Thu, 29 Oct 2026 10:41:06 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] io_uring/rsrc: pass import flags to
 io_import_reg_buf()
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-2-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-2-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_034108_096266_A632FCC4 
X-CRM114-Status: UNSURE (   6.81  )
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
> Give io_import_reg_buf() the import flags argument and drop the
> __io_import_reg_buf() variant, which only existed to pass them.
> 
> No functional change.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


