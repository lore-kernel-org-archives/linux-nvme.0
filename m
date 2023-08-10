Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089D7C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9IC9WjK6/pfODX2dp9hqnuooJTGySqEw/NLcTdVdN4=; b=zzsU6hRHV1aDwBY9xE0pMAEugN
	0raDTmpbVoX94TC5eKgI3a7Xa+hc6q88D+kw2QvTEetcyvslAd4icHxZX32nGK1gdbTsVJrrKrqJ5
	n8BJp96ON9JqRuaVvYYADuZyQvqwpv0P3WfmuhsWS5tkjENTENfMOelPYU9TEhBy1eGgu5mKf6tzC
	hEcLpZGVeQ/ineZIU56I5GUQQthY/hD200ex7xVMrJwkzfwAcy9/rCo23nn/ntYpZ+k9HxMXironT
	rkOWqrw7tFdilQxWbzlqbtgfp8GXRoYWUcydL4q6PPA01nvQqgeHbdY8KSIomDxa6WavK3qwb1fzb
	kFhIoRjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4OR-007XAc-0F;
	Thu, 10 Aug 2023 12:03:55 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4OO-007X9t-3D
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 12:03:54 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99bded9d93dso22227866b.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 05:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691669029; x=1692273829;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9IC9WjK6/pfODX2dp9hqnuooJTGySqEw/NLcTdVdN4=;
        b=Tgb42wvuBfr2CI+cuu1GCNiJDilT9LKovqRsrM732BJNQRcOZLGiBoUfvG12W63l1U
         /vj1Jf7h8rjkMjBAdPYMRAuhGhJhKwJvhqX5IFvv//56+948eKRnmvGvmJko/hktG2mM
         QXRPWRRz4cCz66cVpPXAHQwHzBDHLwTNs8aocvuHjKffTtF13xUs/4Czgktr4otZT8Sz
         hWZ8myEV8+tVM0pO+YTqRpBAl9CubBBsbaUrnrnRupnsUNULaYLdJrp8eMJftXFFTS8N
         zo05A+tQWQcwSuQ8U3kUGma8JUrdc8neg6bCJHCgopSrjEnM18tT+6YUem+9FI5ebe+T
         fw8A==
X-Gm-Message-State: AOJu0Yy6ytd4IXO2ssMA0Z9NRrda+j7Hi0RPHAkcALJsrYzQqUZAHSBn
	QPj0Y1a94A8dnFOIAaEhZiUPJvAFjdg=
X-Google-Smtp-Source: AGHT+IEICYQbDoAcBBdSGW5VnU2Qsd2JfXMlxe0gRgeDQalllxXX245T2b8GjEpzmJESsBJndwGT1A==
X-Received: by 2002:a17:906:7395:b0:99b:d682:f306 with SMTP id f21-20020a170906739500b0099bd682f306mr1540224ejl.4.1691669028986;
        Thu, 10 Aug 2023 05:03:48 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kq20-20020a170906abd400b00988b86d6c7csm845418ejb.132.2023.08.10.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:03:48 -0700 (PDT)
Message-ID: <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
Date: Thu, 10 Aug 2023 15:03:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_050353_054245_F8ABF037 
X-CRM114-Status: GOOD (  18.14  )
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


> Currently nvme-cli is able to resolve an ip address from a dns name if
> traddr argument was given as a dns name, so it does that and passes down
> to the kernel the resolved ip address.
> 
> However, if the dns resolution changes over time, the kernel will not
> be able to reconnect because it has a stale ip address. While this is
> not a real use case for nvme subsystems, it could be a valid use-case
> for discovery controllers, where the resolution is made from a dns
> name that may load-balance/failover over multiple endpoints.
> 
> The last patch (7/6) is for libnvme to pass down the traddr as a dns
> name if the kernel supports dns queries.
> 
> The inspiration was taken from the nfs client that does this for
> redirects or locations discovery.
> 
> It is an rfc, so feedback is welcome.

So I get that there is zero appetite to support this?

