Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91632C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 19:07:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C442722256
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 19:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C442722256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BioM1wRJ1iOCvzW6/SoC1R3xqWU3Pq4cTHvO/FWop7s=; b=F13QsJ9mo8huR9CJnNNfV5sp8
	Bj/+HXG/+/ii473apf8mRsxvBkNZbMbtY4CY/9KtXMdjvQeZDLBMgphn6fRk/+9gDgzx3e/auCtnd
	aTbTS8z+iISIUC9DiZUBiuMS3F2t9c2OC1epAmYd8PEQ2slJqN+vocsnE2E/AQcVrym9suJL9STc0
	1SHcf5jzBIjNj4gEjZPpvVpZAcri1+YLcm9PQV/84HmYvBA9vq7yU9niQRrHFJS9DZnNTybMua78S
	uEzVkgudM9bODCm8pa1RAci45eeiIe7JhxtfvynW10EydQyKLEyReQQIfpLJ9P3hMNrTJZbEn/V+H
	JoLjWIzBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkXTO-0008Jk-26; Wed, 02 Dec 2020 19:07:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkXTM-0008JG-CP
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 19:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606936047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyPnByql6hDKb++n9qwMPEM+6fVfKn8Oppnc5Ohl5K0=;
 b=gtcVUyzF+wVrgjtihv/bKeGl2rtnHgbIiwAHzv4pmDZ17MUUKSvHBgD1ez5F9zR4zSevPN
 IGXfJuDAFIksnMCqNTdr8SE5qCOC+kDy/0h6vkXNCsdj6bBWDYcL+QaDLSuyZ5icSJQGCB
 nbgUUddd9owsaVf27gu5IlKL9+SEsUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-OCx1hdEmPci61uW7KC8THA-1; Wed, 02 Dec 2020 14:07:16 -0500
X-MC-Unique: OCx1hdEmPci61uW7KC8THA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49CB8145E6;
 Wed,  2 Dec 2020 19:07:14 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4836060F;
 Wed,  2 Dec 2020 19:07:08 +0000 (UTC)
Message-ID: <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
From: Qian Cai <qcai@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, Christoph
 Hellwig <hch@lst.de>
Date: Wed, 02 Dec 2020 14:07:08 -0500
In-Reply-To: <20201130023606.GC230145@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201130023606.GC230145@T590>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_140728_462866_4472761B 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.garry@huawei.com>, Bart Van Assche <bvanassche@acm.org>,
 Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> Any chance to take a look? And this issue has been reported several
> times in RH internal test.

I suppose that you will need to rebase as it does not apply cleanly on today's
linux-next.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
