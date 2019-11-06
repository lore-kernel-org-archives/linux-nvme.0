Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAABC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 22:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFCD214D8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 22:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KH+fT9XX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipYgt89j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFCD214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YSJJ1psJJJM/fbototX66zzi6v/sBpbAYp/I6TgaTkA=; b=KH+fT9XXTpRiN5
	C9CGOFHiO7BV41NGD/JSyuFUYXSDZDO7Pb1J2yEZlbF0GhEPGOKDThNNee5Fft93eZUp5uuaW0qoV
	Gv1XgN/BXlfwdJ8Q7Mygp5Ljwgo/82wvHSJ4yy8wHZ89XoozG4SWRBX3LvUpGCIZwjJYQ2Vrks+4L
	RDHK9luGLqvWvvAmHQxCo4cjit+0I1svp0mPzz2OkRUiy8TilhXJA+VTEIt1XrYRTLRxZFHWNaLb4
	xHUIpIitDonfBzpIep+c/prAbgMgQg0sSzpKXu39lYFk9yBNQWiy4i/K7O+z7cLuc8btk5/Jnq1Y1
	/TetWjcJhU13H0HwUgVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSTpE-000759-SF; Wed, 06 Nov 2019 22:30:52 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSTpC-00074f-Lx
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 22:30:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id j12so10212059plt.9
 for <linux-nvme@lists.infradead.org>; Wed, 06 Nov 2019 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=mPlyd2uOwDFOJHnR0FcKb5obhlxfQ+BfqyeB8GcPgsM=;
 b=ipYgt89j3kpMg5qiTffNN6LdEoQP3g88e4XH3OUIaj0Z1pwFVRdoVoPrav7ormtT6e
 Yf6Zlqm0O6Cu2dz1Jgu7MzZ6i7vvuOMrZlc+520c0B5WoTg1vngQsV9E8VQ5/y8FEPAf
 sZs+isfCarOcx8lO2M2uDUS5piSvkSVBJ+Fsm5JnyE4Bn1FWsFBLumzdq3eFlOmqY1hS
 UblmrDi/CJE/00/cMNHcjqsxiKXlTRKCaf2phgBK+xzt3Lo3A7IofRysuc854zYiHqal
 epMUIgkSu5EO5pgC/oalwJLC4H+zrJoRTTZBRlpOnKIyvDs6Deyr00nN4xehlV4PpMNH
 Qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=mPlyd2uOwDFOJHnR0FcKb5obhlxfQ+BfqyeB8GcPgsM=;
 b=FrRWwJyIJXubA5KaKSIV3TkjOB5analhb8tZ8Li+cR0YZlY6RT3srAQFxDGX1DV2lX
 BnlMMKy+oILPdPl64RJLEMSwIsSycEfDUAdrDll7jCaIpTnhtppoGlr8xneUbQkbiPyt
 6OffEXkzpWIP5Z7zM8es6JlRxB/SxCUwvaYoyOxoYedo2G4+ATqMdTcJcokAdV4X0FzP
 Z1RYxx65vVE9wsAcPn2wqkT9nw91iifK2woqD6Vula9APkLUzRNvwMREtqDXe/cW5BE3
 v6dcBFXTvj7fLG/GB75P87QuoMERfUFbJcvn28Bc4W6vbf06h6jKeYBXCCDk0qJDgc4W
 s51A==
X-Gm-Message-State: APjAAAUdp6UjrqnHKkUHinZjTmJ52IvwiOzdoC97eW7+BVrx/ANtbnOt
 sgrLU9Ls2Iky8R4Hfezi1WM=
X-Google-Smtp-Source: APXvYqz/nEBTHz99NrVlIxam5Ibb6hcu+7t9BxFhU/n7xTbsGLzwL4ZkdOXjp/g2h9VT2OgKYIofkA==
X-Received: by 2002:a17:902:860a:: with SMTP id
 f10mr5228913plo.233.1573079449371; 
 Wed, 06 Nov 2019 14:30:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o7sm8717360pjo.7.2019.11.06.14.30.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Nov 2019 14:30:48 -0800 (PST)
Date: Wed, 6 Nov 2019 14:30:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191106223046.GA19493@roeck-us.net>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
 <20191106212921.GA7020@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191106212921.GA7020@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_143050_738361_F3FD47E5 
X-CRM114-Status: GOOD (  19.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 06, 2019 at 10:29:21PM +0100, Pavel Machek wrote:
> Hi!
> =

> > > nvme devices report temperature information in the controller informa=
tion
> > > (for limits) and in the smart log. Currently, the only means to retri=
eve
> > > this information is the nvme command line interface, which requires
> > > super-user privileges.
> > > =

> > > At the same time, it would be desirable to use NVME temperature infor=
mation
> > > for thermal control.
> > > =

> > > This patch adds support to read NVME temperatures from the kernel usi=
ng the
> > > hwmon API and adds temperature zones for NVME drives. The thermal sub=
system
> > > can use this information to set thermal policies, and userspace can a=
ccess
> > > it using libsensors and/or the "sensors" command.
> > > =

> > > Example output from the "sensors" command:
> > > =

> > > nvme0-pci-0100
> > > Adapter: PCI adapter
> > > Composite:    +39.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C)
> > > Sensor 1:     +39.0=B0C
> > > Sensor 2:     +41.0=B0C
> > > =

> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > =

> > This looks fine to me, but I'll wait a few more days to see if there are
> > any additional comments..
> =

> User wants to know temperature of /dev/sda... and we already have an
> userspace tools knowing about smart, etc...
> =

> pavel@amd:/data/film$ sudo hddtemp /dev/sda
> /dev/sda: ST1000LM014-1EJ164: 48=B0C
> =

> I see we also have sensors framework but it does _not_ handle
> harddrive temperatures.
> =

> Does it need some kind of unification? Should NVMe devices expose
> "SMART" information in the same way other SSDs do?
> =


The unification to report hardware monitoring information to userspace
is called the sensors framework. Also, users in general prefer to not
have to run "sudo" to get such information.

Guenter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
