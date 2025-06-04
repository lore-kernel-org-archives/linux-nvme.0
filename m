Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E733FC5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhFqGA7Qdy4GBuqDKCOMHvMHX8BdS/uyheN/8znQjlg=; b=Y++PxGLn51ucKfTp2RcJkaQ2uo
	C2p7tA2dfV4B8WfXOeB93ODPrBB3oiTqJsO/xAzNm5q+xj2U9Jbxq9OHJCzO2cg3wc3yUF3i5lJKX
	NZAdkrvAPzzd9EJanEiCp4VzcwzwxPYFuqo7LfaQEWiIL4WlR3S3mdCD3h+5Vj8Yq27fXASM+/Rjw
	YsNvuPn6fnZ0IwNiBMgfL56JfFWPgIR4KTJlJbkNjw8bRldu+fLVLgoFD2n6HrEPOwoA3I0zE1XJr
	JZtLpTU7ddl3zBGjhVLaLOWuOxo5++HLtYxV1HNow/1HGGa5oBhSmuxdkxYTjZG1tG5hZi+vh7iqW
	Ai2tsvNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiZq-0000000Clsj-1ciq;
	Wed, 04 Jun 2025 07:30:22 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiZn-0000000ClsW-0GJZ;
	Wed, 04 Jun 2025 07:30:19 +0000
Date: Wed, 4 Jun 2025 00:30:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11 00/10] Read/Write with meta/integrity
Message-ID: <aD_2C9-KKnssYXri@infradead.org>
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
 <20241128112240.8867-1-anuj20.g@samsung.com>
 <aD_qN7pDeYXz10NU@infradead.org>
 <CACzX3As_FH1tMgZHMoCJMPhnuB__oh7KBzd9Z_JLtg2CLFZ4rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzX3As_FH1tMgZHMoCJMPhnuB__oh7KBzd9Z_JLtg2CLFZ4rA@mail.gmail.com>
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

On Wed, Jun 04, 2025 at 12:45:44PM +0530, Anuj gupta wrote:
> The fio plumbing I had done for testing was pretty hacky (e.g., using
> NVMe ioctls directly to query PI capabilities), so I didn’t send it
> upstream. I plan to submit a liburing test. While working on it, I
> realized that writing generic userspace tests is tricky without a way to
> query the device’s integrity capabilities. The current sysfs interface
> is limited — it doesn't expose key fields like pi_size or metadata_size,
> which are necessary to correctly prepare protection information in
> userspace.
> 
> That’s what motivated the ioctl RFC I sent earlier — to make it feasible
> for userspace to construct metadata buffers correctly. Once it gets
> settled, I can write some tests using it. Do you see this differently?

Ok, I'll wait for it.  In the meantime I might go ahead with just
converting the data path in nvme to the new DMA API and handle the
metadata mapping later.

