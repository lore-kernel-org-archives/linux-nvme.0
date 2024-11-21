Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF0AD6ED25
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=myEWuJ/F+H+RLQuXWJV2gYCnDed5CZVEDrBKC4pp6mM=; b=knOZjrkuIV7pOI/p4+CuMzRYoF
	RMUrkDxyvrLWoLAES8XLv6ovR9L1/aH+c0Ij9BPHwzFU4tAisTnNS980SQiMs786iggkSVajoYVoi
	kcUvYfCrnyrXvl/UfpiwTGsJz1bGsQs3rr2BByqyOs+QB2OpoZmGGNVcOytZjldmlkzZ98inLsn8G
	FmipjRsT9Uobyc3lXH9mg3wAoPKI2xzTGBH6qBCtSS47QLdaQiKstnXt2IZZ/XVU1BlXIjkYlmvv7
	R9C1Ylfq/Wnss8WvLSyN+5ykHaXjaJmWJ5a75Gr5Uvpuw/T/8NTJo2RKEQo3uOO17j8LGIvD2Hd4M
	PNKO+/6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE6kW-0000000034T-1xXk;
	Thu, 21 Nov 2024 12:57:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE6kT-0000000033p-1SF5
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 12:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732193848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myEWuJ/F+H+RLQuXWJV2gYCnDed5CZVEDrBKC4pp6mM=;
	b=bezRPmB48EqMTUTHMA94IggaFkG2VMSJgIXBECIUxnC94zxX28CqIKodVNVvUZGM/BcjBh
	CuBu/ltLr52wpj/SZdzTmBkyYTevXaywv5rs6T7WLU5RSCq7eY3r9IhQe8kpSZBnKe/rk9
	JAjGGLsKQGLujcA8004bW3w8zYLHm5g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34--RcDxDVrPKyxsXJ0j90-Lw-1; Thu, 21 Nov 2024 07:57:27 -0500
X-MC-Unique: -RcDxDVrPKyxsXJ0j90-Lw-1
X-Mimecast-MFC-AGG-ID: -RcDxDVrPKyxsXJ0j90-Lw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d41a81a98fso15676756d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 04:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193846; x=1732798646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myEWuJ/F+H+RLQuXWJV2gYCnDed5CZVEDrBKC4pp6mM=;
        b=nBHAbzyum54usDVrxDURO05uEeb09mASrQsRGaxTcfiUuC1mRz+AxVIVEea426BU2Z
         LpAFYLRpaca/j5xucWSC8RzP5IGIYs18CFdErtQPNJYzfoDPuzXXf6ZQDxXv9Tx5bE/7
         i1qNL4pMmqWLdtJ3h+Ur/iYeYQtG6kKcrEqLJ3ghnmm2agDqadsZHW/0cTb8Sg9/iZqB
         RQko4CMkuUZUH6kjx8GECbLgRgXPmicBVJKjUXKu8tggYX+Mm1h6PE5UsCj/AOzpJrHl
         MsXXZk26zdTsfTiyzIL7rfy+TPt5bucHT8I0ccGZ40+NlMYHPZv/XEW05E2g5OZ3XkVB
         P3aA==
X-Forwarded-Encrypted: i=1; AJvYcCX+H9pce3A5UaQFRl/QdmHHD1Ozd6Q9WOFR239hp3dBIRqDkKwQd092jUx6WH7fgtDAN2l0Qea9zqn4@lists.infradead.org
X-Gm-Message-State: AOJu0YxN9q+UTNFWS4lOUMT8iD118WA4aHdeAE6UN6Lt9tGsk9NbBrJg
	A5iS4dlKQe0GxooUIojE8roGHMxeW8QrUgRfMTex5uePyKNpf9HWCRIqh8TQ/zCD5P0hS8CmMQo
	v8jKWsPOLrHTQy9CnW4LC1cfkl2dG5DIUftR2Y6C56T5QiDhzMgXSKEIfwbYOjK/fFHqsUG2T9Y
	J5tE0UAHFj3X/czfh1ggpPq/aPxK7QiOverZn4NSA=
X-Gm-Gg: ASbGncv9RH7oaB1/M1vIY2KO6Uimsy/KMppA6RQkRqPpJlm/2Fqez4XNPZOLD1sVIhe
	aVryOLJ3+SFWnNwFIBRGk1r7DegykjW0=
X-Received: by 2002:ad4:576b:0:b0:6d4:2211:839 with SMTP id 6a1803df08f44-6d44248a9e4mr55317586d6.23.1732193846674;
        Thu, 21 Nov 2024 04:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxcMFW7Hm6XfsjiH7G0a0FrNfrTzVmvbh3UlhfyiBa68R/OSjJ1WX7q/zGfYyG2TyKo3CdJmpF1SgaR2zc8w=
X-Received: by 2002:ad4:576b:0:b0:6d4:2211:839 with SMTP id
 6a1803df08f44-6d44248a9e4mr55317436d6.23.1732193846463; Thu, 21 Nov 2024
 04:57:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
In-Reply-To: <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 13:57:14 +0100
Message-ID: <CAFL455kkKZ=E=7XB34NjjH8SC3QuHnwityJABRxFNf=vJNMoLg@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d3HM3o9bSiOq4UQWZwvQRZVKjgcJa1uVDDWnqcwR544_1732193846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_045729_451675_EC7EF75E 
X-CRM114-Status: UNSURE (   4.45  )
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

=C4=8Dt 21. 11. 2024 v 12:11 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.=
com> napsal:
>
>
> +       zero_buf =3D __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);

Question, isn't this equivalent to page_to_virt(ZERO_PAGE(0)) ?

Maurizio


