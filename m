Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174C0C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6J5z6Bi4JphLzSbdemzDaybVl/GSN9qiuQmgl4F3BiY=; b=zZuiU2T7OyzqdkoGxHbGTdf+zI
	cOENym+kOK2D3dkrmtqGvOgaJse/aiU5OmiMZfR8uPNAmCtYOJKKj8HjsKCrJW2LZqD+DBddpLiOD
	BeJ2h3qsS7aCaolJWZ6m51V+jRyjkaLXMnAdWEfTaYyldZCzvmV4tJu2g2ZRGay87zpvwoZ+Y+vhJ
	Y0NoazmU+VaMxKR59Uy1eOQ91axjdFxgaN6JBXXXo9nqxG3bAKBnTb/eGbvyujCq4cNRxJ1QP9hxf
	dRszjdZ2lMkEePB/bKyuRfpaHJ9Txc74QG+70NVCPsJr0KDNPQ+i5ubmK5MRzEcxdzzghulp/KJIi
	3zbby/iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGYm-00000005U12-2XxF;
	Thu, 07 Mar 2024 16:25:32 +0000
Received: from mail-oo1-f52.google.com ([209.85.161.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGYj-00000005U0P-3Mef
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 16:25:31 +0000
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a11b9334b2so572765eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 08:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828728; x=1710433528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J5z6Bi4JphLzSbdemzDaybVl/GSN9qiuQmgl4F3BiY=;
        b=dVM2iZTZiAWlTelL05wJEngHgjf2ujMv/8ML644CgNhjBzOBfSDASDwoMo7K1NBjmp
         ll+C46phWHl7+HA0wOjt6yOEoErw//vtJHH5c2DfBS5IyYuZDMnpUG9F3bziYdljSVC9
         iK0pkP9ordgilsLRa0lL2hjUW481xR0P6FBqig/T2mWju9HP0ABcLKmYRS6pff/SNBPa
         mkVgXwO/Y1/LpkaQWaRvj8CDACO1/o2bbsl6Mso1wVKlAJZibHJ6pwWt7RQ5yUyeJ9Yc
         8fB6r+MFYFwUP1qIdbNzSOIHhMazZzzQzl2bcZKdmqiQ++Fy1MKVK2cnRyTZL6KHC88u
         HKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4pNzyLWE5g0aaWn1r2p7xD9vQ0sYrltINKM7rYWpogZe0vUCoDcfihuMh8nwagFpZOsOGIPLmyrDJ7uQk4t7UoZ5TJ1GvUH76b7Rmc0=
X-Gm-Message-State: AOJu0Yxhe3SJGFeH9LkaaEH7URSwExzuG2S6FtW7LJ54Uo06MI1BDprI
	WlNUywqZRxKlpFLHiW0t+oagGdK6cyJjVacmheFU6kPnQ0SQFZrCDvDH4RoM/bRvBnhYDjx3m6E
	e/cMoWA7lmnJQ2muJxFo3bzXqX5M=
X-Google-Smtp-Source: AGHT+IHmbpjqAPEGZMLhC3b4HmwWmZgBqBBMqSrzvHXkl1Cb9fn74CbUHnpsgkXEWLig/BKFXz5vK9StNmjPA6BNSHs=
X-Received: by 2002:a05:6871:408c:b0:21f:f24f:ff96 with SMTP id
 kz12-20020a056871408c00b0021ff24fff96mr147422oab.25.1709828728359; Thu, 07
 Mar 2024 08:25:28 -0800 (PST)
MIME-Version: 1.0
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com> <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
 <ZenacXkUAh4I1gkK@kbusch-mbp> <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
In-Reply-To: <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
From: Len Brown <lenb@kernel.org>
Date: Thu, 7 Mar 2024 11:25:17 -0500
Message-ID: <CAJvTdKn1xMP-WJhd64XkEk3cznhp4vkVjTynwp+10TLO8_FrgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org, maxg@mellanox.com, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_082529_860681_FB326E3A 
X-CRM114-Status: UNSURE (   6.80  )
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

On Thu, Mar 7, 2024 at 10:23=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:

> Or maybe we can make the print less scary: how about changing "shutdown
> timeout" to "D3 entry latency"?

Works for me!

(The problem with the word "timeout" is that is is usually something a
human should know about, along with "error" "fail" "abort" etc)

you sending a patch, or shall I?

thanks,
Len Brown, Intel

