Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE1C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IEt+TGYek6Qwo/z6KVI6/JrHDoja+dWTEAS8XO50Xho=; b=Vxb9Rm4maMO/THBXslnC+bkmJ6
	VNdecNmg+ZycITJHISAyHrlzlpKU+HZY8WXbYPRrtZgas8BB7flGhRRx5iyLzB9kI6GmNUmdCGmRq
	xaMsP4qQIsGXfR/WQpi3c+D4C8KlnxrybH201iBB0lXQlhbucutTpwOd5FRjgrYyLdYZfYItgjY0a
	rgA7QgwcAa9Pua2lKOeM4z/MI7vxjN24nUFlaEvXwylmQTzfEXNxfcrGI5J8MdjPIZKYLi3hHqju3
	urR8WBXbAVypjJyXgqx+Y6ivHst9LLM/L37drYcREsWKX3G0idF+dCAhQ0gBLtWUWMTANTBZcbzqO
	d5xFIwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjlR-0000000815G-1zlO;
	Thu, 30 May 2024 17:40:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjlP-0000000813f-0WNx
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 17:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717090829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEt+TGYek6Qwo/z6KVI6/JrHDoja+dWTEAS8XO50Xho=;
	b=JmCpknFyo/cAwypg91dHU8Tw9Ak/7hcZPWgX7DhRRxiqofZjzUbhPdAjkOZDghhWhs4aXd
	0VXa//AnHUDJljSHVUUDr4wDrdRCulCErVQP0bN5LnaEGIFMMzsppKek0EhUAnoVDeytd7
	rrmeOedo0+ASMIJjwGK+7uWtEFI4irI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-hveMPgRPPWOV5uwaDviuAA-1; Thu, 30 May 2024 13:40:27 -0400
X-MC-Unique: hveMPgRPPWOV5uwaDviuAA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48a397e092fso1053540137.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 May 2024 10:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090827; x=1717695627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEt+TGYek6Qwo/z6KVI6/JrHDoja+dWTEAS8XO50Xho=;
        b=jt0fbQ/za+A4enaoDdiiEZybSxS/32zStKr6lozTnB0pw2mVihzgxr2+fr2yF4Y+yI
         xRkzzCmJ0cZPx44WIHTufBMYUfXZ9OGK2O1XUvfp2/mjuy1olP+nUIrQzafmO5B5N1Ql
         Bd5qAQxBV60RiXq0btyjxy+K0JnWJAsPyDTzA2GmiIYoFAi/uTCc65SwmjiQC567f24w
         RE9Odrm85F3b1LlYd0bA4CpTVodiAIzoSKP/LmoK5nPj4DhxPDbVONkga4dMJTqVOEtF
         KA5oOAUuukyJPUTS+i7nSi9++qYnUr/N47DHq3lFxw/HgSopmqEoY9DNttN6kdAjHMAE
         FiDw==
X-Forwarded-Encrypted: i=1; AJvYcCULsUxW8x2xn81gnvYlXBh3NtZ8cZFtf37skZ7DqU11raa7cytuzFKE6PceudkXKrCpW0J2FOdRCiCWacGSVMh4+QK5NdkoA95tYd46ams=
X-Gm-Message-State: AOJu0YxruI57vUQY2HSnKU9Qv9+IQ1+wDgO6sczMKXVzPXNG0dfYyJDI
	2i4olZMAYomYlEQEPQZwb0dbji74QJNtSwMBgLX9XHEdpBM14YkSz0mLRoZUlPrI4d9awzrxKUD
	RBeH3kBpPtngkitIzxOYFB+ofEru8QFAxOOtZdKL+UCw8POAf//UrQAmKvy762qEEK/AIbNg4/a
	2dgCCcw6mU4PwHGl/qJfNIK1hyiwHP/vmPFC3It0U=
X-Received: by 2002:a67:f644:0:b0:480:6bf4:1821 with SMTP id ada2fe7eead31-48bafec064cmr2792418137.13.1717090827030;
        Thu, 30 May 2024 10:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM7AfxxTwsZnfa4/yJmLmf8kPN+GsbYnGJGaTldXjNtBIpOuVbCZYqL++2PMi7g4m5DbOPK7zuLpNkVFFsLrI=
X-Received: by 2002:a67:f644:0:b0:480:6bf4:1821 with SMTP id
 ada2fe7eead31-48bafec064cmr2792405137.13.1717090826693; Thu, 30 May 2024
 10:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me> <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me> <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 30 May 2024 19:40:15 +0200
Message-ID: <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_104031_254302_614C126B 
X-CRM114-Status: UNSURE (   7.84  )
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

=C4=8Dt 30. 5. 2024 v 18:29 odes=C3=ADlatel Keith Busch <kbusch@kernel.org>=
 napsal:
> I noticed that too, if cdev_dev_add() fails we are supposed to do a
> put_device. This driver seems to be making it difficult to use the core
> device interfaces as intended.
>

Just an idea: maybe split nvme_init_ctrl() in two parts?
One with the pre-device_initialize() stuff, I don't know, call it
nvme_alloc_ctrl();
and the remaining part will be nvme_init_ctrl().

Maurizio


