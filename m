Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16456C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gMtfG2i5/58SWMfeAnjIgvwP5WuqcBrDMHGFQzmyUVw=; b=Ukva7YEfu1UoXFYfx+Z3G8Wecs
	z1xJNldi6QCn0la/dVCF7JAjqfihRfx7IwTAN+xoWRJG0ZaIkILyUtrb3iGtZ7lV8+o3c76DUSibT
	+R5j3/PFNDDM87d7CvGJiNUYFzT9EgFtSL4MJdzyLjWEGI8qJfg28ZNxMYnqn+Tc+6V4CqZ33mpmz
	8nvginGxCA8jY43NAM1G0cnc1pYEoRgjTfEItl6GcW3Rk79eWwyBKJ59qj/ecLy5/FCUlaUSeqsCN
	xQPZTray73fr0zqih/Y+gnFsTIEkeu0RLKXIcyMsT80nAGYA2Qm3MtbSNnsWhn8FY8VrgxqtG26Zh
	mBiQjQpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvKSI-00AWq7-3A;
	Tue, 24 Oct 2023 16:40:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvKSG-00AWnq-0d
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 16:40:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7E8C5CE2F8E;
	Tue, 24 Oct 2023 16:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F35C433C7;
	Tue, 24 Oct 2023 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698165629;
	bh=rylJe4Rc3q0Rz0TuHurMIpDQo/OOGpbf+xH/9dzoVaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpNTtW3fLW8m3HpDOZ82+nYQdXslJ/8hM19GCct+5xUPz3g2q/m03RAbCpOp49c/w
	 8cH+Qk2Mvas8LXvo+WEq0nsanpF1cY9yZ3XknjRZI06VLksEPyyO+mhtkXMY151q+H
	 ysWJuvtCCLCES3G9tNAQ7YeBZkFmbL5A6ANnCXITHqoY1FfwbY1rxCwjqWwLJDEGTa
	 D2ZSyTd6ifZp52qGHRKkwUn60vQEvwVO1Z+QQ8zqD9v2z6xkxqZIdG9BsMb3yWppIA
	 PnF8WYtNDk7gH8j947IZTAkBy4mCJbFmsXKE/tOvIPtx7r6NKl011xECiuUY4xyfN8
	 YVuKpk0dA1bgg==
Date: Tue, 24 Oct 2023 10:40:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Message-ID: <ZTfzetR5o_RUfJGK@kbusch-mbp>
References: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_094032_407040_C008D85C 
X-CRM114-Status: GOOD (  12.23  )
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

On Mon, Oct 23, 2023 at 02:00:00PM +0000, Mark O'Donovan wrote:
> The first patch is a small unrelated fix which makes it clear that the
> response data section of the Success1 message is not optional.
> 
> The second patch removes use of the host sequence number (S2) as an
> indicator of bi-directional authentication.
> 
> The third patch causes us to always set the host sequence number (S2)
> to a non-zero value instead of the 0 value reserved for the secure
> channel feature.

Should these go in now for 6.6? We're pretty close to the end. If for
6.7, there is a merge conflict that I think would be easiest resolved if
I wait until the block tree resyncs after the 6.7 merge window opens.

