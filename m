Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88857C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjraXmdQ9MKl7DfeMkYtKuFsoM2y5kG0bnTNRXLMD5Y=; b=pP5V9o2+HVE0hfHCT9AcFlb2cx
	sCvQ4WM1lTj4koLous9OGcK+3a3W8oSivK+zBkucXekH1JAr8Xl6egyN6ztZivbVma+bQGzcZGabx
	6LbXqptZl4r5tirzJ48q3xlIbdqtqORoI1WF7+/DYs3p9klbloAM8I0W4N6fc9fRL9ocdDBAcfNJU
	ThMDxlxYbjCM+Si8kpvgq8sYTzpB/12er7O+x84xOROstvfdv2QSgxp5Ud/2iCfD96RKhaBlj+KG8
	rPBYKCJ64XMd7WEwFLysmPld4Taodw9S7w0mGuybm+c37d9SfHyOQq30dkHCTEI2aaQ6C+me3MfTi
	X/m4tkmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHg4Z-00ANtA-0c;
	Mon, 25 Dec 2023 08:12:27 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHg4S-00ANsO-2V
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 08:12:22 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ccbaea0a6cso10308711fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1703491937; x=1704096737; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjraXmdQ9MKl7DfeMkYtKuFsoM2y5kG0bnTNRXLMD5Y=;
        b=A8UFzN8h0foc2MHVmxPJDp7mFUzii7y3/+2u1O+sHtojmRJN91ebZiGpzQytjIzTm2
         VSTsXKQun0vDo3prHObBH5qx/kvN7DAD2czOqU/hwgAducmpyvZU9gEvcF1TdSvRFk2z
         W0zMOk5b3ftY5SQdKTBkh4/owMMcrGz+NOBVb9bPVbnopOw9dPBwLZY+oBnUVioxFkTG
         zaRnD2DnkezWd0ZetHHyEmOIxl2YhcsWnWbfbbq4MXXfY6mb8cL2tOpFUggT4RCm6j67
         UxGJk0xiBcnJ9R7zA7VpQ/SeRfMrvKUT+79/cQq0LNDC0wVpNCqbR69IJOmjkZX9pLhQ
         haLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703491937; x=1704096737;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjraXmdQ9MKl7DfeMkYtKuFsoM2y5kG0bnTNRXLMD5Y=;
        b=ZZaRjIwP2UCZSHjWzLRkvL2QeMA2p+9DWrkQAhl4P4W7KHbykk7XuDzpbGaz/KyklP
         l5xlgeGTfqET9Du06lBxuuTiclvN9br3PGJLHXey/mdFvb3jRHrai+gdhm8A+gm3BLQS
         NKCUy6Mb/5DUq4ulKe91nwAyDN+KIchz6c+zFJby90qaK91h0H6vK2wSrHu4Fqba5aLr
         oFpLx3aOEXgL9ZO2kLGQ3iqxI5ZJy+VjXEUYYBpYMWUprOjd3oq/mlibik6quI9FHoD3
         KQz3prgpt1HarWnjmNFKLwuNoGJnT7kLgmnCSHe6uxhHni4pg+Pg7OWMshqveyK4Wv8O
         EWRQ==
X-Gm-Message-State: AOJu0Yw78sIbY6f2VO704wXYmoezQ/a2NjnkzS0r3fnIVo0P8idkz0rV
	v0RJBXg7LKRcJOMEP/S54Fo1vvThZ8jCTg==
X-Google-Smtp-Source: AGHT+IG9m6rRX69JGpQvGBXzGaGawFNL8+MbLBtXSX7RPir9VMWJcPyssNSi6NY+nNPJQmRsfp9+Iw==
X-Received: by 2002:a2e:979a:0:b0:2cc:7127:ebb1 with SMTP id y26-20020a2e979a000000b002cc7127ebb1mr2335297lji.81.1703491936632;
        Mon, 25 Dec 2023 00:12:16 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:d097:b658:f57b:dbcf])
        by smtp.gmail.com with ESMTPSA id k10-20020a2e920a000000b002ccad70dacfsm1147930ljg.26.2023.12.25.00.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2023 00:12:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <ZYWm_tMtfrKaNf3t@kbusch-mbp>
Date: Mon, 25 Dec 2023 11:12:12 +0300
Cc: Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>,
 lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C457D1B-4923-45E6-A481-28C92B66243E@dubeyko.com>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
 <ZYWm_tMtfrKaNf3t@kbusch-mbp>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_001221_150478_BDE8CDEE 
X-CRM114-Status: GOOD (  16.95  )
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



> On Dec 22, 2023, at 6:10 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
>=20

<skipped>

>=20
> Other applications, though, still need 4k writes. Turning those to RMW
> on the host to modify 4k in the middle of a 16k block is obviously a =
bad
> fit.

So, if application doesn=E2=80=99t work with raw device directly or not =
use O_DIRECT,
then we always have file system=E2=80=99s page cache in the middle. It =
sounds like 4K
write operation makes dirty the whole 16K logical block, from file =
system point
of view. Finally, file system will need to flush the whole 16K logical =
block, even
if 4k modification was only in the middle of 16K. Potentially, it could =
sound like
increasing write amplification. However, usually, metadata could require =
smaller
granularity (like 4K). But metadata is frequently updated type of data. =
So, there is
significant probability that, at average, 16K logical block with =
metadata can be
evenly updated by 4K write operations before flush operation. If we have =
cold user
data, then logical block size doesn=E2=80=99t matter because write =
operation can be aligned.
I assume that frequently updated user data could be localized at some =
file=E2=80=99s area(s).
It means that 16K logical block size could gather several 4K frequently =
updated areas
Theoretically, it is possible to imagine really nasty even distribution =
of 4K updates
through the whole file with holes in between, but it looks like some =
stress testing or
benchmarking, but not real-life use-case or workload.

Let=E2=80=99s imagine that application writes directly to raw device by =
4K I/O operations.
If block device supports 16K physical sector size, then can we write by =
4K I/O
operations? =46rom another point of view, if I know that my application =
updates by
4K I/O, then what=E2=80=99s the point to use device with 16K physical =
sector size, for example.
I hope we will have opportunity to make a choice between devices that =
supports 4K and
16K physical sector sizes. But, technically speaking, storage device =
usually receives
multiple I/O requests at the same time. Even if it receives 4K updates =
for different
LBAs, then it is possible to combine several 4K updates into 16K NAND =
flash page.
The question here is how to map the updates into LBAs efficiently. =
Because, the main
FTL=E2=80=99s responsibility is mapping (LBA into erase blocks, for =
example).

Thanks,
Slava.


