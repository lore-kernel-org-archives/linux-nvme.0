Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DBC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvHjox96ToDS6v8WQFCM85pSp37qrGwYc/dcWxuXOUk=; b=Iauc8PV8qR1Dul81fVB/ESnifO
	F65SXFs8a8Tgf9udZ3i8XzW17Pnkkc2G+IOyv2vRZXxT3PqkWEYhkAWuf1OpJJo+jouFWUS++rWSf
	Nk4PT2gjS6UrTxFyAZSIdDR8cv+MNAmy2j3WwUFOrtKrO3s2d2VCOBnQ/3PxKjKHrWOMuQdHJKhlh
	oKX2wLJOD5c1wUPHXWpew2sr7YdBRRhuvYq9y2pImk+HmKd0ePgNwlygWvDvEF3B+8YLiPGjDQDwp
	+NeEIcWJCLZJJYB0b5BoF8J0prI0SL8FXaFIzJlGjmI4ZqRhBpl6uVoUl+CGLfoNNqUmRS6s46qFm
	rKNW9TGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pua8N-00878q-06;
	Thu, 04 May 2023 14:40:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pua8J-00878F-2m
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 14:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683211234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uvHjox96ToDS6v8WQFCM85pSp37qrGwYc/dcWxuXOUk=;
	b=MeJpYX9M6DsnD3veLfn+MJI/aDm4p2cwdXZVrwEaBbD76hdfm5gmlPM2xCw1JsE7K+qNWj
	54+NqNvu9WY9bxyoTzwBGZZlW89sXyRRy6dYFbAdq5rZHaavuG/4GeNmw2GTFNcymp2qh3
	nBid82PIEumprLjrOg6gQqn6xMGMd3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-K-Hn359RNia3YVI7sMxXKg-1; Thu, 04 May 2023 10:40:29 -0400
X-MC-Unique: K-Hn359RNia3YVI7sMxXKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B42588B7AC;
	Thu,  4 May 2023 14:40:28 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B0040BC799;
	Thu,  4 May 2023 14:40:22 +0000 (UTC)
Date: Thu, 4 May 2023 22:40:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: Remove unnecessary BUILD_BUG_ON
Message-ID: <ZFPD0c2dxQT2N9+f@ovpn-8-16.pek2.redhat.com>
References: <20230504121856.904491-1-leitao@debian.org>
 <20230504121856.904491-4-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-4-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_074035_971031_FD7B29E6 
X-CRM114-Status: GOOD (  15.81  )
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

On Thu, May 04, 2023 at 05:18:56AM -0700, Breno Leitao wrote:
> In the io_uring_cmd_prep_async() there is an unnecessary compilation time
> check to check if cmd is correctly placed at field 48 of the SQE.
> 
> This is unnecessary, since this check is already in place at
> io_uring_init():
> 
>           BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
> 
> Remove it and the uring_cmd_pdu_size() function, which is not used
> anymore.
> 
> Keith started a discussion about this topic in the following thread:
> Link: https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


