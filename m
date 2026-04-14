Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE6F9D0F1
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KYn6Tp7TCb8PO6v6nOJyHISO6TATD4M37skpVUjHfKI=; b=b4gqF43vUlro8jXsIUbZwmGdqt
	iyKJXw1Wc3W3emt686UAY8IDRH0KtDMIKqnD+AYhgc8DuV35kc+CfJM4RcAxC8BBA0VnrlsG2H6AD
	uW28XVz7jtIAcBLnCVZS/ZZze37svINMfcILWq1eo7eqGRyXsvKinxPjbL7iLVXDrbeYBl3dV1KiU
	erYb4wXoEM19qWmYC51TuJdc5NBreks74q9Z+DbwshnD7+gRbb/ub+PT97iclxOUCOu8pUoRen+Y5
	09YUtsU3R2Qs2/UjrOJVx/DEbLcly139IHwb8jGAOi7zlX2/v2nEN6mCjnPENFOY837b6jPViBdDG
	Gzz2bXeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjFP-000000008X2-0LgH;
	Tue, 14 Apr 2026 19:16:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjFL-000000008WH-2DI5
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 19:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776194185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYn6Tp7TCb8PO6v6nOJyHISO6TATD4M37skpVUjHfKI=;
	b=McylxRz56WTfovZbGKLUKTJoiHzdyLEo03M7VvIJZLW5Ve9fwAGQjQ3+g/HKBpcOz+11GP
	QJo80KJ+W4J7Z+35CQyay1MsU9dSajfvCj2InXYOng8ryim0nqDv4MCGbWaQtXFhKrttxw
	lx0XY+if0SFyEVCd97vPrg/xY+HAhCQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-ZMUdt5RUOmWylmR_jTcYTQ-1; Tue,
 14 Apr 2026 15:14:55 -0400
X-MC-Unique: ZMUdt5RUOmWylmR_jTcYTQ-1
X-Mimecast-MFC-AGG-ID: ZMUdt5RUOmWylmR_jTcYTQ_1776194093
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8509A1800870;
	Tue, 14 Apr 2026 19:14:52 +0000 (UTC)
Received: from [10.17.17.11] (unknown [10.17.17.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A1821955F42;
	Tue, 14 Apr 2026 19:14:49 +0000 (UTC)
Message-ID: <cd6f6857-729f-40ff-b3be-51db3225d983@redhat.com>
Date: Tue, 14 Apr 2026 15:14:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/8] nvme: Refactor and expose per-controller timeout
 configuration
To: Maurizio Lombardi <mlombard@arkamax.eu>, Hannes Reinecke <hare@suse.de>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, linux-nvme@lists.infradead.org,
 dwagner@suse.de, mkhalfella@purestorage.com, chaitanyak@nvidia.com,
 hare@kernel.org, hch@lst.de
References: <20260410073924.61078-1-mlombard@redhat.com>
 <e7a5ab7f-722e-4767-a9a6-2a1ae73bd8b7@suse.de>
 <DHRX0LGNILAX.LTFZVPDRLGOH@arkamax.eu>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DHRX0LGNILAX.LTFZVPDRLGOH@arkamax.eu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sV8wZV5I-8nHEhJ7RbaqNp-DxSTokWck1U9QPDQBASk_1776194093
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_121627_640085_48DB550C 
X-CRM114-Status: UNSURE (   5.58  )
X-CRM114-Notice: Please train this message.
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

On 4/13/26 5:21 AM, Maurizio Lombardi wrote:
> it's worth noting that unless I am missing something the user can already
> trigger this exact scenario today by setting an I/O timeout lower than KATO,
> using the global nvme_io_timeout module parameter.

This is true.


