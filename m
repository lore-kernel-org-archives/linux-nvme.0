Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0B606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=svndqFrt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jbMZ2+GO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=; b=svndqFrtg8bD9U
	4MafO8QBPVsga+WFBZqgR5MvP/d/DMgKYYpsmpjDANIFT86pqiFaQZ5AhYOWR+V/BQzEZ4bfIsZbv
	Lrvu4vibeMawKW4+ydL974CqCRkz2omYZCf2as8I5Eq66Ue8F/oKV0ux8y0c9SuQUWJqUE5E3s2u+
	2f/AQ8bPz/kG8cQLk6MxElVrsHpAzn6ItFShlZJY9mz6FSwVA5WoxRNfPw8dWqFQgiCEVxWO6k2rs
	UOVFqt5/CER94ZLcqYPUJ6xNZCAa7yElo9ap3fxay+eRhsk/XPleoW8+vLpJr7vm2CuWsbr1+EVIv
	ZoIPBS1mAmS00WCrW9OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIpl-00000002Mud-0OU1;
	Mon, 26 Oct 2026 11:25:45 +0000
Received: from mail-yx2-x07.google.com ([2607:f8b0:4864:41::7])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIpi-00000002MuG-3Gmv
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 11:25:43 +0000
Received: by mail-yx2-x07.google.com with SMTP id 00721157ae682-8a72cead747so6821507b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013941; x=1793618741; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=;
        b=jbMZ2+GOhwjzVAL054WTh41PevL+gJfu/yoIV/IJdT3dn6pfshP0jmwW9OOFqvDLgJ
         KzPW0FZavgHdSddub5Eiw5S/YlADcRjSpCVMtaFhVNAg8UsrLQkAGftdPmgbNvJBAogP
         SgfvTFKm9et5xiWqnDyDFE2DMO4L+gbYY/au9i6EZ2V36tJx/IiOvK77Rl53KewkIv4g
         685qc+eFsKzx1B+YNy5+fWB/wDR7bsjfQO7wdTSh6VzjmgFQXplWGniJQnhbOSrotMpq
         t826PKzwdzTwb/B5fVMN7uUkHMeX+kdsC2QihorJe4RR1LhbqqTPviQog+idpSOnwUAu
         1/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013941; x=1793618741;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=;
        b=dd7atRZz518Oo52/AX7xFQuw0/eeFZOVmPZqd6KzifRTER+M1JqEbqSa8C31HbG/L/
         HNLpIvj41okrgeShVfJxH7Z3rxUo04f4rhn9RbGBpZf2/JIZc5hN/M8Z00ZlgW9EvpBM
         X8ot2dBv2zffBddNI6sQCDu6E/WbIZxMtV11mov/cH1coiUTsDHdbG+7CWt7k/pdF62j
         gsfglRn2/+512QD7bDoGSQJkCuegoM50np/5amYM7ZDRAa5yhlnf4px5vUCK/kY5AIyK
         kKpf/Y0elrkqON6HjUX3RvLoIZFVr0bv62T7Os2tpdiJrIzGC1NO39Nyz2aB4LVDAOum
         yr/A==
X-Forwarded-Encrypted: i=1; AKwUvBxbiSccsysxqh4H1z0mv3frPhL2LQ30rEAvnnNop7njdW55KC0DXonGAtgkzQowIJpcSTn1CmVYY+2/@lists.infradead.org
X-Gm-Message-State: AFq9FYJpUciwjhi9+6CjeILWj3ipeyYx5YmyGhUDuguN/YIK+MulAHaP
	vCTNFFa+dEuJ3oHtxbrx/dqprnOE82+u6ot1T0LX3B+odUSLmHl9EwTy
X-Gm-Gg: AYBFou2ipLo9Ay8CjIZBLb3gdBcR6UL2WScqsitbY6ydp7rMHQkE6ZTzCy6qTyZ6b9B
	cF8L2o7vSeOMWzJd/cyPDhncnodBL2LkkOzAFCti8uolEn/8s+QVL621IH1LfK6dTGo8ukw+3Dc
	PFPcDmSBnebO5zNwQFA5FVIfarNrzViQGg/BH0viqGjqi3GZXrQeMjLp4b8TeKBStzhlTGUoM+d
	36yXJxL51iXMHezX2XcvDlbRY7iOCpOslgVPjiolyWCPF6bU13C0DWBO6T6oJ9rDxtdstq8dpXS
	grIPhTMVwpu9/wiXOfy9XwEAVDvp8pVEAdRrxA/m5yexU/W+in0r6cvK3R5NqUX+gzVVist9i+R
	ppWS2lxfJLjHd+pvonKKfMIFK03OxQsZm4St7R71KAgjRh34mhvnIVzZM0TNgR4ea+3voPv3vfY
	Nvf205O6eRB7L+d4RCHgXdSciLQ5zHkJccIf4IOICi2rKSreJYMw5o8uj4vmBxWj55o64HFvDYo
	lpvzVVjXb4u8GzAwixaz6kkbJQUlKlmX2q9Ryc87fpKoJKIweAPkS8rHcZCQbx5
X-Received: by 2002:a05:690c:2788:b0:8b0:eab2:f502 with SMTP id 00721157ae682-8b166c93421mr38305577b3.61.1793013941439;
        Mon, 26 Oct 2026 04:25:41 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166c5d605sm29719597b3.5.2026.10.26.04.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:25:41 -0700 (PDT)
Message-ID: <c0c4dc10-8999-4c4b-977c-69beaae7bdcf@gmail.com>
Date: Mon, 26 Oct 2026 07:25:39 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/5] tls: add HKDF-Expand-Label for the TLS
 1.3 key schedule
To: Hannes Reinecke <hare@suse.de>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
 <20261025-keyupdate-rfc-v1-1-60b7756eccbd@gmail.com>
 <c75aa5d6-5037-4489-99e0-3e38528e10d0@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <c75aa5d6-5037-4489-99e0-3e38528e10d0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_042542_823929_F082AD0A 
X-CRM114-Status: GOOD (  14.95  )
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/26 03:27, Hannes Reinecke wrote:
> On 10/26/26 1:36 AM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> A TLS 1.3 KeyUpdate derives the next traffic secret, key and IV with
>> HKDF-Expand-Label (RFC 9846, section 7.2). Add the helper for the
>> kernel to do this itself.
>>
>> Only the part of the key schedule after the handshake is needed. The
>> input is a traffic secret, which is already a pseudorandom key, so
>> HKDF-Extract is not needed. Each output is at most Hash.length bytes,
>> so each derivation is a single HMAC with the library SHA-256 or SHA-384
>> functions.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   net/tls/Kconfig    |  2 ++
>>   net/tls/Makefile   |  2 +-
>>   net/tls/tls.h      |  2 ++
>>   net/tls/tls_hkdf.c | 82 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 87 insertions(+), 1 deletion(-)
>>
> And another HKDF implementation. Maybe it's time to split if off (again).
> But anyway.
>
Yes. crypto/hkdf.c went away again in 6d888db2cfd9 ("crypto: remove
HKDF library"), when fscrypt and nvme-auth moved to the HMAC library.
tls_hkdf.c follows that pattern. It needs only HKDF-Expand-Label, which
is one HMAC here. If a shared helper is wanted again, I would do it in
a separate series.

Thanks for the review.

Martin

> Reviewed-by: Hannes Reinecke <hare@kernel.org>
>
> Cheers,
>
> Hannes

