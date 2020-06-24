Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07868C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:25:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DDE20836
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AKY+v9GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DDE20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7ePB70aFSRCQswsFBRFEjCYqaiPTRf9d4IIK4vkHJ2o=; b=AKY+v9GWgZwM83gluaoJrXYzL
	c8L+9Zs8Wq4NDtjioqfu9CnvCVSIddawuLV41vfuvaTWZhkG/2q33i+fZVKYsWtTJftyICfkWzEc9
	r9rR2Q6xIIfKooo4Mfko/B00f48k71TnS+/bf791N8tvenq6u7KjkNXiSCBcYCtA9sDCNVuO31vec
	KWnkirdixTXr0SW7+6xCTICR8MS4c08DQbNE50UspMbwbrfFRR0PP6D2A7gpCeud+GW2NPpVm+hIL
	XswXkgLQgKBFNO3LU1Us84h5ikCCOJradRP3ZwpHVOhHn9lieYLpRNg8JUj7rM/96oSuCKOk5ZRIw
	pMuVf8Rvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joBxM-0004pL-9K; Wed, 24 Jun 2020 20:25:16 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joBxJ-0004o0-5z
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 20:25:13 +0000
Received: by mail-pl1-f180.google.com with SMTP id y18so1567027plr.4
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 13:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xwebOlClEy1WdYHf9J+tTvBEqIcNQiGH1pQ/oc84nKo=;
 b=aDEXnRtt8AzOkE6SHFIuX6kPb4mCXZiH/sun165JHwDnfozyunJdPYJOrXqb3Ki1lg
 EU+g8o3JIWLEtzd8kqzW3B54yJgb0rvtmAAW1OGBEisA5q3SXr+LwQ3a0VL6L+hBfcLF
 18sYFjx/JLko8rrH3GJvVQaWbKzQ7hVud6A+lbhJVnWKfR7Eel94geQafzZbdLh2vWYl
 JWSv7RJFrd8y1+YCOBeZnsA7+bhrrLJbOI4g4ZIK2rY8so+7qOcFaAyAH66fFD3VwCud
 GEEoq8whBQN02yemILYII5hvuUCfPAvrz/pfl/uQsMa50a33Ync7HeoKBpwo1G4CGi8x
 2lag==
X-Gm-Message-State: AOAM530cy58f8MX6fSL0RNS7ZkiCoU99h7g6pd8LW812XAO8He0wW3pt
 mmU+7ReuoylYu885BFGcuRc=
X-Google-Smtp-Source: ABdhPJxI59RNtyhMvYEUWMSYhHO+kGLjQxiqLuZiSc/dQ8Gr1wq9TMrzSBPgAy0mrEw5MTINLAa6rg==
X-Received: by 2002:a17:902:b107:: with SMTP id
 q7mr30398144plr.266.1593030310180; 
 Wed, 24 Jun 2020 13:25:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id h15sm18539827pgl.12.2020.06.24.13.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 13:25:09 -0700 (PDT)
Subject: Re: NVMe over Fabrics transport requirements support
To: Boris Pismenny <borisp@mellanox.com>, Alex Talker <alextalker@yandex.ru>, 
 linux-nvme@lists.infradead.org
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
 <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
 <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
 <75010fdd-36dd-2ac0-a658-4fc7070744f1@grimberg.me>
 <3a774d39-f786-bdad-0dbc-1dd0e6a56a15@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d0fad47d-d67b-0d0f-5a75-cc73aa0c5ed0@grimberg.me>
Date: Wed, 24 Jun 2020 13:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3a774d39-f786-bdad-0dbc-1dd0e6a56a15@mellanox.com>
Content-Language: en-US
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
Cc: Or Gerlitz <ogerlitz@mellanox.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> I have some early-stage patches the enable NVMe-TLS on the host's
>>> receive side and on the target's transmit side. It requires
>>> some TLS infra work, but the real problem is the userspaece side,
>>> as the TLS handshake cannot be in the kernel. Consequently,
>>> nvme-tcp must be modified to use sockets provided by userspace,
>>> and I suspect that this may be controversial.
>> Yes... That part is going to be annoying as hell. It's unnatural
>> no matter how we tackle it...
> 
> Annoying, but I doubt that it is worth adding the TLS handshake to the kernel to overcome it.

I tend to agree, I've heard that Trond is looking to do something
similar with NFS rpc.gssd but I wasn't able to get a hold of him to
share where he is at.

CC'ing Chuck, whom I've briefly discussed this with some time ago.

>> Please do note that there is ongoing update technical proposal on the
>> NVMe TWG to update the spec to match TLS v1.3 (not sure if you are a
>> member or not).
> 
> Yes, I've seen some draft for this, although I'm not a member.
> TLS1.3 is supported by KTLS in the same way as TLS1.2, e.g. the
> handshake must go through a userspace application, and the data-path
> is in the kernel.
> 
>>> At the moment,
>>> I'm busy with other things, but I expect to post an RFC after
>>> I finish with my current project.
>> Great! Looking forward to seeing some patches for it!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
