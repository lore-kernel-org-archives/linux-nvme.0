Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9DEC761A6
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1l3ZCrosvOuNuXLWrVgc79wWirhyq15PN+dU5h4Qc0=; b=xlElM2tgcQof+p8EuADdu+dsb7
	PqdqnLCyAGP42G/FejGD5jfGmGGqNyu3NnQsmydB5mfdV/LXmxQ8YeA+wSgQE8F4q4D7gtYu/81+8
	e5zQLnH4K1JQN0tGtT/py/tPBUuuEemTEtWxGy58A0YXEBuQq0HsJmw5SJQSPXIkeoaTUp3NEe6/c
	7yqPJ9aLXMw8RfhfcusvDqLvxS8BOex3VhCLVtlM7sQnZ0FQGfmlBuZY7/a/aXeKHwtm2ye4I3YxF
	i38O3br6rTkN1zAqYtLnBidm/zxOpvAZFKgepiULu2P/MFfsfElvFjIjPejojeoQtnHvD0Nwf6v6P
	tc13VvSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk04i-0042zu-0F;
	Wed, 05 Apr 2023 10:09:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk04c-0042z3-2W
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 10:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680689341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1l3ZCrosvOuNuXLWrVgc79wWirhyq15PN+dU5h4Qc0=;
	b=QRegs9tTynbWZjxYMRr13XH8T/Yj2+J5+2rhZtx8Ws0dqeAyFhM4yOfY9JPf+S1Xw43KdJ
	qgJXL6xwWrbZSEsHTGz8AWs5mZaEVO0UmK+4AOwPyH66fIxxjIxwnDdvTjDV5QKpqKB8Ud
	KEzT23yMeVQf9NPJUhxm6z/ZbiSPrFw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-53MzOu9cMxGcomIOsQTd_w-1; Wed, 05 Apr 2023 06:06:40 -0400
X-MC-Unique: 53MzOu9cMxGcomIOsQTd_w-1
Received: by mail-ua1-f70.google.com with SMTP id n13-20020ab01e4d000000b0076512b30a3bso13095518uak.13
        for <linux-nvme@lists.infradead.org>; Wed, 05 Apr 2023 03:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1l3ZCrosvOuNuXLWrVgc79wWirhyq15PN+dU5h4Qc0=;
        b=RGEimGTSQqlG972XXijCJLqKSUz8AKYnb7bK+uFdrGugFOlZ9ZKSqgbpYWGC45f3I6
         AglIfzME3IefljjzXMhxuS15Z7G0hfRlDvpdltd2Zs3YU30kxZU5lEwe6lhzXHLxuns5
         J31nCftkx9aa76z7vIdK8St6U+OeAyNrIkBjphmK8hfAGjyN+xhQpHebWYhyM0Byyn2C
         /ZjVrnMNGGpkjzyVPzWAQrQQVQx6YsE5grA5slY7HvDIx1eG5CPo+L74tJzMrA3x6/Tq
         UR2SgiA+TJNdb4btb8EfeP9MtpHMDw5umh94pYnhOnECClzWze/uRfnevwJRdZ94kFR+
         CF7g==
X-Gm-Message-State: AAQBX9fRohiTT4j3TYe17k1ZPl/+uFuAYn3YhbBsWsPI8e69RNfieC+F
	qR8gBCjWQgplhqxSCpEos7IjgAtGacY1+efUvcBfzQAoRgu/UuIy+XMXgSuP2aLJ1AzyfHzvU7U
	KGOK2NTx2r+HI7I8q5VOF2KRFY/8S9643hUvDRonYVwo=
X-Received: by 2002:a67:cc15:0:b0:426:a319:a226 with SMTP id q21-20020a67cc15000000b00426a319a226mr4614633vsl.7.1680689200289;
        Wed, 05 Apr 2023 03:06:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YR4r6yT1+E70rhICD5Lxf5litt0dkdqFxzO4dys9/wObjCIxpGCHZhK8G3msWKkhK/iyEpaD1npoL2dcAypEk=
X-Received: by 2002:a67:cc15:0:b0:426:a319:a226 with SMTP id
 q21-20020a67cc15000000b00426a319a226mr4614623vsl.7.1680689200009; Wed, 05 Apr
 2023 03:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZCoguA3gBUw1CIdd@archlinux> <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
 <CALL+9ei1m2oj=MceRyyjM+FMuSrv9eD=nLKFrkX+RD-0Zp7v0Q@mail.gmail.com> <df40eec3-012e-3664-14ec-d15e1c57c258@grimberg.me>
In-Reply-To: <df40eec3-012e-3664-14ec-d15e1c57c258@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 5 Apr 2023 12:06:27 +0200
Message-ID: <CAFL455nssqY2Tu6sr3axgr4=qV4NUge1y3R5+1cDqpM2pp4OWA@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
To: Sagi Grimberg <sagi@grimberg.me>
Cc: irvin cote <irvincoteg@gmail.com>, hch@lst.de, kbusch@kernel.org, axboe@fb.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_030902_919404_9CA63519 
X-CRM114-Status: UNSURE (   7.24  )
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

=C3=BAt 4. 4. 2023 v 0:38 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me> =
napsal:
> Not arguing the bug, just want to understand what Fixes tag it needs,
> so that this can go as far as possible to stable kernels.
>

I think the correct one is:
Fixes: d22524a4782a943bb02a9cf68 ("nvme: switch controller refcounting
to use struct device")

It calls device_initialize() but doesn't add nvme_put_ctrl() in the error p=
ath.

Maurizio


