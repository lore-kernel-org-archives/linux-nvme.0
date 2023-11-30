Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC3C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YQqpuGsZIItErENZLmCBFPntp1ZyTZMptB60KCMJ3Oo=; b=ki+KrRPNcRDHlLtA+dt6YR0kfs
	gDPSVqIekNWYKUUv5BA3YRRwfC7JC9TTtzMCJcwVerxKEnCOZioopC/QWPHDwsr8wSYagsLePApCv
	gqpC0qskVVRDwoFdfukigcXg+hvIeeTsMZALdya9opHZh51Nc92NNhekulIu+m/25sBFtHf6JDWGx
	AWL98T9yV5fmxe8BioFC1KmfiWINZA/rMsXabWehn9sAALSRDO5ptgRJ2JB2brWfPZjbOb3dAaXJ0
	iMcJ/xMotyqOWdG5Tnv6N9z30ZF6PUyuQovr2FVhkYgG9eIVUEQHBB7Lhn/F6wxYybsZrz4ljsGgs
	HibqfvBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8UjV-009Z67-16;
	Thu, 30 Nov 2023 00:16:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8UjR-009Z5c-1v
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 00:16:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701303396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQqpuGsZIItErENZLmCBFPntp1ZyTZMptB60KCMJ3Oo=;
	b=S09AF+O8sX6mvWDA4BVVOS3STrxO3UKbp+cDHRmmgItXUpDFmvHmmlaf9eINW81Hqbrykh
	3iM1vAQeouM7L84VDz2elE/TXfp9QWXdFSedd6+KiKUjKhRQCV9ZwnWmyPu9NEbsDxlX5P
	i0Yl8446lcAgss5fD8QO/MSoF1AiGvU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-IKpE6fieOauYI4Awx4BZPw-1; Wed,
 29 Nov 2023 19:16:32 -0500
X-MC-Unique: IKpE6fieOauYI4Awx4BZPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64EE31C05AE1;
	Thu, 30 Nov 2023 00:16:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3EA5112130A;
	Thu, 30 Nov 2023 00:16:28 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:16:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: guazhang@redhat.com, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: About 'nvme-pci: fix DMA direction of unmapping integrity data'
Message-ID: <ZWfUWPsJ7AAOzqHR@fedora>
References: <CAKhLTr2PjPnNDccbc8OMy3fSc_U1Dk7GS+UWLUkj0zWwzcp4zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKhLTr2PjPnNDccbc8OMy3fSc_U1Dk7GS+UWLUkj0zWwzcp4zw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_161641_727441_DCA7ECAC 
X-CRM114-Status: GOOD (  12.48  )
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

On Wed, Nov 29, 2023 at 11:56:50AM -0300, Raphael S. Carvalho wrote:
> I am observing a problem where disk writes are apparently being
> misdirected. File system metadata ends up in file data range for
> example.

Please raise one report in linux-block or linux-nvme if you are asking
for help, and include the following info:

1) kernel release version

2) related drivers or device, nvme or scsi, or dm/md, and how to setup
the device

3) filesystem

4) exact reproduction steps

5) expected result

6) actual result, such as how you conclude that WRITE is misdirected

BTW, is it similar with the following one?

https://bugzilla.kernel.org/show_bug.cgi?id=218158

> 
> I am not completely certain about the problem "nvme-pci: fix DMA
> direction of unmapping integrity data" is trying to fix, could you
> please describe a bit more what the problem is?

dma_unmap_page() should use DMA_TO_DEVICE or DMA_FROM_DEVICE, instead
of block request dir(READ or WRITE), and the issue is actually one
dma-debug warning.

And block request buffer or IO direction isn't supposed to change in its
lifetime, and dma-debug code check if page map & unmap direction is same.

> 
> Can it cause silent data corruption?

No.

Thanks,
Ming


