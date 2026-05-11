Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B0CD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OxNIqj5i8HHZiT1IUY9YBstjZa
	/mXfhpAhAU4X2jbSzoIE1vRINxArqglNpWRFm6VlyVxO/8Cvb4zi6fAkf+nyp7K7DTeOMZ8qXnxOW
	k40E/IyY9GUizUwxDmhnqKPckAzuOzNKin3GImBSATDbOYhXvVv0AzDMvSMskiAWufs5/TgwNWVCb
	pKXXFRG2bvVbIFAgDHK4+k5KD3YMMt7pvCVDKbGEbeSwXxwM/mFuZFrkiSc+HbF5YdKgDqFV/Dsaf
	+1AeGolDi3DgMNgXgcN6xibx+8LHaH4SW74v/bCoCHCaCio3fEZE4N0RmECI9iuRNbJ9xZ/BMnJ7S
	JNFcZaRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLgM-0000000Cht8-0Ssg;
	Mon, 11 May 2026 08:08:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLgJ-0000000Chrh-42Md
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:08:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E01568BEB; Mon, 11 May 2026 10:08:01 +0200 (CEST)
Date: Mon, 11 May 2026 10:08:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected
 uevent and STARTED_ONCE flag
Message-ID: <20260511080801.GD29677@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-4-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_010804_146927_485C7B34 
X-CRM114-Status: UNSURE (   8.06  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


