Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC60C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 10:11:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390FE22283
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 10:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390FE22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U/vyJ1SCZ6g6gGXNSz2OxITm00eSCKAr9C7yGQsDCtA=; b=wt6Mjxnebjcae6V6zA0t/8x8+
	GrpmXnNBCR6cgP8bQUFt3wKwYHSX3xH0R/O9ZRuHWvAPPYb2Eq9txOVSlcECx30KP+W/2GmJsnqLW
	F8xQsIFEtIJ5nugNuR9dmYDvOXIjljM9QLFxd8FyKpuOUcvrTuU7LDFcZSWYNg5MgP1xd9SJZdlD7
	z4GmgxVeFpb1hxY+slJGoC1ZyONQRItW7tOMqUOuJTdUC/kLj6IxVFmYavURlM8TV59EJspEL1GN4
	U5wJykfZtZYA0zgiU3gNhOqmTF46kxtlLI+8QZ1ZPzYOYOsa/aXtjm0rSEqiEztE1qHEEGlbYSSYV
	AaHWORAqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyuAH-00082a-AA; Mon, 11 Jan 2021 10:11:09 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyuAE-00080c-CH
 for Linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 10:11:08 +0000
Received: by mail-pj1-f41.google.com with SMTP id iq13so7506609pjb.3
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 02:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tQXVRgvfonJ4PEuTRbzxudPjNRS7omJH7DB35YDBEbE=;
 b=qS1Mv7agQxrH891K0OGsesQy0Zk2VMgELyvWbefH9Flln1w3Pgx8+1EoRf/wU6x/1r
 ZK6t1ZMNjWraNNn/52knenBCRl9YbKsczTUuxvEJNyf66nq1PzL5rY82D6kQiH+PFlMa
 C/9ek2Xni5bFsdm/6NqUa3DAUd1pd+AyPnNtgTpSwWKQiEm6kEbYm/pUO0Urnv43A3iD
 ZxvItvKk4Bh0SJA5iilCAGBD/nk/slssNTpuIKcYFYqAv+BbkFXMwnImsoo+abNUm4/u
 mGAsEQu3oMOsEsa2INH1LugSTvws5QKA0/xWUOeIbaCrS/t/UpscCpvhmKbuA/spe0bI
 8feg==
X-Gm-Message-State: AOAM530aMomQn3PzuTSG0THbsFWafanyX1MV0JvHLDWVDQ5C2WNJftmU
 SgLYe7XESXIX9j0v9fUTn8Fk0CoGfpQ=
X-Google-Smtp-Source: ABdhPJwJMxM/LlQgCSxn/uIxwfrGBNphIw7dpdd/ooij9jeB0BTlJSD0Prjqrk7Cb0BGsmTmywi3dA==
X-Received: by 2002:a17:90a:c082:: with SMTP id
 o2mr17604769pjs.197.1610359863620; 
 Mon, 11 Jan 2021 02:11:03 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:4dcc:f2e6:c29b:ef3c?
 ([2601:647:4802:9070:4dcc:f2e6:c29b:ef3c])
 by smtp.gmail.com with ESMTPSA id b13sm18702490pfi.162.2021.01.11.02.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 02:11:02 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
 <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
 <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <16fe1e9c-3a43-ef28-7b69-755e6a86464f@grimberg.me>
Date: Mon, 11 Jan 2021 02:11:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_051106_467125_74B1EBB8 
X-CRM114-Status: GOOD (  14.04  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hey Sagi,

Hey Hao,

> I exported 4 devices to the initiator, created a raid-0 array, and
> copied a 98G directory with many ~100MB .gz files.
> With the patch you give on top of 58cf05f597b0 (fairly new), I saw
> about 24K prints from dmesg. Below are some of them:

Yes, I understand it generated tons of prints, but it seems that
something is strange here.

> [ 3775.256547] nvme_tcp: rq 22 (READ) data_len 131072 bio[1/2] sector
> a388200 bvec: nsegs 19 size 77824 offset 0

This is a read request and has 2 bios, one spans 19 4K buffers (starting
from sector a388200) and the second probably spans 13 4K buffers. The
host is asking the target to send 128K (data_len 131072), but I don't
see anywhere that the host is receiving the residual of the data
transfer..

Should be in the form of:

nvme_tcp: rq 22 (READ) data_len 131072 bio[2/2] sector 0xa388298 bvec: 
nsegs 13 size 53248 offset 0

In your entire log, do you see any (READ) print that spans bio that
is not [1/x]? e.g. a read that spans other bios in the request (like
[2/2], [2/3], etc..)?

> [ 3775.256768] nvme_tcp: rq 19 (READ) data_len 131072 bio[1/2] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256774] nvme_tcp: rq 20 (READ) data_len 131072 bio[1/2] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256787] nvme_tcp: rq 5 (READ) data_len 131072 bio[1/2] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256791] nvme_tcp: rq 6 (READ) data_len 131072 bio[1/2] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256794] nvme_tcp: rq 117 (READ) data_len 131072 bio[1/2] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256797] nvme_tcp: rq 118 (READ) data_len 131072 bio[1/2] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.256800] nvme_tcp: rq 5 (READ) data_len 262144 bio[1/4] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257002] nvme_tcp: rq 21 (READ) data_len 131072 bio[1/2] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257006] nvme_tcp: rq 22 (READ) data_len 131072 bio[1/2] sector
> a388600 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257009] nvme_tcp: rq 7 (READ) data_len 131072 bio[1/2] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257012] nvme_tcp: rq 8 (READ) data_len 131072 bio[1/2] sector
> a388600 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257014] nvme_tcp: rq 7 (READ) data_len 131072 bio[1/2] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257017] nvme_tcp: rq 8 (READ) data_len 131072 bio[1/2] sector
> a388600 bvec: nsegs 19 size 77824 offset 0
> [ 3775.257020] nvme_tcp: rq 6 (READ) data_len 262144 bio[1/4] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262587] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[1/2] sector
> a388200 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262600] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[2/2] sector
> a388298 bvec: nsegs 13 size 53248 offset 0

