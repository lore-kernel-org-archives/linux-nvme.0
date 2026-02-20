Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E876C56201
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OECCMeypFHxrRoOewaiO0T6PUMLs0FQsh+k5BaXKk4g=; b=UZexKTJvrjigvBu9JODFjXDksi
	4Lx6A9DejNEdpfhnYk8/SmfhO1W3E9VVHNJI5MqpxrjwqlSAF0cqUopKfECGZt7Zw+rDqrK0gasFI
	e7DeARSW82xLP2e1T3V/d40AE6M1bQP76tScIwEU61KW7IGQq6Dsbnyote0aLL/lisM5A+CDd1TmL
	w5N+yEJZKF/M5y1FVS/59FP+0fQhWL+8JR+3wsgKgYOkdMjzx1svtvtZkHXsuBQtu2Mp+6xtMG7S5
	OSWdcQJRtzd65H1FJ7NGEDgmywR1tgNe3ZNfbzIPAUwWQlQUUFSZ7gXy8MbDzEal/KICTaNZVZ0Gi
	TSyZteVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtRRg-0000000EnVG-0ziK;
	Fri, 20 Feb 2026 14:25:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtRRe-0000000EnUD-0JEo
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 14:25:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771597523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OECCMeypFHxrRoOewaiO0T6PUMLs0FQsh+k5BaXKk4g=;
	b=ahGVCc4bZsKlN79yOtzesoFpbWJNVtTFjDGP3kx8zUnH/YMRWH789+fCnHWNhhh+jfgRKH
	uhpJWsffn/SFRebyM+aPFEoG3kdPngD8Ih/wOfh9hw/lpsVkQNlTk1ZzZHWP3L2HQMeO/b
	mZOeywZmgNiwD9Phl8rZ6zYd7pocTJQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-j29xDchaMBKLccF3kU7JhQ-1; Fri,
 20 Feb 2026 09:25:19 -0500
X-MC-Unique: j29xDchaMBKLccF3kU7JhQ-1
X-Mimecast-MFC-AGG-ID: j29xDchaMBKLccF3kU7JhQ_1771597518
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465CB1800366;
	Fri, 20 Feb 2026 14:25:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F271954117;
	Fri, 20 Feb 2026 14:25:09 +0000 (UTC)
Date: Fri, 20 Feb 2026 22:25:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
Message-ID: <aZhuwOku9lFe33UM@fedora>
References: <20260219172228.429479-1-csander@purestorage.com>
MIME-Version: 1.0
In-Reply-To: <20260219172228.429479-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: rPikbGdyX4P5aloYYkGQZcyWWMlOpevXTBAebmyxIN4_1771597518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_062526_183197_5A49FA2F 
X-CRM114-Status: GOOD (  12.92  )
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

On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> requests issued to it to support iopoll. This prevents, for example,
> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> zero-copy buffer registrations are performed using a uring_cmd. There's
> no technical reason why these non-iopoll uring_cmds can't be supported.
> They will either complete synchronously or via an external mechanism
> that calls io_uring_cmd_done(), so they don't need to be polled.

For sync uring command, it is fine to support for IOPOLL.

However, there are async uring command, which may be completed in irq
context, or in multishot way, at least the later isn't supported in
io_do_iopoll() yet.


Thanks, 
Ming


