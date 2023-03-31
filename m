Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA136C76196
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0smx6BF8UFiSSoiq6UktpCRnWTG2fxIhOdQNn2FnFdE=; b=n0g6EumGbY5iOQHnYxZsI1i1oO
	3MnPpKw4aV0Twy0E+NhKbQgCwq0zBCGq/YHQVxk/Gkb41CwWVn7W1OtEFod4Ua7PqzO/rGTuPOjLm
	AQHhHKhvKRpJTjUEG8/9xkM8r2s4zbuLaONHotaOAgmY02cUcJKqah8g80Q2i9KjMelsl4RVJWBKl
	qsFd943vAjTqw/jE2IXAfSarwYYSsLmn3FysHhb2rLCaU6qd7KoXf2rXunWd5E0T6ic6GrpjvSpps
	hSIK5ulMJHLK5gKmM03SyFsfFLyN2zfGY1NnUsNWoN/IthUCfgGmyhMc/BBhK8cDvJVzyJeCdNpfh
	vwUMkHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piHyJ-008CJk-0e;
	Fri, 31 Mar 2023 16:51:27 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piHyC-008CIS-0I
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 16:51:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 93014B82C32;
	Fri, 31 Mar 2023 16:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76BAC433D2;
	Fri, 31 Mar 2023 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680281476;
	bh=v3lo+fwLuwECciL0wEFe+lXCz5XEDWcJEGAp+VZ8uss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYYEILdREdnuHoq6GBej3xmgZLcodwAXvVCtirN9yvlUFLOxg4Y1sqAeA6nKrXTc9
	 7d7cmO1Eu9ffubccUWVktWMrBFHYlDzvZb/gfiSUNLTfb7vp5EASAF4AgFAfX6xbgg
	 mlqOzb7djlnhHNjW8oq4AkciRrOb74CggmUTaOOhcsnkhM2q6mDl5AzNipxvBq0o4D
	 y1Y9CDI2rFlbe0hW7f67DxJ5n9iHW/yiskRPSy3AYEMgdbHu52PYJIcvZ0wQekc2ph
	 zyZtLH8sZnfO14NXBK9ZsGhTkCsQhVdbcq9EPqo43vNVD2srKPj6Mp3ySmifdcHw0M
	 4AdnfaDjXkZ4A==
Date: Fri, 31 Mar 2023 10:51:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Olav Gjerde <olav@backupbay.com>, linux-nvme@lists.infradead.org
Subject: Re: Intel P4608 (Oracle f640) doesn't show both NVMe devices.
 globally duplicate IDs for nsid
Message-ID: <ZCcPgJq/8QtD2RhL@kbusch-mbp.dhcp.thefacebook.com>
References: <CAJ7kQyGTc_+ajkTGKKsyvazWRFud3P71Nv2U_bcqAnhL9yS=ZA@mail.gmail.com>
 <ZCRbC8I3R7aZK9g4@kbusch-mbp.dhcp.thefacebook.com>
 <CGME20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704@eucas1p1.samsung.com>
 <20230331120100.4tcmcnzgwmsalau4@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331120100.4tcmcnzgwmsalau4@blixen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_095124_265698_38F23F1C 
X-CRM114-Status: GOOD (  22.52  )
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

On Fri, Mar 31, 2023 at 02:01:22PM +0200, Pankaj Raghav wrote:
> On Wed, Mar 29, 2023 at 09:36:43AM -0600, Keith Busch wrote:
> > On Wed, Mar 29, 2023 at 12:36:23PM +0200, Olav Gjerde wrote:
> > > Hi,
> > > 
> > > I just upgraded to debian-testing which runs Linux 6.1 on a machine
> > > here and I have trouble with my NVME card which has two NVMe drives. I
> > > find the following error message in
> > > dmesg: nvme nvme2: globally duplicate IDs for nsid 1
> > > 
> > > I googled this error message and came over the explanation here:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216049
> > > 
> > > lspci returns this,
> > > 
> > > 87:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> > > Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> > > 88:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> > > Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> > > 
> > > I have checked the master source code, and I see no changes recently,
> > > so my guess is that the fix is adding NVME_QUIRK_BOGUS_NID
> > > to the following section:
> > > { PCI_VDEVICE(INTEL, 0x0a54), /* Intel P4500/P4600 */
> > >      .driver_data = NVME_QUIRK_STRIPE_SIZE |
> > >      NVME_QUIRK_DEALLOCATE_ZEROES |
> > >       NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> > > 
> > > in drivers/nvme/host/pci.c
> > 
> > Yeah, NVME_QUIRK_BOGUS_NID is needed. The only problem is this particular model
> > shares the same VID:DID as the 4500/4600 that do not have this problem. I guess
> > none of them get to use those features...
> Can this be then moved to core_quirks in core.c then with its specific mn?

If someone has a comprehensive model list, then sure, but that might not be
feasible. There were different model names for various capacities, endurance,
and rebranding. Best to just reduce to the lowest commonality.

