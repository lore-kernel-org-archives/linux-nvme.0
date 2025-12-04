Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B95CD1CDCB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 04:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKVZ1aW6qd/ymkfafuY8+6Gxc/lRyN29Kqly/Nt2dc0=; b=VW2SlfPrYkdXZOVJ6oQ313ulie
	0jfWt9BcmHNfp7ROf9KTqpzdpMZ83Dx0KDvURj7EZoUjUGmtDlEWYByAAns8EJdUMrypHEYxcVMmd
	kopJ4n4wQaxz8+EF+iTtPfKaphMVMTrjVCGUf8JCMV+7HVd0B5zKw8CTAVXkvfL+av6OrdaT51AvE
	g7LpjzvYclk5sqt6BBSVXMk1UEHbkwpHBgPXVAQGC6FQeW9m7hzC2ZPq83pXgoPRZrFMe4SgYiUPU
	cqZVIjeBk8LnDPS33946L5NlILRCN4G30ckvE5QIAqEvit862lFhCoPILq5Mhj1zjUy+UJK+yfmSq
	AYU56tiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR0Va-00000007Qab-3yCa;
	Thu, 04 Dec 2025 03:59:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR0VY-00000007QaH-3ut4
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 03:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764820794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKVZ1aW6qd/ymkfafuY8+6Gxc/lRyN29Kqly/Nt2dc0=;
	b=ULlW+KAcmnm+FXpIagtNmRrE5aR5pdsdVCaj0827s2nweRNVj1rJ26rh0PjzGDRone/Jkb
	cYrXXozffXgSoNVwnenHrSTga32/3uwSctVIeZVC5DBNiH201icuaJj+MF6ZfEe0Gi4DOB
	/QytGMohCkSsMB4lj8Y48aL7B1qLKN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-hLh1_lQnMEuc70BzgyXxoA-1; Wed,
 03 Dec 2025 22:59:48 -0500
X-MC-Unique: hLh1_lQnMEuc70BzgyXxoA-1
X-Mimecast-MFC-AGG-ID: hLh1_lQnMEuc70BzgyXxoA_1764820787
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71E1E1956050;
	Thu,  4 Dec 2025 03:59:46 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.88.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A479A30001A2;
	Thu,  4 Dec 2025 03:59:44 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id 01F5FC1977; Wed,  3 Dec 2025 22:59:43 -0500 (EST)
Date: Wed, 3 Dec 2025 22:59:43 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Justin Tee <justintee8345@gmail.com>
Cc: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <b1e0835e-cdc1-448d-bb24-1bd7afee8158@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work>
 <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
 <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work>
 <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
 <CABPRKS-UZMwfKNCK6Mx17_MxYK-ZieKddx0N7YBM3hf5Ur=4Ug@mail.gmail.com>
 <CAGtn9rmQW9w42oMVGpXZB4OuifwF3XzgVaxuHyXN1aYpzjRskg@mail.gmail.com>
 <CABPRKS-j+J1XKKoMOXx-d-8d_yxo2JhF6G6jYYFvFXOdy5x3tw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABPRKS-j+J1XKKoMOXx-d-8d_yxo2JhF6G6jYYFvFXOdy5x3tw@mail.gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gx6UnY_55k2Imr5QmaEZvv0TTLnZfrBv99-XDD38Sss_1764820787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_195957_065425_AE4554D5 
X-CRM114-Status: GOOD (  10.46  )
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

On Wed, Dec 03, 2025 at 05:44:14PM -0800, Justin Tee wrote:
> I have a patch in mind to resolve this, and will report back.

FWIW, test kernel with the revert still running since this morning (~13h), no
crashes.

-- 
Aristeu


