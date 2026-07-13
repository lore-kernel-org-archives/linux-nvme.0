Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46280C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wl8S8iLSdP4AKy5hki5ae4R3OUpVAeUg7AI21HnlU0A=; b=PZInl8qEOAaGkG7xwjg59HIzgt
	It2r8MwVNeBI4n0FzZmHWSqPln1Tp6Tlks3kU0xzOyU7w0CG9jb4Z1XGR4G2yxQ1a01tKRvpfEROR
	Gu0oBQI0LGajtZ6E7JXR8JUQgFXvsLqtOUaXpxLLA3JldYOPrHrQgyvteOt+rxRIp/qLybcULvEkR
	oKXDqb0Pe+EnWMRHYN3pgquCtJx4hb9NaueUSmgft8vvgQHtppRN5Qc6RVp/jdlrI7yZouHXUYTjW
	ue/Q5Z1gR/1QHvRRqVtttOK50mgaFZrbQQd5tkIvAAFFm40UV6r8O0udve7c29aAFrHe2J6RWSHJG
	u//IcwiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDHO-00000008miw-4BLf;
	Mon, 13 Jul 2026 09:48:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDHM-00000008miT-0gf0
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 09:48:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2623068BFE; Mon, 13 Jul 2026 11:48:42 +0200 (CEST)
Date: Mon, 13 Jul 2026 11:48:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix cdev lifetime
Message-ID: <20260713094841.GA10083@lst.de>
References: <20260713091546.3013427-1-john.g.garry@oracle.com> <20260713093044.GA8706@lst.de> <92db8054-c7b0-4517-873e-8c0fb18c02ba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92db8054-c7b0-4517-873e-8c0fb18c02ba@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_024848_349903_6D390F62 
X-CRM114-Status: GOOD (  13.57  )
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

On Mon, Jul 13, 2026 at 10:46:26AM +0100, John Garry wrote:
>>>   +	nvme_tryget_ns_head(head); /* Undone in nvme_cdev_rel() */
>> I think we need to do a real get and not a tryget here.
>>
>
> ok, np.
>
> Then I am going to propose adding nvme_get_ns_head() also. It can be used 
> elsewhere and it would match better with nvme_put_ns_head() (rather than 
> using kref_fget(&head->kref) here)

Fine with me.

