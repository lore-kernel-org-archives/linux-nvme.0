Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE86606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4UvO1Ca/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gio80mOp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=; b=4UvO1Ca/Rh+lei
	EvoCX8z7NudcMwASJpPbXguKvF33D9iPMLOPQ/KmYDglcQuhuElvncX3Acz8He/MxGUNrR9ZTPsUh
	FFAendAgM38sYWORaMTwtf7fG2AiJYC3vc7fknGTT8zvG9GR+LV0aHCeJsmjIrXuK4qDZrenRyf0b
	gAUN9C6EVCJDuC0NcsS8J+HMwMguIhoHnq1mRDVTenKMzYy40hDP93LMHBAVj1F69VdqQLWqzOgDf
	byWGd3yNJ0lGgOzqPIXLWNoRIJ+zMVR+8abCDn5suKAX60RTrx2uYtANF3gOA/gF5fkQ/Gp05L0Ul
	SyPZOsqix/6zKBeNLSuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjvY-00000007CVe-0BKB;
	Wed, 04 Nov 2026 22:57:56 +0000
Received: from mail-qk2-x07.google.com ([2607:f8b0:4864:34::7])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjvV-00000007CVI-4AbA
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 22:57:55 +0000
Received: by mail-qk2-x07.google.com with SMTP id af79cd13be357-93ee7c3256eso94995185a.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833071; x=1794437871; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=gio80mOpo1Ul9gbNqJTVLHG3MgYC68Pvxpy/RPo35Y29OQk0Gyk08W3tm+yWrwJOOg
         ognRfC3tC7uNtGvL9O47Feg5hSNy3oxY6t8FxrIII8RMLBErq0dPrjpg/8lb74Dv0MI+
         C14Zxr1XibG/D1CgQ+AS/gozN5n6+A9z9RXotiYkkdppln6LPC9zHWS/FDgCgxASo1uu
         6knTMgw4TB7aRkNQOCF+rKtP5a0i3NPdv0qItu3L+KdaL6+3/A7CnCCcs/9wq0E52y/S
         Y1A/mLwQjxwOpV91pqRKezRAdP+r6MGCH/vhb7Aq8I/yqt0xjBhL3CB4Fd87y2UDeVfy
         +EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833071; x=1794437871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=YPrsbIzX3i0gG2Ec8jZK/KjMThN0esf47b0hyioJ7qDVIJ4SpF+ThI9SNiMAg+dtbX
         e2zRBsITV36HemeTajqzljSmeat1HQJ8zSLEaKJV94qNnLYEu9SNM2SYEsB8zhg03MiI
         c1aqNtYXmX7QGhYn0qbqBhSMuhsSg3id6qGX34Bpv+8u/IgehLs3KmxDQw5nQA0mAgqr
         6jGS2+mOj292Zp1SVFuf5NG9Fd8FyJJ7LYLXHMAiIpJA5DrukhPMWzOFe7U+h5emPjkN
         jkPnW1iRHY1t7kbT15zcVr5Xc+BtrJ+d2tVvh1Ng0ZVDzDMNFaJLzf9AsKVY4VhYUFYQ
         gGnA==
X-Gm-Message-State: APuU4Z9Tw5VrciswjdLTEWb3U7Wb3/VAlGsbIrhqPB4Wn2gn8igByJdw
	cf4Z3VUwzaQGSY0/F8RiP87doRa0HfhvvQ7M7s1KRihkQMT+aK2j54okPiNF79eoJLQ=
X-Gm-Gg: AYBFou0yus5eVlfXooTnPd0uDUEhxaOs87DbVkfCS8dp9DlCgP4oQclt5SbUnyf0TTH
	XHsqvQLN7bAoukjK8SNvOXX36GB8pzwOQKbOmBFw+BCrN1O/62Ym3Zj6PPsBq2bfuk7Gmvv0lG8
	gl3D9slMxpDnTKLuZA7OT1hyDu1Id0uK2oBCrsSJlDhz8S8iHxgfOqcARAqDVhO8xKG64B0r3Mi
	mj7SMMFpXxwA9WPX3KHqVlthpS2Tml0A3g8ekaiCtGGiQlK4M6kn+Jh2gU0H9yEWIkya+jVojS5
	tz50c1Wyjt+YTSxR99UJCyWfEKhSOz5NsaL9KbVayTbsxSU1hcPdfz1gMrrrVtIfaijKKrk9jza
	t9gtoI2f+wcsCPXzzPmsQNs5CAtNe+MeD8OtBdF7YsCYemYMNR7aiYKWJvkoJaOk9h7Au7h6V4j
	EQVHyO9U+qy6uva4YY41rhhDYTIhIQMAAGqrWn5JGeoG1iF9fYX+2iHMs9PtJ8ZOJhtMbna/jNW
	37yjBsnMzLD/12y44AHPwe6v9UblyU+QgU21mhGKQgl+Lm3DK4tHng1VVrA8Rxd3i9FYAb/wy/c
	v2AlNcAuJ1J3/NKvDFpJAmkoH5OXotxTK0A=
X-Received: by 2002:a05:620a:800d:b0:93f:3219:835f with SMTP id af79cd13be357-94421841ad6mr3045912085a.81.1793833071469;
        Wed, 04 Nov 2026 14:57:51 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d483d762sm318573385a.27.2026.11.04.14.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:57:51 -0800 (PST)
Message-ID: <79ebb791-f118-40f3-8f6b-9549dff481ba@gmail.com>
Date: Wed, 4 Nov 2026 17:57:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/6] tls: update the RX key when a KeyUpdate
 is received
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198140@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198140@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_145754_062690_B3647799 
X-CRM114-Status: UNSURE (   9.55  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 16:43, sashiko-bot@kernel.org wrote:
 > > +   memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
 > > +   memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
 > > +          cipher_desc->iv);
 >
 > [Severity: High]
 > Won't these memcpy() calls trigger a CONFIG_FORTIFY_SOURCE field-spanning
 > write warning when tls_check_pending_rekey() -> tls_keyupdate_rx() ->
 > tls_keyupdate_rekey() runs on a socket with a registered traffic secret?

I could not reproduce this. I built with CONFIG_FORTIFY_SOURCE=y and
GCC 15.2 and ran the keyupdate selftest with TLS 1.3 AES-GCM. There
was no warning. In this build, __member_size() and __struct_size() of
both destinations are unknown (-1), so the field check is not compiled
in.

The result depends on the compiler. A small user space copy of this
pattern gives a member size of 0 with GCC. In the next version I will
take the info pointer from the union itself, as c43c1c24f3cd does for
the same reason.

Martin

