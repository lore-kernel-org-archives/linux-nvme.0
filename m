Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F2C46CD4
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFPcAgqpMDjUyOI46eez858frmAfzDRXlIM6U59hUac=; b=HwD5nBf8WNKNkU8xiJiPpvdhnS
	LNvg3gSOwD87fIxyDFFMZ0HJpAUgME+RreCBTa1pFKOEa9y8sV+oJcUDjZEydX54NPAajmY7ZIZe4
	iDIeRLP/PowL5E4XBKl5Tl+bUyZXVlwzA543QSqxSczVZX0l8XW8r2Akso29kbQj5MOfE7hP1hUOA
	VEA9O995bxSL6SYUGSIAqGBvt1M9K5kftHG4MebvjxW24FSbP3DUVaN7r+SiHiSjL+m0+f5ikIDLm
	/WTx7GmTGawEletXTi4XYHfg2/EIV//dvuOuTDMz4oA5QcU+l/9aIPbtFcYSBQRLznQ6McGn/l63R
	XjOSCKPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGaog-005IF9-3B;
	Fri, 22 Dec 2023 08:23:35 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGaoe-005ICk-1l
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 08:23:34 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2cc95f1102eso17389901fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 22 Dec 2023 00:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1703233409; x=1703838209; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFPcAgqpMDjUyOI46eez858frmAfzDRXlIM6U59hUac=;
        b=GG2H80I0Nw7twuK2H6DrWWTlfc7Yd5DB6CBp4EARp4w8Gud1PAytTqBMT83ws1QHXk
         knM2STmyMvC/3BBO6IhR72E+r3BPmVZSLhfnDfOZK6/4mk/AlaAuDAqgdpid2LE9qi4L
         cnRr0x+HE+AcEk8YEa3vLxkECQ3xM7xom2vNPRf4FoHnytAWTZl0IyhNKI3OeNRpDMRw
         nIcxBTYXAKzJ8t/XOsvpwWUvz7qHIV0jLUqxcLUr7efInC6HCL6jGr7LZOy62APJ5cvJ
         fqPBgY62j12QQu/Yia8pwwmg5HjBrKUpZPzR9eeHs8QVnZK380qdiScL6gBagJ5BuvvQ
         XuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233409; x=1703838209;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFPcAgqpMDjUyOI46eez858frmAfzDRXlIM6U59hUac=;
        b=wVPep7hAhfNrDijNs9N13VjRIynQBNXuu1jBOkXysnElAKud49zbioxx01wSouy4zi
         00hn56iMsLzFdACiyB9xfROETRZqBnUlUO7hxCrhC2akORWxIZGYq35x4tBTHcduSdz1
         TXNkRVl2MElWDkBy0N1w4Pi23QHCZt2KLsXznk/OrZQ8cZFYLXewxytPJdOLhw/gdI1a
         +BARlPOpdAjxNiqaWetQkjkGL8F9slCA2l7BbHDoNTp5EsbRBF3o2RvzmsLzWYM+FRM7
         dpz03W5+tzmvs2ojPLPEGXZ8HpcbzWBqBfo9/ZZuUW2jaXEn59+6im2SBgr5SHrIvrEY
         M/Ow==
X-Gm-Message-State: AOJu0Yx3JrkXUAQxtNdmFQE4+DuhwepoX04EX8uKmJkNCZ3HcewNpvIG
	ZhWXVpdb8rss9AhA5xnAwXZmyGqtDo2VkA==
X-Google-Smtp-Source: AGHT+IFkscMU1YqM9TeOxdQwwPdMY0LVyQ1RQr8PJCjzUZLPSRsA6j10f2Q7drwwodCNnYizhoi1VA==
X-Received: by 2002:a05:651c:119a:b0:2cc:7147:c8d8 with SMTP id w26-20020a05651c119a00b002cc7147c8d8mr222602ljo.65.1703233408967;
        Fri, 22 Dec 2023 00:23:28 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:118e:db44:e99d:a2b])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e994a000000b002c9ef016247sm533540ljj.132.2023.12.22.00.23.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 00:23:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
Date: Fri, 22 Dec 2023 11:23:26 +0300
Cc: Hannes Reinecke <hare@suse.de>,
 lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_002332_783059_AF7D2C0D 
X-CRM114-Status: GOOD (  17.26  )
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



> On Dec 21, 2023, at 11:33 PM, Bart Van Assche <bvanassche@acm.org> =
wrote:
>=20

<skipped>

>> .
>=20
> Hi Hannes,
>=20
> I'm interested in this topic. But I'm wondering whether the =
disadvantages of
> large blocks will be covered? Some NAND storage vendors are less than
> enthusiast about increasing the logical block size beyond 4 KiB =
because it
> increases the size of many writes to the device and hence increases =
write
> amplification.
>=20

I  am also interested in this discussion. Every SSD manufacturer =
carefully hides
the details of architecture and FTL=E2=80=99s behavior. I believe that =
switching on bigger
logical size (like 8KB, 16KB, etc) could be even better for SSD's =
internal mapping
scheme and erase blocks management. I assume that it could require =
significant
reworking the firmware and, potentially, ASIC logic. This could be the =
main pain
for SSD manufactures. Frankly speaking, I don=E2=80=99t see the direct =
relation between
increasing logical block size and increasing write amplification. If you =
have 16KB
logical block size on SSD side and file system will continue to use 4KB =
logical
block size, then, yes, I can see the problem. But if file system manages =
the space
in 16KB logical blocks and carefully issue the I/O requests of proper =
size, then
everything should be good. Again, FTL is simply trying to write logical =
blocks into
erase block. And we have, for example, 8MB erase block, then mapping and =
writing
16KB logical blocks looks like more beneficial operation compared with =
4KB logical
block.

So, I see more troubles on file systems side to support bigger logical =
size. For example,
we discussed the 8KB folio size support recently. Matthew already shared =
the patch
for supporting 8KB folio size, but everything should be carefully =
tested. Also, I experienced
the issue with read ahead logic. For example, if I format my file system =
volume with 32KB
logical block, then read ahead logic returns to me 16KB folios that was =
slightly surprising
to me. So, I assume we can find a lot of potential issues on file =
systems side for bigger
logical size from the point of view of efficiency of metadata and user =
data operations.
Also, high-loaded systems could have fragmented memory that could make =
the memory
allocation more tricky operation. I mean here that it could be not easy =
to allocate one big
folio. Log-structured file systems can easily aligned write I/O requests =
for bigger logical
size. But in-place update file systems can increase write amplification =
for bigger logical
size because of necessity to flush bigger portion of data for small =
modification. However,
FTL can use delta-encoding and smart logic of compaction several logical =
blocks into
one NAND flash page. And, by the way, NAND flash page usually is bigger =
than 4KB.

Thanks,
Slava.


