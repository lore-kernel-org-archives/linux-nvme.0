Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47033606A33A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nOne0Fw1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=loUaB1uv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=10ub3j2HnuKKy3PwQ5fhzsA9SVqKz9iTsj8cAH1973A=; b=nOne0Fw1S6ZHWw
	FgSvzWEfL/w+VKZG3pRvnCo4SZdged5NrH7UJiiVFZ6fJrete27ONxZ6f8mKer3K/vu/skyZqZZwA
	aSAOzUTq9O4zwt7ujbUjm7DbSb4UfNwBNPhBY+8xoPPjfF6Tt6lacNr4PRWH212ijYWm2fkj4RNGB
	4BGSFs8hIa4T0/RGjwANMZmQIpyKLrplzKTO3tECv14anql94cgDD8hty0yxHoZbabCWEY/adfMCP
	/uLUkzpzHnR/dZS5mCPIf4piXn9gxtX8oIdOEqiPsjj1id3NWuzMXV+N1JN2WBeLXKIjxNyecTD4w
	fAyGAEKPxnc0JqoHcNHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTeL-00000003UhZ-2MHC;
	Mon, 23 Nov 2026 13:00:01 +0000
Received: from mail-yx2-x02.google.com ([2607:f8b0:4864:41::2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTeJ-00000003UgG-1RRe
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 13:00:00 +0000
Received: by mail-yx2-x02.google.com with SMTP id 00721157ae682-8b4efdc8e38so741937b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 04:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438797; x=1796043597; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10ub3j2HnuKKy3PwQ5fhzsA9SVqKz9iTsj8cAH1973A=;
        b=loUaB1uvdTglp+SqVs9lhHlXZSFdFx65E7L+YuhRAovoJrSt1u51CfUfGmF77VbvId
         5OEC1YotGCkPJwjMUn5XvgVtTmBTMjzSugZR/ssiYhwLA3T1Xx9YxMZgFlWX9K7w/sKJ
         YHRj6SkdohznhApYZd4ZcZRqxcuuBbYO8a4ir14p1HiEmSfuDd9ywlUD4h0Lq67jiBlQ
         fP3oIfn6dj86iHqkKKONsw892GzTfeNchquGtrv8L7TIqlH91H+fgBDD71pjQe32Fbgf
         WHEY9N2JcSfx0znpYdQUYq6SluMsr3Is9gWCzcOEesXONONREvIlGtnWjwUqTk6fm82v
         6DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438797; x=1796043597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10ub3j2HnuKKy3PwQ5fhzsA9SVqKz9iTsj8cAH1973A=;
        b=0IythvolL8AI1AyftkE8MIDwr31zPTWYsodutTcwVenWxVItbp3rD9ZK74OmvAuEoX
         Ua5lezNQUjgOsGcpz9Pfek8Xt6EQyCZfUCL6fNgkm23rrKDFcg5neEPEMqThYvBdUg6m
         5tUHotVBBW9i4COjulq/WDRGHePXWnpRdwMuFhArslZZ2+SZTHkDhK/1sjI9uR7+e56H
         B1tw7UAXPaIMvCQSimG8iBphXogSM6dhT5ZfK/v5sdra2J/z580VB+jWQINip05vHOtJ
         hPgFWZPNkz8kVgc2bYD+mrDKVyhddSVvzOQsPOKBHWhi4m/FkSAk6gVq1sOas2/M5Jch
         XDfA==
X-Gm-Message-State: APuU4Z+Puy0jMN+PhWy6a45k5/8bhB1B2L1AHzaKw5AWl7OxHU1JdoDI
	9xtDZmQC53nAzAQYYFx1Z82YiHOBtSwoigCg7UiuYBSK3Vi/v3B3n+3+
X-Gm-Gg: AZFdTZcU0lDjhvBClszjYR0ZSeDSvoXlt+MQTc9jNNO1jhWvrZOdgQcO/K5fdCxrIJL
	X68rQdw7RF/hrbK6QhjEBUT3ENWXASaWhCThvZO6SD3nwTLdwqg7hX7rhwQG4dNodPAkuC0AWLC
	6hr6xMZxsz69AZHZPHYdRc1F+B7u9HFxi5ML4NTxS6onAlDV87EJfPNTnYOgpRQyjng3NmBOgKD
	Iy3+73B6KyplKqaL4xdM0fIs5CRRFM5EA0krt7u8g2QeA/9UaWEJLgLBqIAZIcqC2li4BNTMvwa
	ndzpY1KzROUdgPil/nn8zqtG9YGbbV/1YlUGuRDQjcgtDGG6UK8asvqFKVrq5ke2kCovd1NoaJ6
	vFilc0Gj7EFfOkb0g9sU87pAf9xusWfPgOgiGP5Viz1WauMPKl2lOQrX8KxlDVpQRH3Jd4Yaxhu
	nOlKlrc2MeTKPoE5p+tlQxEhCPCOUA2AJZe4aPXneB4bZJAggnfB9LFSjNqAg30k/ZicvQSo/Vw
	rGAID7VuVM3dGKw84taE+Lm+2iPZxQ4tPBAVqZAIg6alfGDjy04nc486Kaaah/qwasoRd3IHggQ
	pY1R+cY/C3KGBp7rOFGn34GErig7eh3n64g=
X-Received: by 2002:a05:690c:d1e:b0:8b0:a30a:7f31 with SMTP id 00721157ae682-8b5204efc58mr42287557b3.29.1795438797153;
        Mon, 23 Nov 2026 04:59:57 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52034f7absm44537587b3.41.2026.11.23.04.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:59:56 -0800 (PST)
Message-ID: <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
Date: Mon, 23 Nov 2026 07:59:56 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] nvme-auth: switch to use the kernel keyring
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_045959_421523_B3875E02 
X-CRM114-Status: GOOD (  14.11  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/26 07:14, Hannes Reinecke wrote:
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring.

Hi Hannes,

How should nvme-cli determine whether the kernel accepts a key
description for DH-HMAC-CHAP?

I will add DH-HMAC-CHAP support to nvme-keysd. It will import the
secrets into the .nvme keyring, the same way it imports TLS PSKs
today, and nvme-cli will pass the key description to 'nvme connect'.
On an older kernel, nvme-keysd must not import the secrets, and
nvme-cli must pass the key data instead. So both need to know what
the kernel supports.

I see these options:

1. Check the kernel version. This does not cover backports.

2. Use a separate option for the key description, for example
   dhchap_key=%s and dhchap_ctrl_key=%s. nvme-cli would then detect
   support through /dev/nvme-fabrics, as it does for the other
   options. It also avoids having one string that can mean either a
   description or key data.

3. Something else. add_key() fails with ENODEV when the 'dhchap' key
   type does not exist, but this does not show that the connect
   options accept a description.

What do you prefer?

Martin

