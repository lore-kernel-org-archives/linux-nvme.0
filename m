Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AD4C7EE2E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ai904PU5tZSyzOhImHs8NZvABJ0V9E9IGYDkNgwWjGE=; b=LKJ18F7lER5PRxvHRRrVO2ilQE
	ZBe+zo2EGchWkzb650gPCnheCEdsf3D5DfXa5n0e4OrIYYMxWP15KOSdDGhCAI173G9vMWSuBlQws
	0vSaFONkq8fshWggKUWyvdHof9yXyvgskJbaOovWoFcMf/EByQGn83Cm4QzJX0tOFpVa7fjw62piO
	R0tEBbw/7clGZR01MZx4iPT8aAQV7pkboKHDi9AGhyNWRmLMu65tXukmK9jZ3I34WCGBG0f/AVycB
	KbJ3rxVxl7qbct3rC0BPfCyalP1wt0fXXtk465ASCY/eXIg+zHQuulFu3cOlFRm7Estv0A/pEUWbt
	q8A+Pdug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sPp-006Vdv-2V;
	Tue, 13 Jun 2023 01:01:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sPn-006VcL-0N
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 01:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686618102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai904PU5tZSyzOhImHs8NZvABJ0V9E9IGYDkNgwWjGE=;
	b=SD4dOVfXbUYKWLTKw6JxIEQHMWeu52eW/290esGmrX3baihsw8CyJPQ4S/ANRq7WH5ztjf
	rpGFQaNmMp8gQzgt+kLrRcDwhbkPv4uudo976C7oRSThndZXkYRBk/62lzC7f5pR8iswzs
	hq5SEbQ9zBYm25apUbUKwAMma16zmLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-nDU0hmGwMRCe7h-Oy5152A-1; Mon, 12 Jun 2023 21:01:41 -0400
X-MC-Unique: nDU0hmGwMRCe7h-Oy5152A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7B3801224;
	Tue, 13 Jun 2023 01:01:40 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52690C1604D;
	Tue, 13 Jun 2023 01:01:35 +0000 (UTC)
Date: Tue, 13 Jun 2023 09:01:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Message-ID: <ZIe/66eA5TMeYZ1U@ovpn-8-16.pek2.redhat.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
 <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
 <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_180143_227461_961F37E7 
X-CRM114-Status: GOOD (  14.00  )
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

Hi Sagi,

On Mon, Jun 12, 2023 at 09:36:53AM +0300, Sagi Grimberg wrote:
>
...

> > 
> > Not yet, will do it.
> 
> Would like it to get to the next pull request going out this week...

The two patches have been sent out:

https://lore.kernel.org/linux-nvme/20230613005847.1762378-1-ming.lei@redhat.com/T/#t

thanks,
Ming


