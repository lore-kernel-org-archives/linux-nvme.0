Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1238D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=; b=RXwmeHEDX6bmwwyRVJwbndqlSZ
	59ZDsGA3VZdrpbX4n4tC3vRCHgaNZ9W2MfMXzBsgy1q6Q/tUnBDFy7op6dFNru0BiitZahGYVBDDl
	s/xKDPggWchH0np77fwpIXO+U6leb66vpklESP2A/zcZB/1tlBQR9t7B3Uf4ReKrawhErYkph7Hg/
	CLCer7kJM08q8O8CThLJIhHoLsS4Cg+RfRmElHLTirbfvoddl3lIzjARsWDENo5kLNSU/Y39fUnFf
	5Ff/nww2SklqFzV1Bmfc8SOimZD9jvNAjhISgzQDMu6EIG9VfPo6730KgXchfbuoz7EAtlMvWRYBx
	dEtmQuBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4bM-000000043bN-4Az3;
	Mon, 01 Dec 2025 14:10:04 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4bK-000000043aW-29EP
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 14:10:03 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-450b5338459so1918487b6e.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598201; x=1765203001; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=;
        b=VVQgBHYpbAw3awlZ7IgUfhxj03zIv0uOmi+Mc8IIU766lkezJiPCYPytON6RSf80+t
         SqMjX08UjvT1wezDB38/4T8RHkCr05Cvjqf6KU1VKH9YbSyJKCsiMP3A6D7fRaIrqgSk
         iSWIvvfEwxd9jf6sQXHrwo0vjITDm0xI+dpEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598201; x=1765203001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=;
        b=U5049t9jMKNqxLk2LShcumaGJb/o/pDuKWcSnrapoqCurInA+R3fzNB0Dc2fbjSeKN
         yYSwSikQ26oyXNJjOHGj7bCUpCq9k2b1L9yS77tQImPoq5bXot20Mfoy/BqLRiPMG3RV
         djK+B5qcBz/kpr12lRY/JwFHDZsf7DJ0bfVRAYMNTDzlQbaxq+4zaqKgFmEzWEchXPM1
         ma5yKhr39ey2hhGrecP7aGYqUfbn2oZpackm3XpzRd+QxVKaGHPO0DNIW1aXL1j7aigB
         vV5W2TvRLMIfzgJ9T0E+1OCD26sSA8uWcDDE+s1bSHcMh9kL5cNXTrECc99ABv4Um2qD
         BsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRM+p7oSmm12gRStyDKfYByO6E88j9w89yApbW9EwzQ/7YSCHilwMnMnz833cqE41pqzHvmujr6g11@lists.infradead.org
X-Gm-Message-State: AOJu0YyjrDz2iMBv6BafFOgCqUsPkYH1e2EfyW6s2zPp87i8Nat4dzaa
	ZG2ANkaInaqZ7sjrej4bJoYDbAbzipFU6ivkFzRzS5Ds5aWmZYrVEz7xXkSLt+76hbIgWy9kYE+
	t8uWmDoz9AijcwOxW0nBd3EbcjOYuGBu3rFGcqgEb3A==
X-Gm-Gg: ASbGncsy6XR7atCs5HJCvCyJxM/BeNXvqz0nwyJCLkmN0PPvd6+dMdjXK2OplY4fZYr
	R+Oyl7TLnRcVdKKB3MDYMP6CEg3NkDDI03GNoX3zJTov1fRThcAyj4p/0DTY6BFEjPDu3bnBSAV
	QDHxROT3cFOI8W7my84Ax/n8iAaLV+dyN3ZzBjmIJVbybQqBkacBYPx8DfhBhXWULv8DWz3qjQR
	+dbCVEzxxe4qop9yR1hnwLImYPO4CxQUBAFqf3MF28f6xswEa1WvESFVqm1el4GMT4RiQI4SL/a
	gpB+fV3ErPAaijC6bW+VsrMTx314ErWNWYWXrFIfWasiqaWSlIZzq1CYNBlMS8o=
X-Google-Smtp-Source: AGHT+IFRUfgSsf/TJkHeANSH4dfp2CZgqrYY4eMQAE8vHEGMie1cY6/g5n24t2kOWvlcuoH0jVrzNRVVuINc92eyik0=
X-Received: by 2002:a05:6808:67c6:b0:43f:2464:ee55 with SMTP id
 5614622812f47-451128f91d5mr15599176b6e.20.1764598201100; Mon, 01 Dec 2025
 06:10:01 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXBwBoBZp9t890U@gallifrey>
In-Reply-To: <aSXBwBoBZp9t890U@gallifrey>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:09:50 -0500
X-Gm-Features: AWmQ_bm5--99g4Aj2GUCOOkdASboV31CU7h7n5xreYibAeG3yoF9MLp3qxHFWQE
Message-ID: <CAO9zADyCd_rDa3WEYCU1tw2pNv6PxdJdDkPuJwM437Wv3CRYNg@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_061002_560078_9A59FA03 
X-CRM114-Status: GOOD (  13.08  )
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

On Tue, Nov 25, 2025 at 9:48=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Justin Piszcz (jpiszcz@lucidpixels.com) wrote:
> > Hello,
> >
> > Issue/Summary:
> > 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> > drop out of a NAS array, after power cycling the device, it rebuilds
> > successfully.
> >
> > Questions:
>
> > 3. Are there any debug options that can be enabled that could help to
> > pinpoint the root cause?
>
> Have you tried using the 'nvme' command to see if the drives have
> anything in their smart or error logs?

Thanks, I did check on this and ran the usual tests, everything passed
- as part of this thread it was mentioned that some consumer NVME
drives have these issues:
https://github.com/openzfs/zfs/discussions/14793

For those using an multiple NVME drives with BTRFS/ZFS, are there
known good NVME drives that will work and not have this consistent
timeout issue where the drives drop offline?

