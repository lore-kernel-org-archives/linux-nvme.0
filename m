Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FCC77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8R9fWFJhveC/Tr0RG2k1o1szZvo2X4mY6UFtCHNecA4=; b=JUFO64XvdOJ2p+uiWKpPqqFopG
	lfBtuo7A1TK/TErn7yyYSwpCfDql6fonMvWodGrmebGyrM7I09aWqWmCRLLz/HCh1XvNxRKxsK1jZ
	hVJUc7aqwqrALVzwNkvCmLDm5RyKZqEVdk/abqiQ6MaQXLfEefNuWIIkavtGi4Wbf+hUooFtquizu
	jFBCJhkecZXlFp7WkJ9vtZjJO15MQa3S1GCuK5KYP7xksWJMh3i5WWDhphDvjXAUosE8oSi42Knni
	v21ORdtGmwzCIG+9zPgnYF/Hqav2RLA5w1LVt2mtFL1YoJDCZCetih7TfkrCFoYblxuKMUuvuDv0w
	SGrdjxsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pocAJ-000khC-3B;
	Tue, 18 Apr 2023 03:37:59 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pocAE-000kgp-2H
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 03:37:56 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a6715ee82fso20294225ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681789072; x=1684381072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R9fWFJhveC/Tr0RG2k1o1szZvo2X4mY6UFtCHNecA4=;
        b=TiBaw0C02hiWWWnFfMJGa8x8t4qCby25ACAe4YTvnv6zis2gvWgwgtZDhLkEml71yJ
         0u66HGnVAbXOCcGFcf1vzcSIf6m0cwx5qxv2q7sf7aQxpwF9Q5Zj3GneQP/Ux+YT3U85
         bf7CEuHjj1Va3XXJMEroA6De1hq7jshxC6mklyeu9Tqk0yRI1KX/c/bUJkYYhaBFgfQK
         PNA8oohB7ohZ0WrQNjTyzzNbGER3vvrmU+RucR7Bao0i6TJc+/Uv6wePJr3kzabQzfDM
         c/KEeSQ2Dv5gYSvC7eKtemVukFk4JZ7mb5DyVi++DpRCobkYzjcBH9tvT9VX/yBzWwNB
         zExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681789072; x=1684381072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R9fWFJhveC/Tr0RG2k1o1szZvo2X4mY6UFtCHNecA4=;
        b=eYnknZg1W0HBSebWvtOFoMgP2rSNijDWnLEgGH09NtvJUiYjXQQx4rc9NZUyfd/+CK
         GRED0532YTvW1yihBlCd/VQbJRMbzz0mtPDdu5ImW4BC4WALKNTuQaJhWdPBlGpFouXa
         DgjDv84qfvoLwHkYldFYOD0zPQQp6NqHTkuDF+o2Ww2Ys2kzLAW1JM9YxK1a2j9L3FyC
         j1rnkJ30TFct0JV+bXvT/0ELlxYIWghnEhkA/SBRFhfzeoPqRjT5DVq4HuEjyOJRxZHh
         3Pu1VNIEl8CIl3rsKKvgtuuQhdMme12Zjz6cEOGIdEhEsT2LY+5PZCIKjjz49qSw3vAA
         WJ4w==
X-Gm-Message-State: AAQBX9db+VwQMOFHDlW6aB1VijUaunAdDpDO6iuof6HUFsXFhKgoql5+
	No/j3ErvNMpU21wWgR9w+U9CQA==
X-Google-Smtp-Source: AKy350a1DgwXpeNPHmKni7wCqPet2VBfggUBSuCDkIxFKwsEcN77o8gWXf/QAaRY1a9AKQSHYEleFA==
X-Received: by 2002:a17:903:1208:b0:19c:fc41:2dfd with SMTP id l8-20020a170903120800b0019cfc412dfdmr871408plh.29.1681789071554;
        Mon, 17 Apr 2023 20:37:51 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001a6d4ffc760sm3074921plb.244.2023.04.17.20.37.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 20:37:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
From: Li Feng <fengli@smartx.com>
In-Reply-To: <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
Date: Tue, 18 Apr 2023 11:39:49 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_203754_972494_32492D86 
X-CRM114-Status: GOOD (  23.72  )
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

Hi Sagi,

> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=889:45=EF=BC=8CSagi =
Grimberg <sagi@grimberg.me> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hey Li,
>=20
>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp =
will
>> have a bad performance.
>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
>> socket worker threads.  The parameter is a comma separated list of =
CPU
>> numbers.  The list is parsed and the resulting cpumask is used to set =
the
>> affinity of the socket worker threads.  If the list is empty or the
>> parsing fails, the default affinity is used.
>=20
> I can see how this may benefit a specific set of workloads, but I have =
a
> few issues with this.
>=20
> - This is exposing a user interface for something that is really
> internal to the driver.
>=20
> - This is something that can be misleading and could be tricky to get
> right, my concern is that this would only benefit a very niche case.
Our storage products needs this feature~
If the user doesn=E2=80=99t know what this is, they can keep it default, =
so I thinks this is
not unacceptable.
>=20
> - If the setting should exist, it should not be global.
V2 has fixed it.
>=20
> - I prefer not to introduce new modparams.
>=20
> - I'd prefer to find a way to support your use-case without =
introducing
> a config knob for it.
>=20
I=E2=80=99m looking forward to it.
=20
> - It is not backed by performance improvements, but more importantly
> does not cover any potential regressions in key metrics (bw/iops/lat)
> or lack there of.

I can do more tests if needed.

Thanks,
Feng Li


