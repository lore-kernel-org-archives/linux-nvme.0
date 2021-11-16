Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E62C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ACC6187F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6ACC6187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syvCPzOGpcMaWlCywLFWldJ+YXZSIwXB9LUq+A+lNpA=; b=i6LjQdZY8agZLSK+xw046rtUAw
	R0UYCGJODD/R0Ap7m+fdxB7vu+SxHXi3MRiLscmBNaJrbBwS9m45SMSvlo8RTsDcrUDiLwTqOVHgU
	nSm19CE6Ju/6agQ/iAqmduCOu3hQBblM2Ky6B8m3HFGAjtAw2pnaDiIR7cfftuwNOsdJljmjws6g6
	lELbjM6xQjB6cjobQnf5UVsOBBmy51f6JqAr8Lvc0VJPW7mCJ4YIfz7rNtFk9GljBof//E5qi39Gd
	NWWAff+6a11B/6SJrgN1VZBhTcJugmQ/lRgscufQLKZ9e4vIzbYZULsUML5ZVLqNAFo9auUej58/M
	3QR73uKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn2E6-002S5H-LX; Tue, 16 Nov 2021 17:26:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn2E2-002S46-2I
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 17:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637083589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syvCPzOGpcMaWlCywLFWldJ+YXZSIwXB9LUq+A+lNpA=;
 b=b+qFLghkzMS4RrNCKnjiMGWSjNCu6oCQlEFqkQvLBW0pKOt2xl8QYvISsnaZ4hCg9Sw3zZ
 XJRT3k+p6XRFMMEfqoGKUp4RauUm+L7MSVFbfhs10c8O0Eb4Df1AZBxJA8XhshAGdllYhm
 l0zDfIMDeCQY2ue4bUirSinb0PsjVro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-hgK8vFnpNJSe4a6aBXF-Tg-1; Tue, 16 Nov 2021 12:26:28 -0500
X-MC-Unique: hgK8vFnpNJSe4a6aBXF-Tg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C6A387D543;
 Tue, 16 Nov 2021 17:26:27 +0000 (UTC)
Received: from [10.22.34.91] (unknown [10.22.34.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72DCB5BAE6;
 Tue, 16 Nov 2021 17:26:26 +0000 (UTC)
Message-ID: <08eab849-31f7-2a73-aec3-b73c34d39293@redhat.com>
Date: Tue, 16 Nov 2021 12:26:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V3 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
References: <20211116154920.87279-1-mlombard@redhat.com>
 <20211116154920.87279-4-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20211116154920.87279-4-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_092630_238323_5BBED539 
X-CRM114-Status: GOOD (  20.07  )
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


On 11/16/21 10:49, Maurizio Lombardi wrote:
> If a reset controller is executed while the initiator
> is performing some I/O the driver may leak the memory allocated
> for the commands' iovec.
> 
> Make sure that nvmet_tcp_uninit_data_in_cmds() releases
> all the memory.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 786b1440a9af..605aa2a8ca53 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
> -			nvmet_tcp_finish_cmd(cmd);
> +			nvmet_req_uninit(&cmd->req);
> +
> +		nvmet_tcp_unmap_pdu_iovec(cmd);
> +		nvmet_tcp_free_cmd_buffers(cmd);
>   	}
>   
>   	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> 


