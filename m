Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E62C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udU7uRk9Jy0ZVsf4mGmpSm4T5sCriRXfsSo4P4oU3F4=; b=LZ5yeA1Ej7mDap6s/Eo5EPCtto
	B1wufjeFpp4IWyO26FkgXZc0DWUaUpfKlyCb6uWK3GEPbvQQeYp3HyKPceO8wsHSJ2h2oMmItSC2V
	bhKh0ThKIq0R8rxSWP8sXpzZYfUU1vd+YDlpoDZ+Xq0ZylWrPeh6ceadxbkfeoEuPaYcf/dmeQJdk
	X1bjjZJoE3VjUOM7D4myQgv2+Fga6diCRv/G0Ix9QadJmowWk9aCxrZioxpAsLuAFuryGDYqBJEvE
	4hCl/UMdb+wowTWlX6TK0R7EwmM9a2oWIymCPGnPBF7EXdNiyBNd5/gaMQyLJUWc6RfrVoyEcI2FK
	VIlTjjqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFfEl-00FFEb-2U;
	Tue, 19 Dec 2023 18:54:39 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFfEh-00FFCj-37
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 18:54:37 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so1836327a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703012072; x=1703616872; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udU7uRk9Jy0ZVsf4mGmpSm4T5sCriRXfsSo4P4oU3F4=;
        b=Gf6JU5oLvVTbREjNGsM4ZM8oDlcDKKJbkExJP7wAJNpXyNwU3KZTY6iXbRQJbi4vaq
         o4VufNrbLlsxKclmILoEMA2sDwju0aIH3WAeVFnR7tfiiko6cSM1b6vgqHdhe0o+yFl7
         v6o6WPg09/odotVlUxJVc+y6SGH9H827orKFtGP4SUgoU7BNLC0b6L0ksUNEAsEUAQiV
         n0iKbBpuYQztc9CkZqGBUKCi6kf1fqFJRrX1De1Sz0OA4QA0RF0HrHAARik8RWSEGeOZ
         36t4LG5cGElxumHQQybeLRt2YDS9CJx3LPQnEB4qpdlvjmXU+snBZo6Y6/FJSa92nqW0
         q+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012072; x=1703616872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udU7uRk9Jy0ZVsf4mGmpSm4T5sCriRXfsSo4P4oU3F4=;
        b=TebMiZvqqwppGZH/ekccnUBLAYH+ce3SFzYg/2z1DvqkLJPmXpwfBdNOKwZHPbJO2d
         Ft4QQ4Bb0bJB8zqadYhIikFeZ42Ccwywh2FJw3HJavoAoqMs4RBil4R8LFEk0sIlDTD4
         0Lh3hEIqqlbw60xA0O/PYRgDMPW+nmDT5jrSJOaRNjg1MIxxTDTSxqiQFqwysLEDnYhA
         AvfGQNDJFrw5JieFKMahjAbiJKysrqwsu07wW5dEjKFS+yC/HelEPEWEN14+qK4yNMq7
         DPQxlsVPH2kyJq4HNOG8ScGW6enlclinWyZD1uHyuD3zOJ5Oiqdc4fh+0IMPIf/2G5JZ
         lhGw==
X-Gm-Message-State: AOJu0YyIBCGWZ99mkNjOfP/CePnKYOe1uRp5/4oV5CJhaurhy3APoWLD
	UHq/r1xh++MY+tDD2aHtu9aj7yIsoS+TRAIedPIThw==
X-Google-Smtp-Source: AGHT+IH8ud+IweUSZpx8pVDxTAO+5L7JsIHVNzpeMfjWAna/kK+awksv/G3hke3432ILW0murKO1BNG6CHfkFJkLWss=
X-Received: by 2002:a17:90a:aa95:b0:288:92a4:c26a with SMTP id
 l21-20020a17090aaa9500b0028892a4c26amr8161298pjq.66.1703012072397; Tue, 19
 Dec 2023 10:54:32 -0800 (PST)
MIME-Version: 1.0
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com> <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me> <hqha2fmtutg2p3daqjz7g4ozlkl25orvkirgyq4tibq6c6e7k6@losspn6rhbgm>
In-Reply-To: <hqha2fmtutg2p3daqjz7g4ozlkl25orvkirgyq4tibq6c6e7k6@losspn6rhbgm>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 19 Dec 2023 10:54:21 -0800
Message-ID: <CADUfDZoFgbJ3J0XM=neq5vuyRDmc4agUy64_aVtDos1Ws0bmpA@mail.gmail.com>
Subject: Re: ioccsz and iorcsz check failing
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_105436_440754_3DC355D5 
X-CRM114-Status: GOOD (  37.31  )
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

