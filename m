Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5750C9833F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYU9STrakLqmIxSDy4pe5WDDOj9rDVGZfrzaQa8JAd8=; b=GO/rwILJwi4PWcJQqOqyUKIq1m
	WHUGfXCpMot2UwvFZB1Zy8mpdtY3CPZchrHCPacT/scDxLwYNV0KnMRSRwoXoAJeR17a5NQXh82sO
	cHGBCu0BNz17cV3/u2mwu3QReVdwopP5k0gH+RoJluTqRx66jpDzVSqpNYoA2gyP8JuJYznMCARNd
	x5YkA4MmeSQyHM7DBWZ7Y0uzsOwnBpvPKD5+ktGUNmQod9zIWRP6NHLXoH2L1oArg5mGf811bJ9VJ
	qR4iODgmrZ43+fsWZ31ynz0dqOpQWnpFilyksj6Kce4fUtFwyAyjKxuzqtNUiQc41PjkSILB6pZAw
	W9N2kBZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBDK-00000000dC6-1gfj;
	Mon, 28 Sep 2026 13:16:14 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBDI-00000000dAa-2Hdl
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:16:13 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912d8239so24546445e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790601369; x=1791206169; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYU9STrakLqmIxSDy4pe5WDDOj9rDVGZfrzaQa8JAd8=;
        b=D2j4NUNWSgPoY2jFgg2D1BuOcgQNST/5oAxT3NWteEDfEY21zDikJM6LosvKN7vWWA
         OO4Jm+ZfO62yUcn3egGkzgd5KfIc/P9rPtrQfOzWBWMb6p9plaKv21cUB/Sz7zknbNhJ
         n3yZzm6iyBPzMj/kN7in1g+rQcFm2LPFLSF/Ir49F3kOnUUbZY0qk2BQ4SKoqJoI4EB/
         nfc6QQCrNGQjaUiyjPV/ypI/3AXd9T8rsuB79d0Y5dAnf9MHiMmhuaqqpb09t8A0xo15
         faUrc9htxLIWreERHzig7JzRwRCaRbPv+wyXNGxhrvlmmT9Fa04ArQhCRzoCHyhE4TMw
         WTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601369; x=1791206169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYU9STrakLqmIxSDy4pe5WDDOj9rDVGZfrzaQa8JAd8=;
        b=kMlP2ypa7DtB3/wCslnbeqLHzd4PhcnJ1Agdo/N/4ULHT/zXcpEXIcLLMR6y2ovWWG
         Iuoy7vhAq2qavLdoEpv+q4sDtnC7LbKpZWyf7FQlinMpA4Jz+p+1DoVkf4numz+GfVY+
         eWqNioRYVr9oiBhXWbsGY5UN7hdkvAF5m391qw0pMcYyo8DRr1t5oofxyVg0R7GX/T6k
         HnquVKEoS4OuD8Mm2VgiG2A2Fl/0Oa69UDl+NtdRH12vi1pxushds9edOI4b8pZ9qGqB
         fJnzjgLI26oJdPHEul3Fp8GEqLwiLypzblkJ5reDktaLKLGF2MGBJp46dZ/O7WKqTGzA
         IXbg==
X-Forwarded-Encrypted: i=1; AKwUvBxuBjT+3I9SHVzsVfzfD1UIUVdQhpTIRWVXLNOCDrxzmqhIxrWxaxCIdyUFba8LF8WKrCw9c/KAdiTT@lists.infradead.org
X-Gm-Message-State: AFuF++mkx3Zxzj6FtyTIZb9o+h6VclTcB8+dOEVahoaMARTp7RAcFiLx
	ZFn1AJETz24CFK8mjNP84tzwyDAPqONXVcF0ZIORcjUtZqy+ROTD/8L6f724LQKjfMY=
X-Gm-Gg: AYBFou0fS4ka1cKrAWFXs0G4fVdK5QQIHfb11YJOmKJsvkKSFz/w8sqNiw214RXMO9m
	rS5Wqbf71fDbGwdeJ39oDvxd5Is9cA1C5Pc9h7SV32H+desjBV+tBky+SpPoor0dUnO2mXGy5if
	OIk+vGO079N/ySeeu5HXPqGHr9051ipN0sd/nfSiaTfydLHp5M3LWjMfv2OugYd1VYrcaYtvR6J
	rnddq4pA4gVKqbd1GWTxobrfpKv7yWuKPCqsXWAqsI1drcuDOuN7HKKjJmi7K4I3ZWU3J4QOMOe
	j7yWqdJvg8hX/l6eD5sOQZuHR/HK1zyoZOORH01EiqaeYN5vX1CT4ZQ6XhGDxEgqnR0M76S15eU
	7DSzPk6QKJJYyGvWzt2qBsfp+kMrVGhsber0ZAAOlhoituIQjjjcqv1Y4q0LVUWDYZBhgcjjFVK
	4Uy4xT0d59xYOMwlDugelE9yAnqa+vqpmRs4FaF9ncNX6rML8ARrTJBACp7tczfv0kS3QgM0OZx
	FZn/xhCR24IPkXEm+ZYAuZ57T4zGM4Dykw=
X-Received: by 2002:a05:600c:4592:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-49fed8c6cccmr211520515e9.19.1790601369092;
        Mon, 28 Sep 2026 06:16:09 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm205327255e9.14.2026.09.28.06.16.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 06:16:08 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org
Cc: hare@suse.de,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	sjpark@crusoe.ai,
	saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Mon, 28 Sep 2026 06:16:07 -0700
Message-ID: <20260928131607.50160-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arVFPIKeT-HoYF2K@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai> <arRJLL4ki-sVQnHf@kbusch-mbp> <20260923225753.49224-1-kiyer@crusoe.ai> <arR3zlpx3Xm2mRt-@kbusch-mbp> <arVFPIKeT-HoYF2K@kbusch-mbp> <20260924214503.82963-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_061612_606766_377572FE 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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

On Thu, Sep 24, 2026 at 09:43 AM, Keith Busch wrote:
> Okay, I see. Pehaps instead of having one controller export all the
> namespaces, why not configure your target to have multiple subsystems
> the client makes independent connections to for each namespace?

To confirm, I plan to post v4 as a two-patch series in a few days if I
do not hear further comments:

Patch 1: Default fixes you described
- Restrict queue_if_no_path so fast_io_fail_tmo is actually respected
  in the requeue path
- Make ANA inaccessible and persistent-loss paths unusable by default,
  no flag required
- Add requeue_list kick in nvme_update_ns_ana_state() when an ANA
  transition leaves the namespace inaccessible

Patch 2: The namespace-scoped attribute
- fail_if_no_path sysfs policy, rebased on patch 1's corrected defaults
- ABI documentation spelling out interactions with QUEUE_IF_NO_PATH
  and delayed_removal_secs

Let me know if you'd prefer a different structure or have further
direction.

Thanks,
Krishna

