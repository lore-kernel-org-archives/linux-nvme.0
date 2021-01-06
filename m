Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 22:40:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22ACC2313B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 22:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ACC2313B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=67LLdxImKnr/DYm7alMe25eH1TJii/WNCRtz5xab9NA=; b=2XIz7cV506dekGuBkXkoyQWBX
	Chw3hnEs7Omkcfvr82NmTQ90Zf4fnvWA80RE7Rt9IMHxKCIhuPDpFfuREYmaYJV8TrS/qjMfkldRJ
	fQJzua7yWqBNt4cliR3VvYPFnVSYn6K3OZM85v9p2UFViSYP9LQpr5PMtMjFx7BZUWq0q4N8e62tA
	7XiAsLAx5uPIpd2esi9fGOtk8EEEvN0zpehqgy6gPB7bXsLcitKd5CXZ2DqREiIBu6CwsBlEj/P4O
	lgT1WEmSSR44L2x5r0k0MoJvF2HO3LAMp+3op0wY7/qD1dKA8cUiSiDc/1rb+rV+iEc4XTt/Y5fUZ
	gmgy8e3ng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxHTM-0001SR-Np; Wed, 06 Jan 2021 22:40:08 +0000
Received: from hera.aquilenet.fr ([185.233.100.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxHTJ-0001S0-L9
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 22:40:06 +0000
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 8E5946BB;
 Wed,  6 Jan 2021 23:40:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnVwzdxEFMXf; Wed,  6 Jan 2021 23:40:01 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr
 (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id A9FB643F;
 Wed,  6 Jan 2021 23:40:01 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kxHTE-006P4i-FV; Wed, 06 Jan 2021 23:40:00 +0100
Date: Wed, 6 Jan 2021 23:40:00 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210106224000.skryo2aijhfiomfw@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
 <20210106202823.ehdkno3inlzszqtb@function>
 <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_174005_820822_1E978442 
X-CRM114-Status: GOOD (  11.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 Vidya Sagar <vidyas@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith Busch, le mer. 06 janv. 2021 13:48:08 -0800, a ecrit:
> On Wed, Jan 06, 2021 at 09:28:23PM +0100, Samuel Thibault wrote:
> > Is there more I can provide to investigate if that can somehow be fixed
> > in the driver? I guess I can safely use the system with pcie_aspm=off?
> > (the energy saving seems neglectible)
> 
> I don't think there's more to do from the kernel or driver beyond
> disabling usage of the problematic feature. I think a proper fix would
> have to come from the hardware vendor.

Ok, thanks!

Samuel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
