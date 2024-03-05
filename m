Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EFBC54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkTf9XC1FRr3KOSelsQrNRpfQiCYC4Aa2jODKzu4UZ0=; b=B4u1FlnLBoJl6oWrgcCXZdZLKF
	99mXMf/lyEm6YVV++H3fZeE1PhoPfxJ9wRP/Su0eZppeK6sY5hbhi0upZLEeB7SIx3nGjRMaMVgHe
	Iti+MA8tuaz4AD4mupYHBMAOwFe+SrL/oGa3Kon381ZxWPTt0/2fjD/HZljQztzDqMu8rhXJW7s60
	XKsUwBnY+7kF1eFjCKBHeo1mzZlzVfByaltVnsf6Ba+wgxe8ryxWYIXl/twNLYQDoXnPp5C2AY6tM
	2m1hSzsIJdz+LOV99IePqALWHZpgzv48FEs7ra/EiYrY7bjc0TDWm7vmQGoZe8pBgkA0XU6gP5iyN
	DDZ31FsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXcE-0000000ETOw-43Da;
	Tue, 05 Mar 2024 16:26:06 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXcC-0000000ETNr-08T3
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 16:26:05 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1dcd0431f00so36488035ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 08:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655961; x=1710260761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkTf9XC1FRr3KOSelsQrNRpfQiCYC4Aa2jODKzu4UZ0=;
        b=LLFJEzooQThjZJ1XnTb+gynKW+CPznpQEhRGZP9GQM0Pr4bhgweaxEiM1X504oUCzw
         4PwnIPBZ+uEg4aRd95fQKyJXJYO10guT8i1pWClHpjHwllK7Z0T/9fKQZttRS2gxRgu3
         24deeKoAGj/bWjsN9LhNmXIdj9fmB0MZvFI2OCyy6YFoMiRaG/XLxZrz8PcZmFCYn5yL
         dt32fq1mXIgnrbauAbKJu8pZFa68LKl0k9J7FxLX7u38P+gl53VxjD/SzvXsvV72hP+f
         FsR3cDN4CaRzifFa0XwR9TjQBta9nt49z/iPHuXg0o6M7/kSLtgnTD2wgEYEdgutWTjM
         XNrA==
X-Forwarded-Encrypted: i=1; AJvYcCWSOwoocepvyabF6YMIdv4jiF7ZpJXGadgaoT2C+8jXe3A22JzIZEZgTTxg0Jok5mBVDAkOBR0KCf5QNKkRS/oaijZ/Be8jk4Q1bsWqyDo=
X-Gm-Message-State: AOJu0YwsVDXgvp7xbAcxQFew6RXwuwhvrw+yu0TZ0wSCOxmsalIhBXTf
	5nax5TpIXjZj9rcwPjQQZZyMNMAVa9L+hoDLxoQVbv4Qv0hW5KVK
X-Google-Smtp-Source: AGHT+IHobj7THy2iZGJ+CcuHdHYu60hKjN/DBPQd3Ouy+zBTKPCly8HGREDlb7zehsXPQhWTSuFXqQ==
X-Received: by 2002:a17:902:c40b:b0:1dc:c161:bcbc with SMTP id k11-20020a170902c40b00b001dcc161bcbcmr2564690plk.5.1709655961460;
        Tue, 05 Mar 2024 08:26:01 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001db45b65e13sm10783079plb.279.2024.03.05.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:26:00 -0800 (PST)
Date: Tue, 5 Mar 2024 13:25:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709655959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkTf9XC1FRr3KOSelsQrNRpfQiCYC4Aa2jODKzu4UZ0=;
	b=SpUKm+oi1mlySNT3yVDDUXN2narB8CvbEr1APNgz9BTuJ4xezXVkRBMf8+ULOaqbBNMSvc
	q20H3yr7aSXNQlo+VgkhsJgAEDOJ5L8VGosLxc6q8Iruq9/KsHnrdfpO7DoBlE4StmZOO+
	1eAf2RBUEXbm7N/7HyuaMFBDPwd6HmH0NNd+SFztqf4vmrGDQdbtcunVND2pXjhDxdl7+T
	NHbTUQxs2+MwGBtlXq7Seb1z3MW1QXxyu0Hf8pNIX4KnHlCHrwJ0GJF1AFOINFCzEmOl/B
	eytiTYTdlYZ3G1z3/ZzcTeJncZyjUgG7fZWE1Bylky9TBWbnIti4Ud1QBjJeOQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
 <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_082604_134130_8B7821D8 
X-CRM114-Status: GOOD (  12.57  )
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

Hi Keith,

On  5 Mar 09:02, Keith Busch wrote:
> Thanks, applied to nvme-6.9.
> 
> For some reason this series didn't arrive to my inbox. I got the patches
> from lore, but I probably wouldn't have noticed this series if Christoph
> hadn't replied.

This is weird, I use gmail for sending. Thanks for letting me know,
anyway, and picking up the patches. Also thank you Christoph for
reviewing!

All the best,
-	Ricardo.



