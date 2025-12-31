Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD08EEB571
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8sVwq9k/KtRJfLNXcngxTISm73sU2fRAv4aVFfLZns=; b=wQkPnmmkxpqEfJPyN9I8buGJKk
	tUCjvi7AMKOWPOeFars+zb7D2VOO///GOFgImwDroCmAkD/0Ha8nGPrmxv3MAxpXuX7gA5N/Zd9rJ
	syUkt8mOubsaHAMkkX57owgaBCBaH4C6xXTiPh/CJ2D0Oks6+RxE4FgL3NebSTdceoSRibWdGlUwk
	fJdCOKr43i1BdnA0PeyjdDL75nyaLOiivA+RjOxxFZi3VIuitWRWMsnN2eydvxkSrH4PorbPT5Q+y
	X6QLHoY760rEPzQVVyuSo3msIRy+0qClFZoJNF9wxWA5T/l6/STzz3BemHahep0Ka7Fxa0ablR6q5
	TDMZi7Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4eR-00000006OSn-2BhN;
	Wed, 31 Dec 2025 22:26:43 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4eO-00000006OSP-0WVQ
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 22:26:41 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c026e074373so10587565a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 14:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767219999; x=1767824799; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8sVwq9k/KtRJfLNXcngxTISm73sU2fRAv4aVFfLZns=;
        b=B9CxFLrSUgbmOuFFMKKT1aWx670D3jFoUWYErW6qwqZ1v3Q+kIklCETITla0OuUjH/
         gR6QuvIvvehl8LA3rR//UyHfkwAxsjGO7A3eKR3wOOQAJ/NaiLOR/Di0j7QtezUgfkF/
         d2ZQZOU9eDiC8A9kTMUj7x8B/J8gYzJVzW+abhkj3+v/qXs9Q+ubu8VPrvrWqvBCS7IN
         tFIhSW00M5nAo/94XtgHc/ckCSiM3laqoy8163vUiHhlWd9BmUDzbBpGeGmtkwzVmBH/
         LaBjrQo4JcfpzemVs0XXtsgwg22qLTathq1kqOLkSeBAdJl35l8ukAh+tI5MCpLn+eFR
         Nh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767219999; x=1767824799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8sVwq9k/KtRJfLNXcngxTISm73sU2fRAv4aVFfLZns=;
        b=UCqeGhqKbwx8Hc62gjXclcpoMTBJP+FXDJmK630151narmzh5DFEHKlC5J88hmLr3t
         cWKF8+aYuuqpDM53rN9cqX8HzENCfCI/t5Afqs2HjHhwmzQagyLVZj3DR0oAUAEeCl0f
         gUG4OVL/bQz6FHmU3M51aLX/IiDVs+44qMcmFfJFiIeEhDMoQCAmKXBWphX3PD4l/RwN
         7k9lLxMPliqE+e9kqtQ/vOzCYvmOJ1TZn41QMWy7BgDGWN4auehhh4lPhBUgf+DKqM5k
         hHMj28gb8wNsfrNxV5rOqJMpw0mRQm3qkRw7L+ptdLSGMim4PLozuZLl/T14DxDXyagw
         2nzw==
X-Forwarded-Encrypted: i=1; AJvYcCVebfgMgFu5txQMP/rs+7I2Y+yNBhL5zkxIRZfA5MaFMp8Q7ou2guGmEPszXmNHMl05vjkMQlwBYYdr@lists.infradead.org
X-Gm-Message-State: AOJu0YzQzQg/E1i/s8wAbQXnOvqEDbVP2r25OcgZUXJ5Dz8dqSIUkBHK
	VQ3H/KGp+zzvOf+BSkCXHM8YINOY0l4gVJw2sECoHEOIyqOzsxKo9DihX3n/NqPno/E=
X-Gm-Gg: AY/fxX4wvCoNJ9WBlDy8pf89r24ZxNbF/+u6Qrk26eyeKev9/5SM94sjo/EBnEI9Bxi
	RFqQe+T0O+MAFtDb7fEHzc9jbhozAjjCcxJErtohM08DmxCkWd7zuMmQiY3y3rWEf/Kawu+hVXc
	AQQqhFSKo/p0O6RO5nxSG+NtEI9id7N/LlarXcuRN4RfupnHfZ6no3pCBPY7wKLxPKv82m70uuQ
	h37mwkjHx2hcHNB1D5AHlzGbeS9XcH0mVA0shdDd/95ziEp03xHvqopH1qQ34z3A/3yFM3HJol/
	JQizf8ZvrhnIM6BeY02xMwyGE21T+bJ10z7mm0rNXGGVHnNa7ttRK6wsSy/D+vxK+MOocEKvvyk
	cOq1cTeKog4NnRsV1/rpdWYrT7BphqTqX4JuGeHicmC7FR7Y7ozUg0n2xa6JjTo6tBjyIrk6nN9
	nYT8lzmrnZHWYq32EvZm3CtFxa/puGHH4=
