Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C18AC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 23:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBcr9WsbeIKsnAkSQ/F3sSiJdnnZotvh+jmpVWwHeMQ=; b=k0RF7HgOnCcogsw+abB4421lI0
	D8JSpMg3RUK4xA3MiSjEygqF5QluHboUk3lvxFcFiJ92YUagH+qCQqb8r4v+Qlw1t3fn6dAtSeKkd
	TDPQZow/neseyr7M+N88KRQQUi2twywZo9gJB75MWNXK8CuUNEZz161L+eK2dJWfBovyhGNlahxIH
	0AflTc9pcOQKxzNAdaUFvjzoeNqG1NZe6vMmFjRvPJwBpFynL1fGP8JF1iB4PSOpMwwFHs6qJVCca
	qrcTu8exlDy3SqAu3Aj985UpCPR08/SkNFs8JVrcZW0Jn30X9isWBWhbutX9BhMQR3JslIr8z0b/S
	ouipHXtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4po4-00000007VWa-3oPW;
	Tue, 15 Apr 2025 23:35:08 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4po1-00000007VVj-2UYQ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 23:35:06 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso5849977f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 16:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744760104; x=1745364904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBcr9WsbeIKsnAkSQ/F3sSiJdnnZotvh+jmpVWwHeMQ=;
        b=Va9o3PkqyrTvZatAJcLI7yC8WFA0Kt1lPkQxD0FrNBuU9KgJTLbJT4jEwXE8kDWd4I
         eAy1d6/AwQn8bZV4csZfHbEOCzqZejA2L+IZjfE3raZN/jrcdjD9WZMXr8JM+tRObs1w
         ps5C6Zx+R2xXE4uH7l6Y+fWrjJrnzLJb9YGjnn3ZuOGR9gKQnDpVZ2eD7p9a+FBgoyQU
         xEYW739ebVNON615igZTVYe5cHFm0CyKb+/PzsscGOFXXIlxlDBW9GasFpMFjUEddzr7
         zyhwOz9v8L+MSjVGqYruvg0p/FRnxz9OinXAZI11qnJh7b+7lamRjHf/pKc5ydCeUzCl
         Pq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcjR+cDJikAhSXpC4eRXvcSVpCrhK7BbbMfMOywnn22oXNYzzx7EfLOEapKCfRR0tkaISc2IgCvIyR@lists.infradead.org
X-Gm-Message-State: AOJu0YzCnix/5fdyE9YQuCoJeVuLRAI2321WXk8sfuBJEVrPNXRKfVXJ
	8MUnjLs5gB/s8w8B7LBGLOcPm9s7Prv4AEZHMO/0f/DkzgUEinsZ
X-Gm-Gg: ASbGncsqBQFzAEanGc6P8WyqyD74bVhrLWDyOZ0uUz9aTk+on/F2o3wT9PbgIrnEaYS
	ovTh0W/t+mZkvc8ADDox+Y/8zt1Bh0oYNEKFvJuSw9+jqwxgPSWEXu9ZjxpLk5b2JopbGaPzwML
	s3lWSlOZ6ZzGwFsTT31r8WnLBTuPYyKb6zQpvh4UKH538upJ5gmVjhCgpIgsVuPgWJNg4QsFXIX
	HmR87/GUNsiQT6H4Igc/6aWWENp2vIN3+XKX4wohck8rcNAFmU2z2LlElIRDjRiagrGb9U8yalm
	kn0rfqqnBuh8FFF6h1vRoqpGASEFcXrN3O5yHovnZKDRLWScsycnga5ogLFMrQ/PDW4PPjy+
X-Google-Smtp-Source: AGHT+IGFQoDsrhXlcR5Lo9INVTlZxYBloFpMd7lmfTTWayLAqAGElo+qaSjvY0LXPXIoy97Vsmyhcg==
X-Received: by 2002:a05:6000:250f:b0:390:eb50:37c3 with SMTP id ffacd0b85a97d-39ee27561bbmr970069f8f.27.1744760103585;
        Tue, 15 Apr 2025 16:35:03 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445270sm15341737f8f.81.2025.04.15.16.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 16:35:02 -0700 (PDT)
Message-ID: <8ac6cc96-8877-4ddc-b57a-2a096f446a4c@grimberg.me>
Date: Wed, 16 Apr 2025 02:35:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Randy Jennings <randyj@purestorage.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local>
 <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
 <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_163505_639183_9D483A59 
X-CRM114-Status: GOOD (  21.37  )
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


>> What I meant was that the user can no longer set kato to be arbitrarily
>> long when we
>> now introduce failover dependency on it.
>>
>> We need to set a sane maximum value that will failover in a reasonable
>> timeframe.
>> In other words, kato cannot be allowed to be set by the user to 60
>> minutes. While we didn't
>> care about it before, now it means that failover may take 60+ minutes.
>>
>> Hence, my request to set kato to a max absolute value of seconds. My
>> vote was 10 (2x of the default),
>> but we can also go with 30.
> Adding a maximum value for KATO makes a lot of sense to me.  This will
> help keep us away from a hung task timeout when the full delay is
> taken into account.  30 makes sense to me from the perspective that
> the maximum should be long enough to handle non-ideal situations
> functionally, but not a value that you expect people to use regularly.
>
> I think CQT should have a maximum allowed value for similar reasons.
> If we do clamp down on the CQT, we could be opening ourselves to the
> target not completely cleaning up, but it keeps us from a hung task
> timeout, and _any_ delay will help most of the time.

CQT comes from the controller, and if it is high, it effectively means 
that the
controller cannot handle faster failover reliably. So I think we should 
leave it
as is. It is the vendor problem.

>
> CCR will not address arbitrarily long times for either because:
> 1. It is optional.
> 2. It may fail.
> 3. We still need a ceiling on the recovery time we can handle.

Yes, makes sense. if it fails, we need to wait until something expires, 
which would
be CQT.

