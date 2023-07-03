Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED15EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbr2zsR02hBkXXr/+t6FgeUGHT0OM2sZEGRGoWKe3g0=; b=MiWSs0pxyzz6B8/yVuMrA5vgnH
	03ezuY68eCx34IECW2B7IhBGMyZddwWSaRg7qEE4pla9rVs5J0qVwTa0y1b3jqazHhV7cwBFdIjih
	UnK9N3VosVTGCK582B+VANV3/vL9h8IKlcbrl8/C10QnC0/0pIrs1P0Szuqxm9X4PgCm+NALCKE2G
	A9Y39xSZjcToBOzM9Ur30HN67V4cPp66bfJR5y4XAikhy9+N1BqbBI5RPWFpvzyS4hVq7zc32vsNY
	ApeXJRrI7WncqaA0EK17/3+qN5i6rYePdxrNR4FDneIr3rEC6dY87XjU808GTehqjKaaw1E1SNlCP
	SK+ON7lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIvz-00AWIg-1s;
	Mon, 03 Jul 2023 12:45:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIvw-00AWHa-30
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 12:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688388333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbr2zsR02hBkXXr/+t6FgeUGHT0OM2sZEGRGoWKe3g0=;
	b=WTfwjgSAXZ2zg4PmqpDal4OVWV/vQoji6tpaPrUrx2Iox8YVOaawer6SpD9B3+Jne2lB/n
	WNS8TdNqd4Q5SjD4IH/1IlDIlgHOAYKLSfCkji8Gm4YJMwNp/MJsIOW6SOTb++LblM7CKw
	dOSFoReWwdHICrePROryjVYHQ3KzADE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-RSLTATY6NlykV4zGJ2427g-1; Mon, 03 Jul 2023 08:45:32 -0400
X-MC-Unique: RSLTATY6NlykV4zGJ2427g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2CF11C4FD85;
	Mon,  3 Jul 2023 12:45:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90A4C15230A7;
	Mon,  3 Jul 2023 12:45:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6859f3b7-90fa-7071-857e-d9354165a445@suse.de>
References: <6859f3b7-90fa-7071-857e-d9354165a445@suse.de> <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de> <20230703090444.38734-1-hare@suse.de> <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me> <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de> <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de> <873545.1688387166@warthog.procyon.org.uk>
To: Hannes Reinecke <hare@suse.de>
Cc: dhowells@redhat.com, Sagi Grimberg <sagi@grimberg.me>,
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
    linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874610.1688388330.1@warthog.procyon.org.uk>
Date: Mon, 03 Jul 2023 13:45:30 +0100
Message-ID: <874611.1688388330@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_054537_041176_BDD037AC 
X-CRM114-Status: GOOD (  13.19  )
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

Hannes Reinecke <hare@suse.de> wrote:

>                         msg.msg_flags &= ~MSG_SPLICE_PAGES,

Ah, yes - as Sagi pointed out there's a patch for that comma there.

David


