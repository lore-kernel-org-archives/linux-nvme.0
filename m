Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636ECC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 08:21:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F335F23105
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 08:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F335F23105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3LJGDkRS10530ykkfU7+EkG6JlW/Y+tpy78VhAt2j5g=; b=yyyum131cugt5A5NpDhstQDn0
	eB9DzFdlEHJiQQzuwPpPxsZmLvyvq6VT5SPL4fxJPvCInyKdpUluAhzbroYyO6xiDo8WfsS53wKt3
	GX7t8Nq7TigBYz8idV8yIC2zKLyYGl5Ksp3Y9maHAxIq85MI+5a+yYJsTvNcy/X81E5p8wN6shW3u
	fi+mMs0UKm9ZwFIVnOADn7A8sx4VVbDjxgMp+EKJCN75x8k7McbPTx3qYBwBQ1cqT3cXJdADyPdHW
	ZW6RTU6LHZQ8WXVAJCxJGkQ5d0GwDIoqkaYyDvrUo8Gn1TGOdzXOuNGChj0F19odVIPCsOciBQpMM
	rYrIFRhiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kx44J-0001ev-0e; Wed, 06 Jan 2021 08:21:23 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx44E-0001dn-TS
 for Linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 08:21:19 +0000
Received: by mail-ed1-x52e.google.com with SMTP id r5so3556629eda.12
 for <Linux-nvme@lists.infradead.org>; Wed, 06 Jan 2021 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zs7ZbPd23GibHm7zDlwWFsES3tdAlQiEZOlKRWRgaa0=;
 b=jLIVF9dx+SeL/d9jNSy/YHCKSis9eRlMXeWuR/74ZWIMUB2mUE5d4OzFSRrkfOLlCo
 zNcw2xddp9I+VGfibIa9okNn6PLPSe/NV6MDqwOQ1i78omnBc2P850w+fD8qHrmfOiT1
 4cyB/9+HMEozJgR98N0gCE86btEnDvXL1ikB15zSdt1Wd/o9+pQ0EVfFbxuoZAdyv0nE
 xjQxgf2P6ClgAPSwnRQo3P+wQWLVO+K48VaKrlYVbz6MwCdm/DBSyD8UwQnM1Y4cml61
 zJdO7cgj275a2YSPfAlSPjtQCDB3vp9pzjnnjFyboEZWmWm0S2wqPbtlnKPF/o0W0B3T
 EToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zs7ZbPd23GibHm7zDlwWFsES3tdAlQiEZOlKRWRgaa0=;
 b=WsGH+zjmmRjyWaX6pVlcABDvLsmxuKYYPoLTigfSYi1W2WV8ZCmNCEQCTAr7PGzAYK
 kNepOni3FsqtE/6BE+/muCeuhuPPPdjCDNL8xKQoDugD+WLEhA1e6j4IWAYsuvdDtPGF
 qoyOYr2FURYZ+RoYgp5+NsTqYUJ5AKGze2pkPF1jgDn7O8SWpb3IpDqtLuidkLCwbs7B
 CkhBiWGr7tO4LH7bz6YdMvHP+Jq/0Em9NAC2Apg0WGkN7lWXulEXG4MYwSybiaqycU6r
 lN1EaNSdn+k2XeGsD8NURybs3P3h7wQboBK3KckiHuHbuv+C1LWZm0V+iOIqdN/v2rQj
 9tvA==
X-Gm-Message-State: AOAM533oYDlx9WQJ48/TdSzOh29gZJ4evto/tLGJwa8fb2Q/HJwxm7IH
 mTBiwBqoQHe2D6OaGcuXneOOjt8fJwGlQlSjaF1MKv1i
X-Google-Smtp-Source: ABdhPJw9FlHRn7BIgXuv/QLKU91Ul/s/IiWHk6gQMJuPg5tdkO1sq+r4dpxEqthDFcIfFuemThI9TQ6HILohso7pGw4=
X-Received: by 2002:a05:6402:30ac:: with SMTP id
 df12mr3350441edb.175.1609921275795; 
 Wed, 06 Jan 2021 00:21:15 -0800 (PST)
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
Date: Wed, 6 Jan 2021 00:21:04 -0800
Message-ID: <CAJS6EdhbhqEOSzHLhC-hs0Uj9gTOGV+PwKuR4+z44cx_MwwOoA@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_032118_967239_7C851F42 
X-CRM114-Status: GOOD (  11.01  )
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

Plan to get to this over the coming weekend. Sorry for the delay.


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
