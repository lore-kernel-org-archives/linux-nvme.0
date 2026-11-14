Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F7606A335
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UiVlCGPP;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Amp5lxxy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=; b=UiVlCGPPQ7u6RB1eJce/JHSAZC
	JBeUJ3owVwzms4wHkiquqMLtg+dmsvJo4/V3jZephGM3qSy0Acj+ckdsaTwC2hR3V7VdIwB8PReLi
	EzSZKAuhPZ45p849thiCEE1HXKzh9m/ROloXIF6kVRE0YveXapV6Xh0oxBB47ns3E7yTsiqFRnFzd
	PFeh0J0xegTa/kx4StJGU1VSHwSsrGdxz6Auaw9SSwoBcC9uOOXkXyX6EmtkztgE3ZjzqfaBL6+HP
	NDgZfCZ5N7y9b2FJKh2op7M1AQV5tPQMUzb95O4PSnbhRzB8N3caZjccKELgzUAv4qsCc1EJn/lyC
	a5sR920w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw0q-00000002R1M-1X8j;
	Mon, 16 Nov 2026 12:40:44 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSK0d-0000000Ghxq-2H5N
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 20:06:00 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so854731a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=Amp5lxxyBayyAv8S1taTR8RrM50wOgNT+jinJ0cMX/yxiTfembqV9PzMoO6oUS+q33
         M3px+xQfE+WX6m0EZjNyhVTEpdQS60c6MjJSRhDXfGe51FBlutbWL1b6XQ7NGlYPdm6j
         q1jWRHSKrgxITe7S+v3QMSFVKr6gnAqBw3GUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=QgeHeUHbJA6f9AS5J6IGzaQ5MN9xt3BgOlnDc3SIki1lGJJ+4hBT7heloYZvegwGON
         yk/ljE1yaR5phszvckEGCh5waIoeJnUG0mUJBVSUNfGoeOgqLHYFrq9dC7Sgg6RBi3Gs
         07J7n2SBUdm42MgPjTD9+9kZt9olh3+rsmcedUc3KRNU1fFOTrNHYPRBqsGesa5+leIK
         KfX7DmMu/TkX37QgwfBxR58fYQY8Ed+ZW+xdsI9Kafl0yHFC6n/sdw6NtHRkkaALh97F
         +8N3ULK2J/ZfuFkZEpqExGCagJkmT6nFaYnhYwxrmyxTwDTDoUFeXS298V95S0dUbkjN
         IrOg==
X-Forwarded-Encrypted: i=1; AL+hErFviFirF458yWZim3tzUG0CiseKzUZQZqI95Tmv6Lfycx523df6ZIlM2eGWWwCG4g819V3XM6ZKvPM8@lists.infradead.org
X-Gm-Message-State: APuU4Z+HBJ58Ub9vwn56btQ2gHh1a5sVqMfCevTWajNgdKQsmGC2drxM
	aICHlXE0qzaCRmPJSqGoE/fVh9IBizigblyUQ7dvxLROCWMQa9Pzljgf5WX/6FuUTd0=
X-Gm-Gg: AYBFou1k7h1f7LffEp+uJSDXbSMah6I31Pf92HyL7zXwJe/RXpBFAz1hQ+EHu0vwVIr
	NMcvEBY+T4oBqgtISiNlY6iFSynEfy4+gfMz2UVl7wnze3Gg4KGAZh3grQ8fvLGnFGuosFI9bq4
	CmJ0080NJYQGrJ4dop6TzwQdq0K5hmXtJDQ0oUNCWgvdsSlCSz1YjP+kMlMShHrVS1XkoIwiMDs
	g+POO6LvxQBW01n9QQw8R1pRB7tuf728Hw8LnVVss3d2vCrpHIOKs/An53uH9T9sCQ/whsKlZ5m
	OYz8w8mTJq2WZZKCXsFPW0FuCEe+UVPUetg4q9u/AgAY8GxNUEojaOmsqdOTUQFVdCwgEm4F5Cd
	N9jUG97ETwfKa3wrSzdRJrOQ6VtRyGqldpfoQPMzF4oG8O/MKtA8dKBmywtTtQhkhRw3sMZUeTJ
	eWa8whlQOjPqQP5nVR8/vmrDPrF/8lJsf0V+rYgGh3FRwhRoPiz1pN2a/4VQfLNF+hDM4nw3RP/
	U2zDE6/Ow1UtrvGIkiFORJYVE5RFmM3jxu7xmnWWgCuirtMVsNbIWw8RyUfYmrRM4gj7kH91xBb
	whU9OY2z0gxLAoAQpM5UFS1lbRddJJNnz9FapwFSHLXK/kc897m3qZTvjLgN/Pu69v7cMQ+DGyz
	2pn2OqcydcoOTs8+rMnvNCBy3E+kZpSIJlCKi9gu1XyhMgeD1pv5lppOR+GMi+HfPhtT0RjbrzN
	MQrU+vm9KsqNAqO3wgL+asaRTQlVXYYCqFPnck6BedsrgoKXvgqg7E3HsT
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_120559_605301_A498BF7E 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:40:40 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

