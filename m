Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61114C46CD4
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMijoUcHzP5bWeyrJVvF+/HzMsQrm17RAyJDbZFSozk=; b=pbmYLvlvBlqSedHkrZintFSprm
	PMeK4u4ZHbMW+ewj+z6nYSqRCg8fDbNtX2O3BUQOb3178GyIC2DgRFkmuJPiQHae1VP2Bk/JVzt/l
	olj5/1iB5Y16IsEQXn1xY6Kmmhod59+4nWl73HcdttNsKHbGii7K31hFq5WVlk1iFVCn0Bv1FC9CP
	8KGzjEHYpqUz5nlIqzjkQZPyHDVenPKlIrCih8IdrN7k1Elcxupy8nw6bmBv9XiZ/OTyyCUQ7OnO/
	YImKuEhyGsTma5FblKmrtQJhZpgxOM0lkWmtTQk9pzUoIJVaI7IFRcL95aZM4cqQIslG2BQT5+dfV
	Zd8xkrCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGb6L-005L0O-11;
	Fri, 22 Dec 2023 08:41:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGb6H-005KyF-2c
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 08:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703234504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMijoUcHzP5bWeyrJVvF+/HzMsQrm17RAyJDbZFSozk=;
	b=FDt9FbJObyQHqJvoMNI7mfBxGv6RtR/xVtDDe1VZh9stwNJkUYwxLh9F+YadHHspKF6eMn
	Q5mt/fzvwm6O3LMXx/gFmN/xE9snnN79zVjLIt7QKdPzOxScawrX6LfBFjb7uls9+k01mF
	IUCP9nXm44qtbQHiAfJeHbpDSwyi5V0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-l1XirzMsPH6PhXoZePnSsQ-1; Fri, 22 Dec 2023 03:41:39 -0500
X-MC-Unique: l1XirzMsPH6PhXoZePnSsQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b6bd1ec1e6so308295e0c.2
        for <linux-nvme@lists.infradead.org>; Fri, 22 Dec 2023 00:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703234499; x=1703839299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMijoUcHzP5bWeyrJVvF+/HzMsQrm17RAyJDbZFSozk=;
        b=TKvO01ndy6lRwzVbe+7dA4C36JLjH2uOp+jixMRziO/Zc+HOWJcRq0oJes7dKo/hQT
         tg/S7/bAB8ku50K7UtUnEGzxTxB9/zrWXPzKw1Sl4SeTPvFkAXxf9gBh+OH8gMOcZ8Zd
         imTQpCovDbsz5okd0DohCd3XvzYJJa6MseIjntDiWxFkQO6WDyObWBu/Gy/3qLOicewi
         Y2t9fd93TSbQCHSBLqJLKag5zBNplhFzfRi+Rrkz25WlJJFEIACycWMb0GmfrIIK3ZHP
         t1/ZdIwmgRLXx7SpzeFusDFwVWtyd4lBvqob8hLrjAkVO7ORo7ZfbR2RcivPyT8AK4Q0
         ya2Q==
X-Gm-Message-State: AOJu0Yx4Z7xW3VQZNTfheC9UmINfXxIoyHzf2JCQ5D9ENdpL2xdGdx/p
	AvCsS8/uwLLzjWhm0fmA77VZHbpBClgUr6j+hbex+AKKT2AfH3Azq6rN3yQXQO+I2mPyjSbQnyp
	pOcwg+iyZD9kJNk8KDLMvRXSZZMQyGYh7GxQYsNnSPAIH4lqpqrI=
X-Received: by 2002:a05:6122:3bc1:b0:4b6:c37b:726e with SMTP id ft1-20020a0561223bc100b004b6c37b726emr555070vkb.18.1703234499158;
        Fri, 22 Dec 2023 00:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExj7lVCkNF+MXiAqBcanyMU3sTAnOFeIzDLD/lp/M79krliHtLe7dkzYfbc1TFCa6mM7z60a38vAI3p+H/80A=
X-Received: by 2002:a05:6122:3bc1:b0:4b6:c37b:726e with SMTP id
 ft1-20020a0561223bc100b004b6c37b726emr555061vkb.18.1703234498928; Fri, 22 Dec
 2023 00:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20231221163154.605669-1-mlombard@redhat.com> <20231221163154.605669-2-mlombard@redhat.com>
 <ZYR4_ifqRtrwgwVt@kbusch-mbp>
In-Reply-To: <ZYR4_ifqRtrwgwVt@kbusch-mbp>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 22 Dec 2023 09:41:27 +0100
Message-ID: <CAFL455nm=hphxs7XWyv0gC25fG9mum8dys4vfVopy_bf4nixYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvmet-tcp: Fix a kernel panic when host sends an
 invalid H2C PDU length
To: Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_004145_920551_F980DE7F 
X-CRM114-Status: GOOD (  11.66  )
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

=C4=8Dt 21. 12. 2023 v 18:42 odes=C3=ADlatel Keith Busch <kbusch@kernel.org=
> napsal:
>
> On Thu, Dec 21, 2023 at 05:31:53PM +0100, Maurizio Lombardi wrote:
> Please add the 'pdu_len' to the pr_err since that info sounds useful to
> knowing which type of target error we're dealing with.
>
> Otherwise looks good!
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>

Thanks,

I realized that there is still a possible problem, the data_length
sent by the host
could be inside the allowed range, but still higher than the real size
of the packet.
This could make the kernel crash.

Today I will send a V2 and add more fixes to this patchset.

Maurizio


