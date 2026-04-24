Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3DBFED3CC
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CuZjnySuiuCe5y0+uTlSCu1z1bv7acszR573EEt0/M=; b=Fh6ICBEYQZE+z8eX37rFKv7ehw
	vR7tfXMvO6irkSU7xgRnkxrCBJG0uK3wih3MUEx/MeZPSK7fhQYahBJcGeOI+FOtaTGdWCYLPC4dL
	qNUk3KO/IWI5DcYbwNHzM2wGxKPoHLJyrMh1ccVBBjf5WAtyCNB6Fb31Tm19PLHA6BovnneSHrUge
	YARPrxdBSFJCUHEhEpLDOdQRRNapCdpHicV2LT9AUeH11E8eIM+LDGxOUI8kCBU9Ulyag3Fr40YHE
	YjQbuPNCEWfr4r3PBgm/rszvKLAsCZpYsA26tMAD/+hJQ9ACBoqL8EHetCiM7kZgONlcASv59rm2A
	qThdaOlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGi5-0000000DFf4-1xUH;
	Fri, 24 Apr 2026 13:36:45 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGi4-0000000DFeq-0HTy;
	Fri, 24 Apr 2026 13:36:44 +0000
Date: Fri, 24 Apr 2026 06:36:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
Message-ID: <aetx7GZeKBoRCPS3@infradead.org>
References: <20260422141159.10881-1-ikegami.t@gmail.com>
 <20260422141159.10881-3-ikegami.t@gmail.com>
 <aem0x5CsghH7HoWd@infradead.org>
 <7af729f6-25e7-483a-9a5e-770d6c6e6805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7af729f6-25e7-483a-9a5e-770d6c6e6805@gmail.com>
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

On Fri, Apr 24, 2026 at 02:51:48AM +0900, Tokunori Ikegami wrote:
> On 2026/04/23 14:57, Christoph Hellwig wrote:
> > Can you explain the rational a little better here?  Do you have a
> > device that does not have these entries?  And what problems does that
> > cause for you for which workload?
> 
> The change is just an idea to improvement the scan_work to make sure as
> always do scan for the ns_mgmt and ns_attach commands.
> Actually I do not have the device as I have only a drive these entries as
> NCC for ns_mgmt and NIC for ns_attach.
> (Another drive I have but does not support both ns_attach and ns_mgmt then
> does not have these entries. Also third drive broken then I can not confirm
> it for now.)
> All drives supporting ns_mgmt and ns_attach should have the entries but I do
> not think the driver side not needed to be depended on it as always do scan.

Please document this very clearly in the commit message, and maybe also
in code comments.

> I tried to fix the issue below with the changes at first but the issue was
> caused by the test script then currently resolved already.
>   <https://github.com/linux-nvme/nvme-cli/issues/3251>

I don't really understand how this is related.


