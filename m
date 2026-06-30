Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABC3C43602
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3W15pG85C5FxVGgdo4xnnSJkKUbelIMkLyPB5cfY4Lw=; b=KVQ45MHr1l/EeCuGznbKgIJdlO
	AujwpFT7KTN4FLGjzNNkWFsv2t51F5KORGLH4S55jGOR7IeINkvvu9i55+UgUwvMkgXSKRWhUIrVL
	yz9iOI+xjqDmEshbT9oZZLe1FlTlibLEO9qboBGTTj3jBWYlVsLELUMsxsudN5VZojxQmhluQdUHy
	9d6yqiO8ELWkctY8ZLjQZQF/9GIMUm9KQTbLfT9L5mXpVdkXu4L/bH2go5kTtPLWmHK68ton27ia0
	7WywM6cX91z9WRgt2/LSwFxKa6+ckMvYU/8HZuRzDXDQFOlFG/PGiYE0F3e/txCKXUvwbIY1rW1/p
	U0wqX4Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVr3-0000000GgfC-1ftv;
	Tue, 30 Jun 2026 10:38:13 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVr1-0000000GgeB-2Ld1
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 10:38:12 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so34504025e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782815889; x=1783420689; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W15pG85C5FxVGgdo4xnnSJkKUbelIMkLyPB5cfY4Lw=;
        b=YXwA+Ts6Di8HDG08NtKV6MltEoirUN3VNntZlXwsnGympnVB+Am4uF/iFSPFX+Ci2U
         X/yYbmHrrYh4h9Oyj9Cjd+7SSywAgvLS02BD3D9MlEsTXdY75rQMt0gJWWrRuzsIu/7X
         HcAp45ozfbEW7fO2+zt6MevftDSqORB7igaUalcMCfh3sLbGk56kWWZ5qdjlkfsQhv/A
         ASR7hbXTz4vXrzcpa946u6fkDInTOzxDLF33YT/yZaEMfYEFsorPKJ2eAbgVCsNYrbkl
         Yr6yzkCDMlJXqaCczwVvBP/m+G/uj+Y7mIaj/oNbnV8h1kcK1pgbb+jBhbnEEwc6HTAZ
         PeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782815889; x=1783420689;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3W15pG85C5FxVGgdo4xnnSJkKUbelIMkLyPB5cfY4Lw=;
        b=WusL/bXv44HMmhKo/DBnPwa5iIh0ietTFuTIQ6w3YSAuyTaZpsqMNLfRo1PRMmBSCd
         YLcZaQVydFCLALdwQZgEHBnzEdglAIVKO/ycvFUBLrgAvyE2WQhXGAgLUjX+O9zPWVm+
         zTLXo2xmhZYjSS+Lb9QASQuP9je3Xf9cZSS+FlL5snD6swv1lheFAph8SrAxHF9opb5k
         oIawZeDw4NkR4YcROMSpsj42I4p7NJFb5omJ4LDB5wgkjGvuJiRjrMpA5sLBO79HByjN
         LdYaiagAXPXQLp+xIcDYHHDsmfy/Xmg9MK6p62VxwhuUXDTWKHL3f3LTzag6nerZ/4lm
         O4KA==
X-Forwarded-Encrypted: i=1; AFNElJ9JPmRNZKhwZ4ukPokVk6V+H7VNAz0bUZuXXPQ7I8P9BxogasB9CgePmyrFdfEj+TrTnX4Q5Wi86YY0@lists.infradead.org
X-Gm-Message-State: AOJu0YyMR/BxAKK7Lc9t6K8wrCRQcJaK+dXrvnQrysg4chvnDmRjSTo8
	TPOYDNtaCprxRTdmz8d3vo86/wCfs5gM8h238TLQCdPf4zXPn/InTEq4CSmDIzPcFw==
X-Gm-Gg: AfdE7cmTEkYhnNizfeTseWEGJTSTs+p7ffnbFfLFIdOY8xQVwNqowdZk4ms6nlDteXz
	NDh7OBU0fW4aqghQH3vo4tLD0Yo2nF82H7Rvxc088fNeQZ7+tcoPJpYuH9e0U8u5cjM5ZRu4rzc
	SyE/WBeDaSiCDMnQ7OBrhEEBTPFX7FXXX7PQ3Xdp54N7S1K5M56UqY90mYmPqIKBNcUIrePdSzD
	pAWD0Aeh5Xf8DiX0if1G+47aoM2WlC4g+a8I6qld5fJ6Uo4OqKAx8kUPTBIC8bZg5HUXuDTvK0e
	ubkqLYhaeWZesPZM0LUlLVs8/u+YPG4hLQcOyLm1bvbkhvSKNx7hCAjkEcAJtK8MXv2pjfpB6Bb
	TLHhqCjVsT2FxDSEeS5d0onk7okLf5F3dbvMh4r9Xx/j+JM6UKMyanTuO2EC8WyWaljslqk6Qq/
	EJNdomTQlP+lUc8vTYBaWjQx6Vl9XExFA3MpJ2+OZsTGs3NzGyrZVAtwVV1R60
