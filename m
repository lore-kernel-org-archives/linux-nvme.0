Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A1AC83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s8lTHEFvqn6O7/obO5tIhJdwAk4Fh5VdIus7RBec4R4=; b=0s1cTLeLYpptkrMfTr2F32H6XJ
	17ljKVO+iBoPkphZ3pERTlsQQwodyXj+pOKo8cQYRXsL0Oz0UVbhOxkLdyN/a19uXQDbkwY5IsZBN
	AiVSP/31VTWr3CSiJYIxQ0vFUHAFaUFZlufCHTpMDUrfgWvXxn9HZJ7b/EYhBwGTg8kZDg5cFquSO
	+DM9wtOoMeIodBpPZzXZqdIBEYRkP1mlmWJ8GNRhjtVb9sNAwjGYHyspEeYy7rHmEPxiUO/zrCxMu
	E1uriB3bMKQ3htkxvjKH0IhMmBsq8cdYA+uvXsCQZC3YtNsUcML+RTVmD4+GEhohmkOyI+Kkb/Etm
	v7Kfas+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6bt-00000001RU3-1HbX;
	Tue, 22 Jul 2025 06:36:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6br-00000001RTc-0giI;
	Tue, 22 Jul 2025 06:36:19 +0000
Date: Mon, 21 Jul 2025 23:36:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and
 protection info capabilities
Message-ID: <aH8xY3PyejzGdUp7@infradead.org>
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>
 <20250630090548.3317-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
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

What's the status of the fio patches to support PI now that this
has landed?


