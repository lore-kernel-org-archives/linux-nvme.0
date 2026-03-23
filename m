Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0021BF46139
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pHDNYgFXEPC6asuFrUaYXButl++Xd71S+Uxhx6FkjeY=; b=g/Tfv7t7YFBjvqy3UZb6O776hj
	XB1wOreS0RMF0zL/M4+j8p0Xxo6dIJw9eeuJ5RTGVkpj8J4EluS3+Uanb8xt881qaqB1DzwdOiG+D
	KYUOeohjVXmXKENgzwT+7XHzlzXQ13LJyQK38sTt9EC9tndUe1NV/LTdHTi6SrWijWB2nQmVGX3ly
	AjA6PP5IrSyXde/vKGlgxm85t/XhTKHZJwvEKhywbL7vztqE8yYVJ5pqOZwejKbVUVNsrXvYTRsXV
	VJzH/Fye4BOx+kK1gE0TLgdp4CtXFJxAKKRScO5vfMt7wCupcExjrN0tJQ13AB0xhOZyfiImLQXwD
	eeMvmw6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4hDq-0000000H250-2yuy;
	Mon, 23 Mar 2026 15:29:42 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4hDm-0000000H239-1486
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 15:29:40 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-467ffa745c5so58946b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2026 08:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279776; cv=none;
        d=google.com; s=arc-20240605;
        b=XT8Cc7l6NIV6hBdzucAq9ASJcF5G1oUcUWHvBNO46UP9mNKRr7OeRVei4KO9Is5E9W
         Ou+d5V7xilh52SvHow3fGaZehoPauQ7H73NFyfOVt4rOh337ZnG10sqmYKQ9suYLk9k8
         XKnOdbuyo4o5Kf5HT7a/pjQV31MyB67kz2QbbHIdeo6Xv0Zg+fNPaujxU7fPEe38PMw+
         ccbCjzsV5sZBNaIUxYBfXJT5g1Vj/NXDnyEfAusX4ivKwdX09aHnKytNPrkAq3a0Jinm
         5xv5hidnL9GsliuV445ys6L1WmgIWRROagvfUIJLFCy5i0iJBVjfPNEOwzhFggF3lbTb
         JmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pHDNYgFXEPC6asuFrUaYXButl++Xd71S+Uxhx6FkjeY=;
        fh=6DtpxdeaOyFiqRrw/P1Jtxujtjly5hsoDWRMbUVUDM8=;
        b=Tqnp4bFWmoUBL0YjniPjzZq79iIwHqr22VVlHIf+EYNvCc7q8M6sbglaONw2L2GpUn
         sPpujfnmod0jaSXPxH4G9qoMkHiXaQ0iTPVku78LLsILhIZVCOti9a85h8myNnck5L5o
         rngdkdueEqJ36fZMmgLXwdOF9FAme2ZBcI7942rm62AoKlg8tA0z4fGDJ4bWBT4ivvhl
         w2AB7JHQQZe0dqj+vfYcPWlZL2GE4E0OQoPkPkyNpQEoewmLDZXn2WAZOTi/CY5Ruwn5
         O4ULz0MZiuxdQDuQWywuSK+k0L/i0vunYYUo0pTAbHKMKvxclQY/vzRyP3hbLRNNUEU2
         61LA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774279776; x=1774884576; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHDNYgFXEPC6asuFrUaYXButl++Xd71S+Uxhx6FkjeY=;
        b=DLipaSqzpo/YXLS5uHCZTHeVm2vygUtCnrXELxzWXkFrQM3zk7IpDI1ONICANK2yfv
         ebmRjL6VpNQ4Hzq37ludD4a6A2rPN0atuJKv2YkLQXXaJaAA8Mheq8NmqcBqY/RgDfFM
         Y/LjPZRs9L2+liZdYjwSxn8peVGzKlP7/dx3IfHmJ0inoB66rylQI8f0BlYROAAJMrdQ
         u9naipngdj5Yv3OIizsuwnGYtZPbcDCJ5KSOFGm2cHoYqo4BcSf5GzOjVO+DlMoI8yR6
         HhDhrfCjyFOYdu7ErUVXMiddkit4cpw6DD0HoJgk6VU1SnQtcgsG26UgJo8JcZFwYeKB
         aecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279776; x=1774884576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHDNYgFXEPC6asuFrUaYXButl++Xd71S+Uxhx6FkjeY=;
        b=sAcyhCQH/mP8dnZfQNPchh6bna/V3PxVFBHOjUCRV6vJHHWek9kKvSg0BKs5HyZOiB
         DzErmpvoNAHskU4s6sv35RKK1OQCDVECj23MHMgpSlooUQtsQDJIgwPlP7eudEboOId9
         vx+d9yatRZ1OLFdTZewGAyKfPT8v4izel3McNyUsS6QvAhI8R0eiSJaT8Wd8WEQ0wVtr
         LWFKJ26aKnI0KBXGWthLdAcWiwgxoFXLlTVJ/eu3KahpVt/7HvzfZ60vDZQli3+L226e
         7Yu7G09pitk/Ggd4hBZcnkcAqVZXJgUzzvhJn7LOGCU2NWHUOeb28l6MHlz7EOD/vNwG
         ObAw==
