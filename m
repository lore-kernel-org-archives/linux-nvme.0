Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B9C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 08:56:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D95F22581
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 08:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D95F22581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RlOgPcq9E14VV696vg/lTSEFYqkhhsihxXxBRZRyx+Q=; b=gc/PFyXZVe4NQewsLOwtGv4A1
	O6SzF/YdXF+yaBqT12qpZv10UiDv6PeTjgLbzGdPpdQqr6jhTD3HyvgEBjHa1VYcSWGICT+f+c3QV
	vYp/BmmiLReBojonVquejUYkWLUHCa/KeZmYLgicL7vFpgy183wVd+abyjO0ZbMgWRw2Plri91fIU
	1czUt8BHpLD5VShOBUPnvI9CgzFfAN3ShEI/0yKvz+WmVs0T2HG39vfc+7YbVhW2mj1dL0E65HDVH
	IOhaxU2kkitCpc6qsrOGa2PxKQm0MZcbVAcB2O9lNFQtjKhmq7VG20zv/TF3NdDINk7tJD/fz8EYR
	ZrQIrdWsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyszy-0000wU-VT; Mon, 11 Jan 2021 08:56:27 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyszv-0000uY-Tn
 for Linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 08:56:25 +0000
Received: by mail-ej1-x634.google.com with SMTP id ga15so23607324ejb.4
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 00:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7Ds5gNtbzHPta9ELhuQeLgV2+IDvMvxsXzMy1lN7VU=;
 b=Cb4oEJuynucZXQgeYzH7HIjQOF4OgbMuS4qjMjUBwenNMmKMJijMLfBsOQDBYLUVkm
 FknC08IHkM/PtxZMj3UI+ZSyCjH3Dv4n1+m/g4h5C6GDJYsS9G7DY5K5w0SUiosNchoy
 qHx10p9LInoPsGuP6z43gv/4L7k8P5qlcfvzm0yBmPq+oPQfJEUNz7mPHflKKwHe2bFW
 3nwDEAGMAjcNdiP/WdNT+iDPmHxXuO7wIfZH9fhdTqlt8KUcZvcxQKqQsKHdFjfCNKW9
 r/wc1gZ5OijeLpZjXNOZ+QSijG5b+ZFM43+qIpi/bslNYg8T5ygwN6zVOFMSZpYvIAXt
 8CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7Ds5gNtbzHPta9ELhuQeLgV2+IDvMvxsXzMy1lN7VU=;
 b=X73iCy8XBvP85kbFqN6WAlIdIY+Dn1bLQnUfX+fuq3l+JRvwwHFHLWyy4awYjdioZd
 H7oTzJK7BkvHvIVtV6iWCILUFA9OQuUyMJVXxneDZEa+RYYIuCbHzoMtxK6FDUDtWbKX
 eVHKkHo8rdV+MwLZ0g7v0++2ENaB/lWraYmeGnrCZPNuxuDUqZKdCy4E3S2ygK4QY+qP
 JwGprpxdrrR05WcyeC4Q1UY2xB2k3zDM3EuqP9RbIgv5CAzfzuuAVebPJ+KlCrDkjk2f
 P0+yJWJM5e2jO4cjf9Tt55nB//l0qsLv9+mR1tfiHSQsdEAbX55W+og5DDHRnSdS3Xgv
 YyRQ==
X-Gm-Message-State: AOAM532laHJObg28Oy1jLA7Mkhes7zGcZwWdaGIKq2rfPBAAYRSyHr21
 pprqPdQox04AiPp5dsjpWjO0/tHz2l8/9YO+KWc=
X-Google-Smtp-Source: ABdhPJxb0Ji7TeviEn9KfkVXOo6vIUWfflVS0N3vNWH6R1X+jgCA76JsgW8jg1RRMKPMXEYGVmQaJqABvMzgF+YinGg=
X-Received: by 2002:a17:906:4348:: with SMTP id
 z8mr10188567ejm.371.1610355380753; 
 Mon, 11 Jan 2021 00:56:20 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Mon, 11 Jan 2021 00:56:09 -0800
