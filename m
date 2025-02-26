Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5965C19F32
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EC1eEy16dWk77oUwR2C/pnSf364aeM1Gi+/TEG7RfzQ=; b=hm/DqMwkDjlztvzUjFpztO03lq
	Abx/pRp7YGi9XywER6YomBCg9PylMQjD5Huz0s34yngaH3UMz+twHOFbvcI4Ani2JdtQZcNmzwfcJ
	rXkkryJtP/z7vE0JiSENLXckgpPPwU3kNjfyT4gNh2mEEVcGqB+ssU7Qttc3q9j1TEDesaAztZOS5
	WNXVwV7jp3UnZ6Yl/HK694ycla1hGrFjsN4aD2Ns++MAndEg0rkMWrFLzJnD4Pfw8/Rz1VVbpIW4x
	WX9YhbG5OJS4Sk/Naexk4m4dZqPcW66VTsZPqKR7TRGFiUL3H55Zzih5+W4X4VHohM8MDa23VV3K8
	vGgy9GyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJif-00000004PUE-4B5E;
	Wed, 26 Feb 2025 15:53:09 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJYn-00000004Mxx-057B
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 15:42:58 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so70329861fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584575; x=1741189375; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EC1eEy16dWk77oUwR2C/pnSf364aeM1Gi+/TEG7RfzQ=;
        b=IP7cxbIyqZuiyrNABnC7yvnzMlwH81qsKdYlLQJWKk92jfEkfReCb1CTlgfJYjN53R
         wAtrFNlZDIRWKO8/WnbY3Mnmlw8F7ZTHZ5kunontW02VBAoxq/RXehpOoRg+83Q4ahKa
         xbA4LuJGO1C/Pf+MQ4vocWGy61cLFCvjA7ckMcrV3/1B4z0XxR8giJedZ8uhzI1inOMD
         bHQwzULD4q6AO2/tHE4vVv+SBeMXxyCfeGvTkbrhIxy9Lo9/8LXMUg9s/M6Lse9kZ2+d
         MxwzdiaPWx7pARxu1r5FAKxC7VagolI1addnWpOSR+gGjEj0gVkDedp5M3JaIC/DV3Fm
         LUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584575; x=1741189375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC1eEy16dWk77oUwR2C/pnSf364aeM1Gi+/TEG7RfzQ=;
        b=iFNUC26xPausnICJF68v41Vg83hsJbfwVZAwqdA5DvsbsA+zqRTVA1ODcqg5ASgjcN
         SKphHAD1ktDgsamWucfRM5XvT13Kpy5q1uybe/GZMGak4V09e5C95ieVcbZRHyqh8EQ8
         7gJDXaOP3uD+9oYoqnBsoFHAWqvmtorRVruJWq2ZWf+l7eyiS60/uimuwyu+nPeQM2M0
         Zxjfi8totYdw1AqsD9kZN5IufS1xfwp31qB//s1UlKK46KMgHYVn8dlQu8ywgernDtJ+
         WWYV8T9HDrq/pHaykYg2pumUY/gGdNYnwhA6LqtKPn/Q6keouvYd5fYORgKrPOVOJo4U
         wQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV72gmN7m/AdqXfbMH7uJ2v0xa24I1Rj1rmEdF40cs92byZ/YzUImAKAGkEH52e2lm3q11XerTIQ9vp@lists.infradead.org
X-Gm-Message-State: AOJu0YzxciX03/RrQsqvNV8tGglk+aBfn9Z1/95VjCdGRY/Coaw1E3C4
	EukjCTmmw4z1cbRs2RDHm7lCZ0OXKaZ9zvAl3El1+awstotEH1o/
X-Gm-Gg: ASbGncs1ScZ856PzXpveq49/wW9HEi3jic3E52/ZFD4/A3SoNpFdwYcJC8H/EzJ/QgI
	fqWDvS4GRI2csrbwpaGVNyyLh4+wC9bG4d/TYticRm29aDoEfvz4Fm7Pa0lkWYYw3uXNf9DXMqr
	yZ9aXz3En0rw/A4CtKPaFcYWPx9wmkdgUXkJsc94yeU2mTJoeeidH2qakjNWdU2+pourwDGHx4R
	o5DYHZWGmYDWrkXwyGki0b10LIpNbtbiw70YkpFZOPrsm/EVNQmP5FLEHLYd/7yibTWnpDvSY/j
	maogxTsXIr+n0UCr8A7DbnafkIgpXmyVNtHontVmXWcxWGR4
X-Google-Smtp-Source: AGHT+IGXJ4oZ/znpdkecPp5tddj+wrT+wUd+ZQGedDdTB7EiMlBVxjC98UHDukKm8jBLnJwAplj21Q==
X-Received: by 2002:a2e:3207:0:b0:309:bc3:3b01 with SMTP id 38308e7fff4ca-30a5af4c7bbmr85358301fa.0.1740584574916;
        Wed, 26 Feb 2025 07:42:54 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebe39sm5640871fa.28.2025.02.26.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:42:54 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:42:50 +0100
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
Message-ID: <Z782eoh-d48KXhTn@pc636>
References: <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
 <Z78lpfLFvNxjoTNf@pc636>
 <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_074257_055184_72C74BFE 
X-CRM114-Status: GOOD (  15.94  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 07:53:07 -0800
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

On Wed, Feb 26, 2025 at 03:36:39PM +0100, Vlastimil Babka wrote:
> On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
> > On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> >> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>>>
> >>> WQ_MEM_RECLAIM-patch fixes this for me:
> >>
> >> Sounds good, can you send a formal patch then?
> >>
> > Do you mean both? Test case and fix? I can :)
> 
> Sure, but only the fix is for stable. Thanks!
> 
It is taken by Gregg if there is a Fixes tag in the commit.
What do you mean: the fix is for stable? The current Linus
tree is not suffering from this?

--
Uladzislau Rezki

