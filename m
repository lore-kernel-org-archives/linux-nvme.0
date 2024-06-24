Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41DBC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZISsWq+Zbh1zUlkNXNx3aK3v1zGbcqMb+n5yJw8Ft8=; b=FnfRvykMgG6zIXnQd0UAfUiYYl
	WEWw+N5hSiIR7jAftct7bqxdoAHX2zSF4t/OcOwCY+bMozFK2hh/m3WpBN/ssKUJvDTnbbyd1xcAo
	ExbiyXJiMhEN75romQhE+u1fQK870n38oCW2GMv8enirUyAiIT5T0KlGcTlaxrAA+2mnnztY7UeU0
	rv1xd3Zh/lwl0c6AIuhqUGWlbLXThAue5axLwdeMrJupLBaQYO1Qp8wsN+Xz/9csT/V7mLV3tzYE4
	jpYZCaY8BLnCf8M18RcsMyik9qCbgAddjKWJJJlNa1jikOOoy6jURfQryMLLmyzQgrErKjCpCVyWO
	8h612QqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLntM-00000000BFW-1LDJ;
	Mon, 24 Jun 2024 17:54:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLntG-00000000BBv-2BSY
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 17:54:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C03B068CFE; Mon, 24 Jun 2024 19:54:01 +0200 (CEST)
Date: Mon, 24 Jun 2024 19:54:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240624175401.GA24863@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de> <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com> <20240624084627.GA20032@lst.de> <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_105406_804633_1EDA635B 
X-CRM114-Status: UNSURE (   9.86  )
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

On Mon, Jun 24, 2024 at 01:50:21PM -0400, John Meneghini wrote:
>> Having the identification as the prefixe seems easier to parse
>> and grep for.
>
> To be clear Christoph, your saying you'd like the NQN in the prefix of the dmesg?

Yes.