X-Received: by 2002:a05:600c:a317:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-493b82b9ea0mr43517025e9.32.1782815888152;
        Tue, 30 Jun 2026 03:38:08 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:466b:c391:2be8:331a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cd303csm57386185e9.6.2026.06.30.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:38:07 -0700 (PDT)
Date: Tue, 30 Jun 2026 12:38:01 +0200
From: Marco Elver <elver@google.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
Message-ID: <akOciemHZ2K06tEz@elver.google.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-15-nilay@linux.ibm.com>
 <20260626064916.GC11106@lst.de>
 <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
 <20260629125054.GC23695@lst.de>
 <CANpmjNPgvdKLvQTFvt2OUYzG4V7GMPSmrDfV0jPbbtNxv36GJA@mail.gmail.com>
 <4fba3fdb-73df-4cd0-9318-00ff5a1e4fe6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fba3fdb-73df-4cd0-9318-00ff5a1e4fe6@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_033811_628025_40ECCA4C 
X-CRM114-Status: GOOD (  32.28  )
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

On Tue, Jun 30, 2026 at 03:05PM +0530, Nilay Shroff wrote:
> On 6/30/26 4:17 AM, Marco Elver wrote:
> > On Mon, 29 Jun 2026 at 14:50, Christoph Hellwig <hch@lst.de> wrote:
> > > 
> > > On Fri, Jun 26, 2026 at 09:01:20PM +0530, Nilay Shroff wrote:
> > > > > Does switching to list_empty_careful fix this?  If not, does
> > > > > list_empty_careful need annotations to make this work?
> > > > > 
> > > > 
> > > > I tried using list_empty_careful() but clang still throws the
> > > > same warning. And yes it needs same annotation to suppress
> > > > the warning.
> > > 
> > > Sounds like we should have annotations (or just use of data_race)
> > > in list_empty_careful, as it is designed to be used without holding
> > > the relevant lock used for modifications?
> > 
> > Given list_empty_careful() is a real inline function (not a macro),
> > you can just add __no_context_analysis to list_empty_careful(), which
> > should also suppress warnings about pointer-to-guarded-variable being
> > passed as an argument into it. data_race() wouldn't work, as the
> > warning is generated in the caller, but when the attribute is added to
> > the callee, it also suppresses warnings about arguments in the caller.
> 
> That sounds reasonable. So you're suggesting adding __no_context_analysis
> to list_empty_careful(). If we agree that's the right approach, I think
> it would make sense as a separate infrastructure patch rather than embedding
> it in an NVMe-specific change. So are you planning to send such a patch?

See patch below; to avoid more dependency issues for you, I suggest you
pick it up and carry it as part of this series unless someone else wants
it before for other reasons.

Only lightly tested, please test.

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 30 Jun 2026 12:01:26 +0200
Subject: [PATCH] list: Permit context-unguarded access with
 list_empty_careful()

With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
that are __guarded_by(..) require holding the appropriate context lock
when accessing and manipulating them via the list API. Because Clang's
warning diagnostics do not perform inter-procedural analysis, this is
enforced by Clang with -Wthread-safety-pointer in the caller at the call
boundary; a warning is produced when passing a pointer to a guarded
variable without holding the appropriate context locks:

  warning: passing pointer to variable 'list' requires holding [...] [-Wthread-safety-pointer]
           if (list_empty(&ctrl->list))

An exception is list_empty_careful(), which is like list_empty(), except
that it is permitted to use without holding any context lock (carefully).

Mark list_empty_careful() __context_unsafe, which disables context
analysis within list_empty_careful(), but also suppresses warnings
generated in callers related to its pointer arguments.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 09d979976b3b..ba3c255f6112 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -436,6 +436,7 @@ static inline void list_del_init_careful(struct list_head *entry)
  * if another CPU could re-list_add() it.
  */
 static inline int list_empty_careful(const struct list_head *head)
+	__context_unsafe(/* intentional lockless access to @head */)
 {
 	struct list_head *next = smp_load_acquire(&head->next);
 	return list_is_head(next, head) && (next == READ_ONCE(head->prev));
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

