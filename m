Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C31CC4BA21
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 20:23:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0749D2072D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MG+X10Km";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1D9dNV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0749D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L2UvptAboGLy2uFwRx7HSLFphZuHT0DPw+DfduIuP0g=; b=MG+X10KmjW2ebl
	gCCkXds8R4LNr38jlvzQ0sQC+3uhlcTiAk87U++MB5k++b2zTA2M2RM6WopaWXYFXRjmQ3ZJSUA1m
	lcII+jekTM4vY8+Hb5l57Lj8HAWBNmIMsCaMbyxTQIJvsn3zC2D8L1ddDNJ8Nn0MDQkjct4T+ydXN
	VtvNwW3e2doEp2Gp0uDeGbLJ2R5iq4Bp+IVMQFOVxIstJrhCdPkmeelddQg/7vhjKw9Xf/j0k43Dy
	IMKVml2tWbYZVNKtH6BWfXbbYlivVLIeDEKgHymL4v2dXj1e186VtNUBgYR8C5yDk4Llb+qFK/dtP
	ouzVGfkQkMQwSbC5jI1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j73DC-00088Y-JY; Wed, 26 Feb 2020 20:23:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j73DA-00087z-Ks
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 20:23:17 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93C012072D;
 Wed, 26 Feb 2020 20:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582748596;
 bh=ekk95paQTlR6dEQv2fZl5YosAk4Pd1McLq28vUTVaqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1D9dNV2QgsHjtfsbmmHHDMKfGPRFG4poH+Ju6qKAyKgR8atX//e2iljlM8u0/rXY
 +i26Z3FCmyyNd+gOi+4BRBs8IlSoK8wFW1UMkz3LAJquX6WNrEi3FIeK/zl+a07Vao
 E+mKqt/u+LY9Gmk0XuuTRYyMAvAZfmmTyf2QJ69U=
Date: Thu, 27 Feb 2020 05:23:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: nvme_poll() CQ processing
Message-ID: <20200226202309.GA24127@redsun51.ssa.fujisawa.hgst.com>
References: <143eb9f1-7f17-591a-4302-a86ea1114e87@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <143eb9f1-7f17-591a-4302-a86ea1114e87@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_122316_706064_5050B535 
X-CRM114-Status: UNSURE (   8.00  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 26, 2020 at 11:20:19AM -0800, Bijan Mottahedeh wrote:
> A simpler theoretical example with two threads:
> =

> Thread 1 submits enough I/O to fill the CQ
> Thread 1 then processes two CQEs, two block layer tags become available.
> Thread 1 is preempted by thread 2.
> Thread 2 submits two I/Os.
> Thread 2 processes the two CQEs which it owns.
> Thread 2 submits two more I/Os.
> Those CQEs overwrite the next two CQEs that will be processed by thread 1.
> =

> Two of thread 1's IOs will not receive a completion.=A0 Two of thread 2's=
 IOs
> will receive two completions.
> =

> Just as a workaround, I held cq_poll_lock while completing the CQEs and s=
ee
> no errors.

Thank you for the notice and the anaylsis. I believe you are correct, we
need to avoid scheduling the thread if it has cqe's to complete,
otherwise another may free enough tags out of order, allowing a queue
wrap.

Your work-around sounds okay to me for immediate inclusion and for stable.
Would you like to send the patch?

Longer term, we should get rid of this two-pass completion. It was
done that way when submit and complete were using the same spinlock, so
reducing the critical section was helpful, but we don't need that
anymore. =


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
