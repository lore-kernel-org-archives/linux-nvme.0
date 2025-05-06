Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42CC3ABC7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LgUTLFyRDWkYKDEpuIhDqP9z1m1Yv8U7iugtqQBuYj8=; b=FwQOieY6DOuVw88GTxU8Il8lyE
	KdSs1PhO/ENU2GKM6MFeJKASyQQUp6//GZHY9AyCJeDsAoxSZdxTH2baN8oj4OEb9luf+NMzpkacQ
	brt/9yDqCECtT2PE3vFKmMRpoH3cIDUZxGdZySiPCDbA44w6NSFAbKDshj//SDaEjf2rGZESjfZo0
	jb5Cgt6rnCcsc1f312WabkYZiJz5/OqK2/yPgNgTx81eTgXHG8lon2dvR2bQSVlRj80Ip3ecRSEhO
	FXJi4T6YZMcQ3tYfD1dmBcN35mjbbuw1T8FijA0K/VrvN+pjumTRle59w0ohZuQ2dQmdqQbHQHzUs
	ASaxaluQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpR-0000000Dg1K-1fQ4;
	Tue, 06 May 2025 23:36:01 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMoh-0000000CwvW-1iPp
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:14:56 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-ae727e87c26so3835831a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746555294; x=1747160094; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgUTLFyRDWkYKDEpuIhDqP9z1m1Yv8U7iugtqQBuYj8=;
        b=eTuImJEns2vLdDIAroqLD+XQsR9uSl6A5S3rlnLtDPkH3wDsGVZUNCkclffa2ycYST
         ou3MKc5/DD5Zzg80IwBqO68w0gdmO//cj8E1kmS1HosVW6MhredHXM0n05IkQh8vrI17
         +Wm+GKCa2wqlIo1qhDNptYGi82AgH3qiUGIqZD+LyWQTQRx+9ZvpohsrgIxX6Zjo5t/B
         SHu40daj8h001Zp8IjGbER6h+34l4UKbZawVNVNd/SKMPwrYhIZwLVrTBiWG+9fevDMX
         tB7gtCGWoG8mLDlQtM9N7fLZaeoQlSXsF5v829KxgucS75krMRDoe4aWt0qytZoq1jgs
         GsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746555294; x=1747160094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgUTLFyRDWkYKDEpuIhDqP9z1m1Yv8U7iugtqQBuYj8=;
        b=gHk4WbmN+0J7LCMN7+iOU6hPoyX5b2BCaPkhceRWAXOBYZhCWaJalW0AwaXMU3TyyI
         /HZ7DOs2Jql+J/tqMnF9llCeoiZsJZLmRo4QDovrCyDlY9TQrPMKPV8IE/Ztv0+yLtmi
         XvRyobZ3YPgAjvfOCH8DGdg84xSN2on5vXgCtnmgPxAJwfaxrPaBreB0OLh+YwUAzVd1
         dUv3P9X5iDFALfvoXaM4kqrMyFqJ3zeaa0k7oX8fEHRpJsEHuUGEjcio9Cvn+rQENyLn
         mlQSlODTdirwFuRd8iG6Lf6WZUyWr4aB6JmwrZQCA8IzI8vmbHetu14dLWSACzoIgpYq
         tc+g==
X-Forwarded-Encrypted: i=1; AJvYcCVVDQqzYHviXznBrIYRzFnej9aqXnyddyiHKPb/ObZIfLqpkii3ntoedUknoR3MbVFw+GsTveQAWdcs@lists.infradead.org
X-Gm-Message-State: AOJu0YxSpJbmhUkhWGuiU0GgYZZK6Slr57zL0kjULCsAaJo4AaVvvsCa
	1UEaqn8YKBJW9gN6H6SbjopeXCjddo++6ghYxZUV99vOkSbrgx4wkkjIxsfIlLDahu+anWe4NWl
	DcXoXRy/hIZ3zQpjpQzgZBDMEImc=
X-Gm-Gg: ASbGnct0FJzG0rq4P9lxe17jXjlFIp8A2KhcxSzbseUvgHXcKFZUQSBxwI5//w9f+8K
	xMd6I4cxNvPbxZtC2ySUZaSNMycGvBi8X6aTBbzThZr6YU1W0Dt2TSgfn+B+bYZIF9LhAVTZOIX
	a4F7zKItoyvWWQQSQWRi75vxOg6pSXqsdJodGJ0vz616C6W7wP68yo7ARO
X-Google-Smtp-Source: AGHT+IGwp2IFUitVkyl1IAWa+05GwLKsvMJm418R5rpT8coYjf649UgitPuIXI5xNWy57+nYxUYyxUOZvofrUpHZ/pg=
X-Received: by 2002:a17:90b:394f:b0:305:5f55:899 with SMTP id
 98e67ed59e1d1-30aac184a9fmr718325a91.11.1746555294071; Tue, 06 May 2025
 11:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250506122651epcas5p4100fd5435ce6e6686318265b414c1176@epcas5p4.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com> <20250506121732.8211-11-joshi.k@samsung.com>
 <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com> <aBo4OiOOY3tCh_02@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aBo4OiOOY3tCh_02@kbusch-mbp.dhcp.thefacebook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 6 May 2025 23:44:27 +0530
X-Gm-Features: ATxdqUG9RIoJxTdSYclAXfevasZNEUaF6CXTR24bqSobnO_8A3U2eC19Wgde8B0
Message-ID: <CA+1E3rJx3Ch2POT_t4DWiqb2nJiX7bHPrGVMW_ZviJ_b0o9UvQ@mail.gmail.com>
Subject: Re: [PATCH v16 10/11] nvme: register fdp parameters with the block layer
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, 
	hch@lst.de, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
	Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_111455_448711_EEB6106C 
X-CRM114-Status: GOOD (  13.49  )
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

On Tue, May 6, 2025 at 9:56=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, May 06, 2025 at 09:13:33AM -0700, Caleb Sander Mateos wrote:
> > On Tue, May 6, 2025 at 5:31=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.c=
om> wrote:
> > > @@ -2225,6 +2361,12 @@ static int nvme_update_ns_info_block(struct nv=
me_ns *ns,
> > >         if (!nvme_init_integrity(ns->head, &lim, info))
> > >                 capacity =3D 0;
> > >
> > > +       lim.max_write_streams =3D ns->head->nr_plids;
> > > +       if (lim.max_write_streams)
> > > +               lim.write_stream_granularity =3D max(info->runs, U32_=
MAX);
> >
> > What is the purpose of this max(..., U32_MAX)? Should it be min() inste=
ad?
>
> You're right, should have been min. Because "runs" is a u64 and the
> queue_limit is a u32, so U32_MAX is the upper limit, but it's not
> supposed to exceed "runs".

Would it be better to change write_stream_granularity to "long
unsigned int" so that it matches with what is possible in nvme?

