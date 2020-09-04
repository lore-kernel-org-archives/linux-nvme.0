Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F149C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A3E206E7
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xAFZyrjv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHNuSn4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A3E206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zwd4oxK+Hgs+ldGeuHaJ4aIkeSlroszqYrkvYaLcaO0=; b=xAFZyrjvKOFRuqhJATQchCNX5
	fC/qeDfCLbMauZRpEPxT6+EbskWObjdIonXqzb8wFwYhfzHMdcUhy2DvicP9hadxwLUsagcEG3P1j
	xGOJGb9sL3ojn+UE9GDcg8f7PuP5j3Mp8XY+tyvSLWye0Xojgz8LcTQxStvHJcZy2D+EF+U81idci
	magFF6KxsgNuAJMM3j3YFwD8v5uBL6ksd3mhOx+g5mZ/2/e9Mg5S+DwGIxZU4LPXLoS95ri6+QtCb
	hT6as/am2xTTOUp8hayLu2tf6m9XORITKcFqELs9u/4Lwh2dtnBtSnLqEMqDWg0ETTV5fgOSjbOpX
	pbHF1KoCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEF4i-0004yZ-GN; Fri, 04 Sep 2020 17:00:32 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEF4e-0004y6-EH
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 17:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599238825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+34/F/wFBWk0EaC+XvS9T37vZfyDZYXKnTuAPksLxCo=;
 b=JHNuSn4oJZwItoLbzEVR167aJl/NV5zsgaSlq6kp/Sgc0dNs71s9tHTjO3JszwTB7jixRZ
 1AFFZ3LYk5A/12b+mHrGH8dd7pN220NE1zZ3RUCmRP50oxAj+PJb/mkjHMzgTS9S3B0Qg8
 FS+Mee4lJBugTsUuItIlsecYjMlLh0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-J0Jp4bjMO-SazMDGXV11BA-1; Fri, 04 Sep 2020 13:00:22 -0400
X-MC-Unique: J0Jp4bjMO-SazMDGXV11BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4784E100854A;
 Fri,  4 Sep 2020 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-92.pek2.redhat.com [10.72.12.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A66565D9E8;
 Fri,  4 Sep 2020 17:00:16 +0000 (UTC)
Subject: Re: [PATCH v7 7/7] nvme: support rdma transport type
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-8-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <cd06eee5-d0e7-8dd5-1291-545f6cc0c31f@redhat.com>
Date: Sat, 5 Sep 2020 01:00:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-8-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_130028_510424_E5C2F6B5 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/4/20 7:53 AM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/rc | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 8df00e7d15d0..4c5b2e8edf0d 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -5,6 +5,7 @@
>   # Test specific to NVMe devices
>   
>   . common/rc
> +. common/multipath-over-rdma
>   
>   def_traddr="127.0.0.1"
>   def_adrfam="ipv4"
> @@ -25,6 +26,12 @@ _nvme_requires() {
>   		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>   		_have_configfs
>   		;;
> +	rdma)
> +		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
> +		_have_configfs
> +		_have_program rdma
> +		_have_modules rdma_rxe || _have_modules siw
> +		;;
>   	*)
>   		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
>   		return 1
> @@ -115,6 +122,9 @@ _cleanup_nvmet() {
>   		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
>   	fi
>   	modprobe -r nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		stop_soft_rdma
> +	fi
>   }
>   
>   _setup_nvmet() {
> @@ -124,6 +134,16 @@ _setup_nvmet() {
>   		modprobe nvmet-"${nvme_trtype}"
>   	fi
>   	modprobe nvme-"${nvme_trtype}"
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		start_soft_rdma
> +		for i in $(rdma_network_interfaces)
> +		do
> +			ipv4_addr=$(get_ipv4_addr "$i")
> +			if [ -n "${ipv4_addr}" ]; then
> +				def_traddr=${ipv4_addr}
Do we need add break here if ipv4_addr has value?

> +			fi
> +		done
> +	fi
>   }
>   
>   _nvme_disconnect_ctrl() {


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
