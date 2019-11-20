Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94668C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 19:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6A20715
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KczUfzLW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgYLNcOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JEv+F/r7gv5AlywFYfhMvNtur6JgIwKnMJBEo+cEsy0=; b=KczUfzLWj66w/J
	eWYT1tedlcpJIDcsGWbnUqHq7Kc+OYVdePPV+ojkkibSIQvLlmBm0MPLQwCHIbMytvXsKt2fjXYyj
	M9CKDR7mOj16fwozR295mE9SDB/0pXs/beqPBGnIbZJ3lV7+1JrTEr9WjDOETMjjQVUDfYqlttOiF
	qrlTInbkvBlF0Ja81jaUUnEKHRYimXoxF+/jnZdjut2nZXOCqM+BDTripF0cw/exLshOBUt9Wk5d1
	6HEUSO1mPruUHwrInJLpMSCtfYsmLQLg9CeRC5CYvull1y+v1kag1XK+6RlSFKh0kV5sXZQMvjBlb
	CcdJcjCgPU9D4zxXhF8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXVZC-0000MQ-2X; Wed, 20 Nov 2019 19:23:06 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXVZ9-0000M6-Tq
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 19:23:05 +0000
Received: by mail-pf1-x434.google.com with SMTP id z4so209566pfn.12
 for <linux-nvme@lists.infradead.org>; Wed, 20 Nov 2019 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V3QJ0Tp6bf72YijLpZU1HhM2bvqfckOVDWjydAGu7CA=;
 b=NgYLNcOpKProluX4Nykt5qOyPw43bQYCoh7M48dB34vXBmmkJuXFD/IQjOUAzlOvCr
 NvJ8v4p2E8T6bZuN/DRN1cToSjt6bgEtKnRtc5R7CsT6JE03C6oyZm1Wd5F/gNPLJ8Ck
 KluSVLhOdO0Sh+hsPegaUJCfng34C+kAdi0qL9Mu4vIsDZrjVe8b0jiqsEC3GFt1Lmm4
 NGFhBBz/O3QyE4ZkaMkm2pKgjWWyqmSW/0KerbKsh5HZBGhlwKYCPRIX/sj6IQdpJaSt
 kieadSFz2cFVtyr5XQCYJL6YUmT9anF3bDR0aoQEx64tc84pn8J8I51mIA7r7F7eejD0
 faBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V3QJ0Tp6bf72YijLpZU1HhM2bvqfckOVDWjydAGu7CA=;
 b=BVeqwl5lSFIMgX2vGKagou/1wU/PloeC8tib/WvFKFq+RVoHXGPqLKqkT7Pmw6Z4Ot
 TN0BBjQXqsrrWdFcxbnR9gbCvFn2bLdK/BYYhQod/pU+7IWwL39J47PwdotiTRkHmlAA
 S7TreLUF/OWuuxAHOjOEr2XDu6kGcRv5LXRUAnyu0KYHFZZOEhO5Xl3klyKl7opvibQ0
 MYa2uxGvWO25KyEMdDC+KxBnrm4wF6HXxfHf23tfC1IeWeXyMNX3b5Ppn3Rk8Kewz3YR
 ldNiVV3GLo1DhCGl+uW0+vZMBe2C3KVtDSBuNApW7zaDLIwGEL/egueeuMDwbRNQErSN
 D+kA==
X-Gm-Message-State: APjAAAXfzkwZrFcDohKPWwP2U7cFg4A1AgvAwx6KT+9ZBZgxPI6GpND5
 FQc6a9dM+y6uLueN0ns8ki6MFfl2dRTxP2WVjIo=
X-Google-Smtp-Source: APXvYqxe80Nyzo1fM51xdJHCo2GIv9/Bda6ANBSfuIIATrBcuI0mi0zi32ozyLySgM3QknDtkzinyXeU3cbNEo2cvp0=
X-Received: by 2002:a62:501:: with SMTP id 1mr6085873pff.69.1574277782995;
 Wed, 20 Nov 2019 11:23:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOoKxP99U8E=oAY23wA4_JVQNbPXVnkpcL6_-_zcwCnYDCoBaQ@mail.gmail.com>
 <20191120152935.GA9426@redsun51.ssa.fujisawa.hgst.com>
 <CAOoKxP8XWhuF7ROKsTHmUpsaUvwCJS0ZH7xOXJGUKQvqUOrU+Q@mail.gmail.com>
 <20191120182100.GA11886@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191120182100.GA11886@redsun51.ssa.fujisawa.hgst.com>
From: Sushil <sushil32@gmail.com>
Date: Thu, 21 Nov 2019 00:52:51 +0530
Message-ID: <CAOoKxP_06Qj92GrbnyVQ0tfF0Hp00L-RyMAw6_rr+EYnGZw54g@mail.gmail.com>
Subject: Re: NVM Sets supported on Linux?
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_112303_960160_619C4E61 
X-CRM114-Status: GOOD (  17.89  )
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

Hi Keith,

For this simple use case, I think there should be nothing special for
the host side driver to do enabling NVM sets - although I must
admit my limited exposure to NVMe so far.

Somehow I've a simplistic view of NVM sets at the target side which is
as follows:

Lets say I have an LVM volume of size 10TB and I create an NVM over it
using the target nvmet driver.
Then as per my understanding of the NVMe Spec 1.4 (of June 10 2019), I
should be able to create say three NVM sets of
1 TB each leaving 7TB of unallocated space in the NVM (Figure 133 in the spec).
In this scenario the target driver knows about the three NVM sets and
that they are isolated and their boundaries because it itself created
them?

Regarding taking a stab at it: Sure :) although I will need to come to
speed with NVMe Linux implementations fast!
Also, NVMe is such a hot topic and with NVM sets being an enabler for
new important features such as Endurance, PLM etc., I am sure
someone must have already jumped at it :)

Thanks,
Sushil.




















On Wed, Nov 20, 2019 at 11:51 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Nov 20, 2019 at 11:33:11PM +0530, Sushil wrote:
> > Basically, currently  I want to create NVM Sets on an NVMe disk and
> > export these NVM sets as LVM volumes to VM instances using Openstack.
> > Later on try things like Endurance, PLM etc. with these NVM sets.
> > We don't have any physical NVMe controller with NVM sets though.
> > So I was thinking whether I can use the 'nvmet' Linux target driver to
> > create kind of logical/virtual  NVM sets
> > and therefore whether target has/will have support for NVM sets. Its
> > like how namespaces are created on-the-fly
> > in Openstack during volume attachment using the volume path -
> > /dev/vg1/lvol1 for ex. - and the Nova compute node
> > then nvme connects to these newly created volume specific namespaces
> > and attaches them to the VM instances.
> >
> > So I am thinking instead of volume path, I create NVM sets and
> > corresponding namespaces on-the-fly using the nvmet target
> > driver and then the Nova compute node nvme connects to these NVM sets
> > and attaches them to the VM instances.
>
> Okay, so this is only making a case for linux target driver kernel
> to implement nvm sets. Can we agree there is nothing special for the
> host-side driver to do for enabling nvm sets?
>
> As I mentioned earlier, it might make sense for the linux target to
> report set identifiers for its namespaces if it can determine which
> ones are isolated from others. Or maybe just add new configfs options,
> I'm not really sure about the implementation details off the top of my
> head.
>
> In any case, I'm not aware of anyone actively developing support for
> NVM Sets in Linux, so it may be an open topic if you want to take a
> stab at it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
