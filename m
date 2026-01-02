Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C1FA3753
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jan 2026 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZkU2g9pwmc1oWeUP+RIyHBKEVsfAki23US80eINbcU=; b=lFvdopZQm84WEpJlBs6yXDBOKd
	pi2y2Ic5ai0caYazcAu84dSn6oP+o4Zg4a3RhcMC6k0dXP84A/hsF4jGJ/N94Sk4Pr4XWZyvGD0/J
	IZg49atR7XvZrXDdtfTwB8eAzSi9ocrwTP6dhsOjhYi/R5/E4wsTM2TwVw6HOVaY1wdQk/PJN+7/w
	MxOEiTBs6gDeou5GvvIMRyGWVzOqEGCaR5G+20mJnRqC1mrK3KhDdERm/qCrFHBqPOLheGQ/NxW70
	k1n9K4GXx5Wf6oKqrrRzuVIwq98gfKi43038PVjA6SXPjYAfVWcovSo7hSIX/ollgBhonnvjbRPaM
	70yGJsPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbkUJ-00000008f1y-0T3Y;
	Fri, 02 Jan 2026 19:07:03 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbkUG-00000008f1c-1q0J
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jan 2026 19:07:01 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso6576674a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 02 Jan 2026 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767380819; x=1767985619; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZkU2g9pwmc1oWeUP+RIyHBKEVsfAki23US80eINbcU=;
        b=YhFkinkcbisSpXOIU0fbz0MdkRNDs7Hj1RDTZ9zon8F9w5TniaeOrdjOGrd3yjeIqU
         EhpiKSlKwxU66/zSYKIF3yyrbi4w7+refe4v3V6Q60GvxLOEb/UUou52Uo2cb3SzpX1W
         G41xFlGIPM+HzBzaB0Z+YxHN94c0sCilHiOyc8dspc0RUmcFUUcZZ6/0okP/O2K4JFeJ
         TujsBMpsPNyiJlbf1tIlW4n/E9xB+09Jj0AXwKzEZKpNqkHZ5dr/GdpaV9mVRxh3LOmD
         gqrmxUXcsKzWukCDuDudYUCo0l+VqZ/tDnaU1BGl8nnT3HldgPSneiKmaHAPKqf2B1nb
         rSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767380819; x=1767985619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZkU2g9pwmc1oWeUP+RIyHBKEVsfAki23US80eINbcU=;
        b=pXbMWCmsMPNlYGg1hEchLpIUOajdk+/ASoTggtuRGLPiWp2m66astIRxEzCEBjUdWs
         JDnRVBEIRZDHVvWPo7LU+QnKUQVoaiMe0OCUlMopQHJzBwvsc+z2HODc3ItFaZTwQr8c
         GLJ9Kv/M6bfjbj+ghO9WBV+ke8nD3vKJf1TZgV3YmqFYF1IgIGE+hrgHVX4r18mFtu72
         VYuDGyZhSi/QS2z6oSnCYntaqlI8lgFTB8S1nHsW18/SvuYipacV4RjzAEuWWz5cukZj
         l827OjWKjqZktPuL9px0QQgEFdJP/qqwDjsbIysqTSRHhhLIVjk4YPpdKQ73q+pwN5kF
         fDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBud+3/rXq2/eKw2TTRuDU73S81QjalpqHxdHjtCAAewazh9ebECb9Ar36YmNVy0Jeis1Icdv7kLaf@lists.infradead.org
X-Gm-Message-State: AOJu0YzVd4z0mecgXNZDGz9PTsS/DzN6G6uMMZCj758q2MqLjoCQTxGu
	A6OzLazulffv7jBAFSc+oLoea8Zj8zEkBDQDggoIsRCPinz533dA15JEspW02cOGpCg=
X-Gm-Gg: AY/fxX69p+7+6sGVw8j1ux+hlSFfXeNn+DkZVv4PuVczO5Zf+LncHoYVMqGwEiK8g26
	BVbrsudpCmgYz8H6YA9ComU3g+5wYNGhIkmraQen9hkLuckbthWDmYjqyi2eodAHiLbylfXUYpx
	8ihrf3gvI7brKEm4Ie4Yh+aveKz0itwqANOis8E1Fp5tBRJ6OlhPTsmvbg+2GE/PZ0mpEpmcg+e
	SNGsnRgODO2vAfBtsSYDsFJ5RHoC71R42tLERgE+l//ItKUTG+Y+GPaA01Tb8G43P8PebjoMH9q
	tcL0JQilbsR7BgXgdDGpQyxcdh+sWLedL13/4ZhW5ZNlCAwVESKHB+EENeuZgI3/eguVIYsu3Gp
	VozeEyUH3HWpbX8UrxLU05WhSf+qw4eTM0jEmvSJeoTve0YczE0WZ3wrhRQB93cgbh+r0orDXI3
	5olnZyjWWDrzQyNemHpBZ4KUZctFah2740LPcoiB8y7A==
X-Google-Smtp-Source: AGHT+IG0JO9l2BkWn3kSOLFClKo9cRMw5aP1DvhpwcNfZqrILZIMkJaMjN6WBCxm1Mg/gTF/PX2QCw==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr30508125eec.3.1767380818821;
        Fri, 02 Jan 2026 11:06:58 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b140c42e8bsm1644691eec.26.2026.01.02.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:06:58 -0800 (PST)
