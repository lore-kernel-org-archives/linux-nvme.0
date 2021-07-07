Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EEDC07E96
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 02:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A139E61CB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 02:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A139E61CB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=84OumNx8dl7DxAxRbrk0VyHTaLhkc+e1gpOnbrL+RMY=; b=BtddCXYYdmtkI3
	VBo7RoBcbt4sC0GDgheTN3xO5uOjD+RBYUcYIjuXpJH0bCpb4F+GdHYgO4DvQW0ZT1MHSbF3QXJz7
	yFhqZDmKxk86ADPQ7MQ/M8vSUnjs4CzWyBoUA9VOU+x2+QR/YJiMdoXJ7UoNiCl7oF9pQalkggJ6C
	qDLXexamJwueizT1R9fRxRZOgaBb9D7a5Loq7dPPfKJ4ngQa2U+Cuvd6BkxoKYOuIVnWCSmKxALVU
	2wx7hkNu0fMGt/rbInooJgT4Lf2n7HP51VJPpAemea6Q9Bk+8GDOxcs4Bfvd81b+y/NMVA7eutC8r
	dsj7EUVxOLHIgTcDnEKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0xa7-00DESC-Cr; Wed, 07 Jul 2021 02:46:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0xa4-00DERI-07
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 02:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625625989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/hCAFrVBwva4FwAQ3R2O2B3lOY1+NpCIdMOPkZ0H35U=;
 b=b0/ChPqJvZlioC2f9ydwjKeoIWh482qJMAuKN4uMWPc5SoE4PQo50rCkuGf7vPNR07YYqA
 MnzmXU2/eklhnny+GHI+3F41ZqZ+PlVfFwCrZZ+lTP4jT+12Kr1F+JVcJARrQ7HxByhRKT
 e9cReuPFXqef/jKtTSCMUH779k6RLS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-P-HCtpRpNxexINy-Kay7Sg-1; Tue, 06 Jul 2021 22:46:28 -0400
X-MC-Unique: P-HCtpRpNxexINy-Kay7Sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80605074B;
 Wed,  7 Jul 2021 02:46:26 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B954719C44;
 Wed,  7 Jul 2021 02:46:19 +0000 (UTC)
Date: Wed, 7 Jul 2021 10:46:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOUVdx6VasZNANvW@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
 <YOQYKn+POVR2g/h1@T590>
 <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
 <20210706122121.qicyihexk2qawvef@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706122121.qicyihexk2qawvef@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_194632_281578_DF13307E 
X-CRM114-Status: GOOD (  10.56  )
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

On Tue, Jul 06, 2021 at 02:21:21PM +0200, Daniel Wagner wrote:
> A nvme_start_freeze() before nvme_wait_freeze() fixes the hangers. It is this
> simple?

Yeah, it can be the issue, also nvme_start_freeze() has to be paired
with nvme_unfreeze().


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
