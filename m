Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A8606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oYYwWglj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFR59xpq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=; b=oYYwWgljJ14XGP
	/uPOCCZdFR+NKJcUrQukwatdvO+zn5xgXhHhEZGsUuL4XFwnPSwNxjWDQbDVJZjwARtTxKwj2CCrN
	43g6YGoT9z6rNhUkhff8wYwY4Z8v6pl93JO3Akd1oAAaW/yzCTU/fCoqDZXJvRgwkWIdXpgMuCyIz
	3VSw7njJ1lxf2L4JyXRcq04lF14c4LgwOQh+q7tUyk0/4tBB9u6gnUxY1wzsvKneaYsGy5bGDjj65
	WK8bKIqG6UyQh7pdSo1UAdHoW50u0qZStNyCeuv9V2AsZJs6YaOAMZ7iw525b2LedCwOdB77lXkKY
	jkbCe3z/0anRPp6JsPjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMbu-00000000Pfq-3UwY;
	Mon, 09 Nov 2026 10:28:22 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMbp-00000000Pei-1Q2M
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 10:28:21 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-48dc1508191so23562f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220095; x=1794824895; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=;
        b=wFR59xpqPfqfdJozoxsA5f1YX/e29LK/XICBu8IouXwzNoQ8jvTYjG/Xe7iFu27nFn
         ++aIE3CC29j8LiB0Espj1p7La+I1khTC+nsNFz5WySAGr7+ZkW5RS5e1Fw6gWEOsRa72
         eswda5ePoWUZD6gIe4hdDIClhbx8PY44/uTcnF5raI0agAdBvi/YiB1zL4PQjh7VWcgg
         6BTCvZesx5pkeDuNmeOMFNkJn3NU7xZTw6KkyR7tv3CCeo3myVUJNRh/aDVa/fw1ttEl
         hEgKO02n0pzzzW6VV+nfZs2j73dSYGO/UOFqf04LcpYBecI6BnnuY5ppIB3HoE5WOSkS
         khwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220095; x=1794824895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=;
        b=snHRRKiVVqdQ6qXnq+GCViU6/H+LVxARUIJVBGR2xQTM9bFdm1GRgYIOzFo/faQO6q
         dZOdxdxVhR/d9OkuaKMS4Eoz2x9+vbuhjv5sgkGIG1D9qqHSYR8c5mDsFp1a2ZVxFlRq
         a9E/Z93lAO0EtBNg+qSJoROm0rWShiM38RjH26O5km3g/I92WSRQkBk2J6WZMXH/0KVi
         AXEjOmXVKx0mLsdQEucg9T7O7pV5Msv8dHnFkvhVhM6tSytHjp+5oWF59Qg8QLZ7tO8A
         WbkC2Yww63PthYEDl5aJq60p45OANfuUJIw4lcfi12CNLKC08nbnmJHEotGGxuwsESdk
         6LtA==
X-Forwarded-Encrypted: i=1; AL+hErF1LAOFYdGRQB3toS697Uj65Np5jMPJ4lqrkn3s1KlJEbByWZ1jOmBu2KHfr90KDW14g49NjQSF+glU@lists.infradead.org
X-Gm-Message-State: APuU4Z9ilwtdcJXiFhwT1CN8sMEmIfBxfRiID81vnMTcwV1IA2XEsmhO
	ALNx+6qXow1fx7M/F8fRzwPYcHT/YfZanHVRJOQ4mVC57H21CdIgIw0=
X-Gm-Gg: AYBFou3j18J4LI8tRQL8/Ab23PCDgh3/uB6lNsM7oKivcI5A3JCgQHxTB45/7jeNkB3
	SOkVetlHxXEeMOcx0L/4BJXJWs1MX+CtHnerVKGFbf5K2jVuZIYtMMCEdspXLkVhBv2/A605DWy
	/Dgbe1KVkBOpkvpT1/sn226zyCKkcn0XIph2xA0jGcJLVfXp1u0WVpcxqiD1ndf+Z7WSqdJ9Jep
	kXO8INjQ/DoW2Is8/dTcmDqQKdFfwPSfbYFwtJn6yNJDk7IjC0k6YFklVyPI3moB/4FgsF2Xxgk
	eJJEiAaBejgnVAgSijJn3DEzFdgW/6G2Uu40InqiTR7IutfaB3iT0OclYeI69MlQ4Hbq74fEaYG
	UYkuFsANWQpseKTIRsPhiOcYKwo+aGaBMAE5Dw6MPQmGVmyaR9eU72cMG+xtCYCENvX0I3AXXgl
	xL42QNxEvr0aU1Ha8bgTBvTjy5fA/C6ntlg+cILOlB2nO+IbGLo5PScyXUwTJMuQu6Q5W4ekDzV
	nzzG8QHBKKCxLSpLMe3ZVi4rW5Q13jvlFleuOa07P+JLdLW4sS6Lgug5bxfgKMOHjxjkOsDJUEg
	cznHrVXPUz+dH5XSpAKmVgLPu/d2I0vayNHE3Mvolf7QkqDJCYUXsPOrZki2Z/OP
