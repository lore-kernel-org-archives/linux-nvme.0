Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE9C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:57:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9587B611C2
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9587B611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MoQNHE0v3sSPn7+OorPFjLDdu1o4w45VO5qs4eAXkuw=; b=PYFSLK5KUkEWa97tUWVgJsq9u
	rdzLtJCISaBAfX+DTGUWVe5bzv9NSb2RAmuhZR5vZ0hWt2/rmoNZOsnYorTR9sqQSmstf3lAm0lEF
	h3B9r+zCWDuHTAEXZ9tE9ueFUG8z1CvdoTo7lJIFl5Dw/iwm2HbA+KZG+vtZaM3Ja0w4gJJKgq5Xg
	ld3p0JDCTErOMUEjuKfw5Ic2f9mNlu+7xDWzndFgHi60C1ecGtC1OAxxuEXaFYPPOgGrt6VhEAhyO
	Pv/TVGjWkuwdNA2JeF7GFpT3h6LD4bohEtTxrZlpqmAQIz28BXBqXE5a+HdfN8KAvGu2ojkcXy2Tz
	Cvwk9d5fQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXQqA-002i33-Eu; Fri, 16 Apr 2021 15:57:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQq7-002i2l-8h
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 15:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7d7QovfgpTpJrnkSkPHwe7ftuVNfy2k4JASpm8PnYRE=; b=gm3qH6k16qPfVyGcWYOxtGKHoW
 JyDzFax0Zyew8doHNLTuJv70P5rgJGWFSUtki2eOYNAdBzzb0NWMfdR/tAkI1wyo1qHLWUG8L5WQo
 Q3buAE1CBabKN2Pqv+s2PZ8YWbMgWSp7DBFLKyZDjgSykgpyuNJT1tgb2TFOy0+CJ9zfT+89e657l
 MNJC5daB5ZPiuEtdiPtbrePibYC3/h6Rvd81oSs17mn9n7VKyUEVQGY9dWPf3+bkunlppBFMoj+5E
 uAyrE/TbuOzgLWXZhG5V9r0s5X26o8m7nZs9kkQpdhyR0dOKWIUImaxj1jCLBTvKwcsYb0ZKNGoHW
 O//xxKYA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQq4-009WuV-SX
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 15:57:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08876610CE;
 Fri, 16 Apr 2021 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618588619;
 bh=O00x3WoqG//kJyJftw2hAUxtBiQzR9vHjG/0/3YXKms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rHLk2Akxo47x+91d0TfZb0S1U/YqkzBuF73V2AwBIjNZHypJdB9AxKNAapAWaN32Y
 Q2Avy28W2Hb0W4fITujfO6nshCdrn05cBOxHdvbhHDvrPmoq7l4RooAnXjLxLbFMc3
 UXuS2TYzWUa3vHCSnlw234UVFsjOkyCvpuTZ/6wYRmAgdSy3iS1O2rUAdrxydZsyg1
 mPL51E1M7zjBRhevWKevMhPZdjLmpohmzO+dRRXNJ7eqn3frHRi1AkdIBEgKSxBeor
 1KOtqGigdIyCuVEwaDQX14fnIVQyEG6f3RtLhd1nVGl06SqocmQhzpKQDQCLn6X0KC
 7q9YYG5pJpVCQ==
Date: Sat, 17 Apr 2021 00:56:53 +0900
From: Keith Busch <kbusch@kernel.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, hch@infradead.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org, Alexander.Deucher@amd.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210416155653.GA31818@redsun51.ssa.fujisawa.hgst.com>
References: <1618556075-24589-1-git-send-email-Prike.Liang@amd.com>
 <1618556075-24589-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618556075-24589-2-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_085700_955552_B0D8A63B 
X-CRM114-Status: GOOD (  11.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 16, 2021 at 02:54:34PM +0800, Prike Liang wrote:
> In the NVMe controller default suspend-resume seems only save/restore the
> NVMe link state by APST opt and the NVMe remains in D0 during this time.
> Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
> and then will lost the NVMe power context during s2idle resume.Finally,
> the NVMe command queue request will be processed abnormally and result
> in access timeout.This issue can be settled by using PCIe power set with
> simple suspend-resume process path instead of APST get/set opt.
> 
> In this patch prepare a PCIe RC bus flag to identify the platform whether
> need the quirk.
> 
> Cc: <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Just a "Suggested-by:" from me is fine. I'm glad you were able to
confirm this is successful, so I can add my Ack as well

Acked-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
