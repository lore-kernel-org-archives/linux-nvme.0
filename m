Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B7ACAC5B0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Sep 2025 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0rr8asw5w2LFtUosgimvTpY49NuIARrcjW6GWqnOLnQ=; b=BFthDXYq/QcGDSfxdXbDRgMuPX
	uHmRTintSP/jojNNWAWWcC0XK2SssmH+ksXqvAbL96osH28oui2A9CJr+olVQVyPYUdMe2ej8dBWX
	Br6XtHNNna6j8YODFh4MGa5xhgVMi9Vlc+nTtTmBGISnthmbKDGhEwQmAO49dcaHix6S9XhGHSEQ3
	0zzO5jRPhHIgMxaBLmQh5h7VeRYiA5Msy4jWxwwt7OOaU/XfNo1Q6anA0uzebNajmGANvYwTswG4k
	qnWGw7NXfUs5LgxPHPD3+3Oc2b3hVRn1zxRhyD6G5HzjSnunRWU9Mb9BToj5RHzdWy1G5SM266jr7
	H5cDVVJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Hwo-00000003Ahq-1Pmz;
	Mon, 29 Sep 2025 17:46:02 +0000
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Hwi-00000003AcP-1M7u
	for linux-nvme@lists.infradead.org;
	Mon, 29 Sep 2025 17:46:00 +0000
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-635355713d9so3983043d50.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Sep 2025 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759167955; x=1759772755; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rr8asw5w2LFtUosgimvTpY49NuIARrcjW6GWqnOLnQ=;
        b=AJivD6j80+Kn+mXfkccisUmpUwuDjuyV+4GkKZdN1z5z4jIZR5nekes32RHIfhepCe
         QJRVAiTF4EdoweGnb31c1VIe8iE4O9GPGQTaHQntADNZyd8hmxDheYuHc+Cy7YKVV4iC
         Ilvr4UY/TbRvrbU4CteeqKhhl/jxb+hmvWv71ONIFdv7QbfoG3zsV+rTfPfHTvtrZu6D
         acJHa/XysZI9VD6n/BE7EtYUUtQG9DkazTWaGhVwLvzVkkxhzFN8aZlTRjfK1wkutePH
         KAZgWr9XMTbB4VsdNFEpH5r0sYWySwpIyf0YYF8UP+yfEQ/MzqgEiUjkU7nyJOlMLp/4
         otFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167955; x=1759772755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rr8asw5w2LFtUosgimvTpY49NuIARrcjW6GWqnOLnQ=;
        b=dPrTLkNdOy3VvfAhz/ZZVSW+DMW0ZLAcfEPF1lkxBeeO71BVvslhMCSORm2gHXwoXB
         Db9fgTGXsIOfbgxVdCwVHvO2SVsWRQ3GzmxZg7d3s3noq5V2F96oAZ00awbk7M00V+cW
         Z/P1hZ9fN1CeqdPNEL0k/zjF81aki5zA4XJz7XQj0ZSwtlJsRUw03NHVc+LObKtMvzMb
         wrxOg1UEOTrNLm27DYtUledOZOEaVC5eKwRropal7/kkQ+kcjbjP4WbO+SxEGsvdJyve
         2QZGLm+6IVlHbhzjdAtjUH8CKFcmUndrodWTJYH5UWXn/R0GhFfNBF/ddVVvwuXjIuog
         aFjg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlFVva1ks0kf1zGzyUFxyNDeMRghoipu38hIyUCuf9yDfjQMPFK1j7K/Dq6Iq7AeBMqdfOeQCnOtT@lists.infradead.org
X-Gm-Message-State: AOJu0YwAsxKNrGRJ1KW+FS+NFXmbZWZKxIt/JlEoeZ1u+XNqtf+Jt39u
	Pp32UNf0Eh0v5bPSAeTbMiu30OIrEBDZ5qclBz7Tooi1i7gbDU0SaVq29ZZ3vs7qT89gpLpvdTN
	xKxbWrIigTJH6IaV7tSHZelI+p7i4m/0=
X-Gm-Gg: ASbGncu1HVPg2/I5EN61SYWngDU2Mq6ApVF5Kg7XDK5gbnS+C8NgxAbq11wBUHJ02hu
	Jx+USdgJFk0Y8A/+VehCYHW65n/BUv+MuNVRJN2IOh+xBWJ/rkF1pA9BZfoln3wAAma4VNvgwEq
	UxbliKwyTNangqlgR1SQ413QOM1uAPFq4tnAUBYXiSXeijv9SuIr3RnWYBboaoJ9TrAicwbhfQ6
	tlQysohEZswIS3jip0=
X-Google-Smtp-Source: AGHT+IGWN1U3ruetQeiQiZtCe48SxGVf5HYlg+D8N8D2z6yt7sbK2mz/SAzZzQHv+qRuaJ8dGFMSUcAUInTb49quAHc=
X-Received: by 2002:a05:690e:2508:b0:635:4ecd:75a4 with SMTP id
 956f58d0204a3-6361a8ad38amr14381272d50.50.1759167954977; Mon, 29 Sep 2025
 10:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250926000200.837025-1-jmeneghi@redhat.com> <20250926000200.837025-8-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-8-jmeneghi@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 29 Sep 2025 10:45:40 -0700
X-Gm-Features: AS18NWDiG_e____J7dH1E1fhXzMsXsdLMiodTDWlX59WmDK7fVQpz_X3soSeuJk
Message-ID: <CABPRKS9SkaGZjC_vEy-YdgYELffGLvub7DTFGCYXFW68ObWqYg@mail.gmail.com>
Subject: Re: [PATCH v10 07/11] scsi: scsi_transport_fc: add fc_host_fpin_set_nvme_rport_marginal()
To: John Meneghini <jmeneghi@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, 
	hch@lst.de, Justin Tee <justin.tee@broadcom.com>, james.smart@broadcom.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, njavali@marvell.com, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_104556_427737_64281D9F 
X-CRM114-Status: UNSURE (   6.56  )
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

Hi John,

> +       u64 local_wwpn =3D fc_host_port_name(shost);
If CONFIG_NVME_FC is not enabled, then the u64 local_wwpn variables
aren=E2=80=99t used anywhere.

drivers/scsi/scsi_transport_fc.c: In function
=E2=80=98fc_host_fpin_set_nvme_rport_marginal=E2=80=99:
drivers/scsi/scsi_transport_fc.c:900:13: warning: unused variable
=E2=80=98local_wwpn=E2=80=99 [-Wunused-variable]
  900 |         u64 local_wwpn =3D fc_host_port_name(shost);
      |             ^~~~~~~~~~
drivers/scsi/scsi_transport_fc.c: In function =E2=80=98fc_rport_set_margina=
l_state=E2=80=99:
drivers/scsi/scsi_transport_fc.c:1309:13: warning: unused variable
=E2=80=98local_wwpn=E2=80=99 [-Wunused-variable]
 1309 |         u64 local_wwpn =3D fc_host_port_name(shost);
      |             ^~~~~~~~~~

Perhaps we need to ifdef the u64 local_wwpn declarations in both
fc_host_fpin_set_nvme_rport_marginal and fc_rport_set_marginal_state
routines too?

#if (IS_ENABLED(CONFIG_NVME_FC))
u64 local_wwpn =3D fc_host_port_name(shost);
#endif

Regards,
Justin

