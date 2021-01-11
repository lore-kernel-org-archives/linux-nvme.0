Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BAC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:10:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFD021919
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFD021919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5tYihLPvJq237cEJpNJrNa+SpLbQz0hhiW4nUsEp9rs=; b=USMIE/BDHKwB8nRj0TSDu/2qI
	+7yFfgzR9B56PWbQGAwAikPj+fAvo+J0rBymUHa3cV8IRbid0s39z3pHA7YkAAF6OPuU+JRMVxIdQ
	/ze/vVr8mgodQXG33y4qwvAiELc3DKdP0xFyqOcbCE8GOFqxTiv8tcdtdNQthjjxz0uAyCbPe1zTw
	BMM6T14U2dPR7WNU5NA6OAPWkQxgjrDfwW7JMwULSHME2LQDwSwXGONuTkbdsA00CCHIpPYMYbqrj
	6QSiEK3vmXbKVPIMXtvFt5qWvJReULoXpaRjMeO2MMBU4ypEJ/z/t3NEJPaqUoie5YIarD47eJYsg
	ADD2oYg9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz0iN-0003YI-Ju; Mon, 11 Jan 2021 17:10:47 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz0iL-0003X8-Ci
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 17:10:46 +0000
Received: by mail-ed1-x52e.google.com with SMTP id y24so468605edt.10
 for <linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ku2vbBMBne6+O0dXmkkWbAwF/Xxsg5FBx7XMhl+hh/w=;
 b=ckyWZUKy6SxEEeOvOzfy/zeJVw9z8TLlLQLjpzyXuPQRZ44uJPyqTQU8z0/85eYVMi
 gCVWcECZx0xnh1cAr4qe7ER1ME7nJIpiE1At34NdB8KM7iqiR0IBHOONQvHrB2FF+oqn
 L/HeN/eSjbCY1dVubSW+00lE7+yeAQpzW5567THlUYSYvHYxx4iEmM7WP7mlkBguB6Yv
 yCSXvKznRnBxY4TplJwRKkvLDv9uYK4foU2RR+i9T78GhraO1xK3Fjryagp9SLGx2U9H
 1NKCGrSiVUibxzXDsgz0x8o72q1t/N9oNXhpqpG2At8RAO7nZNNC86jQW/hoZGr6KAF0
 7y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ku2vbBMBne6+O0dXmkkWbAwF/Xxsg5FBx7XMhl+hh/w=;
 b=Q4HyYBqq/XP3yQM1KuYyiHE7VxQCP2I1o+VMBj7CsfIZbio4GR/cQ14X7G8vvB/nmp
 ZuTQKEhElrtJ3MtvxEjfAgiyrMpbi6yMDV18eA+2jbgVgqLUpXi9tz3+2XPBmOGczuDu
 FocJroaePBirxVXSTFamECG4n2xCYC/tIoKtObe6M43f9VL+5ZlMPOlD2h5rTUHIzHsG
 VXmUxEUcMIHcDtlhhW4LjQwrLGdTTy80Z8ZsyL8Ns5AHOMspvC1IGvsG9w9dWoeW+E23
 IxvIbCOBgLUooHZcD2Q6DTXgtXwONHAnUjOX2N/q4o09IJUGyUmX5UIZbNZkxbmGjZva
 w/JQ==
X-Gm-Message-State: AOAM531z0k8Nb2veNkL1fWenbps7tBZu0eiXTPEYVIy1Fnt5Mq2ZrZ7w
 tKhJO+se916oiHwsj961Z4BbWEjLiZB4qZYSWxpx9w==
X-Google-Smtp-Source: ABdhPJzn4yaEhzrfuquBjM4lMPwbzhu455qivDP2RUj/3OgiYvU85SE/oJ+U4D1yi6BRGDp2+352eakfVvcJtKIV2mM=
X-Received: by 2002:a50:b282:: with SMTP id p2mr296862edd.210.1610385043099;
 Mon, 11 Jan 2021 09:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
 <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 11 Jan 2021 09:10:34 -0800
Message-ID: <CAPcyv4g3LKRmUOj1QHmkQ5rZ4BfH6TQaK6jKhXfb2DoBW-MoUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_121045_603510_4AFB7085 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 11, 2021 at 9:01 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Jan 08, 2021 at 04:12:31PM -0800, Dan Williams wrote:
> > Is there a more centralized place to land such a helper? trace-cmd,
> > perf? The nice thing about kernel parsing is I don't need to have a
> > separate pile of disparate tools across subsystems.
>
> Yes, I just placed it in a temporary location to see if the other nvme
> stakeholders are okay with the idea. If so, I can make a real patch
> series to remove the in-kernel decoding, and add the parsing script
> somewhere in tools/.

"Somewhere in tools/" is still not quite what I'm asking for, I want
something nearly as automatic and seamless as the kernel ftrace pipe.
If I need nvme tools for nvme events and mce tools for mce events etc,
I'd rather just have decode in the kernel. Perhaps this is a use case
for a usermode helper that accompanies a new kernel tracing file?. If
the helper exists the events supported events are decoded if the
helper is missing the interface is equivalent to the raw formatted
events. Decoded events "just work".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
