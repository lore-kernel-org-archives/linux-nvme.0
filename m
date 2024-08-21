Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7820C52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OuvCrNKaVffH3dlvsuCUZBR7VypY2LuQe+xgoJ7oWIo=; b=SFFYGWNmgnWn4wQ/AU4gWp4XlN
	adaMGNyZ0thMTHmT/t2DdQoZqPEBFoefs74fqvFuJWS7J6nFl+PZVhbcGKyABo7FTZJQCCRsz8ho7
	B2OS4qXs3Wiczy9b/WmR4SvVFfdbOFRGGTXK7PuUp5XTP61nzWZf1l85JnDwqVhVH70c7Hczuj0Ru
	54nFo2bBXsnD9KfT+mNVkkdTtB4UUsD7jIain+Gsa5Vn8ZkyiTvqV877sqxLynVNnW8CPfyqTsgpa
	BHGAYakxcLgvvxGs3bDvKdX8bnn1CWemlrHnW1f8Q40G/uKIVX9RlCEXdT6yPIz2GAwpSowuxZrn/
	jUhPSjGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgljT-00000009Bpk-27LO;
	Wed, 21 Aug 2024 13:50:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgljO-00000009Bom-0gHu
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 13:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724248232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuvCrNKaVffH3dlvsuCUZBR7VypY2LuQe+xgoJ7oWIo=;
	b=RzNONzXdSs3qm6bOZp+IZxOb94MuhyBI3gY78+UQJz3NSXJdqP//AbD/iVCHZ81yhgMpfN
	mSCKdbViJKn+9T/iVEAXlB+bA+yAys/vNlRCv44En1VfsyMwmjZvTnpTj4hsoSaC5458Rd
	946ACLR2X2noDdhiV8k0IyoGbflYDq4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-YPiUN_qaM_2o8RGETx5mfg-1; Wed, 21 Aug 2024 09:50:31 -0400
X-MC-Unique: YPiUN_qaM_2o8RGETx5mfg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf7a4ff102so14938256d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 06:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248230; x=1724853030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuvCrNKaVffH3dlvsuCUZBR7VypY2LuQe+xgoJ7oWIo=;
        b=u87htDzhByOdWSp/7W/8hgb2r/gFGF/PXYhC1tcBWLpotMEMXstl9V+I/U8HQobW1b
         jBIjnmnhTaInjgfVkfEULs12sMVQ99u+qjHmPCyqC6+RXhnsVuK4T09w7lxF4AVUWgyQ
         fhBhJykeHfv19UJOMjS938TGBVVnuU1slyzuuHlUysANEEJDe2MNbOUfe+Jzu/c3BzPr
         r4nRPQtpzyFyi5Fwmei98IKvQ2h8zfI3c17quWT6qBJZcDO1r/neN1JoT7OVaKQ/kkRv
         w2WIZQf8BVRJN7x7Enb/zQnCcXuIrkewtGM35h1P78PTvi++4T3nC3b/OXSbha3MoACh
         7yFA==
X-Gm-Message-State: AOJu0Yyz+7aC9UaZrKl/LeKz+FZKxOeC2gnWcG2Vwd8sMlUZ6TEMI3zC
	YsMwhC8uVhjJuSM9oArk8J9htXvOOC3X4LMeUrO62Ug+9dRr1Lr2Ewk3r4hL91xEMg+PEEtjWqA
	JexYtZQTfEgptpWSq2ECxYpuUPRU1wqEFx5ljh4j8LU4YVMLFiK/V99cYqijg47E8YfG7T0UFUy
	SdWZoxRZ8mt/xy8WbMr+vymh3JYTacVY0EVN3T6G0=
X-Received: by 2002:a05:6214:20e3:b0:6bf:7ae1:9a8f with SMTP id 6a1803df08f44-6c1571caa31mr38883306d6.19.1724248230133;
        Wed, 21 Aug 2024 06:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm0jECRCp87JJGITYV10AWcBAWLNOPxZ1vLEngcqvh6vDgUbU7r3BhSSOwg/E8JsGlWdszHwvicogOb03yhOg=
X-Received: by 2002:a05:6214:20e3:b0:6bf:7ae1:9a8f with SMTP id
 6a1803df08f44-6c1571caa31mr38882956d6.19.1724248229746; Wed, 21 Aug 2024
 06:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at> <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
 <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com> <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at>
In-Reply-To: <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 21 Aug 2024 15:50:18 +0200
Message-ID: <CAFL455mk0aD2DNOp5PPDKM=OJEVd-Cxj4gbtpQeUJH9gpnSs3A@mail.gmail.com>
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Jonas Konrad <me@yawk.at>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_065034_296755_6D93817C 
X-CRM114-Status: GOOD (  17.70  )
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

st 21. 8. 2024 v 15:32 odes=C3=ADlatel Jonas Konrad <me@yawk.at> napsal:
>
> Thanks!
>
> So from what I understand, this patch fixes the "NULL pointer
> dereference" part. However, the allocation failure and associated error
> still remains, yes? And I assume the nvme-of connection would still fail?

Yes, the connection will still fail but at least the server won't crash.

>
> Is it possible that the allocation failure is caused by one of the leaks
> that have been fixed in the past year in nvme-of (I saw some in the git
> blame), and they haven't reached LTS yet? I can try getting a kdump next
> time this issue happens to see why there is an allocation failure in the
> first place.

Hmm I am not sure, looking at the memory status printed by the kernel
looks like the nvme-tcp driver was attempting to allocate an order 6
page allocation

[436736.043084] kworker/5:2H: page allocation failure: order:6,

2^6 * 4096 =3D 256Kb

----
Node 0 Normal: 277849*4kB (UME) 599680*8kB (UME)
861628*16kB (UME) 313346*32kB (UME) 27161*64kB (UME) 33*128kB (U)
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 31464484kB
---
it makes me suspicious the fact that there are just a few blocks of
contiguous 128 Kb memory
chunks and zero of larger size, this is why the 256Kb memory allocation fai=
ls.
So I suspect your system is suffering from severe memory
fragmentation, but I don't know
the root cause nor the solution.

Maurizio


