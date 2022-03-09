Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 01:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOinsnqh7tuFe1AXLtD6a4GjowO8MZZ5tBv/OgSQsfY=; b=GWvCpHSI3KINHXIVAFTfX0Vszh
	5T3eHrqwp3voMHmz2Nkwb/Fm5HHs2C0hqhwUTUgO8bmJJUC5SLrmZnxQM28VTAMQuEwUZwKUTTbls
	VY/mgBMkiYhlTQcXJBLRxlSZ4XasHOgNH6/SsDoLPUdtnNS7Bjz3fSlm7yuKQvXU+wASDFGK0L858
	G1B0MSWupgpAa8byHKaSxQKajaPXr/bjqyINTwS5FJ2OzbvdT+QY7eathyKGw6xEIPypn2ywPwXuG
	kPAmLH56uX4QfutBQsDEqUEPgRAtNNk2Z1wpad80XQHBqJLBFo60U6gcJSUq46diZHGTJKbOSl8s+
	5x6G2E8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRkjH-006m8b-4Z; Wed, 09 Mar 2022 01:03:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRkjE-006m7E-Az
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 01:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646787779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOinsnqh7tuFe1AXLtD6a4GjowO8MZZ5tBv/OgSQsfY=;
 b=L0X1iGSbZj+dVqE6mMtunqLvf+PGYvZICxBdLUdAOvfNOcxzPpzVu977UGKdMJI63Wmd8d
 3FzShBvHTEacydRhARWhq+vAjqOGfYUQd+CE/0II1s4X4XRdFtlKPnLAoW+oczyt3R9eB0
 dDVFfLvU3hH3vKf+6ycpTn0zDvQcp8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-IZ2xRyylNjOyVAgujDYaRA-1; Tue, 08 Mar 2022 20:02:56 -0500
X-MC-Unique: IZ2xRyylNjOyVAgujDYaRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F306180A088;
 Wed,  9 Mar 2022 01:02:55 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B98AA60C05;
 Wed,  9 Mar 2022 01:02:46 +0000 (UTC)
Date: Wed, 9 Mar 2022 09:02:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <Yif8svaBscrL9WZk@T590>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_170300_482766_F89AFCA7 
X-CRM114-Status: GOOD (  15.54  )
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

On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> On Wed, Mar 09, 2022 at 08:18:47AM +0800, Ming Lei wrote:
> > Given NVMe spec states that data length of IDENTIFY command should be
> > 4096bytes, and PRP list can't be used. 
> > 
> > So looks nvme driver need to validate the command before submitting to
> > hardware, otherwise any buggy application can break FS or memory easily.
> 
> No way. The driver does not police the user passthrough interface for
> these kinds of things.

So you trust application to provide correct data always?

From user viewpoint, this defect provides one easy hole to break FS or
memory, it is one serious issue, IMO. The FS/memory corruption can
be reproduced easily even in VM.

> It couldn't ever be complete or future proof if
> it did.

But the spec states clearly the data length of IDENTIFY command is 4096
and PRP list can't be used, so why do you think it isn't complete or
future proof to validate data length of IDENTIFY in nvme driver?



Thanks, 
Ming


