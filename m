Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C89C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKsK9Ak5aQgKdR0xCF8qKbNC4Mvk+Z+2sHlCt6ax0us=; b=mGjsfrG7ygDzLenjir3rNah5Co
	FJkNE2dE7Rns+XuHQJJY0P8yXoScnLpoEQuPOO2in0jfmYdkr5ZDRj8PfLy88E0qLMqSC/kPHQMsG
	bgrJf8BBjDdadEy0I1aq7oq1chXN3gqp8GXiYO3VSfPIpi3tdEQMyYf/RAfnzjOjrDohyAiGZxTqd
	66jLfTiRwvGe0T2fbwDoD1V05MU+Y6G75dp3Vknsc7qbY36rggta1xLdaGx3N1aHyjGj/gPlj91ce
	R/ps3wb3uREPoqQorPTuVB6Veb5p8TKWoL9yQmEx0AnqS/hVtWW5J6PLYc97OgrBua1a75XpQ+uW2
	SzsNBIJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJ0h-002vtx-1G;
	Thu, 21 Dec 2023 13:22:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJ0e-002vrw-2P
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 13:22:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CDFA68B05; Thu, 21 Dec 2023 14:22:36 +0100 (CET)
Date: Thu, 21 Dec 2023 14:22:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231221132236.GB26817@lst.de>
References: <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com> <20231221121925.GB17956@lst.de> <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com> <20231221125713.GA24013@lst.de> <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_052244_938900_7DAE811B 
X-CRM114-Status: GOOD (  11.90  )
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

On Thu, Dec 21, 2023 at 01:18:33PM +0000, John Garry wrote:
>> For SGL-capable devices that would be
>> BIO_MAX_VECS, otherwise 1.
>
> ok, but we would need to advertise that or whatever segment limit. A statx 
> field just for that seems a bit inefficient in terms of space.

I'd rather not hard code BIO_MAX_VECS in the ABI, which suggest we
want to export is as a field.  Network file systems also might have
their own limits for one reason or another.

