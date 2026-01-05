Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D49C79FBC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=; b=TlGgDjeK0NJ8lWTU23tvBG9G/i
	IvLwcSxWfwe8YNxXnkwVFUtS33bQ74hR1fIsHUJAASeGYZmSPNvpxRQcVuJUpRMi9aosxRRA05lCm
	c90dwoLsuw9plWJEiU5cLwtcMmEHW8YaiUV1DHs1EYYQqfmKyYiFJVi5JkjnJ2QQ/AlFXoU3vo1Tk
	7mtQgYbtC0n6a1TQUTYm4L79yhUD+kSmGJrZOp82v9Cp5BHYUmo4BsDPq0scUb+TpoaGAC3n7Nd9j
	c9WUl6Ti05jUaUPAGtaw4hgEFGjg6vcHdg3gqsWNX4Wptt/UjPsgW6S2YWQM2q+6oaiaDbWZGy2r9
	YxuXe5sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcqVm-0000000Bzmc-3Fhx;
	Mon, 05 Jan 2026 19:45:06 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcqVk-0000000BzmH-1VA4
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 19:45:06 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-5ebf4d3b1fdso162442137.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jan 2026 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642303; x=1768247103; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=kT2RlX6NmAslOHQIjEA4fB+m9V5HbKIJN4aVFuGoLPkLRq8ORkwNylo9gZ5cCkFicU
         7xJh1KgM6BAUX08B3YxKNHg39HjX62po3Fb3/Tp7kmtegsYNc0cbVhTu/8isnNhWBlXr
         oKqTGZEj54DSqTYOJeV/IWggvPVpJnpBeOaPJl6LY8KsxeKNqj3LblML+1UnMfXftKNn
         ZX6KVRqdlG7UHf1u+Obr+QYheyUEIAUry1/1O8uECDKjcWWoUaDwSSaEuwppWLrFC4Cv
         TLpF1uMs3x/6r73EbZP8msp7fHrgcv1G0d51gfPwk6Q7apB4hWja8BQNf2GX0hLRmeNJ
         EEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642303; x=1768247103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=qlrhfhmkuVv9e9ODB7xKFWy4JkP9XN+TwqT3G0pC25LGRJAry+MAerV+6P0rosjJ3o
         71tJ2FCOhR+ihOgK80RjIczLxPB6O3CIgRE0p3iiCgMQyeUhsBS+6ylL90sJVj8soh/0
         zNXRAJt+jpGdRqqkRXd+Mtywkd8htU2Bocqp4w100gglqErW+/iQdgaV8Cc7gapoJzuk
         9Hq7AHUD/mlsYz3gY4Yd73e1ZCV5Uyixw03mW5f2OkzKKITs6zls6JNkT1HhJ0oHsIeR
         mkBHTwmL3/A3RAIgp6ez1zC+kHDVW2irb+VtBJXlpdDBXhYgpmAeruU9ps2zJjalK4B/
         Zo9w==
X-Forwarded-Encrypted: i=1; AJvYcCWzhnjPWmk1uJiUxAZ7sssjfIemOojP4WzR2H/683vCX9CUoPxkMrMaB/NvMhfyfplFcQfPRSizVbJC@lists.infradead.org
X-Gm-Message-State: AOJu0YzoGFL/uIpbSqIDuk+Z2RfIwBojKcdK2ZTOza1J5k2aFsAuZg9j
	UDl/Gjn1NaOKYJ4Sy1KwrcRsQZcGiBR4VIO/7KEefXTzZmnEjL06PkVTvOhjgqsFDIBVJHPkIy5
	YGXSxm1GUavhDWgZ5g462U3Vgnb3gQ58=
X-Gm-Gg: AY/fxX4Q95twxbX0Q0iNLRoEgY+DokmAGTE8IfhDaNodwhRZNh81qARqdFt56pbmHsK
	OwbOLAUdKzcxyPwF9KV/ZH1/rwXKaylWFYZmfmqiNgpRB1QPLRO0ZNKZx9lMDn58+JFPU3mecji
	fKUjL2brT239jO8XDbZVo6fK/cMktVFcfJS92EU2U6c3pM20R5rH60N4i/tFFA/b3v3KExhXufl
	A8nd+HqNjISMJRQ9hUxc2/oAEvnqbDY0NYbkf6r4InDKqZJvnYpFU19m1In80KhgfY02cJASHFO
	Hufs5WFDdfhAkFcXQGaFRXoeNNw4
X-Google-Smtp-Source: AGHT+IGhC8WZ2khF0B1ZzYJv6toAwZVLBn6s50DlREZq57HJmP/rBfKKkp/EHegrMC2uWHxcxNwyVNHyTQnt+yA/hC8=
X-Received: by 2002:a05:6102:374b:b0:5db:deb6:b261 with SMTP id
 ada2fe7eead31-5ec743c206emr191171137.13.1767642303017; Mon, 05 Jan 2026
 11:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 22:44:52 +0300
X-Gm-Features: AQt7F2qOyhucU5ykqhHlHKS-jroXL1WRPJ3u1HtyHqgDS9V3cppHeXbKF7tCIwA
Message-ID: <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_114504_838624_A5DD886B 
X-CRM114-Status: UNSURE (   5.20  )
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

> We don't support NABO != 0

Also, what do you mean by that? I look here and I see that the
boundary is checked by the NVMe driver:
https://github.com/torvalds/linux/blob/3609fa95fb0f2c1b099e69e56634edb8fc03f87c/drivers/nvme/host/core.c#L974
- doesn't that mean boundaries are actually supported?

