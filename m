Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF73C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 02:22:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A1522B37
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 02:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A1522B37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oouuzFV8ZIszBlwUp/VYKmfOlTpKuudwavse88poBto=; b=Aa+wUa+/sFDKtmdkw6Me7Z5IL
	QyjDKFEiWN7eGmJtn4vTr2U/dq23Dja5DxOVamoiIO3bsVjbC4wDzwwP1RLUY4e1Kh31VwV3GxwSs
	Z8ZIjWAbYkOOSdnvIS8grxwGkM+i2kMwxhyO6j8XfMsYOPAi5hjyNhU87LJurnr3drXRcdcwT/smn
	sExaoElcwiXrZL6W2Z9dgSFuLfc9xwb5vGA201zWRMFaBwg734QS1vKayJGlomCHJltFkEZT5OD71
	h4NqWmdyQFa+bY9ZsP0A45BppCMphT8605C3CFHLxrRV7Vn1I3LaeYyI2fWTpDkg4Sov5rHTNYyb8
	graUywsqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz9KA-00058X-VM; Tue, 12 Jan 2021 02:22:23 +0000
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz9K7-00056Y-W1
 for Linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 02:22:20 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id f13so723194ybk.11
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 18:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qdxQVqRy7mBLTSDsVjoxEcxXQmK+MRCpWwvYzFBWdBY=;
 b=Te498q2VjedZwZAruShRBWsUsXHqGtOJGhF2Tr8R7p/YU3g9EpK42stYpuumhmEXXe
 HDK08vRoHgqXqtQWyUxXpQWqS1/0nnDGRXhSkuTOYBW6jswWJkxWEQlh+g6/Bcm419X1
 JfnmCxV2rSKmPANXkWB9oR/P3SCbyZv+FtB101bP2Zaci51GlXnqmPGlb70Q/5Z95IEq
 QRD07ZkvV2GGbVsUtLpbaXB52tkB3fPvl2IISd5HeN0Fpw+zgCBURjEfgUBeXGHvamOd
 iMPjqhFiWtLMsq/jos/8V7xKbLbS64N38kBQrB+bHL1tMYYRwDn8zsBJ7WClRsXjf9e8
 E6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qdxQVqRy7mBLTSDsVjoxEcxXQmK+MRCpWwvYzFBWdBY=;
 b=KCF7R/YQJcShgruTb5uXcWoEWsng+QGcRutBgnI6DzdSbN+h1jiQdEC64OnEbAKJFU
 LptaJzZYcvuphTJJU/EEPdhwWk/kN2UbZMpmhzUsrmW3dkeI5oR7WSWB1qop+MKoTaK1
 jcxgsJzjHBOfAFuXXjPDDEELCDeKjA5J7PD0BZU9MkVB1I5Ceck9+bACL3pGoPxDOPvL
 uNU/mMPRZH7iC+Ji8930Sqa4a56kuraiY6rk0m2QQo7u9N/5FH6girgebu4a820Ooihd
 1E/GKOxr/fLirqtTwYuX0BH4VHLz7mACihuq/cVgSdFt0d2VtgllsUOFzc4P4ZHb9LOG
 0taw==
X-Gm-Message-State: AOAM532xOwslf3xXUo030mQN6ZPYB+KsLoEC7okRXkoDPYPOHo6d+DpD
 03GTHxztjqWfx6lc8WYh3EWqCU30YdTjOSG3xjY=
X-Google-Smtp-Source: ABdhPJxId4PUuh5stekY7aM+W8PogkTyab4Orkl7oa9WoYU+BvLvt/HeyGiNyA9ukmGm2W39+5wCD+roAe3SAeHAYcM=
X-Received: by 2002:a25:5b82:: with SMTP id p124mr4118231ybb.117.1610418136461; 
 Mon, 11 Jan 2021 18:22:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
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
 <16fe1e9c-3a43-ef28-7b69-755e6a86464f@grimberg.me>
 <CAJS6Edi9Es1zR9QC+=kwVjAFAGYrEru4vibW42ffyWoMDutFhQ@mail.gmail.com>
 <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
 <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
In-Reply-To: <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 12 Jan 2021 10:22:05 +0800
Message-ID: <CACVXFVNwhFTq2Aq7bx7cwmhab4itkAntF-TKunv59XoZySy51w@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_212220_074811_799FE13F 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Hao Wang <pkuwangh@gmail.com>,
 linux-nvme <Linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 12, 2021 at 9:33 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hey Hao,
> >
> >> Here is the entire log (and it's a new one, i.e. above snippet not
> >> included):
> >> https://drive.google.com/file/d/16ArIs5-Jw4P2f17A_ftKLm1A4LQUFpmg/view?usp=sharing
> >>
> >>
> >> What I found is the data corruption does not always happen, especially
> >> when I copy a small directory. So I guess a lot of log entries should
> >> just look fine.
> >
> > So this seems to be a breakage that existed for some time now with
> > multipage bvecs that you have been the first one to report. This
> > seems to be related to bio merges, which is seems strange to me
> > why this just now comes up, perhaps it is the combination with
> > raid0 that triggers this, I'm not sure.
>
> OK, I think I understand what is going on. With multipage bvecs
> bios can split in the middle of a bvec entry, and then merge
> back with another bio.

IMO, bio split can be done in the middle of a bvec even though the bvec
is single page. The split may just be triggered in case of raid over nvme-tcp,
and I guess it might be triggered by device mapper too.


Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
