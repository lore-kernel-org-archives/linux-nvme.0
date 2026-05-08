Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B84CD3436
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tNDt38L0Y+fRcMoAvoffPWaNBXKXewV5vofIJAEZ7/o=; b=R9kKchE1fAjRe7Ni74W5hxUcmw
	l7XxdbD5Ld/xl45QieVqNdo4BHu6NixSlwvX+mFaiA1FkZZaFRStMJdxNGsqzRVCcyYQgRCM8IjXY
	IVfHKqWkqI6BulE4gMgUV0oY/05HrMTTVYPtzFFzHKLQuf1FB9EQ1410x5szw4E1a191viCpF/t8n
	WqWaBavMJtMoOFW3kZzg2jQUjoV9XvsUJ+aGtOuWgdmnnaPROH7H+5JyDq34OYUL7+h4mmcYznupE
	8RubP7k6CHecJAtMlFmyRGcW6h7EQxhB+0A/M9MHkv0TQevZ7Fx/Qb8aXI3CI3Joccb4wTh1Ognvb
	wq+rcCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHo9-000000069zQ-2fnv;
	Fri, 08 May 2026 09:47:45 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHo7-000000069ys-0wWE
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 09:47:44 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-834f1075805so1230829b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 May 2026 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778233662; x=1778838462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNDt38L0Y+fRcMoAvoffPWaNBXKXewV5vofIJAEZ7/o=;
        b=E8Z2D3MFHAaGn+TiuP2hVOF85wZaEPyBDTcaWc+rSkXWM46nDOs7bih4I12TOfm1hH
         cjQzXRfVRYLLqhZmhykQ1Hisn2gk62JUsIFJJe7LjBOsTAMkxbeNRyM1xi1NSIat8MuB
         0jlsxTNTdZTe9FGvkYddU16+ze0y+iv9fBsVyec18b+8IH/uZGBGbJSZr8lkdPvOiG7S
         OmiUrEL4I3LxFBy8928nVJSM4lN1LiUEkwOiRyosMN+fb4bHguqHewvYaMXN6gyHJZiV
         SqBbLi01tNYmhUc92Qa0IQikLFeuDRQD/MG9nUpwR/MRRB1j4y/eBSpyzix1XKy+QPTv
         4scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778233662; x=1778838462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNDt38L0Y+fRcMoAvoffPWaNBXKXewV5vofIJAEZ7/o=;
        b=FdNNZIIjoqtfrO4Kwome2rS9tPGQC4MCgynq/nYCr2HWU0PAnJf2fhtGwqoPBu5+Ff
         wF5+1u2lclUVATWj9Co9soWTRG48rL1wjFnxByEa2LbsucXmRcF2o9xFpxUcT7WT30/I
         vBwkg7QSSs5LW7NUEhnnJRqXay8xTH1n5I1UwgiG34HnCCnCPD/Uf68pmNKSI3uYM6Fn
         G6LawlqZIurr6mvPW+Ha8uczBMDvKEk8d+rKrMBiNR8CQk/ANPmMOvLYIHoEBeZQBnFu
         oabj2GM/HGwWKFhB5tYalzXGrmPCp64Sqa/OfEb/CvbFk6n06BBwzjGrqd/SziLvlPFB
         6oIw==
X-Forwarded-Encrypted: i=1; AFNElJ9DaemZp02gtphRKf2oJFAJWISc/94fQ2k8xT1eyu189vWI3F4iM0G37bOw21ljpuCWkGqvyJiHErr4@lists.infradead.org
X-Gm-Message-State: AOJu0Ywr8iu9tO5PbJQB2tpj2h0EDAmlVdOKUp4S3RLRmGrmJHagAxdK
	a6f0Nu5ByaH8i+UqSLiloAX0u0QYJCXxvP1gOChYkduLfp7Pu+aeWmnq
X-Gm-Gg: AeBDievRu+vxQgOIzSggAUJhk+Z21pmvI+uukjP0EcelQ84DpLGLu05/1Bi8i2PkbZD
	SfMYPqoOhsGajV3LAmdeBViYNtiunqEPcLVrtNomtsmrwdNH4KwRft7TQItWZIlT6JA3drFjp/o
	BjvYlocoHh4OF24owQFs0ZMmCi9Ij1A9NdbHa8Q7pdHUlQifBTvME2BGXb0kbjH3hOWFYwWAnYP
	DAFDAv9Ft7dxTLrUZroQESLkbsDWdzC0ItkXce8BVp7oCmhdjrPghnrfegRS+G9DXIdnndxI8cG
	aoAe05+cQ3YtQ6bU8Y7p7tqNFQcpkCqYpL7TYYjXbJwnanu1PjWEBEvipBAHe7dWXqg0U00xpKb
	EKan87FFFKeINedAgKoZQYFLtc5AX688l4iXpLRHHRAgzZMUV3RIsV6nc7t6qXo2j5VxRxqEJvu
	gKTZvP2WDSsZUENmp9QzDlCkhW
X-Received: by 2002:a05:6a00:1991:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-83a5d873ec9mr11128203b3a.31.1778233661551;
        Fri, 08 May 2026 02:47:41 -0700 (PDT)
Received: from dev.. ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm15387601b3a.16.2026.05.08.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:47:41 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch messages
Date: Fri,  8 May 2026 15:17:33 +0530
Message-Id: <20260508094734.2032284-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <afwj1aZteJRqnKxs@infradead.org>
References: <afwj1aZteJRqnKxs@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_024743_317975_33B867D1 
X-CRM114-Status: UNSURE (   9.18  )
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

Hi Christoph,

Thank you for the feedback.

My intent was to align the code with the standardized string helpers 
recently introduced in the kernel to reduce open-coding. However, 
I respect your preference for keeping the ternary form in the 
NVMe subsystem.

I will drop this patch.

Thanks,
Rohit

