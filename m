Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED413C0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 05:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ADztGh0ZGel0l7ThLHHZGM28MhThCUQxexB8Sdty3Xw=; b=asGcHlLdXe4Jb+hYFbYyKlHZJ/
	8DsRahdZUuU0qDCcE34oXIZ0Gy3vBECDx/yktK1ftT11ejodiCRBcAN9bc60igmQDZteyAnxZMKfG
	fz+RpPVwHKbOKC6GGYbXoIpinygjDNQt4MUSGsrA6uc+9fS/haw242893Cv5S0n7mtfPTvuWci4Du
	dC/WnL9Hk8M3Enk/mGzNLffGvIj/QYQegXK/flKQRwnToMS3meuZQRwjx0esro7t6krD+crOO+Ccz
	JStwotJrT3564L1t2ETrYzglmVipy6tKrcRREJvdVG2naURfC92VdjHzr14Dwzs1mhcZ3z9GQXbCJ
	+8PxcbZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBPT-0000000HHIA-0IBC;
	Tue, 04 Feb 2025 05:23:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBPQ-0000000HHHm-1EF6
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 05:23:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 634DA68AFE; Tue,  4 Feb 2025 06:23:34 +0100 (CET)
Date: Tue, 4 Feb 2025 06:23:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 04/10] nvme: add nvme_auth_derive_tls_psk()
Message-ID: <20250204052334.GA28669@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-5-hare@kernel.org> <20250128085833.GC25760@lst.de> <9382676e-6f77-42c0-816d-fd7ac9e8572f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9382676e-6f77-42c0-816d-fd7ac9e8572f@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_212340_471671_0EE85C34 
X-CRM114-Status: GOOD (  11.97  )
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

On Mon, Feb 03, 2025 at 02:37:59PM +0100, Hannes Reinecke wrote:
> On 1/28/25 09:58, Christoph Hellwig wrote:
>>> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
>>
>> Where does the magic 5 come from?
>>
> Two bytes for the HASH ID, two bytes for the length field from
> HKDF-Expand-Label, and one byte for the space separator.

Well, that's information that needs to go here.  If at all possible
using a struct, but otherwise at least using a documented constant.


