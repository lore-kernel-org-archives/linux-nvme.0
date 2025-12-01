Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC8D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUZmg6mIKsML2KO+xPPWVYxDwTLQ1ULJ0C1rbIr/U18=; b=XfunctxLT+Dav7Dh3mMEGrUh5w
	eGulNpufLr3DUldZZTf6ONYjIbafAmA2M7ui0rf24EK+QuivHKX4j5PSsExqWDmca2Xwft9/lkrj7
	Oj27FwwHAnt5YwF8i7R0/Ql4BneaDTaFSjFqyIj3UblNjGXe2HAcbiKSY0R7GI80pwO/jKw22xjGy
	ljivKc83nkEq5c3WM9Ifg4jLPjxCE66cQ1HGugPIc+PtQ1d5LoJvm1YA9GdvCKoAAXa/vgSt6iUjZ
	458rYc7Czq6fXBsCrhPApgaYiGPhKGc8taysgwYW66X1Uk1w5aucoS1eeMepVQrgE3gOb7I0DINCe
	QeMVCLmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4gM-000000044UB-42lw;
	Mon, 01 Dec 2025 14:15:14 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4gK-000000044Td-1x7T
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 14:15:13 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7c6da5e3353so2500818a34.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598511; x=1765203311; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUZmg6mIKsML2KO+xPPWVYxDwTLQ1ULJ0C1rbIr/U18=;
        b=cb0zTTx7OIiJ8NrL894DfFbx3PIQqAq5ZPuSX9TjmZpc5sdzruDeL2j47StURzjXWn
         iYUxF3A6671eObgSym+VqVoQspn9fQPJZcMz0LtWRTORCarSkINc8UsLQjS6Lqygp3mn
         nkzDvu82HhurWD3cyKPPFFyYc396eRxayYkQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598511; x=1765203311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUZmg6mIKsML2KO+xPPWVYxDwTLQ1ULJ0C1rbIr/U18=;
        b=XllKsM7RhOhm5hD9gsiZoTUg1wWEANaGBSynYViDly68K7QPPB2x8vO8NM7S9m6Ije
         9FvQ3P2iNqkkzulRDk4a5rFAzCwT54wbr1o8Un4F39OWKUgYfEeK8MgtS9X2ebdnW1x/
         E/g320fNCT9CWRfz/0Ll4FuBJMkxCRwqDHz5tQ5ChHUr7xlJ4u6OxOQdFPiXvZ13lYyj
         Dbi35/RYskvbtiUKXdhDLGTbsWXsChVCGS+icnDFW7wJUnA6dfF/qbktY5Nubl5MULbD
         10Wf7KIfuSvthSgrtp95fLJ9fHhjhpHsyvQ4h4sVJrpDBWqRyjX4hrbpecwAhoN+9wGu
         /4uw==
X-Forwarded-Encrypted: i=1; AJvYcCXBo31YkC6MLrX0HiSZmL2y1PAhZnXXbIFr+d5KV9DFTGlukWbH98+g+IlzuyR4hrxO+m0nh+egUNoc@lists.infradead.org
X-Gm-Message-State: AOJu0YyZWeQXQg1iHaKtN0VjF8/OIhUp0K9zQ5e2LL5JJOwPFI5Toshx
	//QbPLDEho8F/Y9m7SRSVPbAHx2LUJvkW5g7B2MLg9HuZ5lhd/D4ct5MzVd6RMf+m3sP/n5vUP4
	jdPusYL1W6MxN1XEGbYaiEFLLVSOELreZwnUcSomqgg==
X-Gm-Gg: ASbGncuWboBFvhT04/Mr4/NxFZzK6EiiiJpI/cUc0J0azEEtI7bE3mjRvtiDsG8FYX7
	vHDK+TpREcno71Az/wkXFVMw8KD8MAuxg6cboNO16yq2e4x1GszvL3M+3mO0NnjURyVyiT+9Uuq
	+kK9siPi8yPCrURVoUZVJQqdTkL0EoxC39G2ExmIS31QYOyVB9xQVEQuTvp0hhGjFo1sv5NLfCv
	nOUDkUEPHT8IY2YARF/hJ03D2EiSr0w4SVlTYfcnfyk7GUk+HlEDX+1ecGEdT6Eg6ES/3vUvrWm
	83/HIdAbHeEmadNvZYAe72vYFsSRnE9AU+fYI1MuAN2l3hrXVnqTg5//zKjP9Xo=
X-Google-Smtp-Source: AGHT+IHwLRhS/dOTGy6I8v5RYfy93HQulXXIBuzwmVuIczi0e5dazOauHFCbbBEKS0ayTSTOGt0n/BqP/mu9/5Egnuw=
X-Received: by 2002:a05:6830:6d4d:b0:7c5:2dbf:4a7d with SMTP id
 46e09a7af769-7c7c4417c31mr12280576a34.31.1764598511215; Mon, 01 Dec 2025
 06:15:11 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
In-Reply-To: <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:14:58 -0500
X-Gm-Features: AWmQ_bmQKzJp8vegg4_XTBzVGnygRRMsorS4OWzCZ1CSI1CpVlRXj1d1R7Yz57E
Message-ID: <CAO9zADx+5cNAxaz4R7SAndY5EX1z4V8i1e=rAdBbOTmxLmcopw@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_061512_502110_3E5331C4 
X-CRM114-Status: UNSURE (   8.24  )
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

On Tue, Nov 25, 2025 at 10:19=E2=80=AFAM Dragan Milivojevi=C4=87 <galileo@p=
km-inc.com> wrote:
>
> > Issue/Summary:
> > 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> > drop out of a NAS array, after power cycling the device, it rebuilds
> > successfully.
> >
>
> Seen the same, although far less frequent, with Samsung SSD 980 PRO on
> a Dell PowerEdge R7525.
> It's the nature of consumer grade drives, I guess.

As this affects multiple NVME manufacturers, are you aware of any
consumer-level NVME drives that do not have this problem or is moving
to U.2/U.3 server drives necessary to avoid drives dropping offline?

