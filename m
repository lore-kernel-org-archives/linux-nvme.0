Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAABC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 10:09:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD09611CA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 10:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD09611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MZ8lRFGkB/gjqlaoWReso77EhPEUxzAaS0Gvy/ioOXc=; b=HkTWC/2Xh0h4xLEVIG3LP6vup
	/6EkiCQz1RpuX1BI19Ew+pNetxjmpgTC6RakTgdlmyMdUtkAmdRXtlSmeGl1XKvIo/3SDMK7xJj64
	R3aUqSNzauY08eG5fMevGJh7VVmHwqn6woO70RyuFBzsYEzhsmptmRzaXI/bwavGYxGEuMduIJds5
	17ilxRc4V/U4VU9F+Ao/TNyGs/IdHIV3Eb9ACIcC9rFdUG39o5KTy8UqHCx2CC6hiWqYmfMz/vg7V
	GbrUK/F8FZ5JKactBdIw6Nzf9XvjJiUIVtmKp2zznWYWC9aHk4fAr0Bek2y3W57Isw0q2vpN7qEaF
	L8JOGr2sw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lia9H-00EW7j-NX; Mon, 17 May 2021 10:06:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lia4v-00EVHY-NN
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 10:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ckgZjUQxdMOTLeNpdl3Cyb4DA2f/xWwrvKCpphG2X9A=; b=o4PUJhbYrH+ptqeYkQ2ry6dPb8
 +i7+JViJDkMfRh0w2q1ZeUtfHcmURAoSjG23mQZ/q2gHlFxlTyvazQmpphLFAnf4oGp2j2uIEzzR/
 lkULs1Ru+nYRsyEtbGHh0rITSrcpHbDgq3POx/6ERVJ1Ykvt6KYuR1oLgQa/WyuyM+9rv9ygeq9nG
 0Bu/6ggTTUGyexJIiPmglukmscrqA4i6FvxQ2xs9fEmyjEbM2bVSyjiaDKaI6BTuJaSZfOlmU3F3k
 WF5SJzmD/OaMeVWXXcm4jTWf255nZtde+dCqC49pEsErGJ/2GL9YbsBAcFqm88i06maypgBLCE6eh
 f6fYuspw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lia3D-00Cmcn-KB; Mon, 17 May 2021 10:00:46 +0000
Date: Mon, 17 May 2021 11:00:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <YKI+xzOZ4wPpvo66@infradead.org>
References: <YJlzwcADaxO/JHRE@casper.infradead.org>
 <YJ636tQhuc9X7ZzR@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YJ636tQhuc9X7ZzR@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 14, 2021 at 06:48:26PM +0100, Matthew Wilcox wrote:
> it would need to be evaluated on its merits.  Personally, I'd rather
> see us move to a (phys_addr, length) pair, but I'm a little busy at the
> moment.

This is on my todo list.  Fairly high, but after another block layer
heavy lifting project.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
