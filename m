Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F59DE6748D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=; b=hH7/IxOayc4973NdGSEta3ZYdW
	Eutrd6jbgguhy/HYaXIHEtEigvWR2gBBvttA6rMFdORewRdPanDqgtEoZl8Mutuh9mmy5105Lknig
	bIWML8SgZSDl3rUOo6TFd5hpQoJam0b3xCdHqzNcy6hO9PrtWtn1sfMwCd8EnZd/bZdDz1HPTPRg0
	jxUqwEBNfvVrq3KXZl/6sTuaf0ugPIu5RymeKL/x3Olqw2kUx3UXDFl0FPeqHCGXQ1dgWD/xahwz4
	9H2z8l47tqfra/AUEox16dxbOQAgThbJW611ek2zfO30R2VwW7xqixuZn3qQcv+JPUiE5Ojj8MfHi
	EgQ+zaQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXcdB-0000000DZUG-0fSl;
	Mon, 22 Dec 2025 09:55:09 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXcd6-0000000DZTt-2eNH
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 09:55:07 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-55b24eedd37so2690170e0c.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Dec 2025 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766397303; x=1767002103; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=;
        b=M3Grb1UTxpjLEt67vzG5lQPvIQugtPrhOcd4Q/6JucWG6vmB8KWZmovcM9ZsSYLENe
         76f+tJzMXCBLWkmVkUAmuLXwn3gDmJaPtWRL4XwECKjKjXAzduxE1b6P37cQ1Vyt+JGr
         /wqGE2XxXjAaAJyo+9LHASLJDNIUxpwB4qT1LLqeqieJ7Yp7j5usgaoloWw0kY/Elhcf
         aNGV+RPjH3nLc9Rjykayx/ZHDtjd5b5NPn0Z/5YFue7noYXgI6G3/mfPVYKpHmGer1wl
         tForAwYbXzrDgAbpxxPS0p6wsC5f3Nxgy5cuGx9ELEGPWAe9eK6vcmmSe8AY7wOC3rJE
         2k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766397303; x=1767002103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=;
        b=hU+GhWR6K+dIouD85ONjMIaKcGBqyg/cnigpFEfyyCr0U21/XwL2fwxedvVpDQlWNH
         x07HxQV7BLdqVI5E0QwIBv+CWpBWcqVLoMgub6H6VXnZoU+zX35HF/Ni6hnr9P35QQi5
         3MrrC/YzILA/jpLYUua5NHxRfQFscXF/bKD7ScGfSMnST2KPWunA2OjGrEY3j3iqccqJ
         ZsW1qZZt0ebKbtoY99sXYpQE7urpeXmnwYNEoE322KF0Tlh2pvRpnJKcIUdwjGGg6tkF
         jvpxMPp5kpLI1M1BhDiaLWgqtL7CXEECsQOlLx4vLcq4V0DxFAt+MKyOv0UeGPiFhQwo
         g6sA==
X-Forwarded-Encrypted: i=1; AJvYcCWIXeR+72idTSPVuSiQtDBQ3IjrUkwdcQL1U6zgUX/LqElqAqe3XVvxHrWS/5xX1uaCC7k2RF9OQYHX@lists.infradead.org
X-Gm-Message-State: AOJu0YzrW/uz0KVpoZSvSG/nc2tIMNKTWsW4OSy6URv0ZsqTD+EENxwZ
	kzkPgfvR11nA8U4CAdcrRwqdQelIgMX67RQgeaiqGffjPt2o+NiPeWfEv/sjVVRpmvKrzvJVYhN
	a/lYBkKK0Y8WBFgq6y7GDZqWW0X2CVUY=
X-Gm-Gg: AY/fxX6oalkfNB6onS23WRcuPaHQXLNHCwBBxXusBxspsH+QEJgFKGPtLnsYeMGEWUP
	lvvFqPSHdYEbA+xoxmAXNj+UAtYFicZVzuqtDhgs8HThu+4J+BKoU7xkM3IygbfVEEM4jPFla+F
	2tHVNw9JRasQKpN19bZzVO9/xo7IUFZwsJhKahDMy83P74qxncMiJcd8Vjof1wBnqrVrgAqdPC6
	xeRrTnkkXz12nC/92hUpcFTRVIGfVKeXzBHNwmzuE41/K74b5pUQFaKx842ZivPWd7FLMttYFHK
	js0W47IfXS7hi3SchFbs0rsatw==
X-Google-Smtp-Source: AGHT+IFUCJytn2HUHbFl4mzNuXmAK8kK+A0oe6GlFT83jM7AwAOBoV6P8AXE2BySrBcA6cvbNdp+qPAFe5Yfh5amYHE=
X-Received: by 2002:a05:6102:3f0e:b0:5d7:de28:5618 with SMTP id
 ada2fe7eead31-5eb1a61efd6mr3146522137.5.1766397303126; Mon, 22 Dec 2025
 01:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
In-Reply-To: <aUh_--eKRKYOHzLz@kbusch-mbp>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 22 Dec 2025 12:54:51 +0300
X-Gm-Features: AQt7F2oA_cd-Hnm73oPfh7DxIU2Mt7U5V-SzBc45sFerfpf4qyPQSqEwJCF67kw
Message-ID: <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_015505_056309_0549A867 
X-CRM114-Status: GOOD (  22.29  )
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

Hi! Thanks a lot for your reply! This is actually my first patch ever
so please don't blame me for not following some standards, I'll try to
resubmit it correctly.

Regarding the rest:

1) NVMe atomic boundaries seem to already be checked in
nvme_valid_atomic_write().

2) What's atomic_write_hw_unit_max? As I understand, Linux also
already checks it, at least
/sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
max_hw_sectors_kb.

3) Yes, I've of course seen that this function is also used by ext4
and xfs, but I don't understand the motivation behind the 2^n
requirement. I suppose file systems may fragment the write according
to currently allocated extents for example, but I don't see how issues
coming from this can be fixed by requiring writes to be 2^n.

But I understand that just removing the check may break something if
somebody relies on them. What do you think about removing the
requirement only for NVMe or only for block devices then? I see 3 ways
to do it:
a) split generic_atomic_write_valid() into two functions - first for
all types of inodes and second only for file systems.
b) remove generic_atomic_write_valid() from block device checks at all.
c) change generic_atomic_write_valid() just like in my original patch
but copy original checks into other places where it's used (ext4 and
xfs).

Which way do you think would be the best?

On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> > It contradicts NVMe specification where alignment is only required when=
 atomic
> > write boundary (NABSPF/NABO) is set and highly limits usage of NVMe ato=
mic writes
>
> Commit header is missing the "fs:" prefix, and the commit log should
> wrap at 72 characters.
>
> On the techincal side, this is a generic function used by multiple
> protocols, so you can't just appeal to NVMe to justify removing the
> checks.
>
> NVMe still has atomic boundaries where straddling it fails to be an
> atomic operation. Instead of removing the checks, you'd have to replace
> it with a more costly operation if you really want to support more
> arbitrary write lengths and offsets. And if you do manage to remove the
> power of two requirement, then the queue limit for nvme's
> atomic_write_hw_unit_max isn't correct anymore.

