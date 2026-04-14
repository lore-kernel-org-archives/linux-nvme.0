Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A6EF9D0D3
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pq0i2u12JoSw8G2szImIbnMYMGTvvOYcg8TFVAa/oio=; b=qfRBaXu7R2r7Fh5Dd3CTgJ81bh
	C0HfnHT76fnbAu0qZPhqq6aM6/wdIdO/rSFyFX8J24TiUzgwjkME300VAmxUIh+Y8Zuirfjki00Q6
	lpoVPUMPvPIxDOnYQtUxjiq7I63gHXhrFPGFpSaj5v4mmsQXaZwGl305dOJCzj7ubEVmi5Uc9PkD2
	xtTpX6wEQ7Zxggyd05+dHAFy4lchxDneq0nu4ZkWccii2OGEJmYUqvai4f7wgpeuAiK04Y+agp3t2
	FiEInfRoAhBOBKEWwtZU1BDB7+oT7XoYmjdoyC9BlShBcugFf7vWR7c2Bm0IHsmqH6Sa9759Uu7F+
	f8LH0Y8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCfL8-0000000HUrZ-3zxZ;
	Tue, 14 Apr 2026 15:06:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCfL5-0000000HUqn-3oxF
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 15:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776179166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pq0i2u12JoSw8G2szImIbnMYMGTvvOYcg8TFVAa/oio=;
	b=gM6eF7TUHdZxd7lVLgJFXiB08diVRv+XZMR+KiWbFkSqVrPllYk1qfzw8ApFA7ixj6bjX4
	aeTALp2gFGMZvCydqYbYQ/xo04x2k5mOrCd0jiznZC84Mpq+at/t8zQdzlAD9ORoO7yAOq
	FZOOW0hi8cZTCdzqa5HYpGyPkU3GV1E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-y8Ak7K2aMqC0YdKkc_a-fw-1; Tue, 14 Apr 2026 11:06:04 -0400
X-MC-Unique: y8Ak7K2aMqC0YdKkc_a-fw-1
X-Mimecast-MFC-AGG-ID: y8Ak7K2aMqC0YdKkc_a-fw_1776179164
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6712cd7ccb0so2810351a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Apr 2026 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179163; x=1776783963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq0i2u12JoSw8G2szImIbnMYMGTvvOYcg8TFVAa/oio=;
        b=MLHNCMoogwhpNR3SaZm7OdoEQP+mnCrWzoK7f1rqLyG1mWzI9kaFBCpGWXUBlKcV9p
         FjEv+pa+TK72hgOjKio3xvnbiZkGCAgq0G7YZr3s/QpJxt/RDqHlg2TNao2PUby57Etf
         hvl1xlG1J0Vc/6KQwheJHGjPM2ArecDo/qOrxxPrxqlmhzqk5CooxM1hKlkLUiUfDMMT
         8kQh4tPwFZ3Z5esQf9TO1jLQmu+eQsw97vALPkKdz4xIHW1lKr+h7xYeTxH2Gd1hYDFH
         li0O6UnCek/6+8D5O6PECRPL6Uymnkq5piJdFz6pwniNTXJz6EB91G1r8mjzMYKNKjya
         k+UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/ZmO3Uax3HFjYLP1Me2F6LXMFOj1krg0K2EWwKhogyw1ClrF5MlA+N/HnS7zM9CzEZpKEpP6J3Ozm@lists.infradead.org
X-Gm-Message-State: AOJu0YxibjIccOUfSkLyPKIs2YTk+mA6hiPTagzmgeFeKJnwlkFFi/Z9
	6Pq8KDyEQHAHoBVPy4nObHXQdUDtc4IU5U3jfnyrYq+BTFdSFS6uoQoAH+SibQQKfDT+G6Jyp09
	tc6w0RLhkc5WotrrZd5l8G71ZOpEUqc6HDQk9WJLsesuaAfK6xW5c1iD6PirN8nwbTCM1ISQwzx
	fcpLLCyFjTin6G34l20iRkSov9S7rxPijbenUJQd8gojk=
X-Gm-Gg: AeBDievydXF5y5H7C01oq8hXEpz2nwlZd+yt7l6ZpPAtJRrjHb19SVnBMstxttZrO5j
	pNYwh0Vj3iXISWE7kHr6DgjtrEZnw1meendg47rcBaS6mAkeeVoKq2r7MFOjrRtjExx8h4RhKKJ
	/KQfZ+KDHn0wyIMpesE2WXkThXsJliHb/Ysk0fpxLZb7Qgn4TwA9KsFFFEYavgcXyiHlaMdM6zi
	MCVOaXUZHbeNxyyRVT9OL9vKhL7kmRjMsByutoT
X-Received: by 2002:a05:6402:249e:b0:66a:199d:138 with SMTP id 4fb4d7f45d1cf-6707a4801bfmr8259212a12.20.1776179163417;
        Tue, 14 Apr 2026 08:06:03 -0700 (PDT)
X-Received: by 2002:a05:6402:249e:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-6707a4801bfmr8259183a12.20.1776179162883; Tue, 14 Apr 2026
 08:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org>
 <2026041239-engross-edition-66eb@gregkh> <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org>
 <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com> <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
In-Reply-To: <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 14 Apr 2026 11:05:50 -0400
X-Gm-Features: AQROBzBgA5Wqvp5oZtKf1_KMGtmAAqTigrBukI3evmztM1h1hDtOeP-XyjukJ8s
Message-ID: <CACSpFtD5K8K8x4aqtBxCWUmwygCHcO=YkzUBJb=rgoqEStPGGA@mail.gmail.com>
Subject: Re: nvme: fix handling of tls alerts
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Paul Moses <p@1g4.org>, 
	Greg KH <gregkh@linuxfoundation.org>, "security@kernel.org" <security@kernel.org>, 
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPM0q8OBFKVZ1CwMHvREybmjQTnfOfbhIczuJ2USxgU_1776179164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_080608_289565_DB75BBE1 
X-CRM114-Status: GOOD (  15.66  )
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

On Mon, Apr 13, 2026 at 4:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/13/26 01:42, Chaitanya Kulkarni wrote:
> >    (+linux-nvme)
> >
>
> This should have been address by the patchset '[PATCH v2 0/4] address
> tls_alert_recv usage by NFS and NvME' from Olga.
> I _thought_ it had been merged already, but seems that it didn't.
> Olga?

I recall probing on the list about the patch but I couldn't get any
response. I lost track of it afterwards.

I guess I'm not surprised it was never merged. To answer another
question: Was it ever reproduced? The answer is: I did not because I
lacked NvME expertise to create such an enviroment that would trigger
it. In NFS it was easily reproduced by modifying openssl to perform
extra steps when establishing an NFS over TLS connection. Perhaps
openssl could have been modified to do what's needed when NvME over
TLS starts, but as I said I dont have the expertise. But the iter
problem is the same for NFS as well as NvME so the problem is real.

I'm not attached to my patch and I would be happy for the issue to be
resolved in whatever way is best suited.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


