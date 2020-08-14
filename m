Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137BC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3F82074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOhU9FGZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS0D5lax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3F82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RNApCHju8pYc/nN6xWHwCDPEvktLfMXgfhU5Wj+Ax5Y=; b=bOhU9FGZ0L45Bt5LILOZe9tNB
	Oe+lKCum7/G5MnSdtcO3p1tg50iIvLYXRUktXzaOWYmDeuoxLNivqYzZQ/6gJOsZ5lkYfuV8BW8No
	L18C1+udeypyTZYFkVhyuxeH/auMsYy1n93qESV4t5kPsou5YiZB6DIqZSKMh8t3LhA4pdFkXGLEk
	511+SZiRv14wqIUQ+/TcZz1Er0uqpHclcmCYwwWnLG7IfxyXMrD2qgHVlpcfTgID0HYBjuYSXp6fF
	JVmZg4XoxJby2rvYVtrQWZ125Zppro80i2CAOyaCyj6+THSTtobETSkCC2d033G09vamdfuEIHc3p
	j7LtE3+OA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6XGz-0007tG-DY; Fri, 14 Aug 2020 10:49:21 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6XGv-0007sU-Lb
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 10:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597402156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6gO1r0QjJIKTJ+TFd84x2tinx9ptMc9O29feUY5X4s=;
 b=DS0D5laxAN5nw6VvJj2jXYVXT8C7Q2Ok/cwXKFHRt2ipZSwkMWAyPjKXla40a+h86mM5gf
 BX8iQtqOmd4wsPEYARbw7NLsVWvzSuZ2xpKN7H0J1skXXraA/CX3Vr7L1KrPakfdMrg3EM
 oF1QSyr19ctIxzkUQy4N4/drU1EYHqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-ss58aVESOdW_aZr6sKa08Q-1; Fri, 14 Aug 2020 06:49:12 -0400
X-MC-Unique: ss58aVESOdW_aZr6sKa08Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCA7E1014DEA;
 Fri, 14 Aug 2020 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E017D1014161;
 Fri, 14 Aug 2020 10:49:06 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Date: Fri, 14 Aug 2020 18:49:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-8-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_064917_770465_6F5BBED8 
X-CRM114-Status: GOOD (  18.93  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/14/20 2:18 PM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/rc | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 3e97801bbb30..675acbfa7012 100644
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
> +		_have_modules rdma_rxe siw

start_soft_rdma can use siw or rdma_rxe(default one) module, but some 
old distros may not support siw, but suppor rdma_rxe.
how about:
_have_modules rdma_rxe || _have_modules siw
> +		;;
>   	*)
>   		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
>   		return 1
> @@ -115,6 +122,9 @@ _cleanup_nvmet() {
>   		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
>   	fi
>   	modprobe -r nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		stop_soft_rdma
> +	fi
>   }
>   
>   _setup_nvmet() {
> @@ -124,6 +134,11 @@ _setup_nvmet() {
>   		modprobe nvmet-${nvme_trtype}
>   	fi
>   	modprobe nvme-${nvme_trtype}
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		start_soft_rdma
> +		rdma_intfs=$(rdma_network_interfaces)
> +		def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
> +	fi
>   }
>   
>   _nvme_disconnect_ctrl() {


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
