Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A09C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FA360F11
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1FA360F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZzDnGmQvhZX8Iagxpy5mKSvk3OE4zvzTp8w5hB7G5lA=; b=2vjbitxHAqzffsBoTEmckKN/Yt
	xwuiCM4qbxIvdBuVIwTSdVCS6t0Ey5xONXfVmwja2nKssULISFe1gUDbSiPuq2AIcMBJRsj8CYUMw
	g9JrKyUNPQLDqVIMKmUkU8A1JKjcCeKRe1Dw3AdxlVT41WsR39w6A+mZlIaOXxrJ+8/hnDNYiz/mE
	o0gueJpyc6cqIECmtKK6AgGFQrCWvOtu1EL8DDBvOCx18E2M5NEq8I1Me5vbcSsIFph6rZktqBjUP
	ZtlwkjtkWLxmlVUjOc9fbOUoSJ0adisHti6w3LbmfA5AGndgpaJbcjlYu/GNhbN9/1z684eXYkODu
	SqhKFT3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maXdi-00F8Ct-MX; Wed, 13 Oct 2021 06:21:22 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9Nez-007gFw-JF
 for linux-nvme@lists.infradead.org; Fri, 30 Jul 2021 08:14:27 +0000
Received: by mail-ua1-x92c.google.com with SMTP id d6so3669622uav.2
 for <linux-nvme@lists.infradead.org>; Fri, 30 Jul 2021 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
 b=YPb5MDsNYwCvQCbivctyRFHoxWN6lCov1Fyg6qJBvJ4PhSmt+I8i6zSlZXm8HMNDMX
 ZXG3NnOnlty33VL7xGl1Px6+dBVxM4PUwVlsc3Z8bt0XMtM4jw+Fhq3Z+gKgZwIJwPXG
 rtWBbxQDUssuvfF69XvYPVLifBZJIyDNthFKLz+EV4hIijU92YhghPt9IHUs0OUUp5rn
 UPCpU9rJ2YVsIC7v4fbJ2LtJYyx1AFIfxeiteXaEpGInecGtrEdHWySRCC9CYB00t8jP
 7+TrnO3CANwcqDNfLWbZdWMAbzzJLhF2ugdktTCPivuuC22r3v+4miU/kqhtzxgK5pQL
 h4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
 b=JK/Fu0iOzkn2sce3q9fifCVRmbfHzpFIcbS5NlTyueVCdr5+/JU2Y0sHR5CEltNjMW
 uN3CKQk/JqoaN9YCF4kwRi3yyblir6tujQ2DRa7ZP92z/L90wZi8Mv8yrZGAkKTzEX9N
 S12/THwZ6o5EjL+2zki/Pjnpndb2sSsP9yOjhAPEKUUBQ4vEYT3WVg/ggPr3ktSGYqOX
 G2YjUWaSuWu5G2yupDra1Pa9MDEdr4rTutAz7xt/m2KtJ9b0+K3zY4wxbXertTzMEZYd
 i5QZyopWCngwDeZc5XioMwv/dWmdSSCVyVlbNp6Zp1v6c+dk8s/Pyd+teMJ7pqGeb7tl
 ozzg==
X-Gm-Message-State: AOAM533HW+8/ZTrX/bWkCYmv9VL50Dl9Oc4Pv1krXXTc+L+sDiYbEnlT
 PeNQrni6kURlEBtx35mZBC++dj5XEUFh1t2umGcALONn0CFk3A==
X-Google-Smtp-Source: ABdhPJzN/sEVb8oZDZl4/Zy7ZpvyNDAr+0EPzhSXSVgi9QTaROvcf4PAK+B9CTjsdxzzptQJD6lFnzn9h1kSWcs3ovI=
X-Received: by 2002:ab0:1e07:: with SMTP id m7mr729256uak.67.1627632862294;
 Fri, 30 Jul 2021 01:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGCbPWR7dk7fWxMGQW2ygSEbgPLbfaQiiVb2J6Tczdt_oOCheg@mail.gmail.com>