For (WRITE) request we see the desired sequence, we first write the
content of the first bio (19 4K segments) and then the content of the
second bio (13 4K segments).

> [ 3775.262610] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[1/4] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262617] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[2/4] sector
> a388398 bvec: nsegs 13 size 53248 offset 0
> [ 3775.262623] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[3/4] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262629] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[4/4] sector
> a388498 bvec: nsegs 13 size 53248 offset 0

Same here and on...

> [ 3775.262635] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[1/4] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262641] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[2/4] sector
> a388598 bvec: nsegs 13 size 53248 offset 0
> [ 3775.262647] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[3/4] sector
> a388600 bvec: nsegs 19 size 77824 offset 0
> [ 3775.262653] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[4/4] sector
> a388698 bvec: nsegs 13 size 53248 offset 0
> [ 3775.263009] nvme_tcp: rq 5 (WRITE) data_len 131072 bio[1/2] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.263019] nvme_tcp: rq 5 (WRITE) data_len 131072 bio[2/2] sector
> a388398 bvec: nsegs 13 size 53248 offset 0
> [ 3775.263027] nvme_tcp: rq 6 (WRITE) data_len 131072 bio[1/2] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.263034] nvme_tcp: rq 6 (WRITE) data_len 131072 bio[2/2] sector
> a388498 bvec: nsegs 13 size 53248 offset 0
> [ 3775.263040] nvme_tcp: rq 7 (WRITE) data_len 131072 bio[1/2] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.263047] nvme_tcp: rq 7 (WRITE) data_len 131072 bio[2/2] sector
> a388598 bvec: nsegs 13 size 53248 offset 0
> [ 3775.263052] nvme_tcp: rq 8 (WRITE) data_len 131072 bio[1/2] sector
> a388600 bvec: nsegs 19 size 77824 offset 0
> [ 3775.263059] nvme_tcp: rq 8 (WRITE) data_len 131072 bio[2/2] sector
> a388698 bvec: nsegs 13 size 53248 offset 0
> [ 3775.264341] nvme_tcp: rq 19 (WRITE) data_len 131072 bio[1/2] sector
> a388300 bvec: nsegs 19 size 77824 offset 0
> [ 3775.264353] nvme_tcp: rq 19 (WRITE) data_len 131072 bio[2/2] sector
> a388398 bvec: nsegs 13 size 53248 offset 0
> [ 3775.264361] nvme_tcp: rq 20 (WRITE) data_len 131072 bio[1/2] sector
> a388400 bvec: nsegs 19 size 77824 offset 0
> [ 3775.264369] nvme_tcp: rq 20 (WRITE) data_len 131072 bio[2/2] sector
> a388498 bvec: nsegs 13 size 53248 offset 0
> [ 3775.264380] nvme_tcp: rq 21 (WRITE) data_len 131072 bio[1/2] sector
> a388500 bvec: nsegs 19 size 77824 offset 0
> [ 3775.264387] nvme_tcp: rq 21 (WRITE) data_len 131072 bio[2/2] sector
> a388598 bvec: nsegs 13 size 53248 offset 0
> [ 3775.264410] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[1/2] sector
> a388600 bvec: nsegs 19 size 77824 offset 0

 From the code it seems like it should do the right thing assuming
that the data does arrive, will look deeper.

Thanks for helping to dissect this issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
