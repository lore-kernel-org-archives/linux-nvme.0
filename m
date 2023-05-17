Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3556FC77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=; b=FLIHynQvV8s7JIY8IZ3fXJisGb
	V1Ze9trQligVXQvCRrPpu5kFJwIaMnrHhB5uDbLDBwx7m6bXzWXfSTBthiDBuMkvj7/ss8ehHwclQ
	iMSdvGdXjl8G43MgKm6qm+Elu1cnQhp13FDwNnQBrctxSUBNs59DX7R9coyJ46vKAMbyt2Btwh3/K
	kB6/pIqs3WqgDRALXVxovmgjsd0mZr4ME5pw6rNol9Mb6236C0jh8+xKaEFxrct8oYw7zFBaf+h5Q
	LEkwPvE3zM4tOkIrz8XEXj+Gwg73PNE539JpS7c2V3Pi1V+KrZ+MFvq1NvQiPYSmCW6JWnjzG/KJy
	pAKkVO5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzIct-00ADnX-01;
	Wed, 17 May 2023 14:59:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzIcj-00ADiO-1t
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 14:59:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E63866484C;
	Wed, 17 May 2023 14:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCCC433B3;
	Wed, 17 May 2023 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684335567;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxs7pLqL9n0ieGbizPaB5zI627hN5hXEGeDy518ysa9pAOpVfkoLqUA+tLyENKpa2
	 iPHSfWudyWQ1G6gimufYiKgrQLuXngLnlA6PXQy/hrquI8hE3eTvLST6D2V/ajgfMu
	 Bba1gIwNKyzPFtd5ppRHcS9E+6QlBjd0gAkXsLEFTdsLhnh60HNriXY3mMqYKNqjpb
	 Svb5d3z2JlzyV0YKrIW21T1x+HMtmS6PeHWOgxMzlQ3f7OJK7c5VIQmx5UsB11Ow8K
	 ImkJN1/E9kefDIXE0x7XTowbzZdU8WcfpMAmh/oThHrnb/T9cYdWioqCMSaz7c+jMF
	 asXmlTdXMdPsg==
Date: Wed, 17 May 2023 08:59:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, sagi@grimberg.me,
	hch@lst.de
Subject: Re: [PATCH] nvme: do not let the user delete a ctrl before a
 complete initialization
Message-ID: <ZGTrzOEUHuugsFUH@kbusch-mbp>
References: <20230511110741.1883129-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511110741.1883129-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_075929_687235_6202C2D4 
X-CRM114-Status: UNSURE (   7.46  )
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

Thanks, applied to nvme-6.4.

