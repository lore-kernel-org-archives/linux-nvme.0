Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B4C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 17:09:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0009061245
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 17:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0009061245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PoUDklu30nkpoL3O3Ht51eluXXhO69n3jVmv2l7X728=; b=iitvaPh6CYxhxs1Iit+NT0H+3
	ily6W5qt6sQRJ7AxpsQdob9fIk818TywyjkV/mZso+6B2yQfOXfBrOmoqpgAlG235C3tAtMs2pEui
	yPTyP7SLJthEUPk1FXv1c+0x5/VMiyH9oP6os6XsMP/zMWyoWc306OQPQnhaDw7BBbqDhC2ZmL1fK
	UxZPb2FVYrXAWpYRrSD49oUow80Rz1Rd2/5PKBgfxbLWMeDe4K+DF2sdourhm3hWsQWaJy7W6fOB9
	2GBoG16iseQOucT768tqNmb/wrbVyHH0LwPoobOUJoeLQKsxEHWtRa0iT75EoGcR0YzOKgGYgxgBP
	kQ5VdTACQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUBg3-005agO-5k; Wed, 07 Apr 2021 17:09:15 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUBfw-005aZP-RA
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 17:09:12 +0000
Received: by mail-pf1-x42b.google.com with SMTP id m11so10723186pfc.11
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/XVq69mOYnwix5Kd7zBkIrNiC8mFhGTCpKXj781uUns=;
 b=JVUjxmj9Wkktuxg/Gcq9sRUWuMFEK/6yToF+MUYGo9qPZGzX6KpFGTgeHuQC5G2Aax
 7Pxh1u513JWPQqDWz9MFykWGL7hveg7myLUZ/RqMm0OEaKdnKsLfniAZm005ctASZEGJ
 274FiYoJCN5UkNmv946k9DEdAIVPuQWV6AbJdrVSkKZ60A+035oq6Px3V+nCRoOhDUFI
 bsJE+D/xira0E9iWR5Pe8FdJPFJ01Hl94o1TApoTOMRtj6kHugWBaujcxCtBw+CmPEAw
 B4H03EHSGhMX3I3OTz/qjYZ2IaTn74qovLzOjqY0U9sVqP/VmWtIqbSNSMRBkI3SYO+O
 oA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/XVq69mOYnwix5Kd7zBkIrNiC8mFhGTCpKXj781uUns=;
 b=Xa6AcjmvBFWxJwLsG6Ee2YlftzltrWQCf1J3D/RL4isE8sqx8e3aj4hKSMtzgQ38sy
 kfpB2Tlesfcb2zvn6Au20R8L9AxKaAg4XlOgD7s5f7ma3iGxigFbeqCmet2S/8fS79VU
 2RaHFMZqr3Y07h/S4k05ZsVca8gKqMCop13b5raMFuLsQqxX3wImM2G87rOS6mnuUuKl
 pjY67eO9ncd06qaY3k3ID4bymt1ruFgeEIWQQNi0rVC3xkRIf6+O4o+Xntjhcbec9CN5
 Hhih/Yq+shjywk9fhm83T9jFVpHpB7u+p9WZgdROr0IWvoOmzbL8eOPPxx/BPHYoFNqu
 VNuw==
X-Gm-Message-State: AOAM530fPmCfd/f6Nbx5gfNMDOuC0VyNCrmuR0oSW3Br9zb4DvrLZnC/
 X6m1g8Hn3R0hvpEgMSlQ1Yo=
X-Google-Smtp-Source: ABdhPJyWLk0K36fx9T3fjPw37YWhiTTu/5IlUXORbkQEoJE35ncUbE2HfQTCB/lg5muCgKMjfXZ7rA==
X-Received: by 2002:a63:c90c:: with SMTP id o12mr4364822pgg.210.1617815347259; 
 Wed, 07 Apr 2021 10:09:07 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id t12sm21287422pfe.203.2021.04.07.10.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 10:09:06 -0700 (PDT)
Date: Thu, 8 Apr 2021 02:09:05 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407170905.GB9994@localhost>
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
X-CRM114-CacheID: sfid-20210407_180909_076171_77EEB8CB 
X-CRM114-Status: GOOD (  11.78  )
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

One more thing I'd like to discuss is that the current branch does not
create generic cdev in case that nvme_update_ns_info fails.  And this is
the one of the use cases of the generic devices, so do you think it
should approach as an another patch ?  Or, should we make it supported
in the current patch ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
