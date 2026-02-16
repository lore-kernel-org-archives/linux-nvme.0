Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D6E81A29
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LhwNs3g2wC8tSk7k7YAC3jYSYIPRJ4Qzo/L6Uoi3OnA=; b=Ii4ZioyjJy4m4mPxJ+kPaIxExT
	wvQlbseYt58c47XyQXnATOivzgvC2lJsNV3Mkzthzuw73fltpd6+GnFWgMA9pUHfodwG1nUs2KjEh
	OK784UI/XMzaAdysRgBqB3dQjd8+QE+4ku5BwAYTPDRcTeC0q0TZ0q+h6Zw0+06GYv0BTpoy5cRVN
	83+OBPqZmtJ30F3dAP7CQwrg5sTul17V1ZHaIBRAaZcJ9vy7DqENFhTdhnUOqQGL4Wug/4hYmq8CF
	ejCeTO8rqS5xxkxtSNBmFMCsfQI05LA65Xtd+EZ2YDjKEDEtqMRq574toTLaiQuG+Yh3SKnQ+ID6C
	B0G3tMRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrzR5-00000006lik-0xwo;
	Mon, 16 Feb 2026 14:18:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrzR2-00000006liQ-3kai
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 14:18:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B0F47600B0;
	Mon, 16 Feb 2026 14:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366BFC116C6;
	Mon, 16 Feb 2026 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771251527;
	bh=CfIWmaZkrAZk8PVU0AZVyy1S65UC0yPAi8eNlapkYBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNteKzPpF24LWwhEutpLVXWPBpURfnvoKF/IcZF0UIZvx9YYoMN9r1sWBkdLidrXe
	 d8h32av/x8K2vm5ht36ItHCo28dTmDeLmQbmk6i8pI9O6ufs88Lg+WLVRkiVHcdlnN
	 Y3dH6lQ+3tdAFgJup0vFyvTy6WN3T6sNZSJvaYvUiiy3q5jq1TicbZrMVSFpGMPbSn
	 5nb8asse2sAb7ddAq0dIpNnW/s2QS+LWW0epjJ7wTAq3z5S8evfe+lglCsT6QLXDMi
	 nNBwkVQNYVweElqk0cyp5iSulJccztcGA9C1SN0JkqjJI/c864I9wH/yBH3zgkTdtP
	 57xe2JI332Iig==
Date: Mon, 16 Feb 2026 19:48:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: krishna.chundru@oss.qualcomm.com, Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <a5m4pqtiaxsq5lmq64roro633ganbeq7mypa5ojuuqy4npkvok@wcogdbzaq6xe>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
 <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
 <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
 <unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h>
 <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
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

On Mon, Feb 16, 2026 at 02:03:41PM +0000, Jon Hunter wrote:
> Hi Mani, Krishna,
> 
> On 23/01/2026 13:56, Manivannan Sadhasivam wrote:
> 
> ...
> 
> > So to properly fix it, we need the controller drivers to perform below checks
> > for all devices under the Root bus(ses) before initiating D3Cold:
> > 
> > 1. Check if the device state is D3Hot. If it is not D3Hot, then the device is
> > expected to stay in the current D-state by the client driver, so D3Cold should
> > not be initiated.
> > 
> > 2. Check if the device is wakeup capable. If it is, then check if it can support
> > wakeup from D3Cold (with WAKE#).
> > 
> > Only if both conditions are satisfied for all the devices under the Root busses,
> > then the host controller driver should initiate D3Cold sequence.
> > 
> > Krishna is going to post a patch that performs the above checks for
> > pcie-designware-host driver. But since the above checks are platform agnostic,
> > we should introduce a helper and resuse it across other controllers as well.
> 
> 
> Do you have a rough idea of when you will be posting patches for this?
> 

Krishna posted the series a couple of weeks before but forgot to CC you:
https://lore.kernel.org/linux-pci/20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com/

You are expected to use the helper pci_host_common_can_enter_d3cold() in the
suspend path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

