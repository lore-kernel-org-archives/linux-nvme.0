Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF53EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 07:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOlL3RSz6r/FHa/kJAy/uiAgUQG7pSYnjQgfd6RA4Bg=; b=kIJS6sUw1JMdboTZjDijRSE15l
	8C0k96NDLV1m/xUrpUj0pCw7Qq0ojtFEcPym3xx9cqsl4p3OUfV4wzDy7j0CDEF0+LaNG1RRf42H6
	DOsMjnzRbHqsjyKCAHBVEY6z4nq6UUUnnSTf0ebG5hC6HDfOiRR53mo+cfxxgRvSrIEy3aVC7WYDB
	hjjA3XPoPkRhnINyA4OtYDA1KAl3qUGbuKsTUYI8VLVC0EVo262VOOuZEOmJtoaymRDW8MtjiNIBZ
	9BySYhPFAoNUnTBLIAob0y6QQPE/m9VGH1Jzygm5ehdEH+Lv7qdckiWlPPQrCUq0+nYvvIB3tLR37
	7EH077Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPPG-00F2y3-2L;
	Wed, 28 Jun 2023 07:16:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPPD-00F2x5-3C
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 07:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687936556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOlL3RSz6r/FHa/kJAy/uiAgUQG7pSYnjQgfd6RA4Bg=;
	b=QIWc81Z5N8x0fTLQ/TmkkLl8VUDUIGB3vxsJ+laYZoO8vcVaEVNUm2rFv4zFGK04J99Lea
	2zaLs/T/iKLCKDtVALpXbOq9l2KIaX7yzrc2AeZXVBnnHq9W1m9hM08T0EO2P1+2g4V7xA
	J9b57vin9lJ8dUsfLHfGeyNVbmPPsjU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-6CWJMtw2O_KCXJUnvDKI6A-1; Wed, 28 Jun 2023 03:15:55 -0400
X-MC-Unique: 6CWJMtw2O_KCXJUnvDKI6A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a337ddff03so1263587b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 00:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687936554; x=1690528554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOlL3RSz6r/FHa/kJAy/uiAgUQG7pSYnjQgfd6RA4Bg=;
        b=HslxwZmLO0pFtOeSi3/e+zjoViaJNtQ0ufrHxlpQW+uhi5nalYQkTB7kVXFEMdu+QX
         T5hPxD+kRFPaeZGo014qDoG1eiwgDPnP7nABu8zaKQPUhXW6hZ6Dmi8lnvhkbL6CEcf2
         PJ8OTDgT2NjKS4nCLQhAN8WSmnruESUZvpH2w9TIykWXaMHBRNpaQD0tJw4iQm1dwHhs
         feJLoGetLKhGdIMUzQ+J+UuB6S4DGVXxwsTaz/MGDKPOAhpzpvBqyKKcquhfV3VOLxJx
         qFxzRFqjM6qmzwy/76LDGTDxDBcdOQvOvXxWDLHJ2oLaGUbnNkknz8mZqbyM6y8CW+Sr
         Y3jw==
X-Gm-Message-State: AC+VfDxlW2YZR3XaCi9GCrtRXAGOMDAreAFXs4jF+Azx1oPscZ0BkcsP
	QrMg9icAjNJq7VJoGO41K6SMFnnzc9o7UUUApZupCVs4ns4VRv/DCvevmu1nUAFn8yDGtvQV1RK
	u0YuIxdd/aeBDPMEX7GmXulwTRs+r/vo9mtcWSLu09wzJ1lYhD1nE8kyv
X-Received: by 2002:a05:6808:178b:b0:3a1:efe6:13c5 with SMTP id bg11-20020a056808178b00b003a1efe613c5mr6372688oib.44.1687936554186;
        Wed, 28 Jun 2023 00:15:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5b1JKXXZr/fxyH6D05v9L+c5/fBm1hVIv8gr4cANfz7s7CdBBTWYKitE4TTX3WfkZ9rc5AiDdkfY6U8UjM1e0=
X-Received: by 2002:a05:6808:178b:b0:3a1:efe6:13c5 with SMTP id
 bg11-20020a056808178b00b003a1efe613c5mr6372679oib.44.1687936553951; Wed, 28
 Jun 2023 00:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com> <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com> <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
In-Reply-To: <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 28 Jun 2023 15:15:41 +0800
Message-ID: <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_001600_104924_57E14E0D 
X-CRM114-Status: UNSURE (   8.50  )
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

On Wed, Jun 28, 2023 at 2:47=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Yi,
>
> Do you have hostnqn and hostid files in your /etc/nvme directory?
>

No, only one discovery.conf there.

# ls /etc/nvme/
discovery.conf

--=20
Best Regards,
  Yi Zhang