X-Forwarded-Encrypted: i=1; AJvYcCWGte2bEv8GP+3eDNFFzzb7b63fyvVTz5XqOd7o/YTeVUNs5qpwCjt5sP5bP065qNopKdg3uDPnQuuT@lists.infradead.org
X-Gm-Message-State: AOJu0YxiIX2RdHX9aE4xwptSU6b23kDbtKXTq39uH3G8k2YqQXClyvHP
	Bf46gY5RKq5iMjeOlKzBR2EY8wVsUy2YqlLZ9xwnDVgXh5xdW02D46JjQmAgAwoajS+CDhrhZhQ
	vWKQwaz9LstuXt5l1WJ2ff1KQ1Zi/lYTuKbaYqvs2qA==
X-Gm-Gg: ATEYQzworRe36l/SCfmUw8MHFBNh7K1DxJH7fxxC99aNlHFWzTorFdYcRv49Q71Og2w
	WLv6+Os892mGXunuMX+f3WWRw50rtyPoTOqVGI7rgC+N3RzUWb6MJq1o1o/RUA7IDfT/hnwx/SN
	RW3FEYouxIabnASiL3+LW//beq2CrWVsI5gkF0AJt2Z/hu4ETX6ahS4PCox643CXIpmszE4HTNI
	Aw0a9uKWdJOVxe9HVODnfw5OPaqo7bBILRY3nb0WkCJhrgYrxIgo+VFW7WHpyUaIQr4DgrqBjnU
	oPEdAUaFJckNmroWJjQ=
X-Received: by 2002:a05:6808:181f:b0:467:26b9:d9ab with SMTP id
 5614622812f47-467e5ee9982mr7114824b6e.4.1774279776353; Mon, 23 Mar 2026
 08:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260227202354.1012322-1-csander@purestorage.com> <aaXc7oun2IgjJ21F@kbusch-mbp>
In-Reply-To: <aaXc7oun2IgjJ21F@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Mar 2026 08:29:25 -0700
X-Gm-Features: AQROBzAdttJ1U2ozDwpmNzWxpBMm0qhTejTmV4OpXTFX-MnJ_NcYiLLqQ0kxuYg
Message-ID: <CADUfDZoRZ9mZC+C9xVaGna=ufr9wzTP-4BNkY2KyEFzpesYRZg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] nvme: set discard_granularity from NPDG/NPDA
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_082938_430922_964BC57D 
X-CRM114-Status: GOOD (  20.31  )
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

On Mon, Mar 2, 2026 at 10:54=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Feb 27, 2026 at 01:23:45PM -0700, Caleb Sander Mateos wrote:
> > NVMe block devices always report the logical block size for the
> > discard_granularity queue limit. However, more accurate values may be
> > available in the NPDG/NPDA fields of the Identify Namespace structure o=
r
> > the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
> > Namespace structure. So use these values to compute discard_granularity=
.
> >
> > Also fix the use of the OPTPERF field to better comply with version 2.1
> > of the NVMe spec.
> >
> > Update the target side to report NPDGL and NPDAL as well, in case the
> > discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.
>
> This series looks good to me. I'll queue it up later this week. I just
> want to get a pull request for my currently way-behind 7.0 nvme commits,
> then rebase the tree for new stuff.

Hi Keith, I see this series in the nvme-7.1 tree, but it looks like
you might have accidentally applied v4 instead of v5? I don't see a
few of the changes I made in response to your comments on the last
revision.

Thanks,
Caleb

