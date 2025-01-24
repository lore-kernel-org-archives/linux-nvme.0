Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA37C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOebF37DMOymsce+6h/SiipFHAMLZWVvtXEZKwj/7ek=; b=ISHjZ/axS/0L+9239YsR4AecLT
	nkOB20eoswVcMj+F2gxyUoqFs8+fsdbKvXtnTLtx54xeTihy/LeEXZamoHlJw7C0K1rvaGkXs4LQU
	OAOj+sEJR7HUoBM9abbcHCiHLi78DObqBPCrQKE8Xla1XgMvfS7FDd313a9zuCZ70RBv4D+IVm3CV
	gzJQWWgYBsHcOM06XDCd164wKZBpffdQOdSWXidZqzoS5sp0Drk/ukchT9JzwsXSbVl7fIjPFSGMl
	rASPi7tDqIwzC1k8xCCLyrv/1ku8xz2PUIBOWnnyVkKdVZZEX0A56Jw/unjpWBJeK6d+aT6eYT9G9
	3FshjzHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEkO-0000000EC6D-31pH;
	Fri, 24 Jan 2025 08:09:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEkL-0000000EC5W-3iyK
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 08:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737706136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOebF37DMOymsce+6h/SiipFHAMLZWVvtXEZKwj/7ek=;
	b=H2uaahl13rqGP9coadgG2WsyNPKE5rO8gVwzeRiUo4e3+n0f5pxIwfPQWuAsS95xJGD1zK
	LGaicRqUbiiJ1NMyywV9/afRAhKqW+RSKpusQ08smKGBrALioSrjuDnBalUK1+Ls2uIsb1
	X220y/HNoZeyNPLU7wNhMLUXpWPLMcY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-T9ibxge2Oi6W9Wo2ovoQlQ-1; Fri, 24 Jan 2025 03:08:54 -0500
X-MC-Unique: T9ibxge2Oi6W9Wo2ovoQlQ-1
X-Mimecast-MFC-AGG-ID: T9ibxge2Oi6W9Wo2ovoQlQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f0b1023bso16493836d6.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 00:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706134; x=1738310934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOebF37DMOymsce+6h/SiipFHAMLZWVvtXEZKwj/7ek=;
        b=SLb5jcC6WrFJC+EO3yFpXRWxcA78idjtMjSYp4bjCRbokzGNbfeuhMJ30n4Vmvx5Sw
         cuEhv6cS8uEATsjGY8ylLGqFMqLpSNHjV1oUHXfg2OjL1xz9UCCKFuhuCBQ5FrwGSJKk
         bwBDkYdEuIdU1kkhLztjgVr5zGQiZgopR9F3hpoKBx9QwE2jUSVYKwXq3OKOfV+kHdSh
         rKEGJbXiHObF9rYwKEW1gC00Z6Lhxc7+YWyJadF88g8KdFM8wFBMKhW0SkHo+4A3P4dZ
         MUMpuyf2EkRosCZePFhoOB6PDH5CpXUswgH+tTyNzh2xzRFK0jswtEyxRF+SiCGraCUK
         1L/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIXEZ2qQUuEeeUjvflWOPAMkGOtVbG/SisB1hyJCoK7BPtda5qEs/lnkSpu5mL7/BbXEhpRUxxPUcJ@lists.infradead.org
X-Gm-Message-State: AOJu0YwEf17kP1puxskZastr6+Z/sdbRa5b6q04Sxdvs4q6kstrsuUfY
	1un1G8hKj2ipOWWY5kFthOk62Gz6M9d+sEiO6jf8SLXW10BMGUnY/aMWlTh1ukGL75LdAkkfOzO
	GPtG0aum2VHB+9+SRafeaCuD73jEfEq4pmstQ2uXTWqSg+IOY4iXB3qxS7Cxg+yk/bx+gUyVqgR
	4oLW1C53D/TiTF2Fr6bLczeuLJ3pom4WTezijiLLpna0FNJEBDwprt
X-Gm-Gg: ASbGnctBrAXCw4+kg7nQ8F1Spf2PAuQsVJTtBf3gcTk+1+N4ry3BZeJRnndh7YqnY96
	UZw058Ep1vHwc+OpMQ2eBL05tFoDUNo/pwuy0QG58LuZ2R21BOrpVHA==
X-Received: by 2002:a05:6214:3197:b0:6d4:2646:108a with SMTP id 6a1803df08f44-6e1b2159486mr362113726d6.12.1737706134098;
        Fri, 24 Jan 2025 00:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXB0WyXawe/guYBG84HmjiUbIhIbP/Q3AFDQdx+lLeyo+y/bGKB1YQt0M2h9LzF2hTfLNvcdXFIp1LEXuJbt8=
X-Received: by 2002:a05:6214:3197:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6e1b2159486mr362113566d6.12.1737706133817; Fri, 24 Jan 2025
 00:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20250123224941.1359950-1-csander@purestorage.com>
In-Reply-To: <20250123224941.1359950-1-csander@purestorage.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 24 Jan 2025 09:08:42 +0100
X-Gm-Features: AWEUYZkOamBE7V4lURxcUEd1JqquxWOocCxcibyFvXVGjiuc0WSqMeBMNpVt_ng
Message-ID: <CAFL455=TMmKVZPtnX_CBF34+EtfMbq37OxQAFGJuW_u1VjEQsA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aIm9Iv-agnuVxTlI1TuqKAyETeowvMHBYbpVHa6Sukg_1737706134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_000857_998725_30C07B88 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

=C4=8Dt 23. 1. 2025 v 23:50 odes=C3=ADlatel Caleb Sander Mateos
<csander@purestorage.com> napsal:
>
>         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> -       if (ret < 0) {
> +       if (ret < sizeof(*icresp)) {
>                 pr_warn("queue %d: failed to receive icresp, error %d\n",
>                         nvme_tcp_queue_id(queue), ret);
>                 goto free_icresp;
>         }

There is a small problem here, suppose ret is a positive number but
smaller than sizeof(*icresp),
you will print a bogus error code, then you "goto free_icresp;" and
return this random positive number to the caller.

I think that if ret > 0 you should set it to -EINVAL.

Maurizio


