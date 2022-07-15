Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5453C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=; b=AMAseK0xL3/TLE1E2YOb5hN8W7
	DzyonqAvBTCnfhsmOJ5PwchJfqTE+O4vCYg8mQyGowpsvuhTA2CbueUf1tr4AAkPRL9kzTbPf4vBo
	LF+vqQXfQBGESo8TDLOPFotrtvofseOOU6+y5J0FXmZdgJ6cQqjSC9TxacxDLmYPOE1u4qsEojn99
	fh043nrZTWsIFMMThLRYeWr3sccCjb9OhSZygB1+BHqborgtSVLpfkrWTY7WXJlxXe0ogen2+gJvj
	JvvXbsy4KqVf5YWAL8qcc80nX004ztIPOs4IesEdF2oVSo090sHTMCTJCAPX8u8Q1gvsuMe86fJDo
	R+OTFCWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRM8-009wTX-1E; Fri, 15 Jul 2022 19:52:08 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRM5-009wQh-HB
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 19:52:06 +0000
Received: by mail-wr1-x434.google.com with SMTP id b26so8144358wrc.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=js49Vuv+dqdpAQkHI9F+F/qf8Kw2nyiSwKlBIFQQHL7uM7G/SRteANKwRC0D5rutBM
         lRuJ2gi7kPkZDetRJeDugTcS3gtBv1nmqHP8R5VNWwq6v4T1aR3AERqkKtE3B2/cSn2w
         fvkDOT3RSZSEbMjkvSci+PeP6MNGVYzG8f2i65yt77cl/vOjOuR09OrR4tgP2Is8XhXo
         RQSpjQwTlQ/k/CvARRkb9P3CyCFKFRkgFlfuha9660OVH5gAbAniaXjf60OMuXxfq+5g
         jaTWgugHEjZyQFwbx7VEijdfxPo5hzyShYea+6a1HL5g2vXfKHW5bpNf6AR9vvKooiR6
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=yQ+5IpbHb/pIMVc5ruADJmAyTeMBqywmwwn2YthTz+UM+ChW/1UOI++tsuhAnjWr86
         0NH55anc/b7IXbFq3OC9rQo6piJpfqv8aU0YcYR5V+O6v2Z1Y+PD3uTjyc+y50G88ibM
         1abG3lacic8uvHiYM2NSyc0rAhR/AoEmfIGZatj1qoi1ZPP4vqle5FP+1XHZVOqyPQ1B
         AckNwBUC3UeR1NAdLTEqbfHaWnNZAsBjWx771ew0IuB5X8QjpPkCrUCVkjlsULTcczTx
         9iUAQacrE0iCUPau5Esy3FyKQPBpdvgJPaSCdbeWYPWZ/88CyoH+sm20G7M3/a+ZeB5d
         uk6w==
X-Gm-Message-State: AJIora8HAUk115Ytdqx9TqCl6HWxtlsafsFrdXV6NqSrmRzr7mVysdak
	lIgyEZZN6YeVaLLqY7rN6qAhnoKCgAvMPubUz8Kx
X-Google-Smtp-Source: AGRyM1tKdyxJ6v9iK9VYvhls34IXjSi0vTfVMFlwee16Wy9Y/gwgKOIz8VCFowTfs82eiFn6mMPxqXEzbs16sJVwfo8=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr13851074wrp.161.1657914719053; Fri, 15
 Jul 2022 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714000536.2250531-1-mcgrof@kernel.org> <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org> <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <YtG5zRPFV967/y0v@bombadil.infradead.org>
In-Reply-To: <YtG5zRPFV967/y0v@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Jul 2022 15:51:48 -0400
Message-ID: <CAHC9VhS_dy_qeY=7KnSqs0ZT9dzAbSEyq5WMNKvZTD5=oreGew@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file op
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: casey@schaufler-ca.com, axboe@kernel.dk, joshi.k@samsung.com, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_125205_600625_85A030F5 
X-CRM114-Status: GOOD (  25.27  )
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

On Fri, Jul 15, 2022 at 3:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Fri, Jul 15, 2022 at 02:46:16PM -0400, Paul Moore wrote:
> > It looks like I owe you an apology, Luis.  While my frustration over
> > io_uring remains, along with my disappointment that the io_uring
> > developers continue to avoid discussing access controls with the LSM
> > community, you are not the author of the IORING_OP_URING_CMD.   You
> > are simply trying to do the right thing by adding the necessary LSM
> > controls and in my confusion I likely caused you a bit of frustration;
> > I'm sorry for that.
>
> No frustration caused, I get it.

Thanks for your understanding, I appreciate it as well as your help in
this area.

> > Well, we're at -rc6 right now which means IORING_OP_URING_CMD is
> > happening and it's unlikely the LSM folks are going to be able to
> > influence the design/implementation much at this point so we have to
> > do the best we can.  Given the existing constraints, I think your
> > patch is reasonable (although please do shift the hook call site down
> > a bit as discussed above), we just need to develop the LSM
> > implementations to go along with it.
> >
> > Luis, can you respin and resend the patch with the requested changes?
>
> Sure thing.
>
> > I also think we should mark the patches with a 'Fixes:' line that
> > points at the IORING_OP_URING_CMD commit, ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd").
>
> I'll do that.

Great, thanks again for the help.

-- 
paul-moore.com

