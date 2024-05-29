Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C4C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hoYnL6wLjgtK46PptOendYkx61AvrSyvyQBn8nxgTDw=; b=I3WO0nq8bK96ZTE+Kv2EH7xAMu
	OoZZdpnKhrfeMKDh2VR2Ap7NJ6tfu27ePgPMXzNF116oR/Az/tfiaonW3Nqo7DllvSDOME2yQCMI9
	ZSq4BWIt3Wb1QU6UUghnSbYyZT+2ot3hlB7274qBihh3HEgxjq9ECoMtxZRas05fejAFIp0/NRaWa
	0De5Vkx9R8G3i/j/1mNoY430T+UT2K0fxjUolof03U85hbEXtvetDclx83SNe3HPaS/9NFj71qJBW
	ps054reE4za8nJit5Ny6Lvmhp9Y4WUYljklO+wapkOVrMrP/p6cF49EfvbUS8C3KSlM57Q3bPaMtT
	590k9Qfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCFJ7-00000003ZfV-2fNx;
	Wed, 29 May 2024 09:09:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCFJ3-00000003ZeW-2ubR
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 09:09:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716973752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoYnL6wLjgtK46PptOendYkx61AvrSyvyQBn8nxgTDw=;
	b=HsiZZtTjF8N2Wm1jG8US0zLhtEO/0KYV1yfgMoXZNqM8vj0am1dFvyzUG4+ES3pSauYPtZ
	gBxPaQniIQ3L6wJl6IimuJfRbAet1GXQ8W35KLNWeYKb/17j2OyGpVhQBqsTh35puZ6WAo
	ZgmgSeZ1vyQiRU3ZbQa5dIJt+q7mpfQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-NG5VMYlaMVS_-wGdXzCzxg-1; Wed, 29 May 2024 05:09:10 -0400
X-MC-Unique: NG5VMYlaMVS_-wGdXzCzxg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48ba698d8dbso161620137.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 02:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716973750; x=1717578550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoYnL6wLjgtK46PptOendYkx61AvrSyvyQBn8nxgTDw=;
        b=Iig9ZcUfyy9IZK3eFfm4rgulm82cdvhjl9rIWCk+G3ZyLTnZPKuywR0+HbVl03EUxN
         uhAeF5jmZsKOeKEA4JTbVwhvz2YBVzUtSMqUqR5WG3jgeE53idUAeh7eSjswxtBq070z
         5kgaIG4BlzzZHFDvcA4Zqpp4NfabNDc5xqjKKVvIEL1D0ak0032J1PjLBlEVmlAjLQIu
         LCzWWVHwE/X2hAjMzM0oiGvS9ONMYkCWbQx7j7JISVBfOiDrjdY9DoNv1WgSuxF3+K8X
         UdlUYaWOu/y/65M5DpSGIZPnDVDv5e0Nl18jz86p9RiWCX46KhRLYYt5X24qin5if0wK
         MSCA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPgY42qbnwl4Ut/N2CppSUWJnNIG+MxZ8S1AdCMdvA5SVKUvhFSE4mxIutxH9+NVH1UVA9ZCZ00m9lopueSnnS8Acv58kiqX+EXpu6KM=
X-Gm-Message-State: AOJu0YyqKmFYDmHbnOEhV7FhvtKm6SKwvzsd7L+ezMweCAC5iMbG2EBU
	Dp+tFnJ3z7TipZPB39bD71+W9nfcrQt8Y0zfxsqn/lXe+FV52q1jTl+UKNS0cws7R0UomzNXt+X
	ADXdSFVJg+lgW+cyvJ8s+zwSjYkYPp8Dqz13BwZB0QpdqtU+/+NUUqoHJU4vFsuggd6pnGkPKUJ
	47oZKxgV3MwhHMg95XbEYcY7yAzCuzsDC+19hpOBk=
X-Received: by 2002:a67:e998:0:b0:48b:a945:e445 with SMTP id ada2fe7eead31-48ba945e493mr11049137.11.1716973749781;
        Wed, 29 May 2024 02:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcRk/Z1QtevVonXBArwhnxbI+zvD6w7dkzMJm9ZlJOVW7i29RibXafr5aBwvmpgikFkK8xkdd2vY3OEHZeZrE=
X-Received: by 2002:a67:e998:0:b0:48b:a945:e445 with SMTP id
 ada2fe7eead31-48ba945e493mr11040137.11.1716973749403; Wed, 29 May 2024
 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com> <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
In-Reply-To: <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 29 May 2024 11:08:57 +0200
Message-ID: <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_020913_833169_42AA4C3E 
X-CRM114-Status: GOOD (  10.30  )
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

=C3=BAt 28. 5. 2024 v 11:44 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> This patch fixes the problem for TCP, it should also work for loop but
> I've not tested it.
>
> http://bsdbackstore.eu/misc/0001-nvme-fix-memory-leak-when-nvme_init_ctrl=
-fails.patch

I updated it to fix all the fabrics, with the exception of apple's driver
because I am not sure I fully understand its probe process.

Why if blk_mq_alloc_queue() fails it just does put_device() and
doesn't uninit the controller?
Is it a mistake?

Maurizio


