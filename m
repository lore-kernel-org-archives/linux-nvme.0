Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B86CE8D6F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTPkTS3SGlLBicqmbrM6nkVTBcLVqT8aK0owmsb95Ws=; b=NyWh50YwRRC9PXbKcFvLiVz6Uw
	Vbd37EopQVEAkJ+CkU4Cd+a/9p6VFAKumvjeM0+qTCh17HhggX7HQKIQTbe08mR4p3vKG5FjX7GJF
	bKt730KJBoubpmpCDM3AKjLcmBFwket/M2DpPbfGO6uvGUktKXiOHEhjvesiK3l75MjqFQ4M59GT5
	/jRMJ+3PNkpLjZt/+/nc/0aHnuGcCPQPJATJKr/jvy6MzlpiDnKArsMxosyzhnOV8ZyY6q6+KxK3L
	iiOHE81OA9HcrCMT571z9JMUMqhTKEzDTvKJmteVmJ043M1rta/yD0bQ3v8Dyx28jqJ8hQE1SzIcn
	M2PO5u9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJykT-0000000CxyI-0XPe;
	Fri, 14 Nov 2025 18:42:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJykP-0000000Cxxk-14EM
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 18:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763145730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTPkTS3SGlLBicqmbrM6nkVTBcLVqT8aK0owmsb95Ws=;
	b=AIurkchD82S/dRBcH40R58mJfmfJikKUjsCyUZHqswjniZXsum9GKP00Gz05hzKhbOBe7/
	Jc3Dp01KgXQn/07m/RiYVHRx7Is20BJcs1AgBrL1DNIw2vGeGPUZg1Yi6qAfm7vCYzI/ee
	pEtaA6UVgfOo/92N9BlpFIcp0NbLNrE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-5uU7tFD1P_6zMoEi0H3JYA-1; Fri,
 14 Nov 2025 13:42:07 -0500
X-MC-Unique: 5uU7tFD1P_6zMoEi0H3JYA-1
X-Mimecast-MFC-AGG-ID: 5uU7tFD1P_6zMoEi0H3JYA_1763145726
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3268C18AB414;
	Fri, 14 Nov 2025 18:42:05 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F8E319560B9;
	Fri, 14 Nov 2025 18:42:04 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id B06F8C17CB; Fri, 14 Nov 2025 13:42:03 -0500 (EST)
Date: Fri, 14 Nov 2025 13:42:03 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <6440e968-a181-419b-b203-a354b924341b@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XNExlvDnqAzRhMd_USZn6OLcqg0m_F0CU8vsseQTZFY_1763145726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_104213_367192_276DF0E7 
X-CRM114-Status: GOOD (  12.35  )
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

Hi Ewan,

On Fri, Nov 14, 2025 at 12:47:14PM -0500, Ewan Milne wrote:
> OK, but it seems to me that if lsrcv_work is pending then lsrcv_list likely
> has entries on it.
> So does this fix the whole problem?
> 
> Could you maybe add WARN_ON(!list_empty(&rport->ls_rcv_list)); so we'll
> find out?

since I can reproduce it easily (less than an hour usually) I'll add the
WARN_ON and double check if it triggers before the bug reproduces.
Thanks

-- 
Aristeu


