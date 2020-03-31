Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7195C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42E320781
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pOdKVeCy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4CMhZHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42E320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bl9lbzyCOrazjfJ4z1+3lCKvwCxLVlR7qJ1s9OUYqKs=; b=pOdKVeCyso06kn
	fpYUlU7Dlt7fPeTvjY2bqdCBucP65pjzdqTXVtWVOpv1CEAGTUA/NxuDPkWMXYad6bcCxXRmf67NP
	poJFX4KgLYM1vbMftiZVQKYMjpnLt/q2HJifN83G92gLeAuwRjIn/wDkUjiXDhn4YNr1MS83qwMF8
	8lgAOxcleDj5a0j/Dd+1nFU0DImW1yT3Wxt0yBmmH+mze3+dywuVEYe02CcHbYmF2ontvCv87Y9yH
	JFm4RhYchyU9JmgSMxIGPZmaIBUCXdSrP4FPKsok1Zax3DqeHRsieCkqfEFMJxbyJHLUnFT8w4ix0
	FvH/1oRIh93qqy32bgxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJFO-0000CP-KR; Tue, 31 Mar 2020 15:56:14 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJDQ-0004gs-F2
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:54:22 +0000
Received: by mail-qk1-x742.google.com with SMTP id v7so23551939qkc.0
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SHD4oM9r2sY9bG2/tzxFgd57vQnlmusmcQcj5Ymeb3s=;
 b=Z4CMhZHYQT1X347W8+1lC5u9LQ5mHIJZphRCvvEblXanKGSYoIkW7bTLK+NbufhxbM
 2qTH+w3XzPzvREJaLy4ve4EYsiykme0xfAhW2/8gEYRErstb+RePZcICGsRbuvJimOOl
 833WeRueB3PLEY+SgL7+vhNTHVKz6fJEzzYfuNjKf8gJgFv7KfkVyAIKDO0vaZ3eWbgC
 6pOvT/qG4HwaDX0vLCp55yLR4xjOYPj0tIiDh1RWy5JPcHOVrwCOzEkwDijahfSdP77i
 e1R2YOIK1+aHNMGlYER963UFU4JKSxL+NRgZb/BQ1j4MV3pb4QF30GRBpSmzfinzgv+k
 o7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=SHD4oM9r2sY9bG2/tzxFgd57vQnlmusmcQcj5Ymeb3s=;
 b=D+CIxMjvEcoqnyAtLRVZQgYO7bVZFZ8Z/T9BaG+AP9C6LaDSr5gC1vKeEm5i7Vo8Jz
 5hKn8vPOrYfhvmrFia/T4NQAssXnSyshTT93mcd5RIYpKr9cl7qCOAXGunmDQZQgG30k
 i2kePkt38b8DSQ1Y+6d04uT63z1rzwXPRvVQop6C6nCboUhLdF2rpHb5PYKPcJ24Lf6P
 QxSmRuEjjvz3zQuOg8l0+Vumz1Q1u5RiTW/1f11HA6EpGgEpuvwLd6TLUGcowntXf/kq
 1R503MX4lAwdRBt+7MIFIyxVjVTN8UvSC7WLBd0NpKsInJqdmeR+0Q019o8DR9AOzG/0
 EAmg==
X-Gm-Message-State: ANhLgQ1zWWOf5tsGMUcyibjfbTznY0AgEpRuglGDY9JfcTfPrXQsCGVe
 b8vfU2g/Uo9FyQnXHNJSEYU=
X-Google-Smtp-Source: ADFU+vtmA2Uuio8ivyXkn/LaBIXYX66GosZ34RQ9ZJ5dN73nV7YmEXNKh1VGhwy+FaVbRZmY54Zqjw==
X-Received: by 2002:a37:5d5:: with SMTP id 204mr5656736qkf.59.1585670051486;
 Tue, 31 Mar 2020 08:54:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b946])
 by smtp.gmail.com with ESMTPSA id x124sm12882214qkc.70.2020.03.31.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 08:54:10 -0700 (PDT)
Date: Tue, 31 Mar 2020 11:54:09 -0400
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
Message-ID: <20200331155409.GU162390@mtj.duckdns.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org>
 <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
 <20200331155139.GT162390@mtj.duckdns.org>
 <20200331155257.GA22994@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200331155257.GA22994@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_085412_601520_C5305A95 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Weiping Zhang <zwp10758@gmail.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 cgroups@vger.kernel.org, Keith Busch <kbusch@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 31, 2020 at 05:52:57PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 31, 2020 at 11:51:39AM -0400, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Mar 31, 2020 at 11:47:41PM +0800, Weiping Zhang wrote:
> > > Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
> > > dedicated interface
> > > like /dev/xxx or /proc/xxx?
> > 
> > Yes, something along that line. Given that it's nvme specific, it'd be best if
> > the interface reflects that too - e.g. through a file under
> > /sys/block/nvme*/device/. Jens, Christoph, what do you guys think?
> 
> I'm pretty sure I voiced my opinion before - I think the NVMe WRR
> queueing concept is completely broken and I do not thing we should
> support it at all.

Ah, okay, I completely forgot about that. I don't have a strong opinion either
way.

Thanks.

-- 
tejun

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
