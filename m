Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6DCD5B87E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rStEVmmMboDwSpeFIKmyyOVNv7h1ipRM2s9BTP25/IE=; b=v0/3jYGY6rJrZk1+0nEK7IBhB3
	Y09g0MUb6Tm2HL5kcYtluljaCN2ptcvEEEzC2yky7t9+qFFt0FtBlFpzw+bTcNNPaHwWYc7kCC+eZ
	1WxDWGzllHMmldradaLrXUX8PDm66pY9Rk1X+RG3BBjtWslpLExbZt/5HwnPgkVajTrZhldATaKBS
	fhMP4vA7yBzshkM0fqvzPErmQP8dAbZYafV7V3otjUr0shojuw2TRBQfGrba6DcmuhSgghVpCgC0u
	d90gEaSkXMltgmDuOhujo1d/o3F0BJNjmxsP3n9h3fGNb0KtlFTiB+tLWdi+BkUSJmcqfKNTU9tnO
	VWOv2F0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVJyi-00000004V7X-0BwQ;
	Tue, 16 Dec 2025 01:35:52 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVJyZ-00000004V6Y-2Csa
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 01:35:44 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-55b6a642a4cso2967907e0c.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 17:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765848942; x=1766453742; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rStEVmmMboDwSpeFIKmyyOVNv7h1ipRM2s9BTP25/IE=;
        b=QXEj/or7ffh7EM+hnEA5KKz737LJ+vRqP1avDG/IkE8ET0C0AhpQziLoQAJIfcFVwZ
         9wgQkGogBkRIp1Ymxin0tN5BtZowb2XgS3jOOYlRDrPxNm8iTCTKCs6Ww6l8G/Z01TWF
         s8KLDkKeu5DrdDycSb7TsgFgmQJKz8lJC70AOy1EJTiIUZ0+XBXDDHY+GZf7W50idlZX
         W9UXDYvIMYFyZy58VP/zredAPxpAHFGb52JupAczGAp+D4SWH5OnBPkaJBiX5dRbgiqN
         61GAyPJxgPkeXt+0DC8Xt2nRDWtbBZr0ztLQueAqEIx9kDS2bE06DK3aZF0dkZo20z1e
         l1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765848942; x=1766453742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rStEVmmMboDwSpeFIKmyyOVNv7h1ipRM2s9BTP25/IE=;
        b=J+Av+ijCIf3leBk0u3ZQJizTlmfUIcN+787OX+3GWr41AjkrxyfSym5MuNzWHVxgjw
         ufilIpc3I3QOcVXKb+pNa7uFVhWqksUojpqUVyzFx1/h1kaMYzFoxWeQVX3n56bsTieM
         2G6eQQHPKbeDpnwBRnz8JSN2H5u3I93woOvUl1ldea4gmnQW/YBbvKaGg/QcEJ+NvMu0
         9cDeA9YmengrK8f/Yh/O3WoP0XV4Nn1KpvN4Ja+vremojtDJU1O9hIzx/di4+GxbWIen
         /0iWsXl5cHqJVsOnrQD/K4wJJ0o3JpX6SaR+5LM8HKGDiMXdKOJQcRK1/IHD3MyTrRpY
         nLvA==
X-Forwarded-Encrypted: i=1; AJvYcCUnVjPtbf0IltIlMebCodlMi4PLPOz3n0U8Aa12OBtJ4OrswfK945cK4HOESri24ZMTbzP2ZD7O+IlS@lists.infradead.org
X-Gm-Message-State: AOJu0YxgGWHYMWzSG8z5gorJzRb9is430iSvD8he26f3eM5gEOfdKIH7
	cV6Gu2KwryUhlOWLxAPQ35/5u/ldkDeKnPystQ33lcqJCy7WozccN27Jftsjd2je7r4LWb3dQ4N
	zcG13rk69fCJTB9GgzoLITJ8IF+HEe1+vm+ic3Qm6Kg==
X-Gm-Gg: AY/fxX5/SwoApBnI1hXwHgwPe/M8IoQ+QofWReApy4REkp3PI8LbuxwyrAZXS6VJVsE
	QI36fEcUgrT3gvxQmydKWOmL6YdxQct5y7RQ+gQsPcxsH0ug8kx1AdRed3PCX+PcMr8728kYR0I
	clew2ik4K4KSnQGGffJqoMqW0F5G7cDaiAk61sD2L4+b/1nsgToMBhagg4kJ/AgtN3cE1Zct1bY
	m/FCRMjxD9lX+82XcQUJbDKvcEZPeG8vxWd64sxYQM8mYLtlEK58jAjTaelBc094qmEpAE=
X-Google-Smtp-Source: AGHT+IFoFLGmGzQMMxEIZ9zTk7icYOf+25pXPic/9jQtEVDbzjDKUteBcQAr9KQhR+9g/UvYUUEOj2z+gl2o76KNm2g=
X-Received: by 2002:a05:6122:78a:b0:55b:6b20:a17a with SMTP id
 71dfb90a1353d-55fed5a6df9mr3968518e0c.9.1765848941687; Mon, 15 Dec 2025
 17:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-2-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-2-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 15 Dec 2025 17:35:30 -0800
X-Gm-Features: AQt7F2qeH6T1RDnTTFJ-6TtO9M_4OPy6MhtRN1XQ-2i_eA7CNdEP9EUWjGoxm5U
Message-ID: <CAPpK+O0gqug7fKJnMh6jcEERRwVALqMEZ3UTEvUFGECvfVxKUw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_173543_725078_B1B4E338 
X-CRM114-Status: UNSURE (   6.28  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> TP8028 Rapid Path Failure Recovery defined new fields in controller
> identify response.

Reviewed-by: Randy Jennings <randyj@purestorage.com>

