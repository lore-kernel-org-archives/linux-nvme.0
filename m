Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B896C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9Nhc81z1QBg0/4jfG0c6X5JbsRpDWcMGWCj2xBov+4=; b=FBmy1YAWAFUxxpSzuEkN5svdSn
	OFJMwDh9sounQRb6dpn/g+cjfWWgzZJm2W/CP411IQ/zjvpVQ/jM42MFh8/X2rJAZ9GwTxX2kW6kA
	QmMx1iz+lcDLcJtw5yp5dV/n6nvpP2MNP1wUiLht0j8Aahg3jTGdKoD9KsYaHEQ/J3jZNasjWTVVR
	TUZuNwBSnl74fij72qM2KvRO7Fi6S8zwYVWq1yLJltG1uP4FKlgvLxjy0VQsMvDrBgHb1iKx+arAL
	Zysg3XMkl6olskAWZohkw4Q/8csvGKpOZLajqVeKHaXA8R6C7x9m6IaBH8iLjM6PheAwTZwN7eZLX
	1a6rFBuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY3ED-0000000Bwcq-3lk7;
	Wed, 15 Jan 2025 13:14:37 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY3EB-0000000BwcR-3JxK
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 13:14:36 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso8366215a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736946875; x=1737551675; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Nhc81z1QBg0/4jfG0c6X5JbsRpDWcMGWCj2xBov+4=;
        b=gRrR3T2Y3iEbJEmsv5cqX9mZafNr4w8QkprC5kklxPxPMZar8qhH53/bl4AWXE68ma
         sSv7gUH8BQMUp1lxIftj8e0JQXy/oTR31PnPIDktQTE6hxQ0EsqotCrDaWmgTLPqrPgo
         4i4O9XbdfhUVNAhIoBUvkNOP3whcmPi5aCGV2jNjx+UX5kAaVbjpeVp9XjTy4sJxHV2x
         Qnb3UlyLlVT8As1VCESYRJgGxbmkiPm/BTTIFQpcOsOeECj6lWXYQpmUx/X63gEKULS0
         wGFufkBgR+4FaN4OYJ+YaQaTGkIeEzEILNcp2JafDg5PkMaqX3iID23mavzqdR9DXeE/
         XS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946875; x=1737551675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9Nhc81z1QBg0/4jfG0c6X5JbsRpDWcMGWCj2xBov+4=;
        b=WZtwkRm4JU31n9n0XMYiUT17CrrDbLQckUNjZb18tJeXPbxSa0rWX8+z2/AfaO5EFH
         5gLdBAWSVVfbD9+QlDz3tlcqoWD5um75JojSFksL18OuHRynaiEbjtJmKKKfewZX78v0
         G9DngL2XeIuKTJAM4VbmK7jsainebyxLGkjhIuXY+9IQo7sT98FP0nObEUv+D20CcN+/
         6/2BWXqfC7hZwgfw8QkDSYfugKVOx/3pYA0hJh6UCImgi7L9JOXwR2zft2JRrFP5kgqn
         fiisZpV2nhSO2O6w914/VJkppqSgrFTEUgt+awPIhLlCqlY8khDUoBw5kzsV1lb4C6Ew
         rHig==
X-Forwarded-Encrypted: i=1; AJvYcCXScVIVuI0JjCtm6zUBm8cHAJvWRRYf3imisOyLSYA7UxiTMj8cjStwysk6RF6bg6MkV2oH0Fve3uFN@lists.infradead.org
X-Gm-Message-State: AOJu0YyB8WrV2hyZNlBbcowUsFETz6IcgzlzUNAGJVSeR9/qz172z260
	7gvt00yHtXxZ/F+lcqxr1iPPNsrotV6/XYETw+hfj482i3QbscT1VOh0jdIwo05bP7JaGixZgo+
	MDT+FJV/siDtLe9gb8jLz+QMEmWk=
X-Gm-Gg: ASbGnctTzCDmE5y+h5Gb8sSJzgO0+qxHg4eOdFOa8JI0ufVn7aIvBai0919LglgEM0g
	//9I6VNLjzaUq0CBp033OoXW/RWHORpovtZPRC7dRnwy3ExMYXWoGmRA9l50X2acomkvk
X-Google-Smtp-Source: AGHT+IGQ0R7x9YXj/h87iEBx+CVBf8QtEg+teUTy3q3W8ZCMxJ01VQONo6Wys+qd9jQey7KW+xhI8Rtvci604JXrJgs=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f548e98ea9mr38312650a91.5.1736946874762; Wed, 15 Jan 2025
 05:14:34 -0800 (PST)
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
In-Reply-To: <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Wed, 15 Jan 2025 13:14:18 +0000
X-Gm-Features: AbW1kvZTTan8HgtPgAtw62bza1hvMNTlO07oElZfaQ_VFWMvcxTcAudnz_hCQFw
Message-ID: <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: bugzilla-daemon@kernel.org, Keith Busch <kbusch@kernel.org>, 
	Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_051435_830513_8322ECA1 
X-CRM114-Status: GOOD (  17.73  )
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

On Wed, 15 Jan 2025 at 10:48, Stefan <linux-kernel@simg.de> wrote:
> > Stefan, did you ever try running your tests with 2 nvme disks
> > installed on both slots? Or did you use only one slot at a time?
>
> No, I only tested these configurations:
>
> 1. 1st M.2: Lexar;    2nd M.2: empty
>     (Easy to reproduce write errors)
> 2. 1st M.2: Kingsten; 2nd M.2: Lexar
>     (Difficult to reproduce read errors with 6.1 Kernel, but no issues
>     with a newer ones within several month of intense use)
>
> I'll swap the SSD's soon. Then I will also test other configurations and
> will try out a third SSD. If I get corruption with other SSD's, I will
> check which modifications help.

So it may be that the reason you no longer had errors in config 2 is
not because you put a different SSD in the 1st slot, but because you
now have the 2nd slot also occupied, like me.

If yours behaves like mine, I'd expect that if you swap the disks in
config 2, that you won't have any errors as well...
I'm very curious to see the result of that test!

Just to recap the results of my tests:

Setup 1
Main slot: Solidigm
Secondary slot: (empty)
Result: BAD - corruption happens

Setup 2
Main slot: (empty)
Secondary slot: Solidigm
Result: GOOD - no corruption

Setup 3
Main slot: WD
Secondary slot: (empty)
Result: BAD - corruption happens

Setup 4
Main slot: WD
Secondary slot: Solidigm
Result: GOOD - no corruption (on either disk)

So, in my case, it looks like the corruption only happens if I have
only 1 disk installed in the main slot and the secondary slot is
empty.
If I have the two slots occupied or only the secondary slot occupied,
there are no more errors.


Bruno

