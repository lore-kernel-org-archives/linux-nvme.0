Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B0C52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0gAcJXbB1ZYLEPeQhqr9HuKl2fSI1JydJbxRjYb3K0=; b=GdwkQQ2kvBQlAHi/VuRn7M0qTF
	F7nqGWiyZdsVl6HV4NAhqBHUKTVG/B/nBBVSLnwi/sZ3mvHOpziRprPxzj3twr+AYm12+zptc8F7H
	Ul0RLgq9EJf3y8J+X6CxyWJ96hS33xsNoC/rnGLAZfGmnEiyPP5+mBoMCrOtkpbNqrEuA87joUVTQ
	SGWsOzb/2+MT+MXxynGgs0MjFqlsR2UMCHebe30W79XK0A/+iosIvvwN90roHjk3X/z8GA1+dN9dU
	CBQPq5OpHQlXFnbmer4R/vUHiSzPTzHXDZGxE+7YM64FV4Vv5xruQB6igzluLma2Gycz+H9TCIaWX
	R+a1VFqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgkHp-00000008tMK-3OII;
	Wed, 21 Aug 2024 12:18:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgkGD-00000008svR-3xHz
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 12:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724242581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0gAcJXbB1ZYLEPeQhqr9HuKl2fSI1JydJbxRjYb3K0=;
	b=B6AtXKFaue5cL8KxVKJJwXPbsSE1A9gSRbsdO8R3lW/SArZuMvApLx/aRFEwSApo3rJeVy
	NunPsUF6+By1xTGmO1IBWxuzDTz6p4y9c30AzKYLw5zJuaMx1+q5LkrV8CA/V2k9VksJeo
	WTJLRNLO9fOm8fD5oRyovUb40vDh5jI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-lGOKsCHbP-yLUUjHH4qx0Q-1; Wed, 21 Aug 2024 08:16:20 -0400
X-MC-Unique: lGOKsCHbP-yLUUjHH4qx0Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf6a0c2f1eso82486616d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 05:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242579; x=1724847379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0gAcJXbB1ZYLEPeQhqr9HuKl2fSI1JydJbxRjYb3K0=;
        b=vBFNfHTTHkzdL53ExZz4FZ6iYqxHMQLxlMX80TWdUStg4cWCbyEu/RiyXIfs79sSOq
         E0tB+lQEkXis+/+WidgJt8JrJjDAWk+1RBgITHjFJXo0WJokg2Mpybp9iFr/zi42/PuT
         edpAX0TPL1sko1MeOny8IrWb/vAPb9hWje4UnOev/bQOOkaeNimqH6Z/Rwxj1DarrZq4
         gvCrXJgFRablF/Obd0cySGfMDbSG4sMYEdg9wZDhKg9oJCbTIfQrULPv4BrcEpCrPosr
         FlfsJ/H+c3DVxnQ+DzopZ33TpdHXTnxb5D23GQVxrEkIv3Joeyugb4bNXHk8xinw86oA
         njTg==
X-Gm-Message-State: AOJu0YwPXi+0bmdxOFaVxKX2XXGdV7KztVWw7gD+FRUqG4csvZ5ppacB
	EqmaCA1prNlj9+1r5VnxyUuzdBYQjx8qjBnDMxntjY2sfRYm38r/6s3Zzjl5i6SEb7wvkV80o8m
	Uew1E+ODc3u6H7pblGuaUyTWtR5fsukf+22NSzvLX+MnT7ZCXeH6jGM0omgtbH7MWtligEsKiRK
	EKXULDqpLSLqgcF07Vt5lvcYDC+1uWGLpMA5ctDiT9lTCV5/T84Q==
X-Received: by 2002:a05:6214:3f88:b0:6b5:34b:8c02 with SMTP id 6a1803df08f44-6c155d9dfa8mr27002646d6.27.1724242579354;
        Wed, 21 Aug 2024 05:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkBYle8Ps5S2QM8W9TO/1iNES+vIh9MPWgapdNngS3aQn3RmelzXutRkFv8UyWluUVrto1UCrrwKkTGHDYHo0=
X-Received: by 2002:a05:6214:3f88:b0:6b5:34b:8c02 with SMTP id
 6a1803df08f44-6c155d9dfa8mr27002406d6.27.1724242578999; Wed, 21 Aug 2024
 05:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at> <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
In-Reply-To: <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 21 Aug 2024 14:16:08 +0200
Message-ID: <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Jonas Konrad <me@yawk.at>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_051622_080710_49AB4C0A 
X-CRM114-Status: GOOD (  12.02  )
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

st 21. 8. 2024 v 12:57 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> > Is the stack trace enough to go on? Is this already fixed in a newer
> > kernel? Do you need me to gather more information?
>
> The stack trace was more than sufficient, it's still reproducible on 6.11=
.0-rc4
> What happens is that the nvme-tcp failed to allocate sufficient memory
> for the commands and the
> queue release procedure dereferences a NULL pointer
>

This should be sufficient to fix the crash


diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..b37506ad851f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1534,6 +1534,7 @@ static int nvmet_tcp_alloc_cmds(struct
nvmet_tcp_queue *queue)
                nvmet_tcp_free_cmd(cmds + i);
        kfree(cmds);
 out:
+       queue->nr_cmds =3D 0;
        return ret;
 }

Maurizio


