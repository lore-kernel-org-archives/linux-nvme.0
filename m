Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C1C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:13:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4E42078D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epeH1WAq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="IhD1DfdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4E42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0NVUZk/S+JotUSeGkY3Xl2sswUxPGGpIq0RHjctle4w=; b=epeH1WAqYrpM9eQVoKKx1N8V+
	FybSR/zfQL1emOGcjG6SUqQTscDNbBl/YygKhbN9Ae2jTLqSYdcCjHRx7hUMLRS07icIjGWta0Kaf
	PW1OpNwQ3oe25ZFiJIgoz05+Oy3PPlxjhz7c3K0wXJSoHV5uy/WHj7mK4mgxQb+P8PBotT8skeREy
	tQQBtYFPzB5oNFpsWo/7Qcv69x2kRNI9D0uSR0tVYgs3I4kK2ntf2ISo285gPz6rKzWf3+VHToKJN
	DterYYDHx1WyAs4kcyZznTuuWYTiC3UkgDMLA/EThJvmuHse/RqG8C8zAjAbu8of4T3iQVooiSpeF
	V/Tz7dWZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6cKK-0002fP-Vf; Fri, 14 Aug 2020 16:13:09 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6cKI-0002eq-CL
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 16:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zQQYaG4FDva4Kx2gK/oIgniFA8GobjEVeS/gzgpSBqE=; b=IhD1DfdSl/ZKLJrd5qba0ksZ+z
 8lxNamv6hREYM7exVyKMMtHYw5fwjbZJHCe06qrEdrdnaCBwzhk+FGFPPPSwa/5hbVgXOs1KYVg7J
 QQ8Maen2/tc0lzqfU8kaamix6A9u1QDyOkpLHmdClYdjrMqtpnEMXyKYVIUpQ0/FZ01CBHRUJuLgU
 NoMPqqhdGoKys8gUa+1zhX0XolYpnrEPA1yBKakIrclwGldIfeyellBoH884G+gWwDx/Gdo9b2z5y
 zaBG+nY9/k/OfSZJG9zt75ZUIY11iUKOaxaBR83C8FsMw1Xev0Ad+aO4YVHKkdcdTyV2rOOn1Cds5
 g0pUERCw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k6cKA-00029q-Lk; Fri, 14 Aug 2020 10:12:59 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-3-sagi@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4523fcf6-bed3-a3b7-11b5-6246b4d63765@deltatee.com>
Date: Fri, 14 Aug 2020 10:12:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-3-sagi@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, Chaitanya.Kulkarni@wdc.com, bvanassche@acm.org,
 kbusch@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/7] nvme: consolidate some nvme-cli utility functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_121306_509092_7FB47E8E 
X-CRM114-Status: GOOD (  13.06  )
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
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index b841a8d4cd87..7ea539fda55e 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -33,14 +33,14 @@ test() {
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>  	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>  
> -	nvme connect -t loop -n blktests-subsystem-1
> +	_nvme_connect_subsys "loop" "blktests-subsystem-1"

A bit of a nit, but the quotes around "loop" are unnecessary here and in
a bunch of other places.

> @@ -97,6 +97,33 @@ _setup_nvmet() {
>  	modprobe nvme-loop
>  }
>  
> +_nvme_disconnect_ctrl() {
> +	local ctrl="$1"
> +
> +	nvme disconnect -d ${ctrl}> +}
> +
> +_nvme_disconnect_subsys() {
> +	local subsysnqn="$1"
> +
> +	nvme disconnect -n ${subsysnqn}
> +}

Missing quotes around ctrl and subsysnqn.

> +
> +_nvme_connect_subsys() {
> +	local trtype="$1"
> +	local subsysnqn="$2"
> +
> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	eval $cmd
> +}

I still don't understand why we are using eval here.  There are no
quotes round trtpe and subsysnqn and because of eval they need to be
doubled...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
