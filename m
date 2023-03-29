Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F9C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VeP1AEOS+wBJvxUKj2aAAwYxo51hN1jRb0opgX6GIZ0=; b=DlLjH2ZVQ1aqJNhoC1rz7T6EAe
	tJRuRU4nHSbMW2rt//zb1cq+VHQMwYwZrELZqowhhwb/hiy370ik8IHK97iQIn4r5nLvH6oXr642j
	VTxbOx2VrYTnRFFMRl6ROBm+wuC3+h9ZgsE0GF/M2yIH1vDjt5jVeH9aPvljKl8AY+pVJkTMm9gJy
	V1oPB3v5vQhx+YmE4lLerFBihTh00iIPXUPyj1RUaxSRZRHb/TDFO02PeP0l3ZC0NsRPI9lgMffiq
	MNHEcgoY1pKNMfH82BzWV+V1Atpg59HOXDDNuO6fWNqs6GfaFo9i7jSVVV5x3XF2FBR2UmEOMY8vP
	fZ3DZwwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXr3-000ogk-0V;
	Wed, 29 Mar 2023 15:36:53 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXqz-000of6-0u
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:36:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BAC45B82360;
	Wed, 29 Mar 2023 15:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CBC4339B;
	Wed, 29 Mar 2023 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680104206;
	bh=A76W85DIbMWLmoQXvQ5FW/ugJvF9c9AatoBSe2Bbxn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogj+3txCCunQXejTc2N6WbxHGNGt0/P+Ek1yJ9u78dLBb7tgsfGz5SN1Q06Yae2W/
	 /786wj5btjBS+xQTuF/3I3uTVYybl/aFdgpsaU8IsDtYG689GmWOUGE/Q9IEIRYpyr
	 HqIuB56cQ50vcKf5Mg6O9wJEQfDLYXy6oLIKHs+fh9HrYng3AEkR2kCkIc8Yy4HRR5
	 zaRuihcgexE90DzV4FNQDAqXrzLcLAIQTXnOABhGJthcn1aZCpEaTTpiNhwwVah1hZ
	 yiE8FKqN1iBlPKrGD7eXulqCo8B5oBMN/SVOGH96uLGuak3tjK1oChirdY3pZFoQxW
	 dG4fdYMk6abwg==
Date: Wed, 29 Mar 2023 09:36:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Olav Gjerde <olav@backupbay.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Intel P4608 (Oracle f640) doesn't show both NVMe devices.
 globally duplicate IDs for nsid
Message-ID: <ZCRbC8I3R7aZK9g4@kbusch-mbp.dhcp.thefacebook.com>
References: <CAJ7kQyGTc_+ajkTGKKsyvazWRFud3P71Nv2U_bcqAnhL9yS=ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ7kQyGTc_+ajkTGKKsyvazWRFud3P71Nv2U_bcqAnhL9yS=ZA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083649_474412_73A74514 
X-CRM114-Status: GOOD (  17.14  )
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

On Wed, Mar 29, 2023 at 12:36:23PM +0200, Olav Gjerde wrote:
> Hi,
> 
> I just upgraded to debian-testing which runs Linux 6.1 on a machine
> here and I have trouble with my NVME card which has two NVMe drives. I
> find the following error message in
> dmesg: nvme nvme2: globally duplicate IDs for nsid 1
> 
> I googled this error message and came over the explanation here:
> https://bugzilla.kernel.org/show_bug.cgi?id=216049
> 
> lspci returns this,
> 
> 87:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> 88:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> 
> I have checked the master source code, and I see no changes recently,
> so my guess is that the fix is adding NVME_QUIRK_BOGUS_NID
> to the following section:
> { PCI_VDEVICE(INTEL, 0x0a54), /* Intel P4500/P4600 */
>      .driver_data = NVME_QUIRK_STRIPE_SIZE |
>      NVME_QUIRK_DEALLOCATE_ZEROES |
>       NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> 
> in drivers/nvme/host/pci.c

Yeah, NVME_QUIRK_BOGUS_NID is needed. The only problem is this particular model
shares the same VID:DID as the 4500/4600 that do not have this problem. I guess
none of them get to use those features...

