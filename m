Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13852E65D3B
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gk4s0lN4iiQNDRkQaGooAIxufC3wWStq/REi3qziCSo=; b=gWciRqYUestPWMiXY2pY4rKVvK
	wcQp+O8R5lziSD0eu7gOis0AlNTmr8gWsuozIJgWKe5SvCj0k+b1HmTwrBopGVyxV8ryXUj1baEud
	FL7k7hlg5pZL/cvoVCV7sY0mPAHjgSm5O/7LLWrC0f3ESAPJOh0TY1cl6QL8WKFjHA/tZcR12ALbw
	TWdqIKNvtMayt6ZGSAAZm51dj/1dDIsv80YTWq4fZKOxb6tR6ZCt+Yqn9AKomZhIiWO6lHc36LVR8
	s0MZ6GpDgEL4GCNy+M1/4EMqcbR59v8zSDasW7gvlRfOucCL0mKyt8cjSCAFHnqNGtnuTk8PiSci4
	rrInOesw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPzU-000000026MD-18Pm;
	Fri, 22 Nov 2024 09:30:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPzH-000000026KN-0BhB
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 09:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gk4s0lN4iiQNDRkQaGooAIxufC3wWStq/REi3qziCSo=;
	b=ixEYWB3QxIPP/YhBwOOH2FYHt8Xn3aXdVrp02QYIDt9nT5M003P/j5iZsBeHytr6B/07oI
	KGuCIU6LuhefomITUCrc8lVNJAbaDgkhRXX9jdueA0FTScd7lvxnFhXWubDFumEAs4RRLQ
	auLMQumOyrD1WIJS6KkFs2svoNxiJPo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-hXYN_dmFO6ayDnRLLg5sRQ-1; Fri, 22 Nov 2024 04:29:58 -0500
X-MC-Unique: hXYN_dmFO6ayDnRLLg5sRQ-1
X-Mimecast-MFC-AGG-ID: hXYN_dmFO6ayDnRLLg5sRQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b1473a4640so287286485a.0
        for <linux-nvme@lists.infradead.org>; Fri, 22 Nov 2024 01:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267798; x=1732872598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk4s0lN4iiQNDRkQaGooAIxufC3wWStq/REi3qziCSo=;
        b=DeA+WcMVd0n5cLT1RulcWjkIzQSDE6RoitoiyX2FmczMQXAE8gdybvat+7ifvV4BB4
         88ZRMH/NH0Av9O+mkvmlUlEGa2bdjav8/+0VEJFsI8xfsylNEF365LBlYL1bP3jm6RR3
         rkZGJC408IOePetC4BEo1h1WXA2LPExFfVt2Bse9bUVG3JbKH+pHTK5VgLye6y+YaLzq
         b4FsuPFNtrCiYzDvj6RfdNRFhG62rIRn0x2neYwvxGlwWBRo7wtPhWsDFDS+5jJKF4v0
         ahiUh8lzr/sl42nLhwM6gcE16Tsx9kpB4D7EiJ1l8AV8KYgBWsuGWM5lys7uG1YvutnJ
         ij5Q==
X-Gm-Message-State: AOJu0YxqGv4uDYwZybeDUUo+a68pG4rs9nbRwYc9I7GpATomF7ZTvtiN
	Fi4SARj9+8a8ddbPdLGAww8GSAej7lvO6xOebSHiqyBmOZOkUMrK/e0MY4lo4ctnJfQhrlVqwb4
	ZpbKkLXyNj3oe/S29hHrBTr6e49M81zgTMhCDBMQQjM0oNCqhOuVnt/PmoQGK5Z3sWAvuczuAyt
	qwR1HaQxXzXtFkwwESpQUTZRYZbCZHMYGcnOZD3F4=
X-Gm-Gg: ASbGncvlXsbTi0vva5vi2kYrhEDQcFYwch2J6f3qfbn6/ddzqrqKp2DXOAl1KBFUj1n
	lObYU2ga6wm8e4/mVJoW/qiGTBU9gYfk=
X-Received: by 2002:a05:620a:c4c:b0:7b1:36b7:3fad with SMTP id af79cd13be357-7b50c141731mr1123651285a.13.1732267798221;
        Fri, 22 Nov 2024 01:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAUCvS1XEn13XmSk3eIlZXpYYPrj59Dm1b20gNEXQHKRZiHxF4xYL+Ca6e6c5bid26ackqyn1vdGrb3BB38mc=
X-Received: by 2002:a05:620a:c4c:b0:7b1:36b7:3fad with SMTP id
 af79cd13be357-7b50c141731mr1123647785a.13.1732267797965; Fri, 22 Nov 2024
 01:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
In-Reply-To: <20241122085113.2487839-1-nilay@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 22 Nov 2024 10:29:46 +0100
Message-ID: <CAFL455kVSfcx020VAZaNPmMhJOKb_VPtaqaCvXpzPG7Rfva9sw@mail.gmail.com>
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in nvme_execute_identify_ns_nvm()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	chaitanyak@nvidia.com, yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, 
	gjoyce@linux.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WKuDrj645mEOoaEoR9enHlusam_sCUuAeBv-SiZdyaw_1732267798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_013003_190007_EA64FF68 
X-CRM114-Status: UNSURE (   7.70  )
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

p=C3=A1 22. 11. 2024 v 9:51 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.c=
om> napsal:
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       void *zero_buf;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +       zero_buf =3D page_to_virt(ZERO_PAGE(0));
> +       status =3D nvmet_copy_to_sgl(req, 0, zero_buf,
>                                    NVME_IDENTIFY_DATA_SIZE);
>  out:
>         nvmet_req_complete(req, status);

I will later submit a patch to ensure this function complies with the
NVMe base specification, building on your patch.

Maurizio


