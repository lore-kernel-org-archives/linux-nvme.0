Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EC0C48BC4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KPPW2NF6W8zp/5U4yZS74ji11PvDCvONjPvyuJAAYjM=; b=lulsetfrxPAaSLsli+5Yt7Dg4D
	mecE6Nl0UMz+wnVEeTecuqOf4d8hBJMbHiGmK29wckYp2uOV5/LlYKeTfdsof61EKcrXaZoQmwkgH
	t1WN5wEf0jEdCZbbJeXBxpQXs6j15qeFxWiod3zS3e8wjA5mB/LCoQvcAofMCo0yMqBhvZLEHoaSp
	RkEDFbhXqlG8U+TkVHmX+dzD1kPiqBmgzySOWJ5kiiIJ/aNJ5zjLyF03eW2vDnsMTOZK0ezR2JZYz
	01ZS9Fduzs4urL60jf9yTL0QWgNOq3ZN/+8ojYBbM2jzE0fJEvpAwkIQ2tpjlvgS0uUDv3GGUh+aj
	ZXT5rpug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLMq-0000000Dew3-1bk2;
	Tue, 20 Feb 2024 08:20:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLMl-0000000Derv-253w
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 08:20:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDAF067373; Tue, 20 Feb 2024 09:20:33 +0100 (CET)
Date: Tue, 20 Feb 2024 09:20:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 04/11] fs: Add initial atomic write support info to
 statx
Message-ID: <20240220082033.GA13785@lst.de>
References: <20240219130109.341523-1-john.g.garry@oracle.com> <20240219130109.341523-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-5-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_002039_795256_2A419F77 
X-CRM114-Status: UNSURE (   8.31  )
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

> +EXPORT_SYMBOL(generic_fill_statx_atomic_writes);

EXPORT_SYMBOL_GPL for any new feature, please.

