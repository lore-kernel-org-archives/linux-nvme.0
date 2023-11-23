Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DA2C61D85
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bX9HY8J/QSIqiFO0Pa0EhqdDZFQhOgbTj29TI6Qx/Ng=; b=oZHIA4XSQdFkJYgYVhaH7ufdUL
	U+1RVDHRggAfZixvhA1B4DmFM/C0VcvDSDVl9IeOPY9GQ5i06CMh+zOtMNtQYvWIUlGmIfk7F+QT1
	Lzu0cnPUJSnGbMK33mAJX7ExjC5aTOnDLbdy7Dadlm9bUE9r79yVrm+c6raTbRhy9KOxgZZqhzuQf
	Qtqt90djYeMKBFeJi90vcRD7xBZTZppW1sdsLL661QuoWBZ8UHHf1prXJd8iH3CWqXxMaK60i8piO
	nKxECVNdppzX3wtru9xopjSPUs+8gpTCz16e4L8mq+ShLz+1zHl58069yND+oCJlrjjSOb2fr8oZ4
	Go1i2vFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r65eY-004DHe-2y;
	Thu, 23 Nov 2023 09:05:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r65eV-004DH4-1L
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 09:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700730334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX9HY8J/QSIqiFO0Pa0EhqdDZFQhOgbTj29TI6Qx/Ng=;
	b=N7rwlR3VVAmO9UWDZdt9z31ImPpKjThxxNNcD6nlp+KMnNL8OqboXvnAgN6wcoA3+c0kOd
	BGNHHBLC8ooS/jI4mBCJ4hRLIG/S4fCUuz7RZM1TPWhDKkKOjmb+WTBwbR8xSqRPDgb/2L
	PGhLIvFv8g7aoJM94nmRsQJV7RJBjkY=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-NpqtVvvaOjCPLmWz6xPYjA-1; Thu, 23 Nov 2023 04:05:32 -0500
X-MC-Unique: NpqtVvvaOjCPLmWz6xPYjA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4abebcbc81bso224535e0c.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Nov 2023 01:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700730332; x=1701335132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX9HY8J/QSIqiFO0Pa0EhqdDZFQhOgbTj29TI6Qx/Ng=;
        b=h+kNGxcy02bf7763POhI4WH7XUV8cXaR/L6KCDgSKzBB8kiLhaxjn8/xoIHFAsv8D+
         RB1elByXkDLuEpKq0cdEcSn4o7twUP3yh3gBj51fp4en8oFVXF/4f57QygxyJKIMYMxN
         +8upIo+MtAx+3lehgA5M4GCrYmFDtQWn3KyghwmEc3e+Q5B5KG/GlGBNyzqv/ZNnaODE
         JOEaHFzzgECgMdkTpSGiBixtIFNENM8tpp7kXkENeKBdtB3GA+aheaxK6bsqmaR3586/
         P+WOlsxT2UYTrxlBFzlgFcYWaEbHRgQXk2BvLJqWsBZ56cwehAA9MAgyvch90J3Y8w5a
         9YYA==
X-Gm-Message-State: AOJu0YxuG9NfrZN8nuRDISTCyu6OEYX89AX8Txuqg0qQcBm0isG+yPqR
	40bjOd2z+55yvoWveLNMr2fEP6TMJSB0JMUh+qs4mbz6NogWrrknwUAwrBMakBq/VAkHAJVCoax
	Eocc8IuQVk4wiMnLUOez/Y1vSGtHuSLwWBnxNP8U96m0=
X-Received: by 2002:a1f:da82:0:b0:495:c10c:ec39 with SMTP id r124-20020a1fda82000000b00495c10cec39mr5064336vkg.2.1700730332262;
        Thu, 23 Nov 2023 01:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2vqdFdPzZkQgCl3XpgtS0LbgivShQhQNCLGTAHVaaYnkILc16iwRulyESeyA4eDgGe8SBHNXTui6fZm1OhLI=
X-Received: by 2002:a1f:da82:0:b0:495:c10c:ec39 with SMTP id
 r124-20020a1fda82000000b00495c10cec39mr5064324vkg.2.1700730331977; Thu, 23
 Nov 2023 01:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20231110163721.15292-1-emilne@redhat.com> <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
 <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com>
 <ZVzzW0P6CtataBLK@kbusch-mbp> <CAFL455kC=UuTV=sAxDYNPj9X4y=ex2ND41VXv6Wv0KLWfNcm3w@mail.gmail.com>
 <ZV4st9iwMgJSC01Q@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZV4st9iwMgJSC01Q@kbusch-mbp.dhcp.thefacebook.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 23 Nov 2023 10:05:20 +0100
Message-ID: <CAFL455=kP6fRa_0DJwqJyW0Ys0nt+y-jKN_6nhyrbEG-pdn9+g@mail.gmail.com>
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
To: Keith Busch <kbusch@kernel.org>
Cc: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_010539_548239_97D005DC 
X-CRM114-Status: UNSURE (   9.88  )
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

st 22. 11. 2023 v 17:31 odes=C3=ADlatel Keith Busch <kbusch@kernel.org> nap=
sal:
>
> >
> > We have the same problem in the nvme_ns_info_from_identify() function.
>
> Indeed you are correct. Would you like to send the patch for it? This
> patch will also need a v2 to incorporate the same.
>

Ok, I will send it later today.

Maurizio


