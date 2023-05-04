Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B648C77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qNvfYNf7RID1m406M40A6JjHQdIvWallHiWKlOcnlGU=; b=Vc1zg7B0nAQ8n1u9tk4zcrALwp
	MvbkxwlI9O3MCrAANFhFpZNB4vrY2kbcWPo4/nGaJ4CEb0u/fltYrA9MfSnqgC26blfR4PWSS3L1s
	UtqqcV/xgBDUCybKSYV9cAlOAy8kaO9rvM+teIFLSO3N5bxEFe5J3crP2UFSbi4QI2s6Gp4hSTha5
	9YSLPDREUd1cbY+FcfykwXy+FrVO3y1JDd/tB4i2fJY9znYXFZ7aHBGuyAYsNWMMLVtvl93NRx34o
	UVi5vbzSqz3Nf1TvDsshe0J674Zuf6UXx8D16XMbq7q8LNETG/8YWLJCxaeLFXSLEu37pbRUssJiM
	N3e39t9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pua7o-00871x-0e;
	Thu, 04 May 2023 14:40:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pua7m-00871O-0p
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 14:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683211201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNvfYNf7RID1m406M40A6JjHQdIvWallHiWKlOcnlGU=;
	b=GAAsw+EKA9g7HDxLCwXtd8t+L0/rHfLaa+ME5w/Fr6D88yiwW1fkAGVud6jqWn1JssgnBl
	DzlohbBtwflF9U0dk3kQ/y8KKcfkjoK7OyrVnyQlpu5TFCJ+w+6PokE5P/DhnU1DMbhkPm
	5UVMYASMen5b0SXKxXlM9BJFHktHpgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-ktWtk1_JOk-mJpUN8m4EAQ-1; Thu, 04 May 2023 10:39:57 -0400
X-MC-Unique: ktWtk1_JOk-mJpUN8m4EAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3131884371;
	Thu,  4 May 2023 14:39:39 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7E7492C18;
	Thu,  4 May 2023 14:39:33 +0000 (UTC)
Date: Thu, 4 May 2023 22:39:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH v4 1/3] io_uring: Create a helper to return the SQE size
Message-ID: <ZFPDoI8fw0W0A/ZC@ovpn-8-16.pek2.redhat.com>
References: <20230504121856.904491-1-leitao@debian.org>
 <20230504121856.904491-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-2-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_074002_369961_7076CC16 
X-CRM114-Status: GOOD (  13.09  )
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

On Thu, May 04, 2023 at 05:18:54AM -0700, Breno Leitao wrote:
> Create a simple helper that returns the size of the SQE. The SQE could
> have two size, depending of the flags.
> 
> If IO_URING_SETUP_SQE128 flag is set, then return a double SQE,
> otherwise returns the sizeof of io_uring_sqe (64 bytes).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


