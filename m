Return-Path: <SRS0=g/A8=MX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD0C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jul 2021 08:33:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D12C60F39
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jul 2021 08:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D12C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ZzDnGmQvhZX8Iagxpy5mKSvk3OE4zvzTp8w5hB7G5lA=; b=oGy
	1tpggut1cmtM4upAJdtXiC5f1LCsqJBABW3qdv5lFWzYy8PbCzWbuI2M1kism5iATFNQG414B0aAN
	zpWZfbe+VAxz00g1qwmt0ikixPGvkhMpUkdJtsO9O75LCWW7j1oe6UzVAoUrVkta0QtxEfANOSa/z
	7Dftg2iVLHTocn2uXtwF5ALLD+qmIJptr/gh2Ucn1Pzv7ebgxYtDOkt+HBRSxA2+L9rulcTFprIA5
	89hK7ZhfnaDBKm2Wv0kYbcXdKUk0tdM/k24XgdP0cOpfhBIn2UCF1eVC0kHn2XpDWuEr2t3vtFwi8
	LHHrfvynERZTWe22M8tUEMWKdftm2mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m9kQ9-00BH6d-SH; Sat, 31 Jul 2021 08:32:37 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9kQ6-00BH5y-4H
 for linux-nvme@lists.infradead.org; Sat, 31 Jul 2021 08:32:35 +0000
Received: by mail-vs1-xe36.google.com with SMTP id a8so423601vsl.4
 for <linux-nvme@lists.infradead.org>; Sat, 31 Jul 2021 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
 b=ZwUh8aXIDGcNolWsbCB330z40qs8o2QO4szCdu67RFkja+DyNJHNvai7dNl2MLvibi
 /gD+8rw5J2eAOeEzSOyvs9cmFFQk+MKy8H5lM1JD9im0l06FYEe9/ePS1gsTIDH9fReV
 jqfk2DcAPSoGBYgwsxwSf545lD/CsSF+HbFGMtC21gpSkE8dlTPDXWg9ibIleWpDTLm+
 J/9xfReph5mBe28RrkWHLlDebZa6OkAy23B5FCOIIl7JgaImmvjzW1FOfU56MU/MR1sW
 h6LDYD2lFnVbt01L0fSqK22N4xWcZ3SRSMhS1W089AiHWUkEam3hDT8EaKJyvTAV8T5s
 t9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
 b=FTLbNzOxu/albDYMszsFnGZJ5j6jc8qO2XQyFPeFFmNHizCAtiDv0aylt7QHah8PQ5
 ItSD5iYFBu+VNahcFVBD1vlGT1CkVguaukfCR5ZYW8Pn+0zMz1NgvOGu927u57WF/bkJ
 LvYH7fMBawIx6oejwDzus1JJVkpQI8a5eVa5eZXkBiEtx11yGJc4+RHobjdv3E6NrhDS
 UaEVQg1PRIWdfcQbyPSJ+xQMpQ5sD5JvpysRaOhv0mVS9FxTsBfQ3J1ig9vsTmiEkaUd
 uWZC7WGjcKINTCgh4fIj68/a8y0Ea6HVUX+hPFErJE3loXVCv/bsQFOcMdydjoDFbtr0
 kKJg==
X-Gm-Message-State: AOAM532zHYDAJE1fRTN0jBPBIovdxKpnn4sulPph5jKBCTpjOMBLfGQH
 Y3TQ1aTGqyx3sAZ/kFnGWZXJYK309sSNPZyGbLAaClFFTwT9PixU
X-Google-Smtp-Source: ABdhPJw+oWlJx/a0MyH3kButeMxB7WuIVNQ7fKO11dKUs+LcNu3FvufTRoK4LNy53zUZHrPTdoawRX6UHVtkvgxL7Bw=
X-Received: by 2002:a67:e2da:: with SMTP id i26mr5141177vsm.16.1627720351243; 
 Sat, 31 Jul 2021 01:32:31 -0700 (PDT)
MIME-Version: 1.0
From: koos vriezen <koos.vriezen@gmail.com>
Date: Sat, 31 Jul 2021 10:32:20 +0200
Message-ID: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
Subject: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log entries
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210731_013234_232629_13C12601 
X-CRM114-Status: UNSURE (   5.38  )
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
