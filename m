Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7C9CDC19A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=; b=402D2v4LmJz7x39ceJDAL9r7pA
	o6RtnhC+Z2xXvmAZ4e2A6kSI0Gn9PMdXTtVa1qB16E2zBnJsGS60H+n07PZ2/LoVZy1IuJlOwZSNB
	TAo5ZGwY63D9y+KCZMjydU0wVrLhEP/bci9nFC7IUdw0GJ28u+MVSFmTwEyB0VZZmpRALickxZ87B
	QusmO7NphHAz/EsahvQEGJBzB6Iox9SXhVjXV+M7UJsU4x5pHwUVjji0nY7ApiMgTdmvFjFSy4VzE
	HfbAIr6Uxz2EQAkM3Xv6yxCIuzPvrNnQTmPh4F//dGo5bA9DBl1O/C2UIt+mJWTZCSRh5VoAvHUz3
	QIvOmfFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd6oC-0000000D3cg-28XJ;
	Tue, 06 Jan 2026 13:09:12 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd6oA-0000000D3az-03qR
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 13:09:11 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-5ebf4d3b1fdso587923137.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 05:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767704948; x=1768309748; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=;
        b=auiF5oxXd3mSuH32dQVGX5XCPvNASRC9IBHaToif7RavfGvY9qO+MAY0Sp247pr95P
         +l+RcejhQMytPqlNRKrX+HczA56qFw0l+m9XNLphC+iMk+eNSp1iNDZU7r1qaAGqMGcu
         zysaWdaUO6qp/8UO1v3h23RMSYm2FNGebjmKXVJtoJug5lD7aQX8cobiiESmTDP7y6qN
         F1J0GzG6OcZ+8Mi91zfgsM5xNZlv4G5LynuuUOTIhKjIhjs+tcIuezaKQ8fKbKrdiswJ
         lIQse/J0bUa9zzEe15jHtQ+3aA8MqnY3CVZmA9LcHp1WWI6TDv10fksVeb8O70c8/lNw
         6aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767704948; x=1768309748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=;
        b=TgJbHDNguos1PP+3sZRfoYLc2ia7elROpHJHk2a8g8us8cFqGXW4eB426oAx95pi33
         mOmW1XtJmVOfQIwJHoIrs+o9BxVfIvlB91v1Yfu5M7x6w7Ion5A2vgRLpQeDgXQleuYi
         EmsufSaWgj5+eTLF06xnJpWMV7HSNpj0qDaaLbQ6uwXsbiZJ1Ud/ZVBxJs+2fwDXMjsc
         uSpCIaaFGC9x15cqHwPgcH1A4jdLlbqNShwzIh5LoY+xWYuH5dty3dP16E/aLJlJ9l5S
         C6AWiWczuEvm3eoGVBOvBFOg8hUiL0exyBkenURfO1LPykd4KKCLJ+8hSNHSMfLgj7/6
         2SQA==
X-Forwarded-Encrypted: i=1; AJvYcCVoXJFFss8ue3ZE/O/hplZSDiX6hXtlHejEpxhfVb6ddjrWUBNx0JkVJ1Y5JJlK1SQLRPVV7EtYdH1A@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9jbmPvoM3Xko9zoZU6ITAY5QphUBNjap4eJPdJr1GQd27FO9B
	vqMqKeDaK2dVYNIOStPjWgKPbM60ZtvsRbI++QyD2xKF/dp3HP19RwBCteKhWPYL0iWKDSr/LMC
	DM9RDBWz3Z4nyDGjT4KWoTuxD7QmfuNM=
X-Gm-Gg: AY/fxX6H6b5I6ZUZKnDmOEa/3iIH9xPr666Y7TMakQ8Nk/Haw+XCnkatS+xsV+IPMtA
	su14qATjvETRN1p+hLSfDEgo7RYY9ABCLe3xbh+7EDPFyxb4zHrQ/kaUwOlA+sVg7kfAurkDrbu
	7Ot3K60KAMLVpXb9EIMJGAEQB3vIZF+gzQa53MfYCkxOFlUM2QnEhZmS4sbWuAKBeA7I+RvqU11
	ATzInErZDJMTkAjgIlEMDL8Hnlv+WPBM0Osdh2jJqxcEgORP2sQIQbnCaWCV55XqE+qIiUFdKlA
	4OqBx6kCf9jg5QxiqYLGi9CITK2NUquGCAkDE/E=
X-Google-Smtp-Source: AGHT+IE+q53QRcrwa1X/P2rGt0w5PqjH9BdnPnB9kQyI+2KZqEtLpu+X2QQ2N5km3AlrsGYd8/6HCfpH0EmY/KsMAEA=
X-Received: by 2002:a05:6102:3050:b0:5db:23d0:65e7 with SMTP id
 ada2fe7eead31-5ec74524505mr976101137.27.1767704948553; Tue, 06 Jan 2026
 05:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
In-Reply-To: <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 16:08:57 +0300
X-Gm-Features: AQt7F2qgRlmnXSCMJz7lKw8ZBRZc8vluWO41oBPbsEaM3ovL2_DdxgbKzkrNO78
Message-ID: <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_050910_058619_CBF5F19E 
X-CRM114-Status: UNSURE (   9.83  )
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

> For ext4, the maximum atomic write size is limited to the bigalloc
> cluster size. Disk blocks are allocated to this cluster size granularity
> and alignment. As such, a properly aligned atomic write <= cluster size
> can never span discontiguous disk blocks.

Ok, thank you for the explanation.

But it seems that it's an internal implementation detail of ext4,
right? So this check should be done inside ext4 code. And in fact I
suspect it's actually already done there because generic checks which
I suggest to remove can't take ext4 cluster size into account, so at
least some atomic write validation is already done inside ext4. The
only thing that's left is to move the write alignment check there too.

Another thing that suggests that it's an internal implementation
detail is that a CoW filesystem like ZFS or btrfs can probably provide
atomic write guarantees for unaligned writes too, and probably even
without hardware atomic write support.

Can my change be limited to raw block devices then? Thanks to your
explanation now I understand the motivation for these checks with
ext4, but they still make no sense for the raw NVMe disk.

I mean, can you approve my change if I rework it to only lift 2^N and
alignment checks for raw block devices and not for file systems? For
example if I move these checks directly to the related ext4 and xfs
code? I think it's the right place to do them.