X-Google-Smtp-Source: AGHT+IHRAs+DBQYbJtFjP7Omh9Gnq6yScKTA7NcBPSWy7KfklUqG+PVIdWZUT9a/t3IWDAACfmz/CQ==
X-Received: by 2002:a05:7301:db12:b0:2a4:3594:d54e with SMTP id 5a478bee46e88-2b05ec7417dmr22494164eec.27.1767219998756;
        Wed, 31 Dec 2025 14:26:38 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-121724dd7f5sm142000984c88.5.2025.12.31.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:26:38 -0800 (PST)
Date: Wed, 31 Dec 2025 14:26:37 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/14] nvme: Rapid Path Failure Recovery read
 controller identify fields
Message-ID: <20251231222637.GL3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-7-mkhalfella@purestorage.com>
 <CAPpK+O28VGH0BZA8Kw5p7g+1HvULhwuOOn4rr-zWWd1rq928OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O28VGH0BZA8Kw5p7g+1HvULhwuOOn4rr-zWWd1rq928OA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_142640_322038_86AC5B2E 
X-CRM114-Status: GOOD (  30.10  )
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

On Thu 2025-12-18 07:22:41 -0800, Randy Jennings wrote:
> On Tue, Nov 25, 2025 at 6:13 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > TP2028 Rapid path failure added new fileds to controller identify
> TP8028

Fixed.

> > response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> > Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> > controller identify response. Expose CIU and CIRN as sysfs attributes
> > so the values can be used directrly by user if needed.
> >
> > TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> > Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> > limite for attempting Cross-Controller Recovery.
> "limite" -> "limit"

Fixed.

> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >  drivers/nvme/host/core.c  |  5 +++++
> >  drivers/nvme/host/nvme.h  | 11 +++++++++++
> >  drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index fa4181d7de73..aa007a7b9606 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3572,12 +3572,17 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
> >         ctrl->crdt[1] = le16_to_cpu(id->crdt2);
> >         ctrl->crdt[2] = le16_to_cpu(id->crdt3);
> >
> > +       ctrl->ciu = id->ciu;
> > +       ctrl->cirn = le64_to_cpu(id->cirn);
> > +       atomic_set(&ctrl->ccr_limit, id->ccrl);
> Seems like it would be good for the target & init to use the same
> name for these fields.  I have a preference for these over
> instance_uniquifier and random because they are more concise, but
> the preference is not strong.

The field names in the spec are concise, but they are also cryptic.

> 
> > +
> >         ctrl->oacs = le16_to_cpu(id->oacs);
> >         ctrl->oncs = le16_to_cpu(id->oncs);
> >         ctrl->mtfa = le16_to_cpu(id->mtfa);
> >         ctrl->oaes = le32_to_cpu(id->oaes);
> >         ctrl->wctemp = le16_to_cpu(id->wctemp);
> >         ctrl->cctemp = le16_to_cpu(id->cctemp);
> > +       ctrl->cqt = le16_to_cpu(id->cqt);
> >
> >         atomic_set(&ctrl->abort_limit, id->acl + 1);
> >         ctrl->vwc = id->vwc;
> I cannot discern an ordering to the attributes set here.  Any
> particular reason, you placed cqt away from the others you added?

No reason. Moved ctrl->cqt initialization up with other fields.

> 
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index 29430949ce2f..ae36249ad61e 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
> >  nvme_show_int_function(sqsize);
> >  nvme_show_int_function(kato);
> >
> > +static ssize_t nvme_sysfs_uniquifier_show(struct device *dev,
> > +                                         struct device_attribute *attr,
> > +                                         char *buf)
> > +{
> > +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +
> > +       return sysfs_emit(buf, "%02x\n", ctrl->ciu);
> > +}
> > +static DEVICE_ATTR(uniquifier, S_IRUGO, nvme_sysfs_uniquifier_show, NULL);
> > +
> > +static ssize_t nvme_sysfs_random_show(struct device *dev,
> > +                                         struct device_attribute *attr,
> > +                                         char *buf)
> > +{
> > +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +
> > +       return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
> > +}
> > +static DEVICE_ATTR(random, S_IRUGO, nvme_sysfs_random_show, NULL);
> > +
> > +
> >  static ssize_t nvme_sysfs_delete(struct device *dev,
> >                                 struct device_attribute *attr, const char *buf,
> >                                 size_t count)
> > @@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] = {
> >         &dev_attr_numa_node.attr,
> >         &dev_attr_queue_count.attr,
> >         &dev_attr_sqsize.attr,
> > +       &dev_attr_uniquifier.attr,
> > +       &dev_attr_random.attr,
> >         &dev_attr_hostnqn.attr,
> >         &dev_attr_hostid.attr,
> >         &dev_attr_ctrl_loss_tmo.attr,
> > --
> > 2.51.2
> >
> 
> These are the names used in the target code (uniquifer & random.
> I'd rather have them match (identify structure will have spec's
> abbreviations; ctrl & debug/sysfs for target & initiator either be
> ciu/cirn or uniquifer/random.

I think it matters for sysfs attributes. I do not know the right thing
to do. Should we use spec names like "cirn" or call it "random"?

> 
> But this is small stuff.
> 
> Reviewed-by: Randy Jennings <randyj@purestorage.com>

