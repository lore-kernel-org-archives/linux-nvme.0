Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B99CA9EAF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 06:32:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F352067D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MfFNTOvH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmoKMAvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F352067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JUvgKNzVgHdtf8+9G/wdkWdB5SYzVOTzLotTyPj2pok=; b=MfFNTOvHuJfS6o
	FS62XkOzZOZUQwvXjbzs8VZ3HU2V0qNkOuarfQXLtJAN9Ua1nb38aa87mFkKvAy3jKFPUQa69X/84
	7hz/Viaxfu56IPfKgIRXJu6ql4QG7/MUbEyXE3gbk50UdOXU8e8f/HNSaCkO1rrvNnY+OdVNwvaVa
	Qstib9R10E5Bf/yzAxJQnjb+PPbCkZHv9CT7j5DAQ7GkEe64sONIKpd1o0bAD9eGM1BH+TJ31j18M
	tkYKx67q77x9UhmDV4A0KrdaUwzTYFxM0bBBlVgggUNOpTvjctt62JJ+XbqQ94fAQlxCB3bqVw0rc
	HtDfFs2hQ0FsWefbsw+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPhX7-0002Wt-DQ; Wed, 30 Oct 2019 06:32:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPhX4-0002WM-RZ
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 06:32:40 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B6422067D;
 Wed, 30 Oct 2019 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572417158;
 bh=mQJzQyGGNJJMVNEsin/hOVoiQxTy3AVKsq4SaWHqdoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YmoKMAvz7GNgT70k0mfyfKvU1eFSZXqiqwhxHJI511Ssp7fCRjNfuE49Q3xMTm8vs
 71ZL5eeNfQVtp0Rl7MxXfXZrv2Ka/imud//Wfygz0QcTzCrC9+WKU07V9tvNE944Qj
 ilZQ2tDhxyrBkFdtLhon6YewDT3Biu+NTJk4U6Ts=
Date: Wed, 30 Oct 2019 15:32:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Charles Machalow <csm10495@gmail.com>
Subject: Re: nvme_passthru_cmd64 has a 4 byte hole
Message-ID: <20191030063233.GA16863@redsun51.ssa.fujisawa.hgst.com>
References: <CANSCoS8HakAy6zHgEjDiYQ87z83RJy-OC9ZfktRJwr+9kgnFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANSCoS8HakAy6zHgEjDiYQ87z83RJy-OC9ZfktRJwr+9kgnFKw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_233238_915721_623635A8 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 29, 2019 at 09:43:20PM -0700, Charles Machalow wrote:
> Hey all,
> 
> I noticed (via some debug) that nvme_passthru_cmd64 seems to have a 4
> byte hole that isn't currently accounted for in the struct:
> From pahole:
> 
> struct nvme_passthru_cmd64 {
>         __u8                       opcode;               /*     0     1 */
>         __u8                       flags;                /*     1     1 */
>         __u16                      rsvd1;                /*     2     2 */
>         __u32                      nsid;                 /*     4     4 */
>         __u32                      cdw2;                 /*     8     4 */
>         __u32                      cdw3;                 /*    12     4 */
>         __u64                      metadata;             /*    16     8 */
>         __u64                      addr;                 /*    24     8 */
>         __u32                      metadata_len;         /*    32     4 */
>         __u32                      data_len;             /*    36     4 */
>         __u32                      cdw10;                /*    40     4 */
>         __u32                      cdw11;                /*    44     4 */
>         __u32                      cdw12;                /*    48     4 */
>         __u32                      cdw13;                /*    52     4 */
>         __u32                      cdw14;                /*    56     4 */
>         __u32                      cdw15;                /*    60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         __u32                      timeout_ms;           /*    64     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         __u64                      result;               /*    72     8 */
> 
>         /* size: 80, cachelines: 2, members: 18 */
>         /* sum members: 76, holes: 1, sum holes: 4 */
>         /* last cacheline: 16 bytes */
> };
> 
> (Since I doubt we can functionally change the structure at this
> point...) 

Well, there is no official kernel release using this structure,
so I suppose even this late in the rc cycle, we can change it with
appropriate justification. I think an alternative to padding is to make
this a __u32[2] field, which should also be backward compatible with
the 4 byte result passthrough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
