Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F9C4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1D22072C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bW3SKMc+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUNgHJUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1D22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b6KswQs04PkHpKi1gi2cdX3d856U4tIGs/KNgvFHsso=; b=bW3SKMc+dN/1XI
	Np6QrY5IMSWnM4kFPS5BczzPSe6lNO+P1QJNQ2O40iJdpr6kGhoMZuStaHrkfjleY0JJGBJrgO+AU
	WCffMDrDfkGmJixACcZrfYwyZlUJOfGkyN6ZdtuVPyZGLF7hSGvN2IFGC5j2Xs3t2h9ZScL0ARCVa
	Sy7H33cuyaV5ZKGr3YTZZALBrYxE+Ts/O7airKDqpnOvB3DBHKsVZiLiRr855FajrhTcvlBK0kdHs
	aYixMwH73P/xmOt30U8r9iG4Z43rF4NjPMhJPUDYLGY8L6T2NPeKSyHodNFVk03Uhcemg6kCxvUYi
	DtzpGzV7gLAKJPMiNSig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFRLW-0008Lp-Dh; Fri, 20 Mar 2020 23:46:34 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFRLT-0008Kx-K0
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 23:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584747990;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAknU27sjyKn0azikXOQ8MZtEg6c3Z5a6RJ+riMAqkg=;
 b=AUNgHJUok9ZqcJNRx6NLlWdLBbApDF1PjouLmqiF2Vzfxb3IXbm1QVnExZXrVnO+YOqyLn
 D2xbudJcfEtZDUnH6cE65v65iHWWs7EOZ0zQla9BhsMT8/VUCjX29QeiVgwmk75wWci6my
 FRYhtC5zCotFuXziZgz8jr+4BI8isPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Ky2cb7YAO52X7NMd641KNA-1; Fri, 20 Mar 2020 19:46:28 -0400
X-MC-Unique: Ky2cb7YAO52X7NMd641KNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBB321005514
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 23:46:27 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BCA119756
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 23:46:27 +0000 (UTC)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <f18d9173-b94e-69d6-022a-20603e8cb42b@grimberg.me>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <7b56c65b-40a3-0172-6e42-7158fd88361c@redhat.com>
Date: Fri, 20 Mar 2020 18:46:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f18d9173-b94e-69d6-022a-20603e8cb42b@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_164631_732511_A433A6F0 
X-CRM114-Status: GOOD (  10.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/20/20 5:59 PM, Sagi Grimberg wrote:
> Also, does this reproduce with file backend? I'm not able to
> reproduce this on my vms (running KVM though).

Do you mean a loopback device using a file on a FS or nvmet using a file
on a FS directly?  I wasn't aware that nvmet supported a file back end?

In my particular case the VM is representing a block device that is
backed by a file on the host, it's not doing pass through.

Thanks,
Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
