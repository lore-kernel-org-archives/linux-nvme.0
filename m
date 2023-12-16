Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391EDC41535
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Dec 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvRVmZz0fw4sy81ISwg0UmUCzFZE4mCNoPdzHScTDrI=; b=JjGGwVsjBW21ZmMpdT4wYu9tYJ
	qDzo1ewRFcQ7ANKq8d//N//0xxcJyks7o38ncneMrFHgfJ43h0bJrRAtjn81S7F/lwqlNHAsiDF2f
	KENwE11jAxveAz+EScKOX9Aszcx+okk5q7LIblh8ROOHkKCVfj1s6NKuYqlOvAxg8LWo4WdO/wfXb
	4Ap45cbqSMghkY/SZ+rXtFAZIEfl6NXhG8JKZkZFm5E5T9CsNMtKlOHuWHJceOhGmVG58NMpI7tlR
	TKKc5O7gs2L+SEnlwJCM16zIzhO9jFW99DricOJ6GODVdEd4ktvFWApJqBuboH8t4LTdDYODKraWP
	lfwAW0sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZDu-006W2P-0L;
	Sat, 16 Dec 2023 18:17:14 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZDo-006W25-2Q
	for linux-nvme@lists.infradead.org;
	Sat, 16 Dec 2023 18:17:10 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-dbd0728beceso834340276.2
        for <linux-nvme@lists.infradead.org>; Sat, 16 Dec 2023 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702750627; x=1703355427; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRVmZz0fw4sy81ISwg0UmUCzFZE4mCNoPdzHScTDrI=;
        b=B59ybENjuqxuzol7/wmY0mx8kktx/sEw7j82E8zxdfDORhBh6CfbpRzftyQ1/x7/19
         2kEKK3bN6Pej9wyhe0aPGDZEdTyM+80JE9Cndf1p3RDOjGpGVUbzbkUe0fN8xDlxHoUP
         eFloZotY3t55DFURq5tQGAOVQb/+Nu1tW/CLPf4L+ECmlZlUnc91gAVQntZdIP0tUtDu
         UFyswFZSt72ewPdY64K38o2b/O7CQDPgX2kcjZ8Dpp7p3mmPD0uwMzViIaIjmLnsyOsW
         BmWf7tgy2dSo0HMtAyl1BJjMrZq8SGSF9yxzjEQADfmOYYIS327qeVsX0vmTdoyBzcPJ
         rimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702750627; x=1703355427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvRVmZz0fw4sy81ISwg0UmUCzFZE4mCNoPdzHScTDrI=;
        b=kWe7k+s5wG/e77QSTqr+vT3nAA4K34JL0kXabCLPEhtwjUB/r1994GQzfAsGiwUqGM
         kNleGxQtP7qNMJhhByv9TZB9A67nrtNG5/a0B1lBbCQ1jacGf3HlGcWuD6IfD58thZ1v
         ozZM2bO+pwV6YfLI3qZpqRk+rVxODc1yzLmqQRyo2DpK48AEDLnOOhq2N3Ak+LZfI7GL
         0phCySIGExPI2fHClu6L6CnfA8r3lPIYz97q/n3cDb/1ywIDxTSa8XWBBXeG50XFsN0p
         s90KKapZi9Q/xRlfTPgUn8L9St+hNmM8blsOZUYmGDOcAD3HwLYnI3KLddSFoVGPPzVN
         EB7A==
X-Gm-Message-State: AOJu0Yz7jw825yPlNc+9Q9zadBCHMjYlKlD7Mt4zFpLf3qrTuTd3MZ6D
	hPtKdY8/rh+syI4arMkq1BzMGAXHxlAxrDWeBl0=
X-Google-Smtp-Source: AGHT+IFn9alYrc6pyynJlC3AzJi9+jW7Hyc4Xh9rzrTv9HUyVpLWeYI0lwWtoeqlkhu4lV+c1wb6aazE7dSYi/iN6fw=
X-Received: by 2002:a25:5f03:0:b0:dbc:1b67:e358 with SMTP id
 t3-20020a255f03000000b00dbc1b67e358mr8995770ybb.95.1702750626697; Sat, 16 Dec
 2023 10:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20231206100253.13100-1-joshi.k@samsung.com> <CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>
 <20231206100253.13100-3-joshi.k@samsung.com> <ZXpWOaxCRoF7dFis@kbusch-mbp>
In-Reply-To: <ZXpWOaxCRoF7dFis@kbusch-mbp>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Sat, 16 Dec 2023 23:46:55 +0530
Message-ID: <CAOSviJ2U_yTgvx5SBPvkOg0nZ8wNxRCJyLWZ_zBnN74HcDFA1A@mail.gmail.com>
Subject: Re: [PATCH v18 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, anuj1072538@gmail.com, gost.dev@samsung.com, 
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_101708_810338_0BB928FD 
X-CRM114-Status: GOOD (  13.00  )
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

>>On Thu, Dec 14, 2023 at 6:41=E2=80=AFAM Keith Busch <kbusch@kernel.org> w=
rote:
>>>
>>> On Wed, Dec 06, 2023 at 03:32:34PM +0530, Kanchan Joshi wrote:
>>> >  static inline bool bio_has_data(struct bio *bio)
>>> >  {
>>> > -     if (bio &&
>>> > -         bio->bi_iter.bi_size &&
>>> > -         bio_op(bio) !=3D REQ_OP_DISCARD &&
>>> > -         bio_op(bio) !=3D REQ_OP_SECURE_ERASE &&
>>> > -         bio_op(bio) !=3D REQ_OP_WRITE_ZEROES)
>>> > +     if (bio && (bio_op(bio) =3D=3D REQ_OP_READ || bio_op(bio) =3D=
=3D REQ_OP_WRITE))
>>> >               return true;
>>>
>>> There are other ops besides READ and WRITE that have data, but this is
>>> might be fine by the fact that other ops with data currently don't call
>>> this function.
>>>
>>> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> > index 7c2316c91cbd..bd821eaa7a02 100644
>>> > --- a/include/linux/blk_types.h
>>> > +++ b/include/linux/blk_types.h
>>> > @@ -393,6 +393,10 @@ enum req_op {
>>> >       /* reset all the zone present on the device */
>>> >       REQ_OP_ZONE_RESET_ALL   =3D (__force blk_opf_t)17,
>>> >
>>> > +     /* copy offload dst and src operation */
>>> > +     REQ_OP_COPY_SRC         =3D (__force blk_opf_t)19,
>>>
>>> Should this be an even numbered OP? The odd ones are for data
>>> WRITEs.

Our request opcode needs to be write based(even) so that while forming nvme=
-tcp
packets we send this as part of the nvme capsule.

But now I think this design can be simplified as you suggested, if we align
COPY_SRC to even and COPY_DST to odd. This requires us to change the design=
 by
sending dst bio first hence forming a write based request, followed by
src bio's.
Will send a follow up series next week fixing this.

Thank you,
Nitesh Shetty

