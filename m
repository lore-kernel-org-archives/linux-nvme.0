Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C929BC282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=; b=lk+z7HrbzYPrJwEWeZYGCJlmwz
	zq0tN/gBAH+AtxF9s3UT65GBQQFMB2cTBbRviXFBduy4e12o0T6pxGkDkMA9ptzrqIoJv52fWj+YQ
	d+ebNykagW2OLFRXDMq8o7G6qio7fN3b/cMoxh9FOSt/msfKz3HgvR0xNExp3+AmSBLcKeOW0zKTM
	zTs+dSnel7ac/TsFyTc+ORV6aE94UlfH5ZW8Pt9mT6eoH+z3nsggqN2CBKmbOifbHphgjqKIAbXva
	7XG+oLDKKDbOoaQjvtLooa+JAaFZMF5yhdetAwk33Hy097fw6pn+PS4+bavquLQnu2nEiq81kCwRp
	dJP0N3Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9YD-00000001jnS-0ob5;
	Mon, 03 Mar 2025 17:25:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJn0-00000004Qmj-0gh4
	for linux-nvme@bombadil.infradead.org;
	Wed, 26 Feb 2025 15:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:Date:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=; b=iqKklthlS2ltUjqAy7/heFrGb7
	7QL//0SXdajk/b68AnLxv5pz5Sa7Hobc9MYaNqJ2tV4qYFIE3GOO82P1KebsxyPwJhTxU6SiUa4K8
	em/maSJPtlw2mZ51znnGIRrTj1kj9/f86+W7jZFbGOHlTIix70xUGY9z8StoQYv/i2EMoy7copLqH
	gFpn/Ff56NEQ5//dH90NQmWJ2p9NooxMQVxgANtWwWAYemuUfmFiIbxKpFJmAIjbRWspNAAnIU/Ki
	gJbmU1F/OGvG13nhG3TytYRaa8rXir6fd1hhkOo3bCaE733ZGt8ZkUHETVP5xTKtY+LXhEqareKHW
	WuX9rBLQ==;
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJmx-00000003e7h-1ILU
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 15:57:37 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-30797730cbdso68815251fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585452; x=1741190252; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=;
        b=JK1xMU/K36BF7cGy1siDei/+pgaEGadg3bcsDLRyswjqsCdV+NbWGQThtYmokDakbD
         DB+N0liVArH4Y1GtCslTUelv2V365Ys38790EvFTDiyi7ybb38O2g7pyKOOsXTchtcPr
         Xjb/N2K+dsJEPaJkc5ma5W8wdyYjsEwg6dqxbX4qJp2/ekiHJDQ8XavVc9a+0cgsprW9
         EdLwM8YCOcwGyeJmb2JXW/hI1eIrLCqjfb/4iao3NqODnoHEXdYpIGFHAqzdk4QHp6vJ
         dDcK9SsXeek7AEI0sB6bG3WHkHRKOT7p6O4eF0R6GQorDdN1uxPRd2RG8Somzgk2ixQ+
         j11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585452; x=1741190252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=;
        b=TsomwPPKnB5XGu88oBKdYivio+gmTWF0ckvwLf7YqGnzFU9KmPpB+IXwe9uS/mav2J
         iiexyW5POIg0L0cEcAlWrhsLD+RyJrXdwTv6wjTOGe901g/Wlgt8ANm5DmSmrAZpye1A
         2EDkhJtIRckXNathccFru6VwieKRadNLSjlgJfZrsgh+gS/KDFg4fba3ijEimOnsFks5
         VfxUUpUQUrbf7jqc25fmumMaidwO1erHaXOlPEjcUKNqO0Hmlj74LcVWCFEH+DEfOomQ
         V0DSDO2V/+ARbH7OG8/LnB7t/+0QV6XBLot0nJtrUTeKK0WnGyse4EcZ07iRAR2Gbcd1
         xI5A==
X-Forwarded-Encrypted: i=1; AJvYcCU8BNKIPV9mJCbzozyZ3V1jaX8UC3LVmOLdmzN5URgBVUZ9mFQEMGa7K/ASQ5AuLteYzEMhfOcOS9gb@lists.infradead.org
X-Gm-Message-State: AOJu0YxmDhfe6E9SZbz9gil1c8obEwIZZTNIsfK31Q5OdadG9IvrM6YJ
	e4bVnYcmuSd8ZHRHXcrna1JcQylGWRpI4lM4lm5SrylHGutwJSsv
X-Gm-Gg: ASbGnctPTH+kJJzQhI1TXFzsV565GMT1qgG8G+B2H78XKd5EqFRItmAmXwgmdx5yxaU
	MLuGKrE9D7GB56e5ULxU7bGx9LZxI13sbskkQR6UQoXxoEl8mWvdBlW679bjOmDBjOmYhjojX0f
	6UlcXZ70wbLoPXHR1LpRZ5rbt8cToxGANIGIy/vlc5f0Y6dmmRPdu5/o3rF4BYDqur75JJJqlaO
	lOTqt/HFY+dfsHaQduIojzFZTesU7BkGY4Ic9PuY8h+beyv2K4WODdSUD5WOeA+FQ0J8tMCxejC
	U89Ed7FlG1fYQShblMkPmMok3z0Ge2LaSE87qut1wrMkJU/H
X-Google-Smtp-Source: AGHT+IH82gnLNVCGTkH+G8CSGIkUHUTCF4M+N3ekP+L3X9B7O3TZpIkugYLUjhbxuKtiakwaCquXQg==
X-Received: by 2002:a2e:9789:0:b0:308:e8d3:756d with SMTP id 38308e7fff4ca-30b7918bf8fmr31534101fa.19.1740585451801;
        Wed, 26 Feb 2025 07:57:31 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f4cffsm5537121fa.58.2025.02.26.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:57:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:57:27 +0100
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
Message-ID: <Z7855_cJh493vHNy@pc636>
References: <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
 <Z78lpfLFvNxjoTNf@pc636>
 <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
 <Z782eoh-d48KXhTn@pc636>
 <8899bfa5-bd8b-4d34-a149-40f30d12cb1e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8899bfa5-bd8b-4d34-a149-40f30d12cb1e@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_155735_395533_77E42CDE 
X-CRM114-Status: GOOD (  19.84  )
X-Mailman-Approved-At: Mon, 03 Mar 2025 09:25:56 -0800
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

On Wed, Feb 26, 2025 at 04:46:38PM +0100, Vlastimil Babka wrote:
> On 2/26/25 4:42 PM, Uladzislau Rezki wrote:
> > On Wed, Feb 26, 2025 at 03:36:39PM +0100, Vlastimil Babka wrote:
> >> On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
> >>> On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> >>>> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>>>>>
> >>>>> WQ_MEM_RECLAIM-patch fixes this for me:
> >>>>
> >>>> Sounds good, can you send a formal patch then?
> >>>>
> >>> Do you mean both? Test case and fix? I can :)
> >>
> >> Sure, but only the fix is for stable. Thanks!
> >>
> > It is taken by Gregg if there is a Fixes tag in the commit.
> > What do you mean: the fix is for stable? The current Linus
> > tree is not suffering from this?
> 
> I just meant the fix should be a Cc: stable, and the testcase not.
> mm/ has an exception from "anything with Fixes: can be taken to stable"
> 
Got it.

--
Uladzislau Rezki

