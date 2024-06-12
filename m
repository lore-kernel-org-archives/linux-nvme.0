Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17AEC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ob25+LbMTa2wi+NvOHDIYg/gX0fuWXrPyR9o2kWDTtw=; b=1b0VQgkgC+0fUxBoK2fMj+HqY0
	cySiNa//Z1+erKUGBg59wVvA2ECMomLG7APR+gal5YZ/lYEqNL9AttyqVBWdgQfy6ec3txg3PlKoo
	YVrC9hwPYFI6Pjsj5II964NwP9J7zN4UVKA6cjBFZ9QWVAZsvWhPYuNCUGphKmjqcWR2VSYN1XeFM
	kuNZqW0QOD3DIO7+T2ulCHc72TtB+ZxT540FYrlq16xvQs334zTN9zsdAgMa5j8uckuhu3wD85NZW
	Jd+XQfS4L12DBnI3n7tRhahYxh0reZKAUveYLUrBgJ4TRQ1jrXM/Makt4sbcpw/47E2Y4Q9VPBca9
	AKyJhgiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHNkf-0000000Cgft-49mM;
	Wed, 12 Jun 2024 13:10:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHNkd-0000000CgfM-04iJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 13:10:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718197852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ob25+LbMTa2wi+NvOHDIYg/gX0fuWXrPyR9o2kWDTtw=;
	b=Y7wrBeqCeXZJwRl5dCD80MLzyb0LaqqJ7Yw+XxgB4tOWLydGhWF0JnesVLpA9cQR7TTciV
	/3G1kiLm5SvH+uJNfDmiTiWaxK+bFaTExXc43A3WhIW0Qmej9CpoEsEAJjzAJGXC0O+4rd
	zZk1XbmpdrvWMJRBlxBVS4HIyQFzMKM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-lmg7-lQ5NiOPIvUb64xytw-1; Wed, 12 Jun 2024 09:10:51 -0400
X-MC-Unique: lmg7-lQ5NiOPIvUb64xytw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-62777fe7b86so108320107b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 06:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197850; x=1718802650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob25+LbMTa2wi+NvOHDIYg/gX0fuWXrPyR9o2kWDTtw=;
        b=OfBTSOUZlHxkyr8OjzGMUQomxue0FVRKo7mGwg/EzJCHL8ZzdZZqmLjpJ+71Uzk+ju
         qbzs73BhkbNHOf3tVCwN2Z07Jbrdd5lUiXxwKj2Vc1DjfWzSQGIPB3jzzkKYq/E9X3yw
         6qrYdIPJGACdlvfsvf8PA2U8DgTRdPg9cvhXHcbanGb+vGLO52PrRq8mkVrTeq5tG0Qc
         g9eJyPhqN8e+JVxGZQhP1PdYmer4aa6HVmYlksR9lD5esM/ZbwiElQSJcSu2d5gMfuLV
         5bjaKTEFtThHwpJDd0Fhv6T5xVwXemdkAnnHtzAT69PsCdMonOH1wgSojnZDd77daO8M
         YLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKLb9UIzSGoIhhcaz0r+eNkZ4Kb8mtsCUDCDHs8yEr3HdSlRUSS9gUQ6o9w0jXNbHGvzg5X4hNiqSxuXVp/kT8DfH9qbX+/2GC5aA5x1I=
X-Gm-Message-State: AOJu0YxlJA36jjavlYOhuW2GcurjG4uRzutfXZs831gsHJpMj7x0djNu
	W/RV+Mnw1+4HcT5Z5S4uwCR1/M3f5u8zVUyNm+Vvyf16GEQeVhWGHXfF2AQRAc37cNEb9Po9AJj
	Rmsl7Qd5A/YhO69XtFtZsyF9aiaCdqZmCKAUvcQAZv73yKaA+j4FgcruevRsLwdAiSH7WnmueTN
	oFoXsgUHeWHhXGrHbzum7961+uVIEW9g1wwQV78Ow=
X-Received: by 2002:a0d:d2c3:0:b0:61a:ccb0:7cdd with SMTP id 00721157ae682-62fba566bcbmr15600827b3.46.1718197850489;
        Wed, 12 Jun 2024 06:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHanAbUTofmNMX4Q9adcafKSO53xp2v4tWkcT0yV6rsYBEYSw45vcqNUsPNRkTPmncGCDWnfs3be+vk1gzWDK8=
X-Received: by 2002:a0d:d2c3:0:b0:61a:ccb0:7cdd with SMTP id
 00721157ae682-62fba566bcbmr15599847b3.46.1718197848716; Wed, 12 Jun 2024
 06:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240604091523.1422027-1-nilay@linux.ibm.com> <20240604091523.1422027-2-nilay@linux.ibm.com>
 <CAFL455ndCZipuN1bFTWgqjj4Sfh6AB3WUX014W1V2WY4gqzK8w@mail.gmail.com> <15192c9d-ce45-4dbc-bdbb-752cdfd4e663@linux.ibm.com>
In-Reply-To: <15192c9d-ce45-4dbc-bdbb-752cdfd4e663@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 12 Jun 2024 15:10:37 +0200
Message-ID: <CAFL455kRzW25EB+89dWBMV608PyDVEfuM0Re1q69gXKZ3Uc=mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem reset
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_061055_163540_437F358D 
X-CRM114-Status: UNSURE (   8.90  )
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

st 12. 6. 2024 v 13:07 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.com> n=
apsal:
> I think for your case you shall consider using nvme_wait_reset() before
> queuing error recovery work. For instance, it could be done something
> like below  assuming that all callers of nvme_tcp_error_recovery() are
> allowed to sleep (not fully tested) :
>
> static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> {
>         if (!nvme_wait_reset(ctrl))
>                 return;

Nice idea but in this case I don't think it can work
because socket's callbacks run in interrupt context.

Maurizio


