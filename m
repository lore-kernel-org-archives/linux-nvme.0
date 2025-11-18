Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F663CEBF97
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYX/KYULeh4QeKPfElgfpfCKO+YzjCq0DouTjaZ/LJw=; b=xzs8Pz2dSLvVjbDffhQKF8Je4h
	dky8T0bKC9ctTrSg7BQL+Ez1lNwiZIBY1HmQXwxEKRJaP76D3FXlUyVUt9vbFSsX/g8npkdrKvoBs
	ik0DZbnO3trBOFF94/iWVet3nXen85E77H6pbaQ5AuuD9C7AQox8UsLRuAzqtkoJ2/ghr6FRreq6z
	usiafd6RZ30o0Mc2wYT+AvjmQ/0rdx+tiwNbJVM/4JHhgE/YqHVjFpzZAT28fp02eJEA2DUeRDTpJ
	r9ne67n4LZO1uhv9uWI4VOToSnOnbqUUGVArm932TBEuQauDz6X2HW9/Eo6cJdcP5F5Aj+mWucz5Y
	HWNEl2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLMxv-00000000ZlE-3GDj;
	Tue, 18 Nov 2025 14:45:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLMxr-00000000Zkm-06FK
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 14:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763477146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYX/KYULeh4QeKPfElgfpfCKO+YzjCq0DouTjaZ/LJw=;
	b=d4BLJ8p6OaHb8XOPT1A6d2f1beiZy8u054kFTXpjD5izj9QNc2aDTE9zdCb8lbfTULJzvN
	Xn8t+rKSqKb7sYOIWpfAiw6dbFvuxwVJ719ZmxiooZabqkintj80gPZuDEhycjLy8J4SbV
	xkgUgv/XsZmc+aiCwrTUFN2ewbKlOLI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-M5rE12nANs6r6wYjeonbEA-1; Tue,
 18 Nov 2025 09:45:40 -0500
X-MC-Unique: M5rE12nANs6r6wYjeonbEA-1
X-Mimecast-MFC-AGG-ID: M5rE12nANs6r6wYjeonbEA_1763477138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49CF219560A7;
	Tue, 18 Nov 2025 14:45:38 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3931A3003754;
	Tue, 18 Nov 2025 14:45:37 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id 889C1C3771; Tue, 18 Nov 2025 09:45:36 -0500 (EST)
Date: Tue, 18 Nov 2025 09:45:36 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <7c0a33f7-ecc5-474d-a549-5f807de6a66e@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <1529dc0e-bc1f-4672-98d8-f9ccfe5c1fb7@work>
 <CAGtn9r=n024waWZekDMwSRAM+JM13FYWhXjPuA18WyO6Kcmnyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGtn9r=n024waWZekDMwSRAM+JM13FYWhXjPuA18WyO6Kcmnyw@mail.gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6vXjnUncJLHOv4-ta0IYSZZ94PrFcOXCFmIuEa24t6w_1763477138
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_064552_422079_A3687063 
X-CRM114-Status: GOOD (  13.64  )
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

On Sun, Nov 16, 2025 at 04:51:30PM -0500, Ewan Milne wrote:
> Try running the test with the kernel parameter "slub_debug=FZPU" and see if
> you get
> a more consistent failure.  This will poison the memory with a specific
> pattern when
> the kfree() frees the object, a subsequent list debug message or stack
> trace with
> registers may show the pattern.
> 
> I suspect it is just very sensitive to the timing.

Turns out it did made reproducing this faster.
Thanks

-- 
Aristeu


