Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0169CCD4F48
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4k30yExF/+jiyTcgNQG6/2zIUSoBFoA5FkG5BNe8YdI=; b=4qLERjn9c7EjCAV4FkBbbhf4FT
	jOi9IhdX8ZtGysD8Wk+6sdO8txX/6cmu8xAIjaoah4H1a8v14wysF9oC93HX1pJgfJELm2QB6gnH6
	3VeonrmwnbNmqruHdJxEa5teikhOplkfuBN1SpD+7ELdBxnJ/Q0XxS/Z7xXdUjQzX4om8K5TSeKzZ
	C/fIYMreNGl51hrl8AKPBre7AnadseB1/wcqg60EJbcqpAlzi58GQV/nRiq6ZiQBcnAVk5QxtdFhA
	6NlWUSA1zg291hK03q2gDDsxMBJViGGnAEc2A1AxwScCEbdrVsQawc9U+VdDCkYJMWPKcjkB0Bw7P
	IhWhnPhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK7Iu-0000000DQuL-1oiR;
	Sat, 15 Nov 2025 03:50:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK7Ip-0000000DQtl-2aCk
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 03:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763178618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4k30yExF/+jiyTcgNQG6/2zIUSoBFoA5FkG5BNe8YdI=;
	b=HbvoWZkEXObCBtmcRjTTW9Z6Xp1uQe/Se02WsKOz9qLg5aYVdnQR+hkOIyazAeuYzGJvSk
	pUeAPtlrFx6Lme6ScAUqPcAfsw+8HzEB1OYG45lTWmWMYkPQnNcxYBgE8/23GaUo/7SoUv
	eLYqGtVBmhaX7GlEohE2vb+FnnAxync=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-qVsMiOOvPWazImWXS3rqrA-1; Fri,
 14 Nov 2025 22:50:14 -0500
X-MC-Unique: qVsMiOOvPWazImWXS3rqrA-1
X-Mimecast-MFC-AGG-ID: qVsMiOOvPWazImWXS3rqrA_1763178612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D60A195608F;
	Sat, 15 Nov 2025 03:50:11 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEE311955F1B;
	Sat, 15 Nov 2025 03:50:09 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id 0193CC3FD9; Fri, 14 Nov 2025 22:50:08 -0500 (EST)
Date: Fri, 14 Nov 2025 22:50:08 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-nvme@lists.infradead.org, Ewan Milne <emilne@redhat.com>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work>
 <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
MIME-Version: 1.0
In-Reply-To: <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zOeJNeY3glUfgaiWsu6gW6asa3v2I9volEGklAtFBu8_1763178612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_195020_076297_77328787 
X-CRM114-Status: GOOD (  12.12  )
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

Hi Justin,

On Fri, Nov 14, 2025 at 04:56:47PM -0800, Justin Tee wrote:
> Is it possible to share the sequence of blktest/nvme tests that were
> executed that resulted in this call trace?  Or, was there a specific test
> case number that results in this call trace frequently?

there's nothing different on the test itself, I just run every test under
blktest/nvme in loop.

But like I said, I never managed to reproduce on x86_64 and we had no report on
aarch64 nor ppc64le. s390x "machines" have 2 CPUs, maybe lowering the number of
CPUs would make it more likely?

-- 
Aristeu