I'm not sure IOCCSZ and IORCSZ even make sense for discovery
controllers. These fields are "I/O Queue Command (Response) Capsule
Supported Size", but discovery controllers don't have I/O queues.
Presumably the host should ignore the values in these fields for
admin-only controllers. But the base spec doesn't seem to exempt admin
controllers from the requirement that "The minimum value that shall be
indicated is 4 (1) corresponding to 64 (16) bytes." Perhaps this is a
better question for the NVMe technical workgroups?


On Tue, Dec 19, 2023 at 9:31=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Mon, Dec 18, 2023 at 06:04:46PM +0200, Sagi Grimberg wrote:
> >
> > > > Is anything else in the identify wrong, or is it just these
> > > > fabrics fields?
> > >
> > > So what I am seeing on the wire are a few fabrics commands (connect, =
get
> > > property) followed by the nvme id ctrl command (opcode 0x6).
> > >
> > >   nvmet: nvmet_req_init:962
> > >   nvmet: nvmet_parse_admin_cmd:1011
> > >   nvmet: nvmet_parse_discovery_cmd:359 opcode 6
> > >
> > > This calls then nvmet_execute_disc_identify, so adding
> > >
> > > --- a/drivers/nvme/target/discovery.c
> > > +++ b/drivers/nvme/target/discovery.c
> > > @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nv=
met_req *req)
> > >   {
> > >          struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> > >          struct nvme_id_ctrl *id;
> > > +       u32 cmd_capsule_size;
> > >          u16 status =3D 0;
> > >
> > >          if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> > > @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct n=
vmet_req *req)
> > >                  id->sgls |=3D cpu_to_le32(1 << 2);
> > >          if (req->port->inline_data_size)
> > >                  id->sgls |=3D cpu_to_le32(1 << 20);
> > > +       /*
> > > +        * Max command capsule size is sqe + in-capsule data size.
> > > +        * Disable in-capsule data for Metadata capable controllers.
> > > +        */
> > > +       cmd_capsule_size =3D sizeof(struct nvme_command);
> > > +       if (!ctrl->pi_support)
> > > +               cmd_capsule_size +=3D req->port->inline_data_size;
> > > +       id->ioccsz =3D cpu_to_le32(cmd_capsule_size / 16);
> >
> > Yes, this is the culprit. Nice that it exposed a bug.
> >
> > There is no in-capsule data for discovery controllers afaict.
>
> Okay, I have no idea. I stole this from nvmet_execute_identify_ctrl().
>
> I tried to read up but couldn't really find a proper answer. And I am a
> bit confused about the TCP transport definition. If I got this right
> then a min size is not defined either for fabrics commands or responses
> depending if it is in-capsule or !in-capsule supported. But never are
> both values are defined at the same time.
>
> RDMA is a bit more clearer on this topic and says for admin commands
> these value are fixed is in line with your statement
>
> The PI check is kind of useless as we only deal with admin commands
> anyway.
>
> Anyway I am fine by just dropping the inline part as it doesn't seem to
> impact the functionality for the discovery controller. But I suppose it
> would be good to know why this is the correct thing to do.
>
>
>   3.3.2.1 Capsules and Data Transfers
>
>   The capsule size for the Admin Queue commands and responses is fixed
>   and defined in the NVMe Transport binding specification.
>
>
>   7 I/O Commands
>
>   The user data format and any end-to-end protection information is I/O
>   Command Set specific. Refer to each I/O Command Set specification for
>   applicability and additional details, if any. Refer to the referenced
>   I/O Command Set specification for all I/O Command Set specific
>   commands described in Figure 390.
>
>
>   7.2  Transport Capsule and Data Binding: Fibre Channel
>
>   [ no public documents ]
>
>
>   7.3.2 Capsules and SGLs (RDMA)
>
>   The capsule size for Fabrics commands are fixed in size regardless of
>   whether commands are submitted on an Admin Queue or an I/O Queue. The
>   command capsule size is 64 bytes and the response capsule size is 16
>   bytes.
>
>   The capsule sizes for the Admin Queue are fixed in size. The command
>   capsule size is 64 bytes and the response capsule size is 16 bytes.
>   In-capsule data is not supported for the Admin Queue.
>
>
>   7.4.3 Capsules (TCP)
>
>   The NVMe/TCP transport supports a message model. Data transfers are
>   supported via a transport specific data transfer mechanism, described
>   in section 7.4.5, and optionally via in-capsule data. NVMe/TCP capsule
>   sizes are summarized in Figure 62. The size of capsules is variable
>   when in-capsule data is supported and fixed when in-capsule data is
>   not supported
>
>   Figure 64 (size in bytes):
>                                !in-capsule    in-capsule
>   Fabrics and Admin Commands:  n/a            64 - 8256
>   Fabrics and Admin Responses: 16             n/a
>

