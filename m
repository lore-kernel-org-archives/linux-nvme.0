Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF8C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 14:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF7C61164
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 14:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CF7C61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQb76jDp+PLS9eLpD+I3MLHWGSs2NtSfcP+qMh0193s=; b=MwEBbJ+ZCumdxr
	1mUp4HGFxrxcrRvPGKlsd5KpLmZrkc5ivUFJD4no+KFH4wYL3iQhCHpEPNKwDLUPcEgqdqhN8sAQL
	y3/B3I/f3z83lwObAWZRlY9CZUqz9xasQ033oWzfLuCRfPpeeJfz1jHkorLkr0dyBuqDwf44P4Sif
	ZCcVvlI5OyoVAqQITMqJP40rtUZMV0RhCgVMe6XdQtEhV7AE6cl/B3hKlCKN0nQq/tzDWVWWrjoXR
	VDCyaiCKocx1yePimUcVWf6D4bERdWpdrzyte93P/vysa4QiOI/6ulJu7/UJMMFvbItv0iAWfZMMv
	7f7bpTHAh1ognlyD/CMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQVcW-009HTN-HZ; Wed, 15 Sep 2021 14:10:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVcT-009HSg-Qx
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 14:10:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27263611C1;
 Wed, 15 Sep 2021 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631715037;
 bh=o1RZ+rnjQy03mgmPbQEm4226XZcLgz68RrT4HBoLfeA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mDy1ibDLBrmrzsU28P32A3nQhruDWqgB+5z6iTUpuaHsnF9QPAlcmEWVao/EK5plS
 xugcXzV9aJcWGRQfyZmcwSpglrE0O7o0A6FKeIK5EsW+Q+kTXjZYLt1RmqQJqmTUQK
 bxX8PywzN2E9m8wKQ63sisIAZ6iEe/+QjwcZrHq3whMk/xfu6bksJMireE0vX1a/RZ
 NQ/fVRBJCqQEvZ+DZ1PeKPbacTIWgXULQ7hCggzplr8MfkGts6NY4O/LafvgVs/DFg
 JDrL6HqINOR2E505Mm+arVJRAYKf6jMWhTUGXZ5+v+CDyHdw0zFDFXPCVfKLgY8dk5
 +cGPVDZ76j8PQ==
Date: Wed, 15 Sep 2021 07:10:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Message-ID: <20210915141035.GD3778445@dhcp-10-100-145-180.wdc.com>
References: <20210915072006.956307-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210915072006.956307-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_071037_930702_6832999F 
X-CRM114-Status: GOOD (  11.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 15, 2021 at 09:20:06AM +0200, Christoph Hellwig wrote:
> +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> +{
> +	struct nvme_ns *tmp;
> +
> +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> +		if (tmp->head->ns_id < ns->head->ns_id) {
> +			list_add(&tmp->list, &ns->ctrl->namespaces);
> +			return;
> +		}
> +	}
> +
> +	list_add_tail(&ns->list, &ns->ctrl->namespaces);

Actually, this list_add_tail() looks wrong. If the new 'ns' has the
lowest nsid, then we need it added at the head, so this should just be a
"list_add()".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
