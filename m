Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8FCC6FA99
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Mar 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jhm9l7kIAy31eqizLhp2n/9jg1Oazpb9K6nwe23q+hU=; b=QOBb/Ayt0BE8HqQ0nTrk4OeLUo
	fJ6hjlbEh3MjsQQap5/airrtGAb1xryfYsecA9HJ749cxB54HOxnumgkAAJJHSX7HuhhlGnhNbsfj
	olvr97Jk8t7+sgaI+8C8Qb1Taz9isqJBzdu7kAa7l3SeyvxkW/o1CnPJp4q2sYmJkxutkwU2ol1n9
	f0LUgR1nWQHnUv8Z4zURHh4ngDrkiBbsdvy/AZVwd1SeGyZsvE6buZdPXY1ZrgUNWTg9OTS2vE8g1
	kLQSO++b16ZtEvxJC+ETuf6DJCzwXuT65H4eNjh+IZPPCngXcLYmPDMrb7KThe6t1W1irOHir/dWS
	mCl5i8Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbLFx-002GHa-NA; Sun, 12 Mar 2023 12:56:57 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbLFr-002GGu-F8
	for linux-nvme@lists.infradead.org; Sun, 12 Mar 2023 12:56:53 +0000
Received: by mail-lf1-x12e.google.com with SMTP id m6so12416339lfq.5
        for <linux-nvme@lists.infradead.org>; Sun, 12 Mar 2023 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678625808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhm9l7kIAy31eqizLhp2n/9jg1Oazpb9K6nwe23q+hU=;
        b=AJCvs6YGRjKMsRbNImnThPIqd+zbFYZdMa7iScEIaYckU3SZUtkChgJj+SOBfV4b+E
         iiw7xKSM6/y1oHT1VZiH624xtHEDHcP/vrOUPTFXP/Q4bCZg37zEvxjin6+dLPohPBur
         s7xq3fH9433aP6ul5EYSE1gQbpT0y8MTPSH6dQLqf+8Z8vPQCb1DlnnDQBwKEQo0J5mU
         04/ypSpxZG9LdHWcvPWPo6XFQbNEh09JV8upa4V7MgkZI0Vbwfoqcw7MPj/KDbyoViuT
         o0VkRpb2Q7+4T9Po3x73y+/efh/tgqdg8StEoJuQkFRHhOgYgHKeO+ngHKw9ui+diWJn
         nKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678625808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jhm9l7kIAy31eqizLhp2n/9jg1Oazpb9K6nwe23q+hU=;
        b=SzeNoYWMDe0fB9fqApgVtcElBI69KsuU6JxNKsvFt7h0qtnFD3Cl6oX7s/by9HIkfG
         LBB2vCzImEOeujGqrUo058OxPzZQ4uAAIhd783NoyfxWHkQgw2U85OSgk+hpCpw6cj1n
         4BFDsoankB7focplTmmLBFNiQNOxEiBljLhE45X/pV03uCTfSHmKhfBj37l1lm3QQ13O
         rPRuszEhdbl63KvK/NNIp7kzg8kFg2dgGZL0bm/rrleg28zakDf793WvW3FQtjP3o2l9
         1VtzNfMHvTyM4XEdG3LHMZjzj0wp+f3Ufu2MKFlshB77BKokeCSS37ymOm/mrOQ341ER
         wPUg==
X-Gm-Message-State: AO0yUKWBzWaXwPRSHmKdPGrMQNcVYhzJwzjasw+8Gz4RW4C6c5dihF+8
	dT+3YZ3O3kfDh1NjVx8PuAO72M8zrAqvF+xuE8E=
X-Google-Smtp-Source: AK7set+mqlZMJwlWxmL6mlNP4qyVE46ERn89vuBuvW3BtWNmEJBnPy7eqmMGWyFMhRyP9V7KEZPk59DuL70Z40PgnmI=
X-Received: by 2002:ac2:5fe6:0:b0:4db:1c2a:a96e with SMTP id
 s6-20020ac25fe6000000b004db1c2aa96emr9241513lfg.9.1678625808148; Sun, 12 Mar
 2023 05:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163045.5882-1-akinobu.mita@gmail.com> <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
 <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com> <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
 <dd738a2d-4867-723e-c03e-a9018a7ae633@grimberg.me>
In-Reply-To: <dd738a2d-4867-723e-c03e-a9018a7ae633@grimberg.me>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 12 Mar 2023 21:56:36 +0900
Message-ID: <CAC5umygNMaJF+DY-q1wTx5EPU7PNcGNcHy5O0L61s_q3WASJgQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error handling
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_055651_551097_6DE7AC22 
X-CRM114-Status: GOOD (  27.28  )
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

2023=E5=B9=B43=E6=9C=889=E6=97=A5(=E6=9C=A8) 18:10 Sagi Grimberg <sagi@grim=
berg.me>:
>
>
> >> Sagi,
> >>
> >> On 3/8/23 03:06, Sagi Grimberg wrote:
> >>>
> >>>> In timeout and error handling, various information is reported about=
 the
> >>>> command in error, but the printed opcode may not be correct
> >>>>
> >>>> The opcode is obtained from the nvme_command structure referenced by=
 the
> >>>> 'cmd' member in the nvme_request structure.
> >>>> (i.e. nvme_req(req)->cmd->common.opcode)
> >>>>
> >>>> For the nvme-tcp driver, the 'cmd' member in the nvme_request struct=
ure
> >>>> points to a structure within the page fragment allocated by
> >>>> nvme_tcp_init_request().  This page fragment is used as a command
> >>>> capsule
> >>>> PDU, and then may be reused as a h2c data PDU, so the nvme_command
> >>>> referenced by the 'cmd' member has already been overwritten.
> >>>>
> >>>> To fix this problem, when setting up the nvme_command, keep the
> >>>> opcode in
> >>>> a newly added member in the nvme_tcp_request and use that instead.
> >>>
> >>> I'm wandering if we should just not reuse the cmd pdu for a subsequen=
t
> >>> data pdu...
> >>>
> >>> It will take more space allocated per request (up to a few MBs for lo=
ts
> >>> of requests and controllers)...
> >>>
> >>> but will prevent from propagating this to nvme core...
> >>>
> >>
> >> Is there a way we can do this without increasing the memory usage ?
> >
> > The data pdu has to go somewhere. There doesn't appear to be another fr=
ee area
> > other than the command pdu, so if that's off limits to preserve the ori=
ginal
> > sqe, then more memory is needed.
>
> If I take a somewhat extreme calculation, where a host has 16
> controllers, 128 queues of depth 128 for each I end up with additional
> 6MB, which is not insignificant for a driver...
>
> We could go with the original proposal of storing just the opcode, but
> it then propagates to the core...
>
> Or...
>
> The cmd pdu has a size of 72 bytes (header + 64 byte command), perhaps
> we can still reuse the same PDU space but rather take the last 24 bytes
> of the cmd pdu?

This also fixed the issue.
Would adding the following static check help avoid unintended changes
in the future?

BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) <=3D
        offsetof(struct nvme_tcp_cmd_pdu, cmd.fabrics.fctype) +
                sizeof(struct nvme_tcp_data_pdu));

