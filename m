Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F683C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZU1H4yN3UUD/dCpVyBCRrkiyHeNR+yoWR7z4IeqBHE=; b=2rsrU0Hu084h+X983QF2bKew3o
	9tmLzxlEx1cRVDewPl/G9dHGUjQ6a+rTKXD1Pk+ZDTYg+ICoVo48Hwnp3y6ezz8Kyj38jGndfPDBW
	A06ddMaeX8SnmiE2X3ViqS8z5gSP+Lt0HsLr8SEBYNMbWndbROQ+Pn3r0tT5klNuJ8Y3wxH4MN+L6
	Q7apPMYqCnWxl1XZuFqmq+43twpLvaKa5B/rffrMMo/og9WvUKKPsYcM2MpCX2HF0rLlnmenHbYLr
	cmORcqos/VPrgejeBZE0Uw8Yuw8JZGckfM9/LzNSsobFs5Jrw3MUkXitaEDcL4BGKd6rHWxuCQvkI
	D+0Nkzug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGeCr-000000051NV-2zHl;
	Mon, 10 Jun 2024 12:33:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGeCo-000000051Mq-2o8x
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 12:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718022776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZU1H4yN3UUD/dCpVyBCRrkiyHeNR+yoWR7z4IeqBHE=;
	b=J6c2R9qA326byN6npCkEomZEVg4Vna89sM10qIIHES/5CWp25onZJqoXSf/IGZhUjtSSJ4
	jLv+Korv69k1iYnhhamuxWOL3qcRlegzIM+Onf8Jsyt52Hehg9G83QaBdNc60UnZWWp2Ao
	oScTsootMU+wC9Qi62a3OGE1JJv/eHM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-UBpBkh-uPYGPbNd7EKjSwQ-1; Mon, 10 Jun 2024 08:32:54 -0400
X-MC-Unique: UBpBkh-uPYGPbNd7EKjSwQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dfa744fe2f9so7342189276.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 05:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718022774; x=1718627574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZU1H4yN3UUD/dCpVyBCRrkiyHeNR+yoWR7z4IeqBHE=;
        b=q/8ymrEbrntGjoB6nFovJXfUklXF0p8iv8+xENgFH42V5OkqQWKv3YLX7UsJ8y/Su1
         d07SKv8lo+XH4n04GiP34hg7FJyvvnZFBvOKmJE1XT5oOaOg3CvFBQXyO8KGsTi31Bjo
         xUKlzABBDL11FVop4dr2jRdjTEIjhz8lynogj5QZsdZtpHXHkBcLyaIssLUJjsgztEav
         eBY9JvyXzgkot021zk2F3jlbrnRfTwVjaVBX5t57oBKC4ZdzBMOx1IQbl72n0T2v/fHq
         bpTm8ywrmVNBDtnp2D7jXb4EVUJQjJIW4A2O4iyawcZjlCq8G5WIqjj7eHTCsdLe9XNq
         NGTw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wWwdk1a3hkvacg4A0Dtr+HVdW+rJt7zpN4+cHTz++cEorRQGV/CEDObkzHjfQRw/FkFAL0YDR3HOHzhADAhy0ksD0zhKSjFyHJnXu6o=
X-Gm-Message-State: AOJu0YzA92NfydofUlRVYwa0svd9I7F5lZ55hjAP1D6YbbVp3WSsl/od
	sNnY7kuGcuAhfcnk05y820dgTGZjx+QCpcW3FpxUNZEums5/jjkIIlANVw7c9Esk/hjn9ohpm3T
	kftZMHZcS5i7XmR4+q9vFiI8C13C9bVyr0uZMwue1sRKUcSPhzeZm6jeb+hJNRHwLCwuuHrAsvW
	XS30eVsRwm3crV2qgtgCrzHVUkxNjtGzVuM2gyvjA=
X-Received: by 2002:a25:f502:0:b0:dfa:4a4e:a601 with SMTP id 3f1490d57ef6-dfaf673711emr8258754276.41.1718022773954;
        Mon, 10 Jun 2024 05:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnyvsYB+iJhrp8JB9C8edjj3oHoc+GT5JkUTpsgy5N5mW4RzH5eYTmjUQD31KOHbMoy7BmyPYhgo3DOJbxsfw=
X-Received: by 2002:a25:f502:0:b0:dfa:4a4e:a601 with SMTP id
 3f1490d57ef6-dfaf673711emr8258736276.41.1718022773595; Mon, 10 Jun 2024
 05:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240604091523.1422027-1-nilay@linux.ibm.com> <20240604091523.1422027-2-nilay@linux.ibm.com>
In-Reply-To: <20240604091523.1422027-2-nilay@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 10 Jun 2024 14:32:42 +0200
Message-ID: <CAFL455ndCZipuN1bFTWgqjj4Sfh6AB3WUX014W1V2WY4gqzK8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem reset
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_053259_138541_8E136292 
X-CRM114-Status: GOOD (  14.31  )
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

=C3=BAt 4. 6. 2024 v 11:16 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.co=
m> napsal:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5d150c62955..afb8419566a9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -562,6 +562,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>                 switch (old_state) {
>                 case NVME_CTRL_NEW:
>                 case NVME_CTRL_LIVE:
> +               case NVME_CTRL_CONNECTING:
>                         changed =3D true;
>                         fallthrough;
>                 default:

Side note:

I believe this could fix a race condition in the nvme-tcp driver.
Some time ago we received a kernel dump where the controller was
flagged as NVME_CTRL_LIVE but the sockets were marked as TCP_CLOSED,
the kernel was hanging into io_work.
It might be possible that the socket's nvme_tcp_error_recovery
callback was executed while the ctrl was still marked as
NVME_CTRL_CONNECTING, nvme_change_ctrl_state() doesn't allow a
reconnecting controller to switch to the resetting state and therefore
nvme_tcp_error_recovery() simply returns without triggering an error
recovery.

nvme_tcp_setup_ctrl() then moves the ctrl to the LIVE state, but with
closed tcp sockets.

I guess that this change would fix the possible race condition, even
if I am not completely sure what could happen in case of a race
between nvme_tcp_setup_ctrl() and the error recovery code.

Maurizio


