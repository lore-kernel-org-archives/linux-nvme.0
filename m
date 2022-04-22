Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40D0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ka4pkaIl0n0C8wRiVJB+Tf0N4jkuRhOTDXzmulvrko=; b=PszMT7gH8e1Ggf0cE4zvi3zdYA
	pqzODKNhTxutCIxSK1pUbpcWer0Snfb1bFPzHkZIMbzOcb4iFSLJPaI0qoqqX4S/hHjldZiCjOXRR
	TrQM2/UNtoLHzktKplPQAaUVepdkum3AK/KGXhjjPJAEkGVEkzHb/DRo7lUisrzzVN7Hh8fnbdGXz
	FeNhAFsUZt3JVqgfgkgBitDIm/k5OzH535cLFncyQ/xbnOH4iFFxnrT9X9BrW6hdJ3geZ/LIBLDuP
	DwB7uhx3cUA+A/Adzn2W5vKOCqDBnYImUyDAbl5m6yIdurKBRHFwKSOyiAI/DLV0Rzt4IqXK/unKv
	zk+NxBsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhrik-000G31-MP; Fri, 22 Apr 2022 11:45:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhrii-000G20-08
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 11:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650627901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Ka4pkaIl0n0C8wRiVJB+Tf0N4jkuRhOTDXzmulvrko=;
 b=V/w5COIpfbxGWk7b631dn4Yyqa1Qd84Lnc5jSiBJIeKVvU0WClBPhhK6bE53ST+6Qt4u/H
 +nklrP6WqUvSOQ+BS9PdQzrcnZ2q4FOqsN0FjNgquG7v8Ao0fjB58PBo3K6RvFYVaECOea
 Jdj52sY33GrkgD2BRqDkXuLgUEQnNZE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-2aQCrlSrPfuy5v4vWNiTYg-1; Fri, 22 Apr 2022 07:43:10 -0400
X-MC-Unique: 2aQCrlSrPfuy5v4vWNiTYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFC621C05AB6;
 Fri, 22 Apr 2022 11:43:09 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 567B3C33AE8;
 Fri, 22 Apr 2022 11:43:09 +0000 (UTC)
From: "Benjamin Coddington" <bcodding@redhat.com>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: lsf-pc@lists.linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF 2022: Running BOF
Date: Fri, 22 Apr 2022 07:43:08 -0400
Message-ID: <15847F8A-5246-4634-ABBE-9C05AA3CBF34@redhat.com>
In-Reply-To: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
References: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_044504_206931_EC14C1F2 
X-CRM114-Status: GOOD (  17.67  )
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

On 19 Apr 2022, at 11:20, Matthew Wilcox wrote:

> As in the past few years, let's hold a running BOF.
>
> I propose meeting in the lobby of the Margaritaville hotel at 6:15 for
> a 6:30 departure for an hour-long run on Monday, Tuesday and Wednesday
> mornings.  I'm assuming breakfast will be 8-9am and sessions start at 9am.
> Pace will be determined by whoever shows up.
>
> We're only a mile from the North Lykken north Trailhead.
> Other trails are a little more distant.  I've been reading
> http://www.hiking-in-ps.com/the-north-lykken-trail/ (note this map is
> for the south trailhead of the North Lykken trail).  I haven't been
> to this area in 30 years and I have no idea what the trails are like,
> so if somebody has local information, that would be great.
>
> I note that the room rate includes complimentary bicycle rentals.  If
> we want to, we could cycle to various other local trails.

I'm in unless I'm trying to run in the PM.  I've got a tentative run/explore
of one of the slot canyons about an hour away if I can swing it (painted
canyon, ladder canyon, I may have to borrow a car from someone), and would
be nice to try to get up into Mt San Jacinto park as well.

I'm interested in getting some trail and elevation, but I've not run out
there yet and will need to scope out what's possible when I get there.

Ben


