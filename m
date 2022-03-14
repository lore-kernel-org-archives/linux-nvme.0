Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A803C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CerS4a8OUZGYW+X8CS5QhG576h4KjCig00kFCIeH3Dg=; b=3/1Ip3bGqI163b/108H3dY5OQU
	9aVVVRdFZNXzaNUEQg3zEcDOdIMePFSv7ZfQStTXUe/nzRf2yGG8awm5hQFctDXJIxkvuwqxa1eXF
	Yb5xQtpmtXiqoYTEyhBGreUBUAAMWlXjDezLDTEl5axsZ/to+YAAxyNv2avtt/cuASAd1g3tKCLVm
	dGKhSzl9U4flFrD3iVbyjwSBuNcCOxw+4i0K8ZRtls4nbHKMU+8PTymFFpycmqPKtHaArdh4Nm8/0
	Pz1rC/hIwuVJoUlanQsELS/pBS6T4uYIOlEvm3+9LaCtHSn6FgVKnBpG6XMhCdmH16rwvL3iVnlVA
	xGc6GXew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTlua-005iTc-Lv; Mon, 14 Mar 2022 14:43:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTluY-005iSV-4K
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 14:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647268980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CerS4a8OUZGYW+X8CS5QhG576h4KjCig00kFCIeH3Dg=;
 b=NebZp56pFHg+65gEchyFgyoXeMVdfVJiC32t1UWhKS3Z48yESSIw/AgL3pfhPK+EZmigK7
 QFQpqgvaJAq+gyGkrwa6AwEhGWqSpMgSJwDE0y1O6g+54JWRWAT+t2CFfoHtkzLaeQDNVI
 5bzZ0JZMh/42W2FM7bCYZzkwB2+9gpo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-GIcs86ffO8SR6ecWw880HQ-1; Mon, 14 Mar 2022 10:41:08 -0400
X-MC-Unique: GIcs86ffO8SR6ecWw880HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26E211C01506;
 Mon, 14 Mar 2022 14:41:07 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 995B5145B961;
 Mon, 14 Mar 2022 14:40:58 +0000 (UTC)
Date: Mon, 14 Mar 2022 22:40:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
Message-ID: <Yi9T9UBIz/Qfciok@T590>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com>
 <20220310083400.GD26614@lst.de>
 <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_074302_327463_043B430B 
X-CRM114-Status: GOOD (  15.27  )
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

On Thu, Mar 10, 2022 at 06:10:08PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
> > > From: Jens Axboe <axboe@kernel.dk>
> > >
> > > Add support to use plugging if it is enabled, else use default path.
> >
> > The subject and this comment don't really explain what is done, and
> > also don't mention at all why it is done.
> 
> Missed out, will fix up. But plugging gave a very good hike to IOPS.

But how does plugging improve IOPS here for passthrough request? Not
see plug->nr_ios is wired to data.nr_tags in blk_mq_alloc_request(),
which is called by nvme_submit_user_cmd().


Thanks, 
Ming


