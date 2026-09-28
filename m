Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C71CA5FA1
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 06:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enVf1SyIQ9oZvAJl5nReVDRZKns+mfLkqH0FfDFTL44=; b=CuJx/T38EMVmypma+0tfzQCWR0
	vNKruz2KaZwTAlQ51xAX66zhzj6iJzpzaWBBBHEC69iTdBjqAbrhgTzh/GxrPFOqODALClTPdDSqD
	Ss8NW1iZw91PP3hbZwTdOqqkxlZJ8JwCFcaztJqhIK4WrbTj54vGwp4FaYQI/m+h4lehLTxfbwbEV
	xKfiT16l9v4OIWpG++rNBwmTDw9AG4nox+b48/raOJH98HF/3e7Fiwf1eLYGs/2Yxn9CVl+MF1+Uo
	R1EZl++wxwoLGw/iO0xmi1tDDTq1IIooSyjuVbvtOLugSC5vJAq44fSoooNJ6YmbUk6jwZMsczhlI
	s/4L+PNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4dB-0000000HR60-43fW;
	Mon, 28 Sep 2026 06:14:29 +0000
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4d7-0000000HR3h-3s3P
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 06:14:26 +0000
Received: by mail-pz2-x2a.google.com with SMTP id 41be03b00d2f7-cc7b3311c9bso281066a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576065; x=1791180865; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enVf1SyIQ9oZvAJl5nReVDRZKns+mfLkqH0FfDFTL44=;
        b=i4LTXVR2GWGH0daJ/0YifPKgFFgEN4OKcODSpYH23AMHBqYTgcdh2y6vRJ8Qw0k/1e
         OGwocjrnaWDOO9uhOXJGK4M60okNcT1uwlFDxZmR4X8oga7cwlYQvSjhCFyKPp1F5k94
         bp5VzfLodtLCFDlmGCUobIk14V6baHBc1/7tuMFjsk8n7QxAHXlxTzcK/hVnp/+YdBmA
         ssMWz7KVDL9EZh0Ec/+6rrDWsCpX/bTzOq/7LPTARqa5wFyWzP4n5iAL6/3Ai6q8p+3V
         STgj+V2PfYBb/Wt6iIQmFiti3b0YXnxA51/irW/8IZKecqnkp+jmMdrCXeU8RogvOQQh
         x6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576065; x=1791180865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enVf1SyIQ9oZvAJl5nReVDRZKns+mfLkqH0FfDFTL44=;
        b=VHQf90cwkVNM5kmelYqp79XawjXwrzc/vr+2t3lbr/gpk2E33z6CJ3Z9tlAd4zaOUx
         HyBO2UINh23FFEm3kK6WgAR9pd+06lC3rM1cZyZZE9KFAi/OwcHw+PnyNSfKrSmGrR4k
         /zZ4nj4bKVJgHxe9OFj24aRgtKFwgx/dLhi2RjWFyOTYh01T7alqrmhe2B2A1HrlpzAP
         HwBHyOmurNF99r9SVRey16b0ED7TwNy/TbJymUQX4nCOOq6y3sau2JOwTJSIlh64+53a
         c/Ngr8W3EnTfPIGeKNiEpcUn/VcLcHJBTzqRr+g6ElrkTykh3cSI3LY+qAOaEWWD9hSU
         7C4Q==
X-Forwarded-Encrypted: i=1; AKwUvBycA+ClTz0CpgiBKi2sMA/ngoLZPlHn897gOOCCrDeWzAYb/m+zwGVwE51iHEqRRtOWZOOoNO/oCyT0@lists.infradead.org
X-Gm-Message-State: AFq9FYKnwrejiuxeFtSggIAn9xaPP2fygl7GZrN8Nd7R61htl0SEBqpx
	q3ore7Sd5NANs3BpbcJR4twxJgKsiKs0IWCDvdu947rhUtIf73lprNkZ
X-Gm-Gg: AYBFou3WtOs4rLtgTOS8vMmZ9RulPv9MbtcJ9YlcuD9uLkU9+Qe5HLbLssHmo/4YV6v
	gYskvB/5+bnS9DsRUxGfKII70PdsTOJk/Ia6rzGZ8htipTPlKRRb723CmiFcXB1W2qEQ34y+jk1
	RhVsg2NrKyOg0JASTkXeWomRjmLho3bOIG+7L8cagaVNxsTXY83zHgal3Gbzz7zo5lntMLuqFTJ
	7F+lhDBVC2RvAy/ksS81H88VJE6byCnFZLsUCLWVPLrd086jclT1RxQPHaw0mGqwi84GHFe47Xu
	Zf9sTCBvYt95fJ0Y0C/sOydjrO20taVhUNRW67GDTTmupL0NbtdTUybG/sRzfbRRPYWpHv1Rver
	oPn1YHnzwJAMDW7n4XyjaDGJxqlhigfEpBmyVRlIBT53770mgRRhD1QxMrxkF0UR1oM9iHffqWF
	wC80E3KCBMVvHYiE+bPWiySZeqxlLuyFIa6Le5gfW2a4HArL6GRoYXj9G07VtVwtTz7Xvg3fXhL
	4+qIisxy8ZPXj9y+7ToHLQf/Ues9YNEvtlgse92F0yZcEqboDrSwn58SMHGWXoQhC1Vv5DDUI3h
	QRk=
X-Received: by 2002:a17:90b:4c03:b0:39e:6a82:afd6 with SMTP id 98e67ed59e1d1-3a098feb5abmr10108909a91.40.1790576064881;
        Sun, 27 Sep 2026 23:14:24 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm18864088a91.11.2026.09.27.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:24 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v6 2/3] cgroup: export cgroup_e_css()
Date: Sun, 27 Sep 2026 23:14:16 -0700
Message-ID: <20260928061417.1574676-3-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928061417.1574676-1-yupeng0921@gmail.com>
References: <20260928061417.1574676-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_231425_960962_2E6D9442 
X-CRM114-Status: UNSURE (   8.65  )
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

The nvmet invokes the cgroup_e_css for each bio and under
the rcu protection.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 69b0f0cf2f3e..5a1708ed6b23 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -554,6 +554,7 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 	return rcu_dereference_check(cgrp->e_css[ss->id],
 				     lockdep_is_held(&cgroup_mutex));
 }
+EXPORT_SYMBOL_GPL(cgroup_e_css);
 
 /**
  * cgroup_get_e_css - get a cgroup's effective css for the specified subsystem
-- 
2.53.0


