Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4BC282D1
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RITIVTCCbPTEmlznoBvDtT81aFPY1TF+qiJ3KGGJkqY=; b=wLemonp8ee+qUAZ0bnWH6Bb46J
	DtU+5Tx78QzCFMyjoHaU9By5s+X5uAbiFL7w9GOb4FjAk9/GCXgD2WbZcThSU5ROaXEDcYyl1xTH2
	7j+k+f4m/4Nzm9LKiJ6A19BF2md6bRM5fyoTUH2E6P41sJdhSFeZyEREiIMqo/8WxCLBHXU3+ZRrQ
	ouIkV0pSum+EdU7aO1zWFBLIMg4Tza/AfrStgy8fBfSubh4/4jcTOKza01CzUB+29ee0irW/tz2kt
	jqlbaiKaeCvZDxllFuqeD/4lEhzpvieUVDrtt3o0xozWvgwtl6KNugREucvPlh+yRq1JOv94Ej9my
	GPRP+HYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9YD-00000001jnc-3KrU;
	Mon, 03 Mar 2025 17:25:57 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJnf-00000004Qy3-3pWz
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 15:58:21 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so1259158e87.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585498; x=1741190298; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RITIVTCCbPTEmlznoBvDtT81aFPY1TF+qiJ3KGGJkqY=;
        b=YejAMBgxVvn1PA0rwQn+25Od9k/a8qggbwZpUBGlaFRulis2A9ykvHAs+kFQ0rcrHO
         8cPV3Ly0/HVercnz24TgpU5y/ZUztVpgjIcDgld5GWkyzbhEQd3ZZFuBcYtTXl5eCAMl
         bBpaf0AjDehyVsSdikG8ca744AWdmXgf4DQoLHiGwKZe8faNMo+9lKflwJikb7uPLm9a
         it4cNb2fJyBjr9xUDTnVrqBQzt2+AM/6/oBgSOVFs2Jw4hXygCc34aRl+OBYdksqomgG
         ZrodvGrRNK8aSTwuDwJq54sJCF+YU9dZbRkq0QjOiX7XJPb1ZZ3Gei7qv5tnpnc+92s6
         BjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585498; x=1741190298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITIVTCCbPTEmlznoBvDtT81aFPY1TF+qiJ3KGGJkqY=;
        b=UF18aNu01C1ocPIK8P8+LhFk6FvMJQh/BkH6ogQNzp8nhXnxiJd5hqNSUEGq6swEmY
         1yEXT5WIzprlwBLgCCIm7AJutq9UUDDT7fs6lVsEI4cxaYEnnYdvpxejeF10vpXpLs/F
         pjXla7Qxzk8Z13VLwdm7ip2XzIqGdBoZClacM7He5tHlErfLs7jgcHA8GFrg07Ev0xKl
         dnemwGdd2xtdeKmYS855cqiGujG/cy5jp+fObCPcaUggH0uU4/uDTO6CZW+LJuhK6DU/
         SgNjKfMqUTScGRscewcRx4Wq988GGsRIfw3pLqjj6N71HdOUPUy0ov9bWHvX0wtnQQIH
         aR7w==
X-Forwarded-Encrypted: i=1; AJvYcCV7vOK+6DHkMDztxTola73zo9f5KSI6vQQ8QCga5Flx6R0w2/8M6ftnDDD4NoAi2AT7DDKcIbRKLE1r@lists.infradead.org
X-Gm-Message-State: AOJu0YydSpHeNe7GLyecgPLMSzr1nzOfIsKLQp5ZVRnwg6biedER3rTN
	UwGVHy5FDh169hOC/a1+nIg2XJ4QwI2RWhJ0kq1lrkjmm8l/HO0R
X-Gm-Gg: ASbGncty9jW+k7pGMsvxcUEnLLq2kGzZrCAYlUAoX8B3PsV2HduZYa2RURABuA1q7tl
	3uNkmC4M3mRtfCA+kmcF/h3ONWkQl5pZH7cSzPrg2/NP4DRwkQ+ployVVCXQ70seg9R2eg03OyM
	E2EYPjD5DoPUVQoi/bmbSQpbQEjCCoANv02RJfqorBn3Yp69P+88oJVvrK7cprjW9nmjzvvidHh
	1sCBKvIf7u9THNUXN6XOifdor6ZWnOmIiF9GgdebIufmQObJE2fWPf0ONvaeoooV0riTbzT3cLp
	BoyT4TL/qdjEZO2ttKF9fcIiu6wJccFlE8g3hNZiIrP/lMri
X-Google-Smtp-Source: AGHT+IEKepRkgCxNHEffmBxHyGo3LSSp/FaDq2MJoUWianme6+1VXGIKpH8gZ7BIYRCP1hqyTay2dg==
X-Received: by 2002:a05:6512:3e17:b0:545:5d:a5cd with SMTP id 2adb3069b0e04-5493c570908mr2649719e87.6.1740585497794;
        Wed, 26 Feb 2025 07:58:17 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efaccsm491496e87.155.2025.02.26.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:58:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:58:13 +0100
To: Keith Busch <kbusch@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <Z786FcgpcjVZw4WI@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <Z784iRR13v6SkJv5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z784iRR13v6SkJv5@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_075819_955114_43112B90 
X-CRM114-Status: GOOD (  15.81  )
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

On Wed, Feb 26, 2025 at 08:51:37AM -0700, Keith Busch wrote:
> On Tue, Feb 25, 2025 at 07:21:19PM +0100, Uladzislau Rezki wrote:
> > WQ_MEM_RECLAIM-patch fixes this for me:
> 
> This is successful with the new kuint test for me as well. I can't
> readily test this in production where I first learned of this issue (at
> least not in the near term), but for what it's worth, this looks like a
> good change to me.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>  
Thank you for checking. I will apply this.

--
Uladzislau Rezki

