Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9DDD7832E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fO9AlRctK2v3CrMrGVPyNEF1XOrnNouYnj2+jyPUZVo=; b=X2ZVdhUzEKLGJhpWmB862eG8zh
	3qGEY3EHLceCvxr939gBkXtLELxuH/7VXJiTSGyPgMOD95qH3nYQf7uy+P0+KPNN0PQXeUHWlvpa8
	inx/4yj1AhxB4sB0hgALqrRUWcpo7c3dmERUcn25KY1tG8xUT3MHiN++zCMnmDuCmSxKYRljtNmF/
	Zv6n65E92osfo9Rb3UnZXSySci86+s0SYpRldaOlTFqE5k2VYoUyIqc6ynDMA3nid0SZ6yGApVZt2
	J8WR9LpNWWH1pzh4n5tnkFP87dH6U0aF3LQo23kJ5rPZN4+GFiBk8Ge//7wDGWRomMAv/PDIhVTLv
	cxVgVo+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7zj-00000006ZXE-13lC;
	Mon, 02 Dec 2024 15:05:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7zD-00000006ZS7-1noH
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 15:05:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 17FFCA40ECA;
	Mon,  2 Dec 2024 15:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1E5C4CED1;
	Mon,  2 Dec 2024 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733151918;
	bh=+6lpR9j9Cd3RYWsce41GRUKeHGapgAFdvoXdRbQIVvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfM4GXPMfnC07ZDkZSt+x+Ct+h0e2YexQx3uL+ZrfsV/yfK63RDUn1oitZ4yErFM0
	 lD4OH/VOIqKyN5wbB5tMfwRx3J+BAzgUYESVABvBVYvLXsAnUqQWF5rs3crM//010I
	 td/OZtP+0toeMIR0rceWetImlIIFn+Wu9SGk1Gwjgp+JoX+kWUs19oa7Lqr6E4VSXz
	 ayli2NjXZKcJLHILjIKpgGDdyabKlWtOQDcxpHjQvEj9IrcZigpWjQYdtQ57Jp/lP2
	 KKiTk4RUQOKSrfLj7N6xZCpv/Gl8xcur3Ns/FpZiUDxWxN6aijDteNCq6IsemnNjrA
	 mJaCUlC1UUutA==
Date: Mon, 2 Dec 2024 08:05:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: New warning `nvme nvme0: using unchecked data buffer` (was:
 [PATCHv3 3/3] nvme-pci: use sgls for all user requests if possible)
Message-ID: <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
References: <20241118155738.2737423-1-kbusch@meta.com>
 <20241118155738.2737423-4-kbusch@meta.com>
 <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_070519_534656_E7367E3F 
X-CRM114-Status: GOOD (  19.21  )
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

On Mon, Dec 02, 2024 at 08:56:03AM +0100, Paul Menzel wrote:
> Am 18.11.24 um 16:57 schrieb Keith Busch:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If the device supports SGLs, use these for all user requests. This
> > format encodes the expected transfer length so it can catch short buffer
> > errors in a user command, whether it occurred accidently or maliciously.
> > 
> > For controllers that support SGL data mode, this is a viable mitigation
> > to CVE-2023-6238. For controllers that don't support SGL, log a warning
> 
> For the layman, what is this security problem?

The passthrough interface can't validate buffer lengths against the
command's actual payload. NVMe traditionally did not have explicit
buffer sizes encoded in commands, so this only works correctly if the
device and host both agree on what the implicit transfer size actually
is. More recent NVMe features fixed that problem with explicit buffer
sizes in the commands.

Whether by accident or on purpose, user space can request a smaller
buffer than the device is going to transfer into it. That will corrupt
memory.
 
> > -	if (has_metadata && !supports_metadata)
> > -		return -EINVAL;
> > +	if (!nvme_ctrl_sgl_supported(ctrl))
> > +		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
> 
> Linux logs this on the Dell XPS 13 9360 with PC300 NVMe SK hynix 512GB
> (firmware revision 20004A00).
> 
>     [   14.399238] nvme nvme0: using unchecked data buffer
> 
> What should a user do about it?

Nothing for a user to do. This is an indication that the passthrough
interface has been used with a device that can only use implicit
transfer lengths. It's more of an indication that improper use of this
interface might be the cause of memory corruption observations.

