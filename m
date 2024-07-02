Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A34C3065C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxPrHgSrUppjbHMiTKoRLwoCeBkXo4KHdkPdA9MSle4=; b=ILkGpPiwNYQFfXqLoLbzO62R6j
	U5ZoQtj1TK2YcvRP4pDeK05GslkDRNvxCU0YUK5RICXuLWXRXf373MZzG0pu/GXXmSTDqF63kwynA
	J8abI/sp1wkRMsE4CW1stnbSveKxQuHl0QE9i5uKH1CVtWO28XeeWM16AMrNK0YDsUfSt7C5cSPF8
	Dhsn18UOzTH35ykSBuyDXcpblvb5FcloLGPqydL2/EhVDLHK+b2k9bkhEfOZkc9jr776+aODBn2w8
	stEYUiBd/7dDbOWCiqe8d6TQRRfWLbUg/2MvUjA1uowa21mG7+wkDsoUnJ8/P6KWzqHzUtxK+wM2t
	2B5/8biA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfQY-00000007Cdd-1FFU;
	Tue, 02 Jul 2024 15:28:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfQV-00000007CaJ-02lQ
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 15:28:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A585B68AA6; Tue,  2 Jul 2024 17:28:09 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:28:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Lawrence Troup (ltroup)" <ltroup@cisco.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Franck Baudin <fbaudin@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <20240702152809.GA32373@lst.de>
References: <20240702104112.4123810-1-ming.lei@redhat.com> <20240702115002.GA16219@lst.de> <ZoPum7MPTuA6/t7O@fedora> <MN0PR11MB6280284585EC79A329095CC6C0DC2@MN0PR11MB6280.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR11MB6280284585EC79A329095CC6C0DC2@MN0PR11MB6280.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_082815_227494_5ED7F826 
X-CRM114-Status: GOOD (  14.86  )
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

On Tue, Jul 02, 2024 at 12:20:30PM +0000, Lawrence Troup (ltroup) wrote:
> Openshift needs the ability to dynamically move IRQs of all drivers away from a specific set of CPUs, at the point that an isolated workload starts running on those CPUs, and requires high performance guarantees, i.e. no HW interrupts to occur. To achieve this, dynamic setting of the smp_affinity for all drivers is used - at the moment, the NVME driver does not support this, so the NVME IRQs remain running on CPUs they should not be on, and so impact performance of the isolated workload.

Then you need to create a core kernel interface that moves all managed
IRQs of these CPUs.  Without that you have a never ending whack a mole
adding hacks to the drivers of the day that you care about.