Message-ID: <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_035624_006428_CAFCD76E 
X-CRM114-Status: GOOD (  11.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Sagi,

I exported 4 devices to the initiator, created a raid-0 array, and
copied a 98G directory with many ~100MB .gz files.
With the patch you give on top of 58cf05f597b0 (fairly new), I saw
about 24K prints from dmesg. Below are some of them:
[ 3775.256547] nvme_tcp: rq 22 (READ) data_len 131072 bio[1/2] sector
a388200 bvec: nsegs 19 size 77824 offset 0
[ 3775.256768] nvme_tcp: rq 19 (READ) data_len 131072 bio[1/2] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.256774] nvme_tcp: rq 20 (READ) data_len 131072 bio[1/2] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.256787] nvme_tcp: rq 5 (READ) data_len 131072 bio[1/2] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.256791] nvme_tcp: rq 6 (READ) data_len 131072 bio[1/2] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.256794] nvme_tcp: rq 117 (READ) data_len 131072 bio[1/2] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.256797] nvme_tcp: rq 118 (READ) data_len 131072 bio[1/2] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.256800] nvme_tcp: rq 5 (READ) data_len 262144 bio[1/4] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.257002] nvme_tcp: rq 21 (READ) data_len 131072 bio[1/2] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.257006] nvme_tcp: rq 22 (READ) data_len 131072 bio[1/2] sector
a388600 bvec: nsegs 19 size 77824 offset 0
[ 3775.257009] nvme_tcp: rq 7 (READ) data_len 131072 bio[1/2] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.257012] nvme_tcp: rq 8 (READ) data_len 131072 bio[1/2] sector
a388600 bvec: nsegs 19 size 77824 offset 0
[ 3775.257014] nvme_tcp: rq 7 (READ) data_len 131072 bio[1/2] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.257017] nvme_tcp: rq 8 (READ) data_len 131072 bio[1/2] sector
a388600 bvec: nsegs 19 size 77824 offset 0
[ 3775.257020] nvme_tcp: rq 6 (READ) data_len 262144 bio[1/4] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.262587] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[1/2] sector
a388200 bvec: nsegs 19 size 77824 offset 0
[ 3775.262600] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[2/2] sector
a388298 bvec: nsegs 13 size 53248 offset 0
[ 3775.262610] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[1/4] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.262617] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[2/4] sector
a388398 bvec: nsegs 13 size 53248 offset 0
[ 3775.262623] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[3/4] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.262629] nvme_tcp: rq 5 (WRITE) data_len 262144 bio[4/4] sector
a388498 bvec: nsegs 13 size 53248 offset 0
[ 3775.262635] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[1/4] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.262641] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[2/4] sector
a388598 bvec: nsegs 13 size 53248 offset 0
[ 3775.262647] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[3/4] sector
a388600 bvec: nsegs 19 size 77824 offset 0
[ 3775.262653] nvme_tcp: rq 6 (WRITE) data_len 262144 bio[4/4] sector
a388698 bvec: nsegs 13 size 53248 offset 0
[ 3775.263009] nvme_tcp: rq 5 (WRITE) data_len 131072 bio[1/2] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.263019] nvme_tcp: rq 5 (WRITE) data_len 131072 bio[2/2] sector
a388398 bvec: nsegs 13 size 53248 offset 0
[ 3775.263027] nvme_tcp: rq 6 (WRITE) data_len 131072 bio[1/2] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.263034] nvme_tcp: rq 6 (WRITE) data_len 131072 bio[2/2] sector
a388498 bvec: nsegs 13 size 53248 offset 0
[ 3775.263040] nvme_tcp: rq 7 (WRITE) data_len 131072 bio[1/2] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.263047] nvme_tcp: rq 7 (WRITE) data_len 131072 bio[2/2] sector
a388598 bvec: nsegs 13 size 53248 offset 0
[ 3775.263052] nvme_tcp: rq 8 (WRITE) data_len 131072 bio[1/2] sector
a388600 bvec: nsegs 19 size 77824 offset 0
[ 3775.263059] nvme_tcp: rq 8 (WRITE) data_len 131072 bio[2/2] sector
a388698 bvec: nsegs 13 size 53248 offset 0
[ 3775.264341] nvme_tcp: rq 19 (WRITE) data_len 131072 bio[1/2] sector
a388300 bvec: nsegs 19 size 77824 offset 0
[ 3775.264353] nvme_tcp: rq 19 (WRITE) data_len 131072 bio[2/2] sector
a388398 bvec: nsegs 13 size 53248 offset 0
[ 3775.264361] nvme_tcp: rq 20 (WRITE) data_len 131072 bio[1/2] sector
a388400 bvec: nsegs 19 size 77824 offset 0
[ 3775.264369] nvme_tcp: rq 20 (WRITE) data_len 131072 bio[2/2] sector
a388498 bvec: nsegs 13 size 53248 offset 0
[ 3775.264380] nvme_tcp: rq 21 (WRITE) data_len 131072 bio[1/2] sector
a388500 bvec: nsegs 19 size 77824 offset 0
[ 3775.264387] nvme_tcp: rq 21 (WRITE) data_len 131072 bio[2/2] sector
a388598 bvec: nsegs 13 size 53248 offset 0
[ 3775.264410] nvme_tcp: rq 22 (WRITE) data_len 131072 bio[1/2] sector
a388600 bvec: nsegs 19 size 77824 offset 0

Hao

On Tue, Jan 5, 2021 at 5:53 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Hey Hao,
>
> > Okay, will do that in a few days. Something else just popped up and I
> > have a limited time window to use some machines.
> >
> > BTW, what is the performance implication of disabling merge? My usage
> > pattern is mostly sequential read and write, and write bandwidth is
> > pretty high.
>
> Did you get a chance to look into this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
