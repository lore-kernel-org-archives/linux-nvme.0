Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 21:48:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA82313C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCA82313C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ocX3Np4pB8jxr1ixfPAFOwxrbFKyPxjN95MLJQOwbIc=; b=IUs05oBfd8MLT0701ePoyQMLln
	6owEpziXnneJv80cfEP7H/WbS/kIVS+lGRKbQWxrWFMGiSPdunubJYeVn1K2J35FxFeq8OiRq33nC
	DZhec/BHVCWLZi7b6iC7/peZI0NcvyWazJuBNFLGoqIOw4nrJ2X0LxhvZCkl3G3zxbcItm8w3AzJ0
	7bLvwGAjtiAYEciuqfs5SVbaJoqZ0xPn5Q4GRZkvEa17n7B2C5HnLDojqOlCVnJ/aHWmfdticZlUs
	S7ud9exiSmulHdQkEtRy/WInUX5ZXf6OwZjxYv7KuGT1T5XNYMI6v6Ec/CNzMXVqHH2/8DuWVheUM
	gfqVXSpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxGfA-000696-02; Wed, 06 Jan 2021 21:48:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxGf6-00067y-IM
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 21:48:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C84DA2313A;
 Wed,  6 Jan 2021 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609969691;
 bh=91/Aa98h8TuAYSiseznI0xMKY2ksHk8wwEYUs1TmWBA=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=TB4UJMTwlEbyEZimdtXeo88/zeLItuFtUNA9BkImKyObE5keU+fu/mISceNCZE72h
 UAHrHpbNBctsQ5DL32gByjPTz/SuCjEvlu8uJyFTukb+sLFcmOnm4662wsSvRGDu/y
 P00JZbNLXU+Fgs8llYwHUnE+2NdO+ktdkB262U6zDK3bSb+q+UAa0KYGg4BBVSdJvE
 PiSsKiABtVZ12CiZD5PGbhok8rHisCIFNNN+mz/irrMomOVUqHBD99RngPnb16yYuJ
 OCSXdBSNjkW1myRjAaYIcpW7T3yiY0tyEr1DUReJZwtVtAzcDfXq0A5KPstCHhscO+
 qfI9tK2NoNLew==
Date: Wed, 6 Jan 2021 13:48:08 -0800
From: Keith Busch <kbusch@kernel.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Vidya Sagar <vidyas@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
 <20210106202823.ehdkno3inlzszqtb@function>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106202823.ehdkno3inlzszqtb@function>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_164812_758854_75290DA1 
X-CRM114-Status: GOOD (  25.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 06, 2021 at 09:28:23PM +0100, Samuel Thibault wrote:
> Samuel Thibault, le lun. 04 janv. 2021 22:36:48 +0100, a ecrit:
> > Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> > > Vidya Sagar wrote:
> > > > Since this is a laptop, I'm suspecting that ASPM states might have
> > > > been enabled which could be causing these errors.
> > > 
> > > Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > > > Sometimes these types of errors occur from low power settings, so you
> > > > can try disabling the automatic management of these (assuming the
> > > > hardware supports it). To disable nvme specific power state transitions,
> > > > the kernel parameter is "nvme_core.default_ps_max_latency_us=0".
> > > 
> > > I have tried to add it,
> > > 
> > > I'll watch in the coming
> > > hours/days to see if that avoided the issue.
> > 
> > I did get one
> > 
> > Jan  4 22:34:53 begin kernel: [ 7165.207562] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
> > Jan  4 22:34:53 begin kernel: [ 7165.213891] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> > Jan  4 22:34:53 begin kernel: [ 7165.216949] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
> > Jan  4 22:34:53 begin kernel: [ 7165.219995] nvme 0000:02:00.0:    [ 0] RxErr
> > 
> > > > PCI also has automatic link power savings that you can disable with
> > > > parameter "pcie_aspm=off".
> > > 
> > > I'll try that if I still see errors with the nvme_core parameter.
> > 
> > I'm on it.
> 
> I tried to make the machine only run apt-get update every 10m for 24h.
> 
> With pcie_aspm=off, I didn't get any corrected error
> Without it I got 39 corrected errors
> 
> So that seems very relevant :)
> 
> Is there more I can provide to investigate if that can somehow be fixed
> in the driver? I guess I can safely use the system with pcie_aspm=off?
> (the energy saving seems neglectible)

I don't think there's more to do from the kernel or driver beyond
disabling usage of the problematic feature. I think a proper fix would
have to come from the hardware vendor.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
