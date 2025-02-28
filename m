Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D51C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJMiX5JQBlxofVNED+SUwd5iuEVsRwDlgHWXTEfci4Y=; b=pAfFgpSfUn1NrVyhhqyLc25uP1
	qyeebkK+76ptDxsi1DTgsVAqXNIUSY8HnmkMVZKlr4Y0Tugo8KkrBF3vvX0fTyxmdQwPIgX0R9oAW
	nLrnYYfY/gtr7PdU3d7jmgg+Y9nQ3LO+ocduq+iWNlFpjlnknBl+SBKqmm5OQ2d1F5pWz9c9uT/uX
	DB1i9HBRt0ZZxw8vaQ80QhEGF+9EbePEgoztegxd3Z18hfu7Hsn780sO6bHQJPr/t/ZjguWcDRZNg
	hwR+AvM037MRVkBPhdmkLm8YoV+HiaOsdGsNeMPKZfUL0wo1jliEljQFxfTjc0Fzku/cc1PmpTCHe
	Yhs2Z0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvYc-0000000A8iG-1i1v;
	Fri, 28 Feb 2025 08:17:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvTU-0000000A7Rj-461O
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:12:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJMiX5JQBlxofVNED+SUwd5iuEVsRwDlgHWXTEfci4Y=;
	b=dSCouV2RZoXiBnByuoe8x8z3qVnUjwqSObJvo8QlswQE8alDOFgB7rnrTJEWp0VsBzqedo
	tVhYXKAMKPyuS9Oy/9TDpBwiw4MwEOEzwaGTcGgLgYm7jOsR55t2r8xjSP1SsRtt/KywD8
	DECwsVQOxRYUloYXtVfG3PzH/Lsd5QM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-3J5Q5S_xMVWFm-zXaQ9Mww-1; Fri,
 28 Feb 2025 03:11:55 -0500
X-MC-Unique: 3J5Q5S_xMVWFm-zXaQ9Mww-1
X-Mimecast-MFC-AGG-ID: 3J5Q5S_xMVWFm-zXaQ9Mww_1740730314
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 870E7180087B;
	Fri, 28 Feb 2025 08:11:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABD91300019E;
	Fri, 28 Feb 2025 08:11:47 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:11:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 2/6] io_uring/rw: move fixed buffer import to issue path
Message-ID: <Z8FvvUMo9NmBxwKt@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-3-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_001201_087697_6DD3A856 
X-CRM114-Status: UNSURE (   9.66  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 27, 2025 at 02:39:12PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Registered buffers may depend on a linked command, which makes the prep
> path too early to import. Move to the issue path when the node is
> actually needed like all the other users of fixed buffers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


