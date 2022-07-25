Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19660C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPzV4GsyKTfsVb7qmwqs501nrfGyvUtR4Gy6dLhO/wQ=; b=PKr5KC7AYF8EJkuQsV7zWGOjDl
	8P50n1XUyZlsjyPIiQ8ozVzzZFhExv7NgQMnDuoMqhntQneNU2pgFM3aWxjXlizYpf4kTP58n7713
	RG6My5KzfKCf+a1bDeDRD0lFwWgYxb/Gt+9Ip017NW+rilz6Y5qOK9avcD+uyo9Y3CKvzi3Y3BxeZ
	/bgLpHQ1PAjDYPaNbNR+AMs/meBbdLNiP/58OCG6oU88jJW4lKPoGJj7ixFeFgFEZrd02ha3TQJAE
	IX4lPpqd/JSADBmxp0xIIdLqs4FzvWIUpRKB6hai7AkqSqJrTBo450VuaSL06sEjOMM81cugePaVx
	QFgo5/OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwaD-0094z7-W1; Mon, 25 Jul 2022 11:49:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwaB-0094x1-Ti
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 11:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658749745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TPzV4GsyKTfsVb7qmwqs501nrfGyvUtR4Gy6dLhO/wQ=;
	b=hNh0jZvUyU9GauyN3Yib8O4q0CT5NVHnLAlS0Wkb82SvhczD96j9BM5MsxKGTe1SYhH0zb
	mBOt9hOxv0d0rsTUKTgEF6RD8G8Pw37QmYPeQKkBUgok2wyS/RIM4jtJilb10tqObPsABk
	drDZseN1FYqrsGeH5YLFsJd++CDuZz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-im1PdhLBN4GFuRKDSKS0Ag-1; Mon, 25 Jul 2022 07:49:01 -0400
X-MC-Unique: im1PdhLBN4GFuRKDSKS0Ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 638B485A584;
	Mon, 25 Jul 2022 11:49:01 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 412881400C30;
	Mon, 25 Jul 2022 11:48:56 +0000 (UTC)
Date: Mon, 25 Jul 2022 19:48:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Message-ID: <Yt6DJBRXyGXbShIF@T590>
References: <20220721003358.543509-1-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220721003358.543509-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_044908_072952_69C4885B 
X-CRM114-Status: GOOD (  10.44  )
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

On Thu, Jul 21, 2022 at 08:33:58AM +0800, Ming Lei wrote:
> Without restarting admin queue in __nvme_fc_abort_outstanding_ios(),
> it leaves controller not capable of handling admin pt request, and
> causes io hang.
> 
> Fixes it by restarting admin queue if the caller of __nvme_fc_abort_outstanding_ios
> requires to restart queue.
> 
> Tested-by: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Hello Guys,

Ping...


Thanks,
Ming


