Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AB3C021B3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=; b=XEbob0dWFSZF4H4ZV23eNjo4fF
	jODS8Ncs+hl0DiSVQx6B3I4DgAvPxiuoZWXMqZLPsL4sOx+Zb/vXfbWtj/YuhQ15IyfetNvTWDtGG
	+R0fbZ4bSVbnQ/66psDUA6tstHjbvxrZkp2+rv9m67xpk2FkomltFxU3WfLuWzemvxL/+DZ6lrqeN
	IzT4o0QdKZdHU6LqPO/7BiVCBaAxLht794AN42AXGwRab/zNwlMPf6cjWtc3gdOAhfOXuIKE11icq
	/hz5U3o0/DPlGAM8MP1Jxcazk6VA9A+BLMBbf2pR/4y3CtTLI6BXfI4erMQ6/SkD6Xml6I/EIQ5r8
	d4oA0KBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlXGI-00000006RUv-44xK;
	Fri, 21 Feb 2025 17:56:30 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlWGi-00000006GPj-2IMc
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 16:52:53 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso370815066b.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Feb 2025 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156770; x=1740761570; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=;
        b=msU/CacX0NyPprjE881tDDjLyygkx3lyCQVap32M4ePXtorScJzN5DU54SfTJZHezr
         kuz9uuoWG3LY3V33/zogSH632ppO1r7xTqDMKDWPya7ft8Ipe8zhBCv2QIpgdDw8O0xV
         uaLboDdPcdeo5ZU3jpddmH5aVi0YFoEAbupdUAqhAy5zZJp7O9jJTG/K/T9BlCbpIfuw
         LeoNbHplz81VyFjyAI3n+Sr8t3h1v9x7EuVUg9NcNsIhtKjrLF4Xdzf1ESfxrDCnrC2u
         EPFf43IP/dFcvOmKSkM+4SR5uXCm6wSvMwuNIPTQ2agOyGZzr0HvrjSaXodWNfUiW1II
         c+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156770; x=1740761570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=;
        b=XZf4pq6vtXVkh7wLvYzyDdVZ/RBjwRBPT2DrEq7Fb54V0n4X5Alql5re3+otX3iZZE
         SZu+QXo058+XbZdXoNSHm601adBIe1d9uQzzYLAcmvN9ihX0xks855c7jFBgxqGGqBL7
         Y82482WYR5R7X7clAt7ZO6qhvldGgzc+aypHL76KEWOi8PX1pwIog8CNGjgh93TJNqaS
         xD77Jf9twVEhHJy1ksxBEKrA6fHRaIMSQ3uWzi67YP5+LTVYxuudqFtaQ2Zn68bJA+cw
         wliOWWm4kozxON9w578Btf3ql5XJp7FtDKHiOP3ze8YZpnjUX280oRfm6okGX8CzrnuB
         4DiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM8QhSNTnsWuX026F9izHtHh7osrzka5kxBzgPLqLioRjnqEDfWLYzmo6azc5JuB6oPuomt3iBTPyi@lists.infradead.org
X-Gm-Message-State: AOJu0YweoyU03Ev1gCBvloTJ/WEMeVfy/x3GJEONnld6Y6i7IlTEgG+a
	ET1RBYiUgdU0WeMlIalwfZJXniiXgzqWCrgKFtft2QWKU4LoO3xCo1fY2XOu6stlRQF1my8D68/
	HtDoIKIBVUc0JQa/BShx8eWSeqiM=
X-Gm-Gg: ASbGncs7piU414SRyza1JScAytV+EbhkynrFmLWcpS938XSAjtUAd3APfrDUsbrFtcS
	PX36neWkfOGRvywEbKTyvZG7a3trF+lYtGfL5MYSbWUHdMem1SEPFN4jAhi/XIONeBB+ZjAN1m+
	Bdp6HPDA==
X-Google-Smtp-Source: AGHT+IHpa7dVTFfLnzKGtw2UdVJJ5Ox7pwmBS6uaFDBASq3wQSqM7Dh70sJDq3JmlljMQpfKXkg8quBGs3JbrAY90XA=
X-Received: by 2002:a17:907:944b:b0:abb:c647:a4c1 with SMTP id
 a640c23a62f3a-abc09e37de2mr406314466b.52.1740156770066; Fri, 21 Feb 2025
 08:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp> <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
In-Reply-To: <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Feb 2025 17:52:38 +0100
X-Gm-Features: AWEUYZldjsBOz6dW6Mngy0JPyOmqYkSKLBXfGnQS2tXN2Unv8ZD0Hi38e_Hg0os
Message-ID: <CAGudoHHeLDgSt2Lt7AO1qpN7uf-SOJ=LP9y+UG4zv0EY8gA2Jw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
To: Keith Busch <kbusch@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>, 
	linux-nvme@lists.infradead.org, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_085252_580514_4175B29B 
X-CRM114-Status: GOOD (  20.82  )
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

On Fri, Feb 21, 2025 at 5:51=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Feb 21, 2025 at 5:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> w=
rote:
> > This patch appears to be triggering a new warning in certain conditions
> > when tearing down an nvme namespace's block device. Stack trace is at
> > the end.
> >
> > The warning indicates that this shouldn't be called from a
> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > and tearing down block devices, so this is a memory reclaim use AIUI.
> > I'm a bit confused why we can't tear down a disk from within a memory
> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > flag when creating the workqueue?
> >
>
> This ends up calling into bioset_exit -> bio_put_slab -> kmem_cache_destr=
oy
>
> Sizes of the bio- slabs are off the beaten path, so it may be they
> make sense to exist.
>
> With the assumption that caches should be there, this can instead
> invoke kmem_cache_destroy from a queue where it is safe to do it. This
> is not supposed to be a frequent operation.

Erm, I mean defer the operation to a queue which can safely do it.

--=20
Mateusz Guzik <mjguzik gmail.com>

