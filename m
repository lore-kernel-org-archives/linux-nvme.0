Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1F606A6A5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XTuBTjt+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J+99jVPg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/iuEShb+SCbUmAuhOf/JItulqcNTWtm6fApHRcV/K00=; b=XTuBTjt+QmI1jC
	pBugX9i8aL7qgo8mBVcTSQ/Gqkw/dnoy4CTOYuSmFXIP5WsJC63A7lBcI/lDIHeyKAH9C3QuWAwR0
	YDepYqwy3Cd/qtzGa2uM6eDocT+acLkzil6AI+FkJSFARDkFfqwQedq21K2ZuFXIwjB6RoyegBytR
	FMQb7GsvVDDXQDiR6hZH2hqFWT8Hx7/Vw67TFwZ568xJYXymtYN8DgCgQGfMJsM/umr96SfZLec2c
	9PR/l56kHbcPZCHpstJxvdL56pkqXg5/8VhSj9xUZsj28oblsw9I5O7+9MniEj3q8v3CHgyXOOhPw
	C7TLz1KYzcKUx4RKJWhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW1l-00000003zxa-0Xoh;
	Mon, 23 Nov 2026 15:32:21 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW1i-00000003zwL-3huO
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:32:20 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a3d39e406so1431499d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795447938; x=1796052738; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iuEShb+SCbUmAuhOf/JItulqcNTWtm6fApHRcV/K00=;
        b=J+99jVPg5EG48gXGZ4h8sfFRwZPOa0G7A9fN4z1V3ikvuOHKMfOynXdvaiH290po93
         vw3/DgUbWpkE5Oms6sFSHpmScE6p1ScIPlNAPVgZCZOy9AWsdPQPHV+gleMp1NkeRTaZ
         wgCc1khEqUBIhkCymIrBdGJN0q/YFHyjWRQnfl+1UKaP0gbDet3ZcvMzstWIb93g0BbS
         K1rCC3NLHbRZahvKoD5/QfxboSWhulHLB6JwVM0sCr1Yp3TC+csErny4R8eLGrkCRlSY
         i4KlhMNC78MsIo9S4nWy7InibIMU5gelhqqbMvR1QTACRQnaToei2qYDDvmKoABKxq06
         hQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447938; x=1796052738;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iuEShb+SCbUmAuhOf/JItulqcNTWtm6fApHRcV/K00=;
        b=pR5FO9rYsnDOSCfzjknYKuqqJLonj0i7IlXM8ob2I1wThTx87JPjF7dLlacfQGCVFV
         kBZhFQHUSsdetR6q0OZLF+4xv144xbbotzX2EW6SXJYLmkobauFMZmpYFE38YK4Oy0i5
         l4A3uXSoyOJOgCkZKj8vUymIfIn12bH6CS3mqKuQPT8EXYPkB4dlvsBMkbbkaVYICPhJ
         pi5p6hqgT/S6fVUtM9h9t7BkGF5XwyefSw3ve3109svg0X1Tn5HZSrE2y2tjmZyXDnSA
         JOvFm+KBdjv4cVJhbiMl0F195ZTbiOYAX9vCgr4iblJiHqkTbd9r4toQeqYSSnvn5A4s
         UWUg==
X-Gm-Message-State: APuU4Z+t3ut7qZwlX+2xDEVJARmR0NfzXEIVS1SaT4GuRot4E/7F+Pgm
	/3JWenlldNL/UWdl/ZXjad6+nfoASz71uRwNbRe15i+JVguW+pOmaqbe
X-Gm-Gg: AZFdTZfzDIXlFLvzIEIJQiFmkGJwdhXAhH9zJ/NjxrZIvecAbsUepEYexQ/Lsc9Eelt
	/vbz0EXFNRo86lS73AbR9zwJzl4l2XCtYC/NGCWGPprjzLsXh7JCfaMK+RjZJ6cs0BhkWjkcst0
	Qj7dp9fi5UF3tYJVdGe55PqCfxxeuHZZh148a9JYTa0O93x+ITZ1Fxt/+y6s7/mLEWD3SIhwQnk
	HOv7TKUBiYzj8V/VnrPN1xGxG9y0U9sD78SH48TEfCeZS1Un/dKGW+lDbWDs4vrk4mDOdgoS8UY
	8Uuv5TSZYDDnx1TNOQkGVza4bTPOWz5db4hIe89tGhHm0LrX+fzKkp449lAb3vte6mAH3LFhlzE
	iHeQE4jzbkjsb5MlPh0t4N2EYomN0mRvFaOFqB3k6d3SAaWQdP6hQDR+c2pB6HZmIknRsn8BrQs
	RQXhUrbiH1pMjbCc3prCY+JAv9a3gnAp+1sam9SPFSndqw7le09XltEk/scXogag1tnA+V/3ORo
	SnW1ULg6TSZUziVnwqPLmsGPrLmxqN/hkArAcV7gzIBuzkLjSVBD3RDv7NnL0wGcDSIvR+S1IC1
	m+0kgUmcFyCv7cE196DjUuaNEq3mdAsMGwQ=
X-Received: by 2002:a05:690c:e908:b0:8b3:3956:6f7e with SMTP id 00721157ae682-8b52043cdd0mr44199647b3.12.1795447937296;
        Mon, 23 Nov 2026 07:32:17 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520c5b6f7sm45871217b3.9.2026.11.23.07.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:32:16 -0800 (PST)
Message-ID: <463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com>
Date: Mon, 23 Nov 2026 10:32:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] nvme-auth: switch to use the kernel keyring
From: Martin Belanger <martin.nvme.dev@gmail.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
Content-Language: en-US
In-Reply-To: <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_073218_939082_0D9B10BC 
X-CRM114-Status: GOOD (  12.42  )
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



On 11/23/26 07:59, Martin Belanger wrote:
> How should nvme-cli determine whether the kernel accepts a key
> description for DH-HMAC-CHAP?
[...]
> 2. Use a separate option for the key description, for example
>    dhchap_key=%s and dhchap_ctrl_key=%s. nvme-cli would then detect
>    support through /dev/nvme-fabrics, as it does for the other
>    options. It also avoids having one string that can mean either a
>    description or key data.

Hi Hannes,

A follow-up with test results. I added DH-HMAC-CHAP support to
nvme-keysd and tested it with v5 in a VM, with nvmet over TCP and keys
in both directions. Import, connect by key description, a wrong key,
and a key replacement all work.

For detection, nvme-keysd now uses add_key(): it fails with ENODEV
when the 'dhchap' key type does not exist. On an older kernel, the
connect fails with "Invalid DH-CHAP secret <name>", which is clear
enough. So nvme-cli does not need a new option for this. A separate
option would still avoid the ambiguity between a description and key
data, but that is your decision.

One finding: add_key() with the exact secret length, without a
trailing NUL, fails at random with EPERM. nvme_dhchap_psk_preparse()
treats the payload as a C string and reads past it (the bug Sashiko
reported), and base64_decode() returns -1. User space passes the
length without a NUL, keyctl(1) too. Could v6 parse exactly
prep->datalen bytes? For now nvme-keysd passes the NUL.

Martin


