Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF010F2865
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2026 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ge9Iw921OwlEIIL0zU7ZodWK+HVNZiJY7DqmCAymPXI=; b=fvY9EeH2xSSRoBOVpDWfEpe6HE
	wBOwoSJ+WnWq5rHgUDIpIpkkPePR1c+HkNmiG+hN2nSti2Tl8bsecrfxy4epKOkeUGH2iKbW0fmtY
	nKsnEvf2w0LiGDI0uz2XSLYSxC29GZ35EyU3/wY+Z/0syk3PjdgEo8zkCtrXkEcJAg48hrNtxqpJE
	w2+rWi3/2MrK9oM9VVxzLmv1KxVcZ06BO10PbJBAz/peF4cDWUgXQGZyDuu/HW9RsaUEX1qFF9GQN
	yesfS33mtR4FolnlWAYXgBOlH7je65J4t7yuAblQd4HsdPDaK+CHlM0+6y+X+FH6B22oU34nvJXyt
	dHv9Qczg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6C00-00000007x4E-0Blk;
	Fri, 27 Mar 2026 18:33:36 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Bzs-00000007x3R-438m
	for linux-nvme@lists.infradead.org;
	Fri, 27 Mar 2026 18:33:30 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-12a71ade78cso2909069c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774636408; x=1775241208; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ge9Iw921OwlEIIL0zU7ZodWK+HVNZiJY7DqmCAymPXI=;
        b=IA1HZDPhooPUP4Ir+nky1Ay8ROM2ipfDx+GnP7a05AeYnkMZUM+8prKnZJoU8U8BL8
         LHl2XEKq9yncVgT0q/3GYqsTvtFoO2kd07fcXKEwbAEbtgfbz4+26tI2L8KcJmQd8Crm
         sXVJ/h4WE8FQYsnlr10lmmAvQ+Oy50z2CZd5guGgNNi3GPuPgkPtjLBIvpBOTfs8xpWS
         qXcfvkHtrMn4qpLv1J0jtozZ68UiRnvVK9YA6Q3VnwWJaffdDZhGYbJS4syxVQP8qUs4
         LGkigPjrGJ/YsoimMStUcphK7dZ02Fyj5+k5QI2+FEXV5q9ftcWTUmPUyBtj7PYyxxHW
         Amtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636408; x=1775241208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge9Iw921OwlEIIL0zU7ZodWK+HVNZiJY7DqmCAymPXI=;
        b=FWPwVYVHBb3jT0ZAYkh6JC9KE8ZaAyPry+kirnkH5dnhc7bOh1DoIFQbYeChmTYSYa
         RtBsCQ+2F0HeL5l9vMc9+nnxNC2Unl/pedgXWgvdrqB9nemjcVDnPjZiO4X8eZDkD25P
         lnyyqlpA1IpfAtNZ0dQCAMTM8hr1bcfjNV9Ge+2F5iuL5vS7SgB5wm4mJTZSxP9BLUni
         gRTy2dkQq0uoR6b2Pf3AbLxJQhszGpv9MNutkezL3w+hllMpCYK/g4dmEIoErPQeuP7u
         hSMV8GUj8gGk/ysFoDluGy+shSZRxD1K4RghoPrT1Pcw6xbH/BPXSHdllolIO0b3m4ho
         2VLg==
X-Forwarded-Encrypted: i=1; AJvYcCXQQfUnqsPGBRrRaO0U4rkmI2Qsw5RjX0hHlPleR+rKrGJ3O7ZNyFFp/8wOZJ/iqjeo9zbDO/FEbDUp@lists.infradead.org
X-Gm-Message-State: AOJu0YyqqHzoDjhuuX7RZAfbWwsggvPRgx5P5KNmc7nM6MQfsezd5aRg
	gkUEQGbK7OCPJDQjtyYxj3bV1BJUR3YTSjHad3wuqPfbkYCISJ70KErlOlPRD80Dnn0=
X-Gm-Gg: ATEYQzxjxuRiX3/uaapQektbIxYEvmu3bgt0qJM/Awaukk/cWUsZ3Rf5PV7a1FKp7MM
	nyNirXBdxAY+DDEKGCNx6S9uBHEssJ2ulKf3UtVXzq5r4BGgwM+FctZ+k2JLOObcsXOHG2e+SXT
	RpEDxLGU8DG8xieqAbFI66IapwwRUxO4x5Snzu7TAAgKBieEy8wf3ysDjCpIeRogQPw0XbWyOeL
	rGQRWCvewpAyVchJoO7nV4KVj2cfX94fwPly/O/jRwlkv/P33gJOxR4ODQkKq+5SYzcb3JCT84A
	ietaqqG6AzXERlMA3JG2Rzv/Fh7yvnQxkNl7mQ1qHS5DpHeM1CPecMSmIWg0dwBRRiA7rFtChzQ
	2dU/uB88bBKS5zHT/47kkrkdJMRlyPs/Ya+mKYbpI0/obeVhBSY6CEYVRFdYdEc8gndfklYB/Xo
	rz86SZqiAMYoIsdJFnkBy0aJA9kfy0VeOWV+ev2sm9WjY=
X-Received: by 2002:a05:7022:f005:b0:119:e55a:9bf6 with SMTP id a92af1059eb24-12ab288a058mr1954310c88.18.1774636407293;
        Fri, 27 Mar 2026 11:33:27 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12ab97d88c0sm30404c88.5.2026.03.27.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:33:26 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:33:26 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/21] nvme: Implement cross-controller reset recovery
Message-ID: <20260327183326.GQ3435530-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-9-mkhalfella@purestorage.com>
 <CAPpK+O3wwqOM0B8AzmHXTkVYV_8_X4NKwpw3GiGaRO7e313FDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O3wwqOM0B8AzmHXTkVYV_8_X4NKwpw3GiGaRO7e313FDw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_113329_040672_963542B6 
X-CRM114-Status: GOOD (  20.52  )
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

On Wed 2026-02-25 18:37:44 -0800, Randy Jennings wrote:
> On Fri, Feb 13, 2026 at 8:28 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > A host that has more than one path connecting to an nvme subsystem
> > typically has an nvme controller associated with every path. This is
> > mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> > path should not be retried immediately on another path because this
> > could lead to data corruption as described in TP4129. TP8028 defines
> > cross-controller reset mechanism that can be used by host to terminate
> > IOs on the failed path using one of the remaining healthy paths. Only
> > after IOs are terminated, or long enough time passes as defined by
> > TP4129, inflight IOs should be retried on another path. Implement core
> > cross-controller reset shared logic to be used by the transports.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> > +       if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +               ret = -ETIMEDOUT;
> > +               goto out;
> > +       }
> The more I look at this, the less I can ignore that this tmo should be
> capped by deadline - now..

I updated nvme_issue_wait_ccr() to do that.

> 
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > +       deadline = now + msecs_to_jiffies(timeout);
> > +       while (time_before(now, deadline)) {
> ...
> > +               ret = nvme_issue_wait_ccr(sctrl, ictrl);
> ...
> > +       }
> Sincerely,
> Randy Jennings

