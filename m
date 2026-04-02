Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C210ED6AB10
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IB55pBrPrRVvy6yC37jMsRUOxNSIdANq32MiVaAR3v4=; b=zowgCMA5Fnd/xFOi45bOvOiozO
	2j/j7wldkQiOxrDavYZllTvX721K5NQY8NwHXeJcZpqspkRAfW1j/ElcLJRVChF0kHh6yJHYdzbpc
	z/T/E6PKmOyH7HvGuPPYhVnx0hYQ/R6e31sXp2UkU96ZqX6Nwz38mqMabJYuoJmMnZx0ecoPd1rYa
	QPDQISaYSEV99FgJLxjDu9L8xAjH6dHaWp+eyjQ+zgzbv6cnCe/xV9B62D1890goaQZnQUE4bWrSF
	Ce+tXaZnO8JOH1DmywxG5xSAavpvWmVFxaDOVj+DsPg7BzQiUV4Am5+GMN8DkTX+yfkxqsv66TEuB
	K3Pm/qrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8PV1-00000000mvY-49Fu;
	Thu, 02 Apr 2026 21:22:47 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8PUz-00000000mvB-0kq2
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 21:22:46 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-953a0431639so340547241.2
        for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775164963; x=1775769763; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB55pBrPrRVvy6yC37jMsRUOxNSIdANq32MiVaAR3v4=;
        b=YMZyiKHvqXpJ2nyTZa8YKOfcr4E6WP31S2AZfuMeDWhB3WjlA7evAe2lQnWACAWOvx
         FfgyBNWektu8yY7se++zWETXQQh8QLuNDStBavV7D2KvN91/cTZw8Bf54ou86zctSe5O
         /ttwsF2bspAbDKrj99CadLr56wWhRiJGTVYccKAXGQ+7FkVwCw/gAFX6auXz0aUOWyTu
         k4Ic8QlXoaSqAC4PiHSi92gRpzInT2gbFORdvmYlvlw3HIkbbdN9e9SPDj9vEp37YU5H
         Y5eEhIHvbE3cVFz0obKXLuoyWAacLMlKkU6U8TrS8fzSEKYt3pzJUaxKreWjKeTJ62VI
         +doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164963; x=1775769763;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB55pBrPrRVvy6yC37jMsRUOxNSIdANq32MiVaAR3v4=;
        b=UniLIt0C3d8U3n3EONlYTD2vFIgOIKh4ARwCZddY3/8G4UqM8jB6tR/rjn+pfkAVKV
         hOeDvVM2E/JR0AnnjnhgJM+3CX3JpwHFcz/tLg805UdftDOoK8cUlMuml+pFPiBV0iHs
         Hdvd6JNtaXOjYwVjvxTFyjWH/kh6zH1ZNDkmiBkw6PbRMogFjBDUlI7iShz05dWJBgcH
         P6LUQZMU58/r048ca9RG+2QvtvWqOVn2lZb8SkBskTylPAKODyyJSGydivlp1GOhQGD6
         OnLFDVUEMJIaRL8Gp7MNjNx0DKFbXFUYKGTzEzTwSHKLJwbxpWqwMXt+neWDpKqgvyKF
         264Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBxhL4GniyoMOggCpn8EAzqubCmlqo7BhK5D2c67k1ngfynnBy4CSM15NtHnRKURDOIbLNoLIQGQYx@lists.infradead.org
X-Gm-Message-State: AOJu0YzKscz2ghz/k32HPBYQRRVLipMElDVZW5IAfdbY8FpPlbb3p+3a
	WqDoaotGJFTDq6DngtSh3VW+pNbDw6pPhHia47hZmg/2WDdIX9WhaBEONDNEWA9M
