Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC59C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF5E61B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DF5E61B3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKIl84R5RPJEVEqbXbZ5NjJVEdYIaCZy2wmKezRTV2w=; b=Qm+xH2ny7jBQvM7xyQ1afPZi+2
	2GqoQAhHLG76sbcfGQueWv9BO5MiUI+V6JW6DtMjPOGFiez80aI5A2toJu1v8G2gHjhY8EH4r3v4t
	cCsq/jg9Clagm9fOIPxajGOd17EWp8op4ZuhLumMtDTnTGB7AfGS8DtEYcvwRYQ6shHXKSFzeuX9n
	Kpe5NeJuTYxFCK5nvM4aOMPtV5v3cu4Uw54+7pBpd9M24kd/seqE5XCkuLJyNwm7iiUHPIgn3hbbp
	kBCL3DmaHRLJYvGhxL7fPSFKgYJh+ww+FYR1SdeAH5zbr4cNg2yarBd8Bf6XjZlmccG5/SEghamMI
	VDevgnxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mndWu-007Jk4-Iu; Thu, 18 Nov 2021 09:16:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mndWs-007Jjc-52
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 09:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637226984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKIl84R5RPJEVEqbXbZ5NjJVEdYIaCZy2wmKezRTV2w=;
 b=WE7wRY5F9uCzvhNpw7nTAlX80hZEKZCGWfsbxliHbw1LNiicZ3ZFwn0OVDPiHhV4f5anfi
 OQlr9FNYJIc49NIcZyQQ6xaA0KSdReIYUJYMr3ug9VNkIdjY62LYpDSJIYsEcgixLwjlIU
 Qd/8QkCr32SIqstKrRB7by9zqfjWkhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-MknFwrQdOS6cLs14oBfSKg-1; Thu, 18 Nov 2021 04:16:21 -0500
X-MC-Unique: MknFwrQdOS6cLs14oBfSKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C6B196632B;
 Thu, 18 Nov 2021 09:16:19 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3396419811;
 Thu, 18 Nov 2021 09:16:18 +0000 (UTC)
Date: Thu, 18 Nov 2021 10:16:15 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Message-ID: <20211118091615.GB144997@raketa>
References: <20211117152454.122014-1-mlombard@redhat.com>
 <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
 <20211118082928.GA82729@raketa>
 <51450d94-43e9-16d7-46fd-c678afc34e53@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <51450d94-43e9-16d7-46fd-c678afc34e53@nvidia.com>
User-Agent: Mutt/1.14.7 (f34d0909) (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_011626_289739_574648D7 
X-CRM114-Status: GOOD (  11.71  )
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

On Thu, Nov 18, 2021 at 08:42:25AM +0000, Chaitanya Kulkarni wrote:
> One more thing you need to add a new block tests with the
> configuration that you have used to find this problem so it
> will get tested every release.
>

Ok, will do.

Maurizio