In-Reply-To: <CAGCbPWR7dk7fWxMGQW2ygSEbgPLbfaQiiVb2J6Tczdt_oOCheg@mail.gmail.com>
From: koos vriezen <koos.vriezen@gmail.com>
Date: Fri, 30 Jul 2021 10:14:11 +0200
Message-ID: <CAGCbPWSuHFQdZEciPVi8J3Yxd4rB=kn0VsV=26fZbeGftVk5HQ@mail.gmail.com>
Subject: Fwd: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log
 entries
To: linux-nvme@lists.infradead.org
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210730_011425_697730_A37A1252 
X-CRM114-Status: UNSURE (   6.00  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 12 Oct 2021 22:54:01 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On my XPS 13 9380 I get local mails with content

"
The following warning/error was logged by the smartd daemon:

Device: /dev/nvme0, number of Error Log entries increased from 28 to 29

Device info:
PM981 NVMe Samsung 512GB, S/N:S3ZHNF0KB11472, FW:EXA74D1Q, 512 GB
"

after boot and increasing numbers after resume. Git bisect report:

git bisect start
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
# bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect bad 62fb9874f5da54fdb243003b386128037319b219
# bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch
'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/
md into block-5.13
git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
# good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag
'regulator-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/br
oonie/regulator
git bisect good ca62e9090d229926f43f20291bb44d67897baab7
# good: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag
'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
git bisect good 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
# bad: [be18cd1fcae2ed7db58d92d20733dfa8aa0a5173] Merge tag
'mmc-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad be18cd1fcae2ed7db58d92d20733dfa8aa0a5173
# bad: [fc0586062816559defb14c947319ef8c4c326fb3] Merge tag
'for-5.13/drivers-2021-04-27' of git://git.kernel.dk/linux-block
git bisect bad fc0586062816559defb14c947319ef8c4c326fb3
# good: [42dec9a936e7696bea1f27d3c5a0068cd9aa95fd] Merge tag
'perf-core-2021-04-28' of git://git.kernel.org/pub/scm/linux/kernel/g
it/tip/tip
git bisect good 42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
# bad: [2958a995edc94654df690318df7b9b49e5a3ef88] block/rnbd-clt:
Support polling mode for IO latency optimization
git bisect bad 2958a995edc94654df690318df7b9b49e5a3ef88
# bad: [b60b270b3db617811e593db5d5920ed98e67ce49] swim3: support highmem
git bisect bad b60b270b3db617811e593db5d5920ed98e67ce49
# good: [de5878048e11f1ec44164ebb8994de132074367a] nvmet: remove
unnecessary ctrl parameter
git bisect good de5878048e11f1ec44164ebb8994de132074367a
# bad: [5befc7c26e5a98cd49789fb1beb52c62bd472dba] nvme: implement
non-mdts command limits
git bisect bad 5befc7c26e5a98cd49789fb1beb52c62bd472dba
# good: [d8e7b462f5b8b93920c6c6a191be887b32306e6b] nvmet-tcp: enable
optional queue idle period tracking
git bisect good d8e7b462f5b8b93920c6c6a191be887b32306e6b
# good: [25a64e4e7ef6da605a86ec1bff18d2c3c6ed5329] nvme: remove
superfluous else in nvme_ctrl_loss_tmo_store
git bisect good 25a64e4e7ef6da605a86ec1bff18d2c3c6ed5329
# good: [dd8f7fa908f66dd44abcd83cbb50410524b9f8ef] nvme: retrigger ANA
log update if group descriptor isn't found
git bisect good dd8f7fa908f66dd44abcd83cbb50410524b9f8ef
# good: [c881a23fb6f7eb901155d25ba8dd1af0b8c7923b] nvme: disallow
passthru cmd from targeting a nsid != nsid of the block dev
git bisect good c881a23fb6f7eb901155d25ba8dd1af0b8c7923b
# first bad commit: [5befc7c26e5a98cd49789fb1beb52c62bd472dba] nvme:
implement non-mdts command limits

Reverted 5befc7c26e (first 8609c63fce nvme: fix handling of large MDTS
values) on 5.13.6 I don't see the error anymore.


Best regards,

Koos Vriezen

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
