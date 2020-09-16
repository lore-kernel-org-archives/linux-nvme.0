Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6EC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 19:53:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3B4208E4
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 19:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OvNP7VDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3B4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cr5xcRGfuzXV5KYa2BBt51IAQl2CrFpnWNP7RhoPLpc=; b=OvNP7VDWYX7roKD7/L2+agfs3
	zz8xQlu05DDyH9fzxYCQGxhrYpM0Xyk38rtWNIpR6TdiHiQaKVkcv/ky3aQsXnqvy08iQKvUnHfhW
	JSgGShiIx+Z8/awkMcOYCwWesH6LWKXQk49QaYLgKyaxFKLwTsviz9ZjaINKAeQj+a/NaCCh64WrY
	BjvW0YVzB6Xvyp1AzhSJRAb2c516ZjzJciCc/j5AV+UJCn3Ocqh9pLib8jFRbJ5lMGOU+8ZnceJqu
	078+3/F1CA/Jn8b83SGJfJQDSwRPEE4yCYHx+AZsARoOwcxBXEuu7Oah9q1YroYwxLCpTdyARZlY8
	nASYuMt+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIdV5-0003xi-Uj; Wed, 16 Sep 2020 19:53:55 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIdV2-0003wc-4i
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 19:53:53 +0000
Received: by mail-pg1-f193.google.com with SMTP id l191so4514072pgd.5
 for <linux-nvme@lists.infradead.org>; Wed, 16 Sep 2020 12:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lbEw7DXZRdNTVdRKkXRwBgXUvuHFLb+dl3ACUzNiSm0=;
 b=TJjJctiuT2ErnQ848OO792LExXQjpgTubjcjNAn8fKgilxSx3OxpcsVi/24C2PXSUG
 ZuMxbH6XYjneCQG2jc/AizXcYZtMrFeGMNI4GgCXNlEhM74QdbrAHtXy/VwHdHLrZdYE
 osbEsSDUXSdqM4wIKtqh8MeyxL1+R3WvFlNB5wNgpanBe49/vi0L1ysbbpBbQJ3cAUqi
 JoaJkV67TX/+GJtQN/SUEJMwPqxfV3WM63ZwetS9uGK2sDW/lIJQpqylU3q86UBLteiL
 Bz6hM1p//LcNFVUsvywSFB/yG2GepaDhRhe1qaQh+9fwJALiE0MBwypPEiGxnJ9MUksH
 ph8Q==
X-Gm-Message-State: AOAM533EcH+gSooFstAloA6Fblnvm8apQdy/D/tahD5yRU7kffRnUCjV
 mKOk9VbZONEK4fkqG7fG+rbn957M96c=
X-Google-Smtp-Source: ABdhPJwwAg4ZZBXjriY+tjYwAU7RippffV06b2KP3kzfOatPeAguRkjuycwnKvdOH9DjR8XjkcTbgw==
X-Received: by 2002:a63:778d:: with SMTP id
 s135mr10267064pgc.219.1600286030680; 
 Wed, 16 Sep 2020 12:53:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5b8f:1046:c134:e3e4?
 ([2601:647:4802:9070:5b8f:1046:c134:e3e4])
 by smtp.gmail.com with ESMTPSA id g1sm3304416pjs.30.2020.09.16.12.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 12:53:50 -0700 (PDT)
Subject: Re: [PATCH] nvmet: handle keep-alive timer when kato is modified by a
 set features cmd
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <20200916174720.12610-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a076b8dd-301f-02bd-c5d8-ef7a29741d5e@grimberg.me>
Date: Wed, 16 Sep 2020 12:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916174720.12610-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_155352_207949_3DBD00C9 
X-CRM114-Status: GOOD (  12.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Amit <amit.engel@emc.com>

Can you please make sure your author reference has first
and last name (that matches your Signed-of-by).

> 
> A user may modify the kato by a set features cmd,
> In that case, the right flow is:
> - cancel the timer
> - update kato to the new value
> - start the timer again
> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>

Besides that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
