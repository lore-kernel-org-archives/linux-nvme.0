Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B16EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yk3h8MT1WXQ4Hzm+/nTwX2HobwerbK0LKQs2bmU3+jk=; b=2T/ZRpusZd1lxn4domxtH7C0ss
	lQVnByaMoVaCSwiRNdT+sh5ZWcm6PzumY/n4ZHWdX+svsh/JRVwgZn9FBXLl4s4Go+cYtxk6sHr/N
	qXBs76PmEVvURmz3p97Mdtn5zzdV1rba+pVqvusfAXQq5f+6eHm6NSv5p1KQpnvfzCpsC2rFyi2zG
	5kqFr/5t4lEfafU6IooLcyvmpxOgMLIsLiYSFAWarAdWQgIidb/Rf7Hbavhj3AUB18rqbZVBX8JFA
	yDuL+dq5SmcRvkTSkgvTj61bAGPlfSQRPNFcSwJBGBMI7TNSjy+57MSxZ087uv3XETLgK02gLln34
	fIvE02xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsxQ-00C1TJ-10;
	Mon, 10 Jul 2023 15:37:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsxM-00C1RA-15
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:37:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9E13561070;
	Mon, 10 Jul 2023 15:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F76C433C7;
	Mon, 10 Jul 2023 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689003463;
	bh=UH9FD6H4E8FgVGpGrI10/m2MFNWZjqwwvLW65UsSe9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QM0MOFFaogZsNCLdvOIVJizQKOk6ReGZFQDD6LxUb543yeezLwPAystRKd3DpVsnj
	 nI6DdZgFUKdZJ08pa2RIssoB1sTsuJ2iZv/Jc1m0zVWcBNgom0S92S+WoknE9kpkBb
	 4L7CEQY/tlAt+MXshVmo9iCZxfkxB5N23zR+I7TTe1mStU+nZs/IpLP2EbwYzeNFko
	 gltLN4SbVrkEKzLc0w6/DdjQHNLrPJ9CnwxjpGPQc8yLXyfWBpTjqD5EfMPO2ezZ/s
	 Ui6WRPnylNm0VR2ZhgDlMV9L3Jajd+02z8bkvFOViQiF+mkbJvBfCjUkfbwyx3jP/a
	 omrrki/TXN1Dw==
Date: Mon, 10 Jul 2023 09:37:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/6] nvme: unquiesce io queues when removing namespaces
Message-ID: <ZKwlxGBI2zUzbacn@kbusch-mbp.dhcp.thefacebook.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710153555.1766438-2-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083744_437991_3B5FB568 
X-CRM114-Status: GOOD (  11.28  )
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

On Mon, Jul 10, 2023 at 11:35:50PM +0800, Ming Lei wrote:
> Error recovery can be interrupted by controller removal, then the
> controller is left as quiesced, and IO hang can be caused.
> 
> Fix the issue by unquiescing controller unconditionally when removing
> namespaces.
> 
> This way is reasonable and safe given forward progress can be made
> when removing namespaces.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

