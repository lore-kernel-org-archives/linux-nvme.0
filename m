Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2189C6FD20
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3WaaPGOKXIoM7Ijkgh3JmOjc+xfuKH7WyS/qBsk0NA=; b=YScv+2rwgk9CAkaVus4v3Bwd2a
	Xt+kXaaFGPHbp9xgNM7EdtG4bO7zIcWtsJo566WuwVyUyUx+IXvpOnwcV0wADGyVeeeezrc3VQrjB
	GGBDeH/hpEjLqFYJGwGVaPREuYaeV2XRPAOQTMKcMA0PFZqOzbw6gy8aiUUYcrg0VzM30d9d+F2HS
	8GWlyjr4SmSoT9pTgNBrOOoGB3TadeDpznO8iIZ4iv32kVe7NL+zVzdH/fXhVspQGiW/79KKkxwIe
	2FAGU01hfZx0zYd/Kcw8kMBcdqntwwaEW7P12hVaJ3SFvm5OCYDc+G3A+rd9nWD8PVc1TJcNMenhT
	INYcCmaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peiSD-00Df4T-1x;
	Tue, 21 Mar 2023 20:19:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peiS7-00Df0X-01
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 20:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679429962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3WaaPGOKXIoM7Ijkgh3JmOjc+xfuKH7WyS/qBsk0NA=;
	b=UU/0CuEdk2xG583F+KvjzZsmCmD+f7rbBsMx+QLyETGGRnerZMaqOpNLVxUEAPz+g0KqWs
	FgtA4dtLdQ69OJHLEAo1jK5zO5s2dx6fLcTHndCaveCITlgerAVDmRc/nqyn+pvozLzDV0
	sbiE9+CYPY54eiZ++yYqb0s6sbgAAaM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-Wi2yGVl7NYqqQ2Mmx2xL_g-1; Tue, 21 Mar 2023 16:19:19 -0400
X-MC-Unique: Wi2yGVl7NYqqQ2Mmx2xL_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BBD01C04331;
	Tue, 21 Mar 2023 20:19:19 +0000 (UTC)
Received: from [10.22.16.20] (unknown [10.22.16.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E12391410F1C;
	Tue, 21 Mar 2023 20:19:18 +0000 (UTC)
Message-ID: <8d212fd1-5024-6e71-0a01-a9ffd264cbba@redhat.com>
Date: Tue, 21 Mar 2023 16:19:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] nvme-tcp: fence TCP socket on receive error
To: Chris Leech <cleech@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20230320220947.3244247-1-cleech@redhat.com>
 <20230321163025.9437-1-cleech@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230321163025.9437-1-cleech@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_131927_603163_28A71613 
X-CRM114-Status: GOOD (  17.82  )
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

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 3/21/23 12:30, Chris Leech wrote:
> Ensure that no further socket reads occur after a receive processing
> error, either from io_work being re-scheduled or nvme_tcp_poll.
> 
> Failing to do so can result in unrecognised PDU payloads or TCP stream
> garbage being processed as a C2H data PDU, and potentially start copying
> the payload to an invalid destination after looking up a request using a
> bogus command id.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 42c0598c31f2..99ad715210af 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -888,6 +888,9 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>   	size_t consumed = len;
>   	int result;
>   
> +	if (unlikely(!queue->rd_enabled))
> +		return -EFAULT;
> +
>   	while (len) {
>   		switch (nvme_tcp_recv_state(queue)) {
>   		case NVME_TCP_RECV_PDU:


