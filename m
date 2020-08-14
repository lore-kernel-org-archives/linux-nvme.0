Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F0DC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:24:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE4120774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJxmKzKh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="kAh4/KEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE4120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+cgGiGmvvyI1RC83HA1ZIa5sdoxrHv63vXNdAc9TxEI=; b=DJxmKzKhzUBUUKCZq2bkqfgAt
	2zuUCSL1Lg54kMaBpWmd425WE1fBPcySVCcv1yL9tzLZlMYLkzyNpSyZ3crmuufXoH8BSnRqcd87K
	uKFcrcwlgslHcU5sz0q1bZJRBLlCiI+ovLou9D4x0Siuz5L/fv1qjqk8gSU6tZBRavvBu3hRVQDaP
	YtrJ/tzNGq/DFkBNwH6UuMvu6UOlomiYMOWKyRKGBInu+hyf2VPppZzWPleeihgDpFErqYHufsBAK
	SZf0a/2VL+aVSm25TYBUS4ZKxmeA3BIx335btl2diO29Oux7vUUzW55TcKAidmlz+ETReCyUgdwQQ
	93OK9mwzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6cVP-0004He-Nt; Fri, 14 Aug 2020 16:24:35 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6cVM-0004H8-Vr
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 16:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kh0Xgc5bxfK/3zw8VCgNUFwM8M2Hq7iTnrXUmhoIB+Q=; b=kAh4/KEZlLjUhq+qvu0tbjpY5C
 PTxJoNVnXfZJ5rj1B/Md2In92ZOTgxPvEnSQHm2gH4R3pu//HBw+paarUSjRiHHW8EXwI3b2WCkJT
 VRiQNLPIxTrT6cmufNBgH7e8X6Er5Fc1uhaoHllLh/1PTyxsVl9H1sF5T10QtfVjsie7nYVcXR/Kt
 k06GruMhQp/abtJdnyCutYjHNjDKVrkwNsgX/EDzfmm/H4iycYlBeqxIZoqC18tq9U+q7SdxUalAi
 K7BwRzBQ2vZ5AcI2b1zDXRwZC+RQwTQsnmdwxBY3Um+I3uCmSXtOmpkMGRWQblZqlVjxqSv7N7CXC
 K3Lxiy1Q==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k6cVH-0002J2-Id; Fri, 14 Aug 2020 10:24:28 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-4-sagi@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3418d9be-7f2d-7d01-9a82-25cd79ac8bce@deltatee.com>
Date: Fri, 14 Aug 2020 10:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-4-sagi@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, Chaitanya.Kulkarni@wdc.com, bvanassche@acm.org,
 kbusch@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 3/7] nvme: make tests transport type agnostic
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_122433_046164_A1487A79 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-14 12:18 a.m., Sagi Grimberg wrote:
>  _nvme_disconnect_ctrl() {
> @@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
>  _nvme_connect_subsys() {
>  	local trtype="$1"
>  	local subsysnqn="$2"
> +	local traddr="${3:-$def_traddr}"
> +	local trsvcid="${4:-$def_trsvcid}"
>  
>  	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	if [[ "${trtype}" != "loop" ]]; then
> +		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
> +	fi
>  	eval $cmd
>  }

I think this pattern would be done better with a bash array instead of
an eval, which will get the quoting correct:

ARGS=(-t "${trtype}" -n "${subsysnqn}")
if [[ "${trtype}" != "loop" ]]; then
    ARGS+=(-a "${traddr}" -s "${trsvcid}")
fi
nvme connect "${ARGS[@]}"


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
