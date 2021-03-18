Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78578C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 11:44:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100B064F33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 11:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100B064F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QYVyEjG5VGzGXMvRT584mkn5nCDbFAlTDVeLPP/1KFI=; b=Sb0fmt1OI7tbC108PY+njWV58
	eLiwJEBOskqfXBAyifdyYIZwptmKhKNKg2lwqEWMhCJph2r4BpReL+uhaDrQQ5p6D4xgjOrlOTJbr
	LYhxqqoxgOEbBAjrAsfDgmaiikHo9n4Nj5ZjRNuFhjoFHbHHMX/d7JSTiOUX8KrgaUEumdSydib9f
	V/xG6dD94U83bZ1wZ9a2xhOOjx8tHtnJvE4cxytnqNWOcy/BVg6rQEk4onY+j8V39rQWVnSCPcXCx
	WRjznL9TX4j96xpmANTIx0iksmK/F0iNB5O1dFh6rPTDvAJhcs4+7iActIf/Isnyd+4KG8Tcx6pD4
	2OP0UxH5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMr4v-00583O-P6; Thu, 18 Mar 2021 11:44:37 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMr4r-00581o-QR
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 11:44:35 +0000
Received: by mail-pg1-x52b.google.com with SMTP id r17so1251325pgi.0
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sq+HlX8K+Uboilns8lC4qV56oYtmPENbtFpCHxoVqnw=;
 b=nI0Lgg5BfGq0t+A6cDKYt4tRKNXf8uJt9UsJc1y8xYwCiNZdK5bDywDkZjOTnb9ZPW
 bMUOFXeiUXF+TSWde8s8DGQGzqqFR5yrr4OPnDgUIgVJD+q1IagKqVZhLJR79exdF1/8
 SDDMmwpDlZ6X784ppDeiRb2Sg6RhSm73HkrL1SJ2AVZphQPjf4eh522Rjj3lXk1VagHx
 yA6puch86SzSo3c0IilugDOORb52Afi0XwXwBa8i1fqYNjandoQwoJ1cMpn99C7dA+Am
 n0G3NUkxOJ13t4iSwWQZFgYj2PRWMTh2FwipatqUAUCDiSlDaDqN+USZTOUtEXzq90w4
 OZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sq+HlX8K+Uboilns8lC4qV56oYtmPENbtFpCHxoVqnw=;
 b=eSkdb1Df+Db4cYoQXwVIYgoQ7lNJ+xKY9n+vWMLmFhl+0lUgEJzM4CaGLQ1mlE0Au6
 rShj3vHJ366nQyBorV+x2dLbYqt+0H1/+68Je2FYpGF5IL1BDydvDif6uICFSVcQCx41
 5c9CJPqd6BdS1HrRpKG0M35Iar/j+s92ycdxBA8xNfJ5wIF9/kluIJbLDMkz6kI+qUoC
 d09tFACPjnaZD/omo/KrXor9owcQEi8NiFijvcZBIGdLHe6HiafiGeuDRYSS8asyYML1
 VFwfXHUhgXqh5CvrUhViVPg/Ki7j6jICai4blUNP/Pbwc23xDRYJ3AKdllW8Fznh6cq6
 smSg==
X-Gm-Message-State: AOAM530nFV/Po1K7FZE8o5lOl4XPjDYMGifC88Uc0/QBp0BvlMOQ69rH
 HvZDGDve77sTuOKlLsDdUYkNUyIf8ByRbA==
X-Google-Smtp-Source: ABdhPJxQAqm4cHQzHOP++hDGXV153sEcBPVaU49vbt40jmfMfRjUhbC2bu3O+84agbl16qZ4Y4YuMQ==
X-Received: by 2002:a17:902:343:b029:e6:bc94:48c7 with SMTP id
 61-20020a1709020343b02900e6bc9448c7mr9136844pld.72.1616065991540; 
 Thu, 18 Mar 2021 04:13:11 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id p20sm1971625pgb.62.2021.03.18.04.13.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Mar 2021 04:13:10 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Thu, 18 Mar 2021 19:13:00 +0800
Message-Id: <20210318111300.75883-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210318082834.16093-1-elad.grupi@dell.com>
References: <20210318082834.16093-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_114433_908857_27785783 
X-CRM114-Status: UNSURE (   8.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>In case there is an io that contains inline data and it goes to
>parsing error flow, command response will free command and iov
>before clearing the data on the socket buffer.
>This will delay the command response until receive flow is completed.
>
>Signed-off-by: Elad Grupi <elad.grupi@dell.com>

Hi Elad,

Could you please add this tag to help backport to stable branch?
 Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")

Thanks,
Hou

[...]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
