Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9A1C00144
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 02:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acqGR0kFWSkm/ad9JFTPqiQhrcQMxRZuJPZIwNcUsas=; b=2xRAOrEcPqfBs/yG8+D3c8jO5o
	QHRnSLaN+OiNR/HR83JdWXUSVzH0kuyrdvK2aJibSGB1g83mHO7P5gxl5cIgejrHIlXkpSUWVPzKJ
	JLcHPYb2I6vJ4XZf+6fAWll73eG5l3SkUhEXqDSeFLq9TvUFHke932lkqV5u9pTFbR15ltnOYBPcO
	RJfeRCXY/1avXWx1rRW7CMirlggkwX5zA93aSjnghAPWW0wCtD0OqDAZnDln5lzRT1NOoM5FbjqDB
	DpTnHaCmMHm2QVG5zoO4bBaK7b4Gy4BshWvKfeLW0PfE8ywdfTWL2EwX7wYW5Y+LirAtoohtPqcZA
	x7C+T+cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhGx-009qjh-IO; Tue, 02 Aug 2022 02:04:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhGu-009qj2-Bb
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 02:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659405874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acqGR0kFWSkm/ad9JFTPqiQhrcQMxRZuJPZIwNcUsas=;
	b=UqgUYnY6LTNNQ78f+VkQGb9fEnp4S4q0ecoOydoQ1ZkFC6LPukxbO3935/reB7oWPZMacT
	dCpwJ9NFUCp8n/gysV0by4LmGq3UJYe2d+3IErBgJKYP+Iy1+yEiY+4qSfz4OYLMsq/OLY
	et/cVrfT4SFsSud9USCohcgwih6LOy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-QxWYA7RnNueocftbBVoE_Q-1; Mon, 01 Aug 2022 22:04:31 -0400
X-MC-Unique: QxWYA7RnNueocftbBVoE_Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33618811E75;
	Tue,  2 Aug 2022 02:04:31 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 023BC492CA2;
	Tue,  2 Aug 2022 02:04:26 +0000 (UTC)
Date: Tue, 2 Aug 2022 10:04:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Message-ID: <YuiGJdz/p8Csyk37@T590>
References: <20220721003358.543509-1-ming.lei@redhat.com>
 <20220728160637.GA19898@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220728160637.GA19898@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_190436_509579_25CACC46 
X-CRM114-Status: GOOD (  11.38  )
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

On Thu, Jul 28, 2022 at 06:06:37PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.20.

Hi Christoph,

Looks not find the patch in your nvme-5.20 tree, :-(

http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.20

Thanks,
Ming


