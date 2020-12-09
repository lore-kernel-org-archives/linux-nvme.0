Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72CBC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:17:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D1723B87
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D1723B87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T7NbtoFCCpLfXlGGS29viSykRK0z3SGRtzhe196+Oko=; b=MTI8jAktLAhw3MVaMHWu8R827
	OGRvOKAPTb733hRtQ/kVC1pE4Ht40OchIr3jnNG6hRJKcZ+AU1g82YFQFNKIseHsijFBbHfcOoJ5s
	igL2ywOG3TYlUHeIOwKhFEK6sfSkuG0TVtKlS53batoAH3Cbcl29CzT1e8Gjc2C73DDyMcy/aeQuY
	edXohFgezt+qKv8phfVxJ00bjEdAowNkGq5BOlfJW+V05qvZ5wKw0vIaoRb6J7EjxyLX0XNTWWMic
	rBwyi/4yZSihDtR1Xd3j2r6dq8nLNfrN1/ZfushqGe45HLkoalAIWwAcfNluifGRRpAjtOr1d1l6u
	jbbmIIHJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmuf6-0001LW-IR; Wed, 09 Dec 2020 08:17:24 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmudl-0000YX-5x
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 08:16:04 +0000
Received: by mail-ej1-x644.google.com with SMTP id ce23so811241ejb.8
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 00:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=08ob/p4UnManlSRT0tUy3hrEEI/D3u1JpUunWfKCo5w=;
 b=s2vKpouyMm3wbzMXwpn7cMBaEZ/m4HMqhpTYZ2IMX/HxSeMcfe8wu+Z8sZ9wWBFjzo
 D3KDovVWoSkIqaEvc0O5eEeSuHf+phxmOe2cah5+o1FlLJBMAl9AvGyoK2q0LorhmaDR
 ScGPAu8OsJCyCSx/QAg7A/OvITI5wLSGkrU6ZPaeWWf5vyS34z9x75XFKOTRe3PH3oP5
 ocRW5jc8ndtUPpneuWNw/bN4Exu36iAflmOaFQB9p99q64O5d+hDsYrmP18B4iS4ZWWG
 jLer34Bz6KqFYqSsiwJTiVyLAV7FC5uD14cfduhp7G2eQZLffl82wDa0XhbP84poEO1X
 cmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=08ob/p4UnManlSRT0tUy3hrEEI/D3u1JpUunWfKCo5w=;
 b=BP/k4VwbCtrBEbinpMs3iYVyifwz54rIdY2k3twWU0hyt8immWCVO80HMTv+FGn2di
 TUz6DeeqKEcPWS8oJoHqsfTqlLagXS1T37kz8DjhWW0L+Q3G+Y/ObTa4O4PiRHnF1MlJ
 HAk2+cinnkBirhS8ZmI/JKKuSLlXonz8IjlGHAl8PfH0SjaRNSgRcUmOdr/wcgGPiXVc
 iaBmg4meNy28sbUzP6eEBZ4A5QkglypfzFKInsJDGCMiLd0XEFPBJKH5QvRjMqQ5NlQD
 AGwARZBhE853e/N02cOt/xLo+RCv5Fr5HAL4/+3bxJJC4y++livHf8DRchVE2woZiazB
 FV2Q==
X-Gm-Message-State: AOAM532YJuPm4E1XBMAteNA2HnNS5O4xum/yk49ptjbYSOjcd4iiHDBq
 HVG6XI3GnHu01Jxwuo18AUc=
X-Google-Smtp-Source: ABdhPJyiSTu4RqA4peRiMEDhIuXqyqwqC5BsVz5rN5DsFOBikhejYSZ9hSxYhQg+/A8LNni+nLhlbQ==
X-Received: by 2002:a17:906:f905:: with SMTP id
 lc5mr1064715ejb.177.1607501759732; 
 Wed, 09 Dec 2020 00:15:59 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id bq20sm751767ejb.64.2020.12.09.00.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 00:15:59 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
Date: Wed, 9 Dec 2020 10:15:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_031601_370615_82D2781A 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 09/12/2020 2:38, David Ahern wrote:
> 
> The AF_XDP reference was to differentiate one zerocopy use case (all
> packets go to userspace) from another (kernel managed TCP socket with
> zerocopy payload). You are focusing on a very narrow use case - kernel
> based NVMe over TCP - of a more general problem.
> 

Please note that although our framework implements support for nvme-tcp,
we designed it to fit iscsi as well, and hopefully future protocols too,
as general as we could. For why this could not be generalized further
see below.

> You have a TCP socket and a design that only works for kernel owned
> sockets. You have specialized queues in the NIC, a flow rule directing
> packets to those queues. Presumably some ULP parser in the NIC
> associated with the queues to process NVMe packets. Rather than copying
> headers (ethernet/ip/tcp) to one buffer and payload to another (which is
> similar to what Jonathan Lemon is working on), this design has a ULP
> processor that just splits out the TCP payload even more making it
> highly selective about which part of the packet is put into which
> buffer. Take out the NVMe part, and it is header split with zerocopy for
> the payload - a generic feature that can have a wider impact with NVMe
> as a special case.
> 

There is more to this than TCP zerocopy that exists in userspace or
inside the kernel. First, please note that the patches include support for
CRC offload as well as data placement. Second, data-placement is not the same
as zerocopy for the following reasons:
(1) The former places buffers *exactly* where the user requests
regardless of the order of response arrivals, while the latter places packets
in anonymous buffers according to packet arrival order. Therefore, zerocopy
can be implemented using data placement, but not vice versa.
(2) Data-placement supports sub-page zerocopy, unlike page-flipping
techniques (i.e., TCP_ZEROCOPY).
(3) Page-flipping can't work for any storage initiator because the
destination buffer is owned by some user pagecache or process using O_DIRECT.
(4) Storage over TCP PDUs are not necessarily aligned to TCP packets,
i.e., the PDU header can be in the middle of a packet, so header-data split
alone isn't enough.

I wish we could do the same using some simpler zerocopy mechanism,
it would indeed simplify things. But, unfortunately this would severely
restrict generality, no sub-page support and alignment between PDUs
and packets, and performance (ordering of PDUs).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
