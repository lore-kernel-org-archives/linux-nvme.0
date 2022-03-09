Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD7C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=SmOswNDHqmG33wPIElNLc88lhn
	9c89OGQeR+JjovbFUqSZaF/jzezjak7decYXhd1J5VoyD/bE9hsmlOpuwh2Q0kYWwmDTNf+rr/Mkk
	e1ZcfI+8DQntp9D08mg4FOW+XIvFVLld8b3+QyLZb9SBpjfaa+HT4t48G3jIcLYYQ480GneR5x5+q
	oXHc+fr5GY7phdt5Enp/DsmQSPspF14QcsTEL7tuqfBf4KCmmopX1wfKiNdly7cmHrQPv8qR6Nyff
	qG5gEQUq7N1CpkO+i37NSC9fEtj/xXHbBchFStAfL4HtozpNrBnpybcBAqvjG5krfxgQ+jjy3XhXO
	wBnrCn6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS12v-00A5ON-EB; Wed, 09 Mar 2022 18:28:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS12b-00A5ER-Cy
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 18:28:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9026268B05; Wed,  9 Mar 2022 19:28:00 +0100 (CET)
Date: Wed, 9 Mar 2022 19:28:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: call bio_io_error in
 nvme_ns_head_submit_bio
Message-ID: <20220309182800.GB13216@lst.de>
References: <20220309060228.18846-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309060228.18846-1-guoqing.jiang@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_102805_599603_55F261D9 
X-CRM114-Status: UNSURE (   8.36  )
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

Thanks,

applied to nvme-5.18.

