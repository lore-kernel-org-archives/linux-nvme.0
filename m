Return-Path: <SRS0=PPGx=2I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF1CC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 07:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906B521582
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YNRaolPe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4eVYsNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906B521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFubV7b41g5Ndj2OnWOKMkfosHeuIBGtCEexygVHt8A=; b=YNRaolPeW9VvBu
	OysKzoJE9lxv0rwQLIJ62VbtoOl+4wl8O/Mkt0/GSgD2iYcYaz5p46UxeHd3f7AYrLF3EUyOQ7Uwm
	axv4yqDNkEIgHLWFJJ0TpPgiKI7Qd+E7xEimbupTe0dpo40Cyd9eRWF4FzJvizkBrARSOqDhZzIYO
	mDSgCeqjXC7e/9EE0gLmAlgUwaMrjxeL99txLAJIxDz/t2VMpAsEYLD0fdDOfyojgCI5ry+RuvCN6
	HhCZsUZicIgI6UZuox0BNYQBZaPaFo45QsAdoilXr1xvT/Qprbz57aOiXP3Ap9ny7vNm/KhLdsrje
	EIsHM5g6I3ltv5G2pjNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihTmc-0000lg-Kp; Wed, 18 Dec 2019 07:30:10 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihTmX-00087V-Oh
 for linux-nvme@lists.infradead.org; Wed, 18 Dec 2019 07:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576654202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9H2DVcDuErw5Mawgg0b4fOtv6PTSFGpt1qhFWb1gGk=;
 b=X4eVYsNJGUhY1jih2DnJEfGw69iyzrOwoKxq+J+7mxfKewpUh3u5FVM+dUjag8UCaqPrDl
 F6cHN8qol/Fn0CtktcFbo0WZdzFdFWBU3REe938eebPX7aE2bSNEFn94G0rJ8d6yPZS0a3
 y03CJobFFXzED7A25fFb3vdQlCtkKMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-kYjT2sDxNFKRFg3aC3ByFw-1; Wed, 18 Dec 2019 02:29:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E0410054E3;
 Wed, 18 Dec 2019 07:29:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1346760C81;
 Wed, 18 Dec 2019 07:29:50 +0000 (UTC)
Date: Wed, 18 Dec 2019 15:29:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 3/4] nvme/pci: Remove use_threaded_interrupts
Message-ID: <20191218072946.GA23166@ming.t460p>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-4-kbusch@kernel.org>
 <20191212091433.GD2399@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191212091433.GD2399@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kYjT2sDxNFKRFg3aC3ByFw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191217_233005_870872_60F1B828 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, bigeasy@linutronix.de, tglx@linutronix.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2019 at 10:14:33AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 10, 2019 at 02:56:21AM +0900, Keith Busch wrote:
> > The nvme threaded interrupt handling provides quick completions for
> > latency sensitive workloads, and threaded handlers for more IOPS intensive
> > ones. Remove the use_threaded_interrupts nvme module parameter since
> > leaving it disabled should not be providing a benefit.
> 
> I think we need some careful benchmarking and numbers to justify the
> switch.

The patch can fix CPU lockup on Azure's NVMe, however, IOPS drops to
~600K from 3M+.

Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
