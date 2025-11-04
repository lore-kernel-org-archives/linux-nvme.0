Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B716CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=3fmd2yvMouIG51obXWe0g9ZmeN
	baXF/ED9gqghIiJxkay5kNYZtPN4rd9TT0QPyiBHw9Q9CxWQmApiVTFYSYdw5JdO0Q4NU7PlBTLdC
	JpHoIcshoO2TZiVqf1PS/oMnJh9r2UnFZZiKAU03pQ1f9xA0oEg+8TV8VAfV52hN2ltiZIv71waMD
	iHvdi501DbKs75qzAziiXNHqqlc+wtHUqvXhd1Ay5HfuqmaThpQRMo79dMgr5PBELk5mAUZiR/2Zd
	n8r8eip4UUJN/nRkBcOy1uwaWb0g1gjbcxGq9ZOyqqGLWLuwGY42h6ya6HqwcPfS2Lhf5fxPgtwdU
	WQW/f7og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGPhH-0000000ChfS-21uo;
	Tue, 04 Nov 2025 22:40:15 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGPhE-0000000Chew-2zqj
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 22:40:13 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-89e93741839so415904885a.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296011; x=1762900811; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=GG4zgKELAkwIUf/NhzWIKG4hn3HTexHUjT6BeMY288M0FEEg0xmqHq5ihSRfxIhO8W
         mZtvdGG+Bd9yJTQKrqIy+GhCX4ztihM7GAxnqJ+/dZ0j9lw5b0dDX4EDIYoA6YDoToZX
         mG+CcaIIgqePHpQTjLK2p6VyK7d+D9CTgthpQrUBcYqDqUlYjQMzQf4e7b4hbGzhkT+i
         AUPMU2oebarTzmU3nAyCSGcKXVXoGSlOjId/qCQ0w3Pt4E6KlLBi5yF9GFKe2sJdliOd
         D1IXcvkJUtJ7zO/dGj3TJCq1pYr1FLtc7E/b0xpC3ii9EHc+0xBLJdQJfQvRD81i1boA
         dBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296011; x=1762900811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=JoASRHxt9jtbVzJLXlSqJZSNHA+K3fbEdI1/GFnyrMG+rU/r1NRybqDB9wEEwbjRGj
         a/yoVxpsJ9jl9tWnuoL6AYrmflZ85NmywRuf052wUfQLSn04b/U+VAIx+O70t51/HPGu
         s/evJmZ0BgR+W6MMc+5KS8d2qmS1Uw6S6K42jUhoGPBoo15DVHBUvlu0VMKR8Sahb8Tn
         rIt9y26Azsjz162rCAvww56LYimeJqUk/f6E6TD4Zb2M8eadcR7s9iDLQADVfj+KEQ4M
         2eA78G+0K8vlpIvdrQqAq1mPkKxhsBtemzwfhMIPZMKZreh55g4RquPFHiSo0gGRfwYN
         VBcA==
X-Forwarded-Encrypted: i=1; AJvYcCW3bBmmTGtIaEJaBVF6nQUzid6KVVapA7EsbxsJ0qAIxXGurpoSxBJHjIFcuZTnp8R+rjGlNdwSsF7E@lists.infradead.org
X-Gm-Message-State: AOJu0YzoANPgZHgh/bJgvhQF2Jz5kZTyCVIfDL3Dblt58wU/BxMl0JDz
	NTEirpX6iYCY5x3n0Z7wu6yIrqWXkrjH0pdL5EfZivznceXJAnddr8yp
X-Gm-Gg: ASbGnctyDrtksDBnV0DU0hnl96m8jhW3+dTLkNC158UMgKGia92rk2M2e37o11hpNpA
	6cR2IrNdLmKh7fziyFmYpjaG3lFAIBOxFE6xN2zEX/oofERqzNznFuETjtRGhKRoJaStUPfNPu3
	8QiPzTuZTYhs8L/a+PhRvUM0pw4waWN0BQM1rw9caNPjVuEC0TO1ennCtTTU4sZuQpiT0Me7JjI
	NuVT+TYgjUNXdMNnAvlgx51wPUH6zL5p9LRJa5kTZQiHQz0d9DgI2BvPkOH31A0RnPoT+3HhPzv
	KN3CBhahZPNwVIr+FMVv4jRQv+Q/q6F7U9xZE+LpsTtJs+IqFGafFgUxDZB6Muoqdfdcc1fPZW9
	eD5pZRRR4y6zpdw6G+ZKGW1lb5N7mssxTyB2jnGtxPvFuA1ROH0r1wz/WznrHBBzMdKmyGPmdqR
	mSguuZLruLMP5GbF3EZIY=
X-Google-Smtp-Source: AGHT+IGVJcQ7+Hm8/Mbp21EWtJYFZbeasKoHxrkrg5KoPSIeIFN3VHq0ULl0RYiT/x4RRTtxCZVdnA==
X-Received: by 2002:a05:620a:459e:b0:8b1:ac18:acc9 with SMTP id af79cd13be357-8b22094fa87mr184006585a.32.1762296011340;
        Tue, 04 Nov 2025 14:40:11 -0800 (PST)
Received: from [10.69.71.192] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f76cde9bsm276498085a.28.2025.11.04.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:40:10 -0800 (PST)
Message-ID: <49d5cb16-7632-4b85-b638-8e8bc1c602fe@gmail.com>
Date: Tue, 4 Nov 2025 14:39:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
 <20251104112535.139450-4-marco.crivellari@suse.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251104112535.139450-4-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_144012_783450_0D924DB1 
X-CRM114-Status: UNSURE (   5.96  )
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

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

