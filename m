Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E962D11194
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCkg2MqyvbvBZAlL2mUEIor+vLrb1naW+xQwcnP9n30=; b=gefQaAXhTysHdQEq6i/ux+VkIR
	rMKYgrRYbeZVna+OshCVwN2GCtgf1VzfCMdwHrPDMyN7yjbY6EmUlvM0OU2F1+jm5jkuNPDy59F6o
	vUjUOZLNXfk+QgHi+pepAX2xfm1aFLkphyks2207yaUevj5Q3VBDb68JjOVP5NkgG9ToL2SHT3x4l
	66mprLakOXqSoDJpvLhCYCny/wWelsw2Aca4MWIOhtAuAtWRSpXI7zPNPVjQ/J1tMV88mzb5XRXep
	D+unUgDe8azZ2s5ZX4IXRgAfj0ayMgyha2xhk0y/8fdCGXuUarWncG/KNm3sFJ0wQjTLVNADDTsB1
	DoB4gc+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7l0C-0000000CJWg-46La;
	Mon, 04 Nov 2024 00:31:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7l07-0000000CJWD-17CL
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 00:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730680281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCkg2MqyvbvBZAlL2mUEIor+vLrb1naW+xQwcnP9n30=;
	b=MZpDiKy7fvAzfUbJ2e4ya+3iKczhdDMgBNVXEM9ADs0iZMvfeV1fz1Ef4Q8cRDCZTN1dz1
	Hrf3FBXcF68LW+VsSDwpmWsHFXdOv8VjO68NmqHzMG/cvh/jTncSSJKU3ub3E3j1Xm35W5
	lw22dI5EXM3NYncpS1dMjNsodbvTUtE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-p-H_wuOWN7mTg5T2Zx9FIQ-1; Sun,
 03 Nov 2024 19:31:18 -0500
X-MC-Unique: p-H_wuOWN7mTg5T2Zx9FIQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0381F1956080;
	Mon,  4 Nov 2024 00:31:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 970C61956086;
	Mon,  4 Nov 2024 00:31:08 +0000 (UTC)
Date: Mon, 4 Nov 2024 08:31:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 1/2] Revert "nvme: make keep-alive synchronous
 operation"
Message-ID: <ZygVxkjQeOD_Jzy3@fedora>
References: <20241103181450.933737-1-nilay@linux.ibm.com>
 <20241103181450.933737-2-nilay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20241103181450.933737-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_163123_399659_73DAA959 
X-CRM114-Status: GOOD (  11.72  )
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

On Sun, Nov 03, 2024 at 11:44:41PM +0530, Nilay Shroff wrote:
> This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.
> 
> It was realized that the fix implemented to contain the race condition
> among the keep alive task and the fabric shutdown code path in the
> commit d06923670b5ia ("nvme: make keep-alive synchronous operation")
> is not optimal.

One good commit log is supposed to explain a bit why it isn't optimal
instead of "It was realized" without any details.

> 
> We also found that the above race condition is a regression caused due
> to the changes implemented in commit a54a93d0e359 ("nvme: move stopping
> keep-alive into nvme_uninit_ctrl()"). So we decided to revert the commit
> d06923670b5a ("nvme: make keep-alive synchronous operation") and then
> fix the regression.
> 
> Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

The patch itself looks good:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