X-Gm-Gg: ATEYQzyD1UlNzuX2NhMQPEdAfotVC7NcyOc6iWIob1HcrvDNEENu4d1SvyqOJfvXTKi
	myfEland1VQDHOk6hxvHi0Tw4bQyeJNtjrXERcDDQ9e5o2ikIeBwNzU1t6FesR9MeKTJWnKalGR
	h53vLJH8lphLXnwZUdOFunwRf4CphPm3GttAsHv1lE4MacQS/DDGfWJ2RAc2b6JS/B+htJELKLI
	7uPE85heQ5xNGrrMcTXyxnTaWAL9ttyKdDP1Nmu7IbXWu83X5o6/aqi8KWpBsrMHfvSi3siN9XM
	KT+zl23aMOHNxSriZzVjeCJQRHn14f+kuFfX2Kr+jEB959cwL5Pn+feVoxDK9ZFfbYSEm4PytSC
	1UniSkCxKoyDGjWHRY/uZP9F6tsDKm9Xy9DgjxsHNuDr9EUxEDlS7c30gOeZHNm9Rn4OUpmNwSQ
	rOr8UPk9uisfCmpYpg3/jbciBKTA9KFTMACPRRuzCMOVE7uXwpAY6XSOLaCnvFd7//cX3MRtA8U
	iTV/fdFZus9Xw==
X-Received: by 2002:a05:6102:605b:b0:605:1994:a8a8 with SMTP id ada2fe7eead31-605a4d770f1mr250928137.9.1775164963308;
        Thu, 02 Apr 2026 14:22:43 -0700 (PDT)
Received: from localhost ([2800:810:843:17:c685:8ff:fed8:cae8])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-60582e1214esm5184674137.3.2026.04.02.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:22:42 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:22:36 -0300
From: Esteban Cerutti <esteban.cerutti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <ac7eHEnFQlLN-vDy@yanara>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_142245_241238_3A920A03 
X-CRM114-Status: GOOD (  11.68  )
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

Hi,

I would like to explore whether current NVMe completion semantics
unnecessarily conflate execution completion with durability, and
whether there is room for a more explicit, asynchronous durability
notification model between host and device.

Today, a successful write completion indicates command execution,
but not necessarily physical persistence to non-volatile media unless
FUA or Flush is used. This forces the kernel and filesystems to assume
worst-case durability behavior and rely on synchronous flushes and
barriers for safety.

The device internally knows when data is staged in volatile buffers
versus committed to NAND (or equivalent persistent media), but this
information is not exposed to the host.

This RFC explores a potential extension model with two components:

1) Multi-phase completion semantics

   - Normal completion continues to signal execution.
   - The device assigns a persistence token ID.
   - When the data is physically committed to non-volatile media,
     the device emits an asynchronous durability confirmation
     referencing that token.

This would decouple execution throughput from durability
confirmation and potentially allow filesystems to close journal
transactions only upon confirmed persistence, without forcing
synchronous flush fences.

2) Advisory write intent classification

   - Host-provided hints such as EPHEMERAL, STANDARD, or CRITICAL.
   - CRITICAL writes would request immediate durability.
   - EPHEMERAL writes could tolerate extended volatile staging.

Additionally, I am curious whether host power-state awareness
could be relevant in such a model. For example, if the kernel
can detect battery-backed operation or confirmed UPS
infrastructure, it could advertise a bounded persistence
relaxation window (e.g. guaranteed power for N ms), allowing
the device to safely extend volatile staging within that
window. This would be advisory and revocable, not a mandatory
trust model.

Questions for discussion:

- Has asynchronous durability acknowledgment been previously
  explored in NVMe or block-layer discussions?

- Are there fundamental architectural reasons why separating
  execution completion from durability confirmation would not
  be viable?

- Would such semantics belong strictly in NVMe specification
  work, or is there room for experimentation in the Linux NVMe
  driver as a prototype?

- Are there known workloads where this model would clearly fail
  or provide no measurable benefit?

This is not a proposal for immediate implementation, but an
attempt to identify whether the current binary durability model
(completion vs flush) leaves performance or efficiency on the
table due to lack of explicit state sharing between host and
device.

Feedback, criticism, or pointers to prior art are very welcome.

Thanks,
Esteban Cerutti

