Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E1DC021B2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CAEEVhldvoc8F0ob7ntJxWjSZWN8MGyNUwWibkuTCoo=; b=Dn8hv7N9dKCEqWYmJwYmO7EwZd
	DJD8vZrlU2QuyNH5pucQwUuecMrXYJRZOBI/DEbOJ/2sQaCi1GOzQexwDSkXmYVCiAfs/lucOJin0
	KmiU1JZDvfA/to4BEdL77RQdlHxTz5rCVMHaLqOi7zkDh+LLPU/yLU7J0p4/LdboUFf+RWkdg26xA
	I8AKb4xiHyVUTyNSJVra5fMsMzbnBV9OI5+jMQR2ou+OoytXJZuEhp0ENl1TOJn5nLZJZgtvB9Ml6
	pdtOH6uuN5V/lqzjFjkqYY5vJn0XD12Zmxd5osB5FO+NsxYL2ztIcYffnxIrgTeHcLPFpdBQ7y0jg
	aFR9qevw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jN-00000001v4Z-0j4R;
	Wed, 26 Feb 2025 00:56:57 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzZD-00000000uAL-39GO
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 18:22:04 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-307325f2436so58601541fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507722; x=1741112522; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAEEVhldvoc8F0ob7ntJxWjSZWN8MGyNUwWibkuTCoo=;
        b=ZYfydjH+u0B8jEg3+2mH6DmI92upk/mxCLc2T0f9Q1isRHobKii2mXVpN5PhrHdua1
         n4Iv/1oS7/Ix65zpMIw3z4CTmDPYDbxASucPjoe8u4msScJWhxpX/fgO/w3zsZkLrAnq
         Z8C3Le4kiPGA2Io3ash9yg7mhtaHfiVRQ/iPpX0uNYWOYVGqTAGxkgbUQKghYX6h1w2E
         H/VOyHjOP755QXiApKM66XXjbQFzyg77T8KOf4VQQlv/TZXeZEdhivq3SjJ1eSPPklAb
         o32Mr4GJgD3Ot+kVzXxUQFFfxKJd5R353o7OMJhHoE7S+UhgOJHLnjRxsEp0bhk35tAZ
         933g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507722; x=1741112522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAEEVhldvoc8F0ob7ntJxWjSZWN8MGyNUwWibkuTCoo=;
        b=dTe0qryPlAIDqHqfPFVlF5BGTuELESFFGKUzqYaD0xXGUHVpvCiXnvXQ7skzcAr+EQ
         kCIykIM8KQ1FqmNXKS+KMe6yD29NzYiJMCYTZ0HKSpTMJRB4+DetRPJK6tY1CEusAZK4
         /+2I1aDGUnwZB1Xf6jEm/12Kp47067nNF4xz2T5HsIkgEI/1JS/gDH/cJ1ynBXaAaheM
         CQ5A0pTOaDrwgCIj4gMgulrRfWllCPStudN6cM2zz9tqOTN+5Yv/l5UiIHlRWRS40Snp
         r7nbNmBW6EdWNhQS6as0zPISJIGGgrhez629YEIhh4uiwjvSDCDD1RjGY9nBG9VcT6Hj
         DJbg==
X-Forwarded-Encrypted: i=1; AJvYcCVUtZ6kaoQRVXyOtOpM1bu4v6wotmt+Cbexn1X+MG8i775WgTt1FS8ZBGKZk5dDIyWO6NMl49T2talp@lists.infradead.org
X-Gm-Message-State: AOJu0Yws+l8DdzG+7jAkyuP73kLSZwWF+5Gh3kXJAm2a262aLM5hPTAG
	wUNP3woGNqXy5gAor9mOaoyeMnL5PNBjx+oN8G0hxz5HL365g4QM
X-Gm-Gg: ASbGncs6ADCL3EJYafwl4z2N4MRN0TTs9jcE96qOS1G2KTO+fWunvwTKFtqtA1pVzkt
	ddwOK46g7IMPpm3v45rLkOc708HY9TKmb4IcS1tdI1N8+PBXCpgc0mIzoO0vRJIjjGaeigikNkt
	K0hK4U44kbQna9GwBlpSFxPT5xnVeQnYM/dLj628I13fc3fHsfBFbBnQX4UJVX/pzRuc+IAhw+o
	3Cdy7PqDTO8ra9Pqbs01F5BKB4MPg8BPZz3+e0kYjzRNFannNWna7mr2kpltxpNfZf0f0tCQXmY
	6Z9o4MAP9GS1/LcTZzYtIusauYW1cl3YxHjxfm7C+sM0+0fl
X-Google-Smtp-Source: AGHT+IE6+fIcIs/2ApTBgpzTwSR439oiVm+vBAsWtJBpduyP9tKItZO3b2wVdjRM3zH98k0zKDgi3A==
X-Received: by 2002:a05:6512:3ca8:b0:545:576:9df8 with SMTP id 2adb3069b0e04-5493c579f97mr311547e87.26.1740507721477;
        Tue, 25 Feb 2025 10:22:01 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9ee0sm241429e87.219.2025.02.25.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:22:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 19:21:56 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z74KRHzSNbmUJUWt@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <cca361c8-2f03-40b9-872c-0949dc70cde8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca361c8-2f03-40b9-872c-0949dc70cde8@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_102203_788129_4E4E9FC2 
X-CRM114-Status: GOOD (  11.73  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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

On Tue, Feb 25, 2025 at 07:11:05PM +0100, Vlastimil Babka wrote:
> On 2/25/25 18:41, Uladzislau Rezki wrote:
> > 
> > but i had to adapt slightly the Vlastimil's test:
> 
> Great, works for me too, thanks!
> 
Sounds good :)

--
Uladzislau Rezki

