Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5064E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=; b=Do5lrcvf4L8StTz80bgsKIRV+k
	H2KwQzI+HLRC6a1cqzBAMwNvuWoFBA7XZVDJreYT97YCGu/e91lNyaw+TGTYOSG9hYjYVyaCmwxKa
	2d1rPC3+Bl3DBURiBn21Uswj+IMUuMg1mL1z2aaF864J3jPphon8erKSHTeM8Q/3dAu9pfxi3wjuu
	gb6B3tWnfMdeHOEE7WQXp+EnKiNBEJvT+ZMee+1IuDIXneuxiwVkb/vc7phC/W6V9x4SBiqpabGQN
	UT+fPDFNSISjeJOrC5asGyPa+N5G5JcW3XV5jAzsRkoCTNKZSd10rTak56gf6zi/uZU3+OxKQtHz9
	1JUBsrUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpa2-00000001snb-1Jbx;
	Mon, 06 Jan 2025 16:03:50 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTjUS-0000000DFso-2cGU
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 15:21:33 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-21675fd60feso226964755ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 03 Jan 2025 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735917691; x=1736522491; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=EelseGLj01TXnIIrHqfbTtiiXrvuCyCkNXCjyH1zHYbEolrfn+DzCTe5oXpUjJt5B0
         K/2SavxjfRGjQp4J4eSmNGOI8H/Bc8/7DgzS+/yfkM1o6lbhZhDOGkh4iamLfuV6SlGt
         i5L1WgdNUusATEjT/3RAvXBMfJQvfgfxNHgIrAV0nsuxOJYlLas0Z+rcxFGC1LJeUY0f
         lqOyL1va92wTbFh72erydzjTiBMFK05Z/a7cpPfzsRnUN4kPceslAad0vU2r0rNDpfTO
         cSs1Mm1rU5ys7+KXE8u/fa0G6V2p/A/nJodI6Mlqkffc+DfEbCZilwDJ7CDp9f2iKhKm
         MoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917691; x=1736522491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=k2xAb2GSNZXZlTsjWsVn83c6lb0+o5Oem4dBb5TtIsdCtAuG13mnv0tFsPXUwplZyF
         qpe/XiZ8g2FGKoh5HZ2ZgP7wAVSlQQBgovG9IZTF1iYzG+JjGZecROSU0defnH8yCoEu
         zyTqobT50JcL/jbNgkcjfI11ysRvhVzbfaLN1FbTyTtz36sg1YRHAqi0ugMbWZDfvqoQ
         BqtfpH7boq5JoVSwuhnh2NLGkcmkDShdhLF20YULfHOC7PmxF1bPDKF3+G37Y4Il2HZu
         lhUZeKDxhs+5M1BuFSHUv4OkuEhWS+eeu9P1zrgh49UVnmP74lg2r1z/dd7nSW9hjzPm
         YouQ==
X-Forwarded-Encrypted: i=1; AJvYcCURquh2SCBwfX9l+PLZY4J3KJOY3lNK3IMWzKugTVOOVCu/+QEguK5gQur4LBw/dq8ml1bzSfN/q+zd@lists.infradead.org
X-Gm-Message-State: AOJu0Yy68My3phwaQkF2+k0skxc9w4vwRoOmvZ0yePC/nahV80RAtsoF
	uxhjb4ElRBud90ywURrisQkMdnWKAfgeL/G74Scjpcx2dG1I2AMk
X-Gm-Gg: ASbGncs0Y5xryaeXN53u4jSMtiTx02xVMDo4aCMkA5l1IHmLVM2LVW7YOb2QLYuQwLo
	QzPV1a6dQDL8tT0lis2vlDzfvf26a2koTXLPIlc0zH3ymlyQeeF8KZBbzGdBmKqDECYEf29m93i
	H6jH0y72RLbew7J2xceGjmYvZ8sUWaWYwX6pjM0nXzAFg0znvsyWYUosQiBHbULmGM+XET1UycZ
	Lk5GE8MqYaWu1jSa8QVapiFC0yQMf3QxlTtojuupUifEEpuWf0mcfdqTH04T75uRePqUFmCCyQf
	8wP7
X-Google-Smtp-Source: AGHT+IG5A276qFKzsq0vRtD6GevOEebgjRTwKom2lvuNWUTRxP4Uq5vYQN1tUnp8ZXMDpu322FblbQ==
X-Received: by 2002:a05:6a21:3a85:b0:1e0:c77c:450d with SMTP id adf61e73a8af0-1e5e044ddfamr75802412637.1.1735917690845;
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm23948804a12.23.2025.01.03.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Date: Fri, 3 Jan 2025 07:21:27 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <Z3gAdy7nU_-DAxhq@yury-ThinkPad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20250103070229.GC28303@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103070229.GC28303@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_072132_663612_C24A2F58 
X-CRM114-Status: GOOD (  11.95  )
X-Mailman-Approved-At: Mon, 06 Jan 2025 08:02:41 -0800
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

On Fri, Jan 03, 2025 at 08:02:29AM +0100, Christoph Hellwig wrote:
> You've sent me less than a handfull of 14 patches, there's no way
> to properly review this.

Hi Christoph,

You can find the whole series here:

https://lore.kernel.org/linux-scsi/CABPRKS-uqfJmDp5pS+hSnvzggdMv0bNawpsVNpY4aU4V+UdR7Q@mail.gmail.com/T/

Or you can download it by message ID like this:

b4 mbox 20241228184949.31582-1-yury.norov@gmail.com

Sorry for not CC-ing you to the whole series. Some people prefer to
receive minimal noise, and you never know who is who. If it comes to
v2, you'll be in CC for every patch.

Thanks,
Yury

