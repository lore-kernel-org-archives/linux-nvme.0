Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088D3C64ED9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBi/Vc+mRROdrEC455aN+NdpNW+dE+GmksUXJel4JK4=; b=QRhBGSpyYKUVZ8rYWVQjUloW83
	FI0r03aRWeLhlJ1xlcBwzs8zQ0uBqaTdSrm/mszZ066n4gYyDWL9gzlFA8yMIryWxmMFao2tMHJUX
	84eyQPSz9Z5KTVd4vdxkim8Exkvj6w8pHqV/QNaCUQvl3HEyNI21UrQ54UR2Xx3S4Nhnmb/ya6TgI
	Hxp+k4SMuzOV5uC3c99uiu1scJkODFFedw4eMm/Rx+SR/uMAfejNECFLNnsh3KVOcuSH6TkYV5lwH
	c45/tAIjbU6rLf0thd88YtAxq/iu9HBjXVKegy3CscfxbPy44RJd4FpKNN/r2Y2ITbZ36sJ1MsPeC
	XEq5oP/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVxj-0092Sp-Ag; Tue, 21 Feb 2023 16:57:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUVxf-0092Qn-Oj
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 16:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676998670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBi/Vc+mRROdrEC455aN+NdpNW+dE+GmksUXJel4JK4=;
	b=KpqOe78vPy4pyBBuo/a2gJSYXWe9TMc7WBe1fT6oGO390p15Uk619wfE1kVjElSF4T2KGn
	G3iRGsFito/TXyPlRIHmU23rCGuOXdEjHi8ReerQyGzYp7pc1mL+pxASlkGlFAQeMJ1do6
	862UxTge2TH3jrEzQMo/0AZEDIsqjqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-OLf3luQ8M36JB5-LMaE-cg-1; Tue, 21 Feb 2023 11:57:46 -0500
X-MC-Unique: OLf3luQ8M36JB5-LMaE-cg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29062100F90A;
	Tue, 21 Feb 2023 16:57:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13F98492B05;
	Tue, 21 Feb 2023 16:57:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Y9KtCc+4n5uANB2f@casper.infradead.org>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2897037.1676998663.1@warthog.procyon.org.uk>
Date: Tue, 21 Feb 2023 16:57:43 +0000
Message-ID: <2897038.1676998663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_085751_888528_951D9676 
X-CRM114-Status: GOOD (  16.85  )
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

Matthew Wilcox <willy@infradead.org> wrote:

> I'd like to do another session on how the struct page dismemberment
> is going and what remains to be done.  Given how widely struct page is
> used, I think there will be interest from more than just MM, so I'd
> suggest a plenary session.

I'd certainly be interested in that.  I've recently been looking into
improving folio support in various places, including now splice and pipes.

David


