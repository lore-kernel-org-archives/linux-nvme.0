Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8575CC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EOJO21mMWm9Ve37XvF5zAOvUvne3pqlm8zmlzW92C/4=; b=T6eMx7fZW8lRw/330GWuTILqKs
	7crxmM2LLk2JfMlBM+OT0mrWVcqeGGT9sqNMmEPtxNDe3EHlTNrVW2SbO34IcHLK0ovbMzhOiDAvc
	dJLM6QvSgpKpEcUI7hxZSpx/PuuC3KBHAI9ItWRQenSCTTa2cCp+zoK1lTKWjK/opC0p0uBSUfa3L
	5fgH/fuxjHVnVAAlHa0FmgDU/fkjWDxXk3iiwjNIFnQOLlKHAhXYs2EGxZqFiQjK3XlX+euK1XEz/
	TvcFO1Qh/cSXNLwj4l+4ogNKJrJIHms7sDVKeckdNK42dCiTrR2/cUfHhZbdYXA+ivWG3aeOOKMc9
	4OtGMIsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSd6S-003Qu7-0N;
	Wed, 24 Jan 2024 13:15:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbwc-0031eL-36
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706097684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EOJO21mMWm9Ve37XvF5zAOvUvne3pqlm8zmlzW92C/4=;
	b=AIRZ+6IqGSTpTHhEX7E10BzgetD84nbIdeaDeP3LcaTEb28an3QkqcKKdY2pn1EtQU5UkE
	j/gwWisx9prOBv+Zb+M7zfu5V1FLY6Nr2+3No6a9OLx3CroE4INXKtgqavXBLpJOiLQrul
	FsE8eGXD2wWKF/Yy4skkePUFkcHqE9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-hTHzp1ECNrKOB1WIMu4y9w-1; Wed,
 24 Jan 2024 07:00:01 -0500
X-MC-Unique: hTHzp1ECNrKOB1WIMu4y9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43F73C0F1A9;
	Wed, 24 Jan 2024 12:00:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA262166B32;
	Wed, 24 Jan 2024 11:59:57 +0000 (UTC)
Date: Wed, 24 Jan 2024 19:59:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Cc: ming.lei@redhat.com
Subject: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Message-ID: <ZbD7ups50ryrlJ/G@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_040127_181880_040ED8AD 
X-CRM114-Status: UNSURE (   5.63  )
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

Hello,

Requests are added to plug list in reverse order, and both virtio-blk
and nvme retrieves request from plug list in order, so finally requests
are submitted to hardware in reverse order via nvme_queue_rqs() or
virtio_queue_rqs, see:

	io_uring       submit_bio  vdb      6302096     4096
	io_uring       submit_bio  vdb     12235072     4096
	io_uring       submit_bio  vdb      7682280     4096
	io_uring       submit_bio  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb      7682280     4096
	io_uring virtio_queue_rqs  vdb     12235072     4096
	io_uring virtio_queue_rqs  vdb      6302096     4096


May this reorder be one problem for virtio-blk and nvme-pci?


Thanks,
Ming