X-Received: by 2002:a05:6000:230e:b0:493:9233:ce65 with SMTP id ffacd0b85a97d-4957c6e3a22mr7285786f8f.0.1794220095238;
        Mon, 09 Nov 2026 02:28:15 -0800 (PST)
Received: from localhost (69.red-80-39-28.staticip.rima-tde.net. [80.39.28.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597d09e20sm9165541f8f.54.2026.11.09.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:28:14 -0800 (PST)
Message-ID: <d3e9eaa7-fff4-405d-a7cc-d5daab77ae16@gmail.com>
Date: Mon, 9 Nov 2026 11:28:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-cli: nvmf-autoconnect: Consolidate vendor-specific
 NVMe-oF udev rules into a single file
To: Martin Wilck <mwilck@suse.com>
Cc: John Garry <john.garry@linux.dev>, Nilay Shroff <nilay@linux.ibm.com>,
 Guixin Liu <kanie@linux.alibaba.com>,
 Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
 Martin George <marting@netapp.com>,
 NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
 Zou Ming <zouming.zouming@huawei.com>, Li Xiaokeng <lixiaokeng@huawei.com>,
 Randy Jennings <randyj@purestorage.com>, Jyoti Rani <jrani@purestorage.com>,
 Brian Bunker <brian@purestorage.com>, Uday Shankar
 <ushankar@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marco Patalano <mpatalan@redhat.com>,
 "Ewan D. Milne" <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@monom.org>,
 Hannes Reinecke <hare@suse.de>, Benjamin Marzinski <bmarzins@redhat.com>,
 Christophe Varoqui <christophe.varoqui@opensvc.com>,
 BLOCK-ML <linux-block@vger.kernel.org>,
 NVME-ML <linux-nvme@lists.infradead.org>,
 SCSI-ML <linux-scsi@vger.kernel.org>, DM_DEVEL-ML <dm-devel@lists.linux.dev>
References: <20261109000834.513230-1-xose.vazquez@gmail.com>
 <f2b862d6106122031d3ad93ea3bd1a7964508de7.camel@suse.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <f2b862d6106122031d3ad93ea3bd1a7964508de7.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_022817_405040_C9824BBD 
X-CRM114-Status: GOOD (  12.55  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 11:09 AM, Martin Wilck wrote:

> On Mon, 2026-11-09 at 01:08 +0100, Xose Vazquez Perez wrote:
>> Cc: John Garry <john.garry@linux.dev>
>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>> Cc: Guixin Liu <kanie@linux.alibaba.com>
>> Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
>> Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
>> Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
>> Cc: Martin George <marting@netapp.com>
>> Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
>> Cc: Zou Ming <zouming.zouming@huawei.com>
>> Cc: Li Xiaokeng <lixiaokeng@huawei.com>
>> Cc: Randy Jennings <randyj@purestorage.com>
>> Cc: Jyoti Rani <jrani@purestorage.com>
>> Cc: Brian Bunker <brian@purestorage.com>
>> Cc: Uday Shankar <ushankar@purestorage.com>
>> Cc: Chaitanya Kulkarni <kch@nvidia.com>
>> Cc: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Keith Busch <kbusch@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marco Patalano <mpatalan@redhat.com>
>> Cc: Ewan D. Milne <emilne@redhat.com>
>> Cc: John Meneghini <jmeneghi@redhat.com>
>> Cc: Daniel Wagner <dwagner@suse.de>
>> Cc: Daniel Wagner <wagi@monom.org>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Martin Wilck <mwilck@suse.com>
>> Cc: Benjamin Marzinski <bmarzins@redhat.com>
>> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
>> Cc: BLOCK-ML <linux-block@vger.kernel.org>
>> Cc: NVME-ML <linux-nvme@lists.infradead.org>
>> Cc: SCSI-ML <linux-scsi@vger.kernel.org>
>> Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
>> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

> Generally a good idea, but I think nvme-cli has a GitHub based
> development workflow these days.

While GitHub is an option, web-based interfaces tend to limit patch
visibility and broad review reach across subsystems. Mailing lists
remain far more versatile for cross-project visibility and discussion.

> I'm not a fan of repeated lengthy match expressions in udev rules.
> Can we improve the readability by using GOTOs and LABELS?

Using GOTOs and LABELS cleans up the duplicated model match expressions nicely.
However, the scope of this patch is intentionally kept to a pure consolidation.

