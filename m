Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C38C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgKmKFWjWbSru9vDxGmVshFZEb7MXJwfHyUsQcUeEmY=; b=o+2XLQzCw2RRNgE8VbpEAXyoNs
	x+W0wwbnhoMYzIKChQt1PSFFSKNWo2Wr4VuzHODlHVvhB1e0TLL9uy6HTZ4qr79RzgYir+zaBsJAl
	iT4wqx4vy6Z1p8MoFfAFxxctzQUqXahkBMFwlDM8mhvNNXJKXb2DdMhVJzZyZXGZegc6KVLtB6CU5
	nVBihTnnibC57BlYhBYzd0YAkAP6FTVN5apXj7GXjU1zjwxNAEYXI2jzhjZWXWMlZchlBI/YF5yvG
	wzKpF6T74xNrSHulTdfhzDWyz/sIFjW6uIIpQpSARgMlM3dsjYKYy3nCiNTjFP4D1n9ScvyUP6zkL
	XlKWcDXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRkMD-006kcR-NX; Wed, 09 Mar 2022 00:39:13 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRkMA-006kbk-95
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 00:39:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95037B81E02;
 Wed,  9 Mar 2022 00:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FF9C340EB;
 Wed,  9 Mar 2022 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646786347;
 bh=22syWfaYqD9PH598FPb7GlzaKli4j5cTtLvkcFkuOYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ooLSfg8wGnM+kRhhFeNlRtOGEWP8DdpOXcztVdaswCpdBRvuFcMvM+ibLGMyd+QzV
 E2Alxtoxc1G0kUGQiMRR+zF7P4LJ5dye7Wo5IiyLZ+ceqOFPprzuGcPfgXho2VatYu
 JV30qYFFxKUO1S9MNMMCoRkWm8U2a3i70NvehUCLvSsXQW3LHn2jxRKddXNK1sN0zE
 pi9orfvzgwuSzMck35SV8DProAY1ySTDQP4akocptue9rOPWw9UKDFtwv0sRn5MEQN
 ePoCjVv9qwy13AVwNGeOYcMZiatRwVIA2ZUsKx1c4TwF0/Vt4r/sWDx9nL4Zabp3oj
 NIz7JpiY1ePrw==
Date: Tue, 8 Mar 2022 16:39:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YifyZ9MoUws/7esK@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_163910_507573_C9AD6381 
X-CRM114-Status: GOOD (  10.29  )
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

On Wed, Mar 09, 2022 at 08:18:47AM +0800, Ming Lei wrote:
> Given NVMe spec states that data length of IDENTIFY command should be
> 4096bytes, and PRP list can't be used. 
> 
> So looks nvme driver need to validate the command before submitting to
> hardware, otherwise any buggy application can break FS or memory easily.

No way. The driver does not police the user passthrough interface for
these kinds of things. It couldn't ever be complete or future proof if
it did.

