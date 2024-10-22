Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B65CDD0FF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uk/euQiSfMOS4mByAaTp457YCIIfi42DurYEaELQS1E=; b=VEIrrH3Xw6pyXnQ4ObOOj4Szmy
	PXQ4ENSqXsz+R91sh+alTzgpLoYVK1OCTBtFuzzuQ1HxCsX4uZd05D7/W35jWXKJuJnzd2SE0OSUL
	/+Tw1kT2oWYrCRDM+hlGS7LJezeRpNnSh07tLTMynkG49ZbO/8wkwv2kC/sRs2pK1ANy0HD986nB8
	rst9qI1AnJZDd9GiOMERQjDElIO7XvRxhCZE7Ab3JefdL9QQwoS9G9ZD8GPhU8qE4vM7NiqAOwjhS
	Bd3khkvQ/RM45ZhEolJ18D0W/GOUr0edtJj/FNqiQFmidxckmxi5L37VRNhoviHcBaHm0weclelW0
	Qr8Iz68g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3O2z-0000000CPaa-3iWM;
	Tue, 22 Oct 2024 23:12:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3O2x-0000000CPaB-1bPC
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 23:12:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3E66E5C5CF3;
	Tue, 22 Oct 2024 23:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BEFC4CEC3;
	Tue, 22 Oct 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638734;
	bh=gq2WQl2AUVFCzvlksQy7SFSC3bLekLTRFPZjvgGCA4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDWlD5romleOFrg4ZUoUeUrtXIqTrwJ6kGiMjFqsxWDN48fztBX9SYE+l4XQxHZB7
	 aM4c17KS1MikIBpVq4y2F8OFc+q50K0d8fGCtVkw8cFYhnfJf9YiyfKJLIPSceHhZE
	 HF28E+KjNKC8RlKy4y1acqvvzmFxeSJz+lZOmm1jjoD5XQbatbxYm5F2arHICSco2J
	 /C1yGf7g4LWpqtelVMHHiDzC/z19936QEtThzRAZPNqhCHeSjZjISRJruY1ZWcSeex
	 3fX3ZH6INg/6lntyWvh7lSJ80nq2yg348chFFU2APlcxXmDTf/d0WMaU/jOnAwPwTd
	 pAj2fzLbKLDyQ==
Date: Tue, 22 Oct 2024 17:12:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: pallas wept <pallaswept@proton.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: x2002 Errors from Corsair P3 Plus
Message-ID: <ZxgxTKTtebOyZq0j@kbusch-mbp>
References: <jvHjYW6DhvfuRsFL46GsoefGgOwF5IWcmq0u1UPhMbrALDMj6935K31Zyl_dHKz3WIuO4Fb5NSkTLJT01xD3TA3Rh9XsHPuPaNrVxC2AiIQ=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jvHjYW6DhvfuRsFL46GsoefGgOwF5IWcmq0u1UPhMbrALDMj6935K31Zyl_dHKz3WIuO4Fb5NSkTLJT01xD3TA3Rh9XsHPuPaNrVxC2AiIQ=@proton.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_161215_485544_63B351BD 
X-CRM114-Status: GOOD (  16.34  )
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

On Tue, Oct 22, 2024 at 11:03:18PM +0000, pallas wept wrote:
> 
> I've searched about this and I understand that these errors are
> nothing to worry about directly, but I also gather that for some
> devices, there was a means to avoid these errors being logged. I saw
> some discussion of a 'quirks' database? I'm wondering if maybe the
> same could be done for these devices also? They're quite popular,
> being Amazon's recommended NVMe drive, so maybe it's worth it.
> 
> Advice from github https://github.com/linux-nvme/nvme-cli/issues/2540#issuecomment-2430454238
> suggested that I provide PCI IDs, would this help?:
> 
> 08:00.0 Non-Volatile memory controller [0108]: Micron/Crucial Technology P3 Plus NVMe PCIe SSD (DRAM-less) [c0a9:5421] (rev 01)
> 
> 
> Presuming that I have correctly interpreted the issues here and
> nothing is really wrong, my goal here is to get a clean log when
> nothing is wrong, so that genuine errors would not be hidden behind
> the 'noise' of spurious errors.

I think you've interpreted correctly. It's most likely Identify
Controller NVM Command Set command, like everyone else. We have a flag
to make sure we don't repeatedly do it, but there's nothing that turns
it off by default. I'm pretty sure there's no way to tell if a
controller supports it or not without trying it, but since this is a
common reported problem, maybe we just quirk it off so we never try it
ever for some devices, or come up with a different criteria and
potentially skip devices that might support it.