Date: Fri, 2 Jan 2026 11:06:57 -0800
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
Message-ID: <20260102190657.GT3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-7-mkhalfella@purestorage.com>
 <CAPpK+O28VGH0BZA8Kw5p7g+1HvULhwuOOn4rr-zWWd1rq928OA@mail.gmail.com>
 <20251231222637.GL3864520-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231222637.GL3864520-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_110700_483855_DFFC9C14 
X-CRM114-Status: GOOD (  36.05  )
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

On Wed 2025-12-31 14:26:39 -0800, Mohamed Khalfella wrote:
> On Thu 2025-12-18 07:22:41 -0800, Randy Jennings wrote:
> > On Tue, Nov 25, 2025 at 6:13 PM Mohamed Khalfella
> > <mkhalfella@purestorage.com> wrote:
> > >
> > > TP2028 Rapid path failure added new fileds to controller identify
> > TP8028
> 
> Fixed.
> 
> > > response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> > > Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> > > controller identify response. Expose CIU and CIRN as sysfs attributes
> > > so the values can be used directrly by user if needed.
> > >
> > > TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> > > Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> > > limite for attempting Cross-Controller Recovery.
> > "limite" -> "limit"
> 
> Fixed.
> 
> > >
> > > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > > ---
> > >  drivers/nvme/host/core.c  |  5 +++++
> > >  drivers/nvme/host/nvme.h  | 11 +++++++++++
> > >  drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index fa4181d7de73..aa007a7b9606 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3572,12 +3572,17 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
> > >         ctrl->crdt[1] = le16_to_cpu(id->crdt2);
> > >         ctrl->crdt[2] = le16_to_cpu(id->crdt3);
> > >
> > > +       ctrl->ciu = id->ciu;
> > > +       ctrl->cirn = le64_to_cpu(id->cirn);
> > > +       atomic_set(&ctrl->ccr_limit, id->ccrl);
> > Seems like it would be good for the target & init to use the same
> > name for these fields.  I have a preference for these over
> > instance_uniquifier and random because they are more concise, but
> > the preference is not strong.
> 
> The field names in the spec are concise, but they are also cryptic.
> 
> > 
> > > +
> > >         ctrl->oacs = le16_to_cpu(id->oacs);
> > >         ctrl->oncs = le16_to_cpu(id->oncs);
> > >         ctrl->mtfa = le16_to_cpu(id->mtfa);
> > >         ctrl->oaes = le32_to_cpu(id->oaes);
> > >         ctrl->wctemp = le16_to_cpu(id->wctemp);
> > >         ctrl->cctemp = le16_to_cpu(id->cctemp);
> > > +       ctrl->cqt = le16_to_cpu(id->cqt);
> > >
> > >         atomic_set(&ctrl->abort_limit, id->acl + 1);
> > >         ctrl->vwc = id->vwc;
> > I cannot discern an ordering to the attributes set here.  Any
> > particular reason, you placed cqt away from the others you added?
> 
> No reason. Moved ctrl->cqt initialization up with other fields.
> 
> > 
> > > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > > index 29430949ce2f..ae36249ad61e 100644
> > > --- a/drivers/nvme/host/sysfs.c
> > > +++ b/drivers/nvme/host/sysfs.c
> > > @@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
> > >  nvme_show_int_function(sqsize);
> > >  nvme_show_int_function(kato);
> > >
> > > +static ssize_t nvme_sysfs_uniquifier_show(struct device *dev,
> > > +                                         struct device_attribute *attr,
> > > +                                         char *buf)
> > > +{
> > > +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > > +
> > > +       return sysfs_emit(buf, "%02x\n", ctrl->ciu);
> > > +}
> > > +static DEVICE_ATTR(uniquifier, S_IRUGO, nvme_sysfs_uniquifier_show, NULL);
> > > +
> > > +static ssize_t nvme_sysfs_random_show(struct device *dev,
> > > +                                         struct device_attribute *attr,
> > > +                                         char *buf)
> > > +{
> > > +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > > +
> > > +       return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
> > > +}
> > > +static DEVICE_ATTR(random, S_IRUGO, nvme_sysfs_random_show, NULL);
> > > +
> > > +
> > >  static ssize_t nvme_sysfs_delete(struct device *dev,
> > >                                 struct device_attribute *attr, const char *buf,
> > >                                 size_t count)
> > > @@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] = {
> > >         &dev_attr_numa_node.attr,
> > >         &dev_attr_queue_count.attr,
> > >         &dev_attr_sqsize.attr,
> > > +       &dev_attr_uniquifier.attr,
> > > +       &dev_attr_random.attr,
> > >         &dev_attr_hostnqn.attr,
> > >         &dev_attr_hostid.attr,
> > >         &dev_attr_ctrl_loss_tmo.attr,
> > > --
> > > 2.51.2
> > >
> > 
> > These are the names used in the target code (uniquifer & random.
> > I'd rather have them match (identify structure will have spec's
> > abbreviations; ctrl & debug/sysfs for target & initiator either be
> > ciu/cirn or uniquifer/random.
> 
> I think it matters for sysfs attributes. I do not know the right thing
> to do. Should we use spec names like "cirn" or call it "random"?

Now I am thinking about it, I think sticking to the spec's abbreviations
makes more sense here. names like "random" and "uniquifier" in sysfs are
not descriptive enough. I changed struct member names, sysfs, and
debugfs file names to match the spec.

> 
> > 
> > But this is small stuff.
> > 
> > Reviewed-by: Randy Jennings <randyj@purestorage.com>

