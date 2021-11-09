Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 19:04:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BC461186
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 19:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4BC461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HyzW4AacSBmokdxTEAgyZVeOa7XjJCCF5D7qadrtso=; b=x2iUn7ojg7lkr+rTckgJLsJlAc
	0jAKqaeJrr0aY7UjNjoUDT2q1ffQgUG5F9yZT0vuzZsDy7v710uCpfCu93YIHcIcl8xz6ufXZxf55
	RY845Cj+hW1Xtlveotx9gzsiURuM7yOXI3An6Vbj+zp8MMv4Cu/KHCUG8BPu5iIY6SjMKRgdupbGo
	A4BEHJBtZ4TWPZN4jsxKfGKQCfOY4zZOHfUd4f16U2bU8mOTdYkRp4syUeIUXPt4r+vB7kVOixMoT
	CvUNfWTzwYQqhCv7tkGSQsPe9qEuEPXA0Uk0+X7kj2gRIv0Gd8jMLkkHE9dtY29ILAe29QgS+9FIt
	GOz/WXNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkWQC-0034H7-1p; Tue, 09 Nov 2021 19:04:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkWQ9-0034GA-Ag
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 19:04:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5699E6117A;
 Tue,  9 Nov 2021 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636484676;
 bh=zlAae5OlBeiL0j5fV8vDKlakayQl/be15LtfAF+OImM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EXiwdpu5BFQbqbGySQKTXXUwxGA+5t9WcjOt2yQlpwGnzaFsGBYmaDaWDwWQpU9OC
 FfkxydIm4X6irOQXC3giIK4OZ+M9KkDF+pOXPJeBRaYbMXL9diWToX1Oct7Tq/9zQJ
 lcPEiMT0EnYuWScfvPq8beLpWM8lZsjkKKySuebM0SuCu+JvR0TT4YxEodKj5DxpVY
 6oLenpzy4Z4zCGiVWjrLMGEHGbcMsg6uJYHR99G7/vcNHlLbJwkF3GyxHs+a2eRvYh
 Yxc69kVVAXU6vJHyhnEKm3JEunkjHHWvsi53+QfDZg6GNspGQbGfntBHjARAEaqlon
 XGnOuKdIafp+g==
Date: Tue, 9 Nov 2021 11:04:32 -0800
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, chaitanyak@nvidia.com, oren@nvidia.com,
 benishay@nvidia.com, borisp@nvidia.com, aviadye@nvidia.com,
 idanb@nvidia.com, jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_110437_423170_8F27646B 
X-CRM114-Status: GOOD (  29.72  )
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

On Tue, Nov 09, 2021 at 06:59:05PM +0200, Max Gurtovoy wrote:
> 
> On 11/9/2021 6:15 PM, Keith Busch wrote:
> > On Tue, Nov 09, 2021 at 03:31:02PM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 09, 2021 at 04:23:33PM +0200, Max Gurtovoy wrote:
> > > > On 11/9/2021 3:15 PM, Christoph Hellwig wrote:
> > > > > Max, if you can't point us to a broken target (and yes, it is broken)
> > > > > this will not go anywhere.
> > > > Any target that uses Apple device as backend can be harmed.
> > > > 
> > > > Most simple example is Linux PT target that copy the sqe as-is and passes
> > > > it to the NVMe Apple drive.
> > > Take another close look at how command_id are assigned my Linux driver.
> > > We obviously do not pass it through as that would be completely broken.
> > Also worth noting this driver has always defined the command id as a
> > __u16, not __le16, yet we don't have any bug reports from big-endian
> > hosts.
> 
> Right, my bad. I thought that the pass-through target uses the same id.
> 
> Linux PT target works fine.
> 
> Bad example.
> 
> Linux kernel world is covered but I still think we need to add this ability
> for fabrics controllers as we did for pci controllers.
> 
> There are a lot of vendors out there with their optimizations and solutions
> and by adding some code to cover a broken TCP target (that no one said what
> is this target and why nobody fixed it) by default that hurts others (even
> if it's spec compliant) is not a good practice.

Could you qualify the harm this caused? The command id is just an opaque
cookie; the target should not do any interpretation on it, so this
encoding should be inconsequential from the target's perspective.

There are more hosts than just Linux that may encode id's with flags for
driver use, so non-compliance here is just asking for trouble.

If a vendor wants to constrain the command id for some vendor specific
optimization, they should bring forth a TPar and fight it out in the
workgroup.

We did get bug reports that not validating command id's will crash the
kernel or corrupt data if an unexpected response is observed. Even
though the incorrect id is not the kernel's fault, we generally strive
for resilience against those types of observations in spite of
potentially flaky hardware.

