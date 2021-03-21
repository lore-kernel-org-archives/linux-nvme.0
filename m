Return-Path: <SRS0=79y3=IT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A3C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:08:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39936192D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39936192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z6Pj4zpa6YlUkQHJgflx9aF8xWtTXxKGRijAWBdvGSs=; b=amDEB3CA3d7FE61WtmjeQrouL
	2xaeDC4Zk7TCXecyjJllPwQC0nYDFYhpMa6xI/ArdnqzMmmsOhHMuHoj5EpvWw/ekg20+hJwQIs4k
	2tMMA4tAnbc8UKvskVTYPeCQB0iTkrHWp9rWiyhIX48BQO96TESz1tLththe1NBblQMC27dTwCjD+
	dr5EEcI6MTLej4xAlcHFRLvBGmRhypmRc+irmQ/nnY+gl1t3I23KIR1CzY6mQKnsVeJvXJlGSVy8t
	rsv0g0mdL9RoijwOyjISUy4yJRPIaRox6y6ycfN19WkJKIkfZzVkv2jicqJpX0REeVtBN+pGPQjaI
	3QMkRmiKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNsBe-009hKK-6c; Sun, 21 Mar 2021 07:07:46 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNsBZ-009hJq-6U
 for linux-nvme@lists.infradead.org; Sun, 21 Mar 2021 07:07:43 +0000
Received: by mail-pf1-f178.google.com with SMTP id h3so8815372pfr.12
 for <linux-nvme@lists.infradead.org>; Sun, 21 Mar 2021 00:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LU/mKr279SXxXilzaERq1vxgcoaamhFrv6RA4iJzv5k=;
 b=rTOgm+qsU87pxBs8wI84ywSfNoZR8d4TxipOxob4E4oP0JzGDIJC5Azvc06isp9GBr
 RWyGMULkBJjbgEjyqCwUhDczqDmJixS4RMGn7GYbCKm/zKRaMPAAzMBTYsaka5Q+08k2
 DL4yuiGPUsjFmLCVreNerd0HWgDTjqtno3TTupOzN3PXjlRGpVQhM1vKmdAHATMEWme8
 dBG7l3hi7tmAx2MCa6p/r3aT9NDCP0U4h44gd7IIG2DcXicMsx5WQJEMF7UdOrUpQNRy
 GnHsRBkCZLc0jQYN8HZZ4vaGj6AlK8XGCm6prrgl0rywVW8oQbUbo5pCgETnh9rRn1Lt
 JQPg==
X-Gm-Message-State: AOAM530hx7uixdGEbkKDQct3ovyt4NXkrCZIz0pFNC7QRjAtIjar7UgK
 gOvi9X+IrXLt9KK6Q8HKk8QcB75NjVk=
X-Google-Smtp-Source: ABdhPJye25FdsE8Uo+6BcPY4aF9GN0iDMO0HadcnbKfbR8OBUKLGQIakCTycC/ltATT8wZSVH/3OIw==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr18171773pgi.446.1616310459631; 
 Sun, 21 Mar 2021 00:07:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b1ab:c8be:b97:f20c?
 ([2601:647:4802:9070:b1ab:c8be:b97:f20c])
 by smtp.gmail.com with ESMTPSA id 15sm10007614pfx.167.2021.03.21.00.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Mar 2021 00:07:39 -0700 (PDT)
Subject: Re: [bug report] WARNING: inconsistent lock state observed with
 blktests nvme-tcp/003
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <1378655048.19877042.1616170706639.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f1d1cda8-e2ec-800d-89ef-a3690262f21a@grimberg.me>
Date: Sun, 21 Mar 2021 00:07:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1378655048.19877042.1616170706639.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_070741_685240_37BC7A0A 
X-CRM114-Status: UNSURE (   9.43  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for reporting Yi,

I think I understand what is going on here.. blktests are
special in the sense that they run nvme-tcp and nvmet-tcp
on the same system, and since they have causal relationships
it makes sense how this can trigger.

Let me submit a couple of patches for this one...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
