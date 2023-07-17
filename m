Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA0EEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jul 2023 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Md2k3SrB9PFNNZtXw1D5bjJvxlmODL3oFcv29rGU+0w=; b=4KH6F5zlC6l49koAeSvsynFrGh
	2w4UpDcjPeTbugN2YTp6w/iO9ioxDcMWkWsCha9FXjchvUOJhBd+HgmkHQT06/GgXOTW1ZUa2IWCK
	Pjrno8s8xMUH2P2O876D+vDVOSU8HYM3+gUPNypmUvr3ZqdygfPQtjiD9PrGJG+3cSFmR6Uq9Xewj
	R1SkCaOn/IicuzMlUKdgvJ/q7+8+hl7Dqf69FTT6SREXog1Zk1BRct6RsBw/i1lvD9oV5txH10wa0
	jVvrVBftFpEpLZs/FsnfpFxKMZgIGf8cL7TPG4Kxf9K4S0qb/d7n37KEDRUciCavMezMn82uPkuUM
	k0wrouNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLJBY-003ONT-2F;
	Mon, 17 Jul 2023 08:02:24 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLJBD-003OLA-0U
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jul 2023 08:02:22 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so5523297a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Jul 2023 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580920; x=1692172920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md2k3SrB9PFNNZtXw1D5bjJvxlmODL3oFcv29rGU+0w=;
        b=Tj9ESHlAIEY5Ok+t1+UQEqgXZpFohXw53hftfkkBeDtkJIo0nBvLvFnisMxq5Rj2iQ
         8PdNEnjyaoS3UOEi9nMjIifEQFGggbFY24svukX5rnVJOCICfNyxM2s59REzz8UWfsIp
         ZawCt/JduBAq7tD9sQFEtpyhZCVMxmJef/ARUOi/5XgDoiiri8ZVk3Ooe/THn+zFXcTM
         z4EiPvrbE/5ScWF5My9n5UAxbY+/u23lKTRQJM9dJ7+ItLjDQcSZkrc1jpUqsaxNIZmm
         zG/iJhwiSZQr96qBLHcF2SeD/Hsp4E00qsw5D1bKsKirfD/yPzGiMrlGRgYG+Tvf2j6d
         BgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580920; x=1692172920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md2k3SrB9PFNNZtXw1D5bjJvxlmODL3oFcv29rGU+0w=;
        b=b+OfrmFBvWNXTA31powC4mITdlk7+fmoyWmi0V60vuQItXvod/9tyoUDB3svqC0yPU
         8Nf8aUrmYQp3/VAXXUuWjLJMq4GLwcWEPqAFUDrmw5Af6HYAFfRQDQnIfwxwoWkTxSgI
         i1nfieCDQMOVrkEIHCXHEYEqJb5jfDb6H3nhnmdSHa/NccVZwPi9EprX65WbxejMorXX
         xh9xdf5fSSZvncJ8WXIH04RgAEf2Lt3zQ03g4qyoXw8juBSSuiJraC3kGwP789QQPH8E
         V+GoddJdnZCn8AtzpSi/QzIYmoGfYUkFTZZa7lDA97cWUXaap3bttnKg2Iz8j83vToL4
         XJ1A==
X-Gm-Message-State: ABy/qLb4d2FkIsvmzKWP0NpuqBb7SBXQEG5CtkxAbezoFrvtVt/UGMKV
	SP4wrZyb9AbVUKh/6wqjmwiK6Lq7UTNPvdbWIK0=
X-Google-Smtp-Source: APBJJlHZQRmdkq0uytrbJpI4dB8Hr+FJMXkrPe3TaMiMWBSlVina9KNg9TPqxFql3z1+rKwkjMtlLgZZSjtgMCU/25g=
X-Received: by 2002:a17:906:20d6:b0:994:4e9c:30c6 with SMTP id
 c22-20020a17090620d600b009944e9c30c6mr3743404ejc.57.1689580920270; Mon, 17
 Jul 2023 01:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com> <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
In-Reply-To: <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
From: Nils Kruse <nilskruse97@gmail.com>
Date: Mon, 17 Jul 2023 10:01:49 +0200
Message-ID: <CAKVFSw+_EFNaYjOjNDQ0zOGoSFMt3yZctR47Rcss2KhkfNQJ9g@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
To: August Wikerfors <git@augustwikerfors.se>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_010204_091559_2D549E2C 
X-CRM114-Status: GOOD (  11.76  )
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

On Sun, Jul 16, 2023 at 9:30=E2=80=AFPM August Wikerfors <git@augustwikerfo=
rs.se> wrote:
>
> On 2023-06-11 13:41, Nils Kruse wrote:
> > Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids
> > for disk.
>
> Is this the same issue with suspend as [1], [2] and [3] or is it a
> different case?
>
> [1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors=
.se/t/
> [2] https://github.com/tomsom/yoga-linux/issues/9
> [3] https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augu=
stwikerfors.se/

Yes, this is the same issue.

