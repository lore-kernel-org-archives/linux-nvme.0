Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A1AC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 17:00:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06556120E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 17:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06556120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IyZmzKdfz6BNZXD7Sp1naMic+wir00jijqabKD9M5kE=; b=B6p71R8cqckzxgnKEialu0t9e
	FHirXE/bTxNyjbzeFZw+RYPvtch38oRgqOSD3v0ucKmn5Lqe6bf/Oa56EmZAe+16iaecFOmkZ/CIh
	hLM1v3d4apCebwnZehwF3Bx3aFF0EAPDTaw3MLUlHW5rFSvpgDvqZ8YaM2znoFR4QXMx+w1dTz/Z5
	9jmLoMPZcwUPibX6cowEKHGTqCUaUKR0pexuDlcjFc8b/YKvJCG5I8PLCb4OnVh2mqV9Ae45P5Bzw
	m3TEgwPC5WCfDWSeGT50rPTCCJQZhA8J0AGOrRoeyLlxv35rW8ImUlxGp1OV1vL1zZggyIF78oY3q
	/tcuTd5eg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUBX7-005Y2q-Sj; Wed, 07 Apr 2021 17:00:02 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUBX1-005Xtw-4r
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 16:59:58 +0000
Received: by mail-pg1-x52f.google.com with SMTP id h25so13550109pgm.3
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ImYMso2XRCF7hE1RjLKX0h9qdwdQfKT4pokhFBRad5c=;
 b=FAjBz55T+TyhqFgK0aInr4/aVzFFp+yayrWi4AMP2kOX5n9M5XY8gqLSGua5zJa4ia
 mJJ50OUgUubyY6YuUdgLtsVn0mpXZNWxeSvijp/W4QcxTWyYnS8QV33Y5DWAMCTXeVeJ
 ATmJ2shPV7EEpQaxLgCaZIDOVEhM4tcqcw/m1DuX87JQo3Q1znc/eLQHonsNW9a9saav
 OzqoQPCC6Bo8PPQfdduRm/3+3+m/s0yK/KC1xJyAPKcdOdmD+kS2ApiouH/9KNvHb4Mb
 DAIbN+sjRA03P1RRry6RIO1HBt2IixmEG/7VjpIo9SBN/9G0zy0yXGU4bCT3vUWbmnmx
 gmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ImYMso2XRCF7hE1RjLKX0h9qdwdQfKT4pokhFBRad5c=;
 b=Dgn7HKoEU2kBqcSSgFo1G/uIWtqwhOTxXbMCbChcM8qqe0KZJO7rcEYDyoumNKcKtq
 CSZXTbLiXlP/dbm87SADrdeOZEPqWtkKWs/b/3xB7QK8XGGZj1d9SF6VzD1sFRZ6RWrc
 TzvrfM9l8f+MXjD2JWV4Zi2VJq7ZHYrn84lDuSJBO3Bv1xogEvi4uVb3gZT9YdNV8hxo
 JImXurlxzvyurwfFEljVGDrt+jfGjWUJpo8f9UD+60KY4M0me4oK9+8CII42u7AkbZcn
 3e9WQ4IEe/UmZczSIKKPOrjb+RnNSSwt9UIg3lS/Fd9Fh+gP/yfxgIXe+wiV7aRaTdHI
 Zv2A==
X-Gm-Message-State: AOAM531KRVBRwJsqa2o9yXe7kX7Kln/NPxBeuKC2mRkGdom+Wg8aEAOP
 Cjmkt0zA/q7Qu0aa8uC9dvM=
X-Google-Smtp-Source: ABdhPJzykyBuxa8HfJ5ZzL2QFjbxefONF1QTgKB6N1mH5pLiPb97OEmCB59EuV59SLlnIOMRhSYbVA==
X-Received: by 2002:a62:2c12:0:b029:22b:2c97:15a0 with SMTP id
 s18-20020a622c120000b029022b2c9715a0mr3695627pfs.77.1617814793667; 
 Wed, 07 Apr 2021 09:59:53 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id x2sm22847575pgb.89.2021.04.07.09.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 09:59:53 -0700 (PDT)
Date: Thu, 8 Apr 2021 01:59:50 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407165950.GA9994@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407164818.GA31878@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_175956_635888_6BAB2511 
X-CRM114-Status: GOOD (  11.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-04-07 18:48:18, Christoph Hellwig wrote:
> I've force pushed the branch with the updates, let me know if this
> looks good to you.

Checked the commit.  IS_ENABLED() makes code much more cleaner by
removing the #ifdef from the .c file.  Also checked that the
mutex_unlock in nvme_find_get_live_ctrl().

Otherwise, the generic ns patch commit description looks like needs to
be updated: it's still saying that nvme-generic-XnY, and also about the
module parameter that's been removed in this series.

Tested again based on the force pushed branch.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
