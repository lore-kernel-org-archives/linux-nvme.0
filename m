Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52EC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:11:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA622054F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DRYa+2fk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKwTusGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA622054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IedI12xytdHBg2AKKYIxy/vo6EcazvG9yd2IAxuL5so=; b=DRYa+2fk73R3U5Y6hW2u5AXps
	RlPIPRV7768s7Eu5NAi5wJ4mmXeGKaK6iSuvQzWXw1laDR200sQQfItWysXOULIqnT0jyxovRMNfk
	V+46pjJl+Lz68ruZw5a8Ogd2dCOtK8yh09Q4nmrQl9tMUS7d2E6uIeg9Mt5F1PFAjcOh4WOQWphx9
	KgT53DnXq8x/aLYEEsLIEnf3DocoksA2ca+oyvS2rxC6adkIxyVuVWjsGO7z4txntKzjWgnYYdJgt
	lH820RP1yUrwYW/WJvb3tIa3EEe/Wn2YSyczobdXLXFx+yKPjXwL4+aZ6jfg42CRUWBPAKbwBCkE/
	ICVKzsRyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7gnD-0003Yq-Sr; Mon, 17 Aug 2020 15:11:23 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7gnC-0003YQ-0W
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 15:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECXyN5kUbXjepFGjzoTjpZ4/PW0epcTDb14CMVTv2LI=;
 b=ZKwTusGOstbAivn5TnSaSG4qUizeL+u5ZF0Tb/uB0e8dR6TU+1kgLPkF1zTW+5x6KM//cH
 3wetEsTsAZBAgabefh43HnPFfkawl8nRvqAyVkP5pCeBHghnN5Hg9Lce+it8srVfTvbbWK
 LKUlcAYTXQE8FuKna0lME0UraIwrRow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-A2lTqiNMOK2V21xj-tVcqw-1; Mon, 17 Aug 2020 11:11:19 -0400
X-MC-Unique: A2lTqiNMOK2V21xj-tVcqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3CA100A954;
 Mon, 17 Aug 2020 15:11:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC9D10021AA;
 Mon, 17 Aug 2020 15:11:17 +0000 (UTC)
Date: Mon, 17 Aug 2020 11:11:16 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Message-ID: <20200817151116.GC30005@redhat.com>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-4-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-4-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_111122_113027_EF213FDF 
X-CRM114-Status: GOOD (  12.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17 2020 at  4:15am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Check the SCT sub-field for a path related status instead of enumerating
> invididual status code.  As of NVMe 1.4 this adds "Internal Path Error"
> and "Controller Pathing Error" to the list, but it also future proofs for
> additional status codes added to the category.
> 
> Suggested-by: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ah, this is why you carried the duplicate checks in 2/4's
nvme_is_path_error and nvme_is_ana_error, makes sense.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
