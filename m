Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15057C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kheKSJR7ZObrBS0AH/9NiDGW+t/mS166QpvKgtSP8nw=; b=nhawP0k9dS8gMH/0qDvcXWybb7
	44Qz94/KaEwafOMzI13VpACfvwJevaDBpQgeVoDlicStme8WLlfXTRnraiV4yzryX+yKGDOStAHGe
	ThpWEnKLIy8so6Oaz9p9ZVGXlYdt9kT3NB8d7qIvNdZW8TEW5n5M/RigTtLNVYdls7pNwaJ6OFGtp
	9sPmFeIQQ3ers+StI3W4iKKQRjimO5fbA3+PgebsfysdO2pAJLgqVmAB2EeBZ/2lD2/On3Oft9c7E
	bkprSTVLyRPEt4YBDsWKpJZuTDlZSjxDdlV2laod1Z2OHixM1bh82mndMMCm3XFocO/65ngpqA4DV
	13iUADyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNa55-004vUr-NK; Fri, 25 Feb 2022 12:52:19 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNa52-004vSh-7S
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 12:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1645793530;
 bh=9lcoOLsGCXLhkybsvev0q1tU/jL3rCQ5FnCyxRe43og=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=Jd/SsLoPixrR02DgY9hWbozzLSPPbGTNJnOW7wDsw/ZrlZX9EduwaxRHuSJO5jDdl
 4GLz8WqWjsUHRFAecNL1seO6geNv2sb8+IbG0dcUyhS+YRqJSCrxsqZTT6t21hNJIg
 qqBYTLJdur5M2gBEV30oIOLZPF68G7Cq+4w2vl4Y=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id F1F4F1280D51;
 Fri, 25 Feb 2022 07:52:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id usP77mWu0meA; Fri, 25 Feb 2022 07:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1645793530;
 bh=9lcoOLsGCXLhkybsvev0q1tU/jL3rCQ5FnCyxRe43og=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=Jd/SsLoPixrR02DgY9hWbozzLSPPbGTNJnOW7wDsw/ZrlZX9EduwaxRHuSJO5jDdl
 4GLz8WqWjsUHRFAecNL1seO6geNv2sb8+IbG0dcUyhS+YRqJSCrxsqZTT6t21hNJIg
 qqBYTLJdur5M2gBEV30oIOLZPF68G7Cq+4w2vl4Y=
Received: from jarvis.int.hansenpartnership.com (unknown
 [IPv6:2601:5c4:4300:c551::527])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1D461280BA6;
 Fri, 25 Feb 2022 07:52:09 -0500 (EST)
Message-ID: <c97132f444ddb45dcbd4561df0a0c045dbcc2192.camel@HansenPartnership.com>
Subject: Re: [REMINDER] LSF/MM/BPF: 2022: Call for Proposals
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Josef Bacik <josef@toxicpanda.com>, lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 25 Feb 2022 07:52:08 -0500
In-Reply-To: <YherWymi1E/hP/sS@localhost.localdomain>
References: <YherWymi1E/hP/sS@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_045216_327777_B6E91068 
X-CRM114-Status: GOOD (  10.47  )
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

On Thu, 2022-02-24 at 10:59 -0500, Josef Bacik wrote:
> A few updates
> 
> - The COVID related restrictions can be found here 
> 
> 	
> https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/
> 
> - We are working on a virtual component, however it will likely not
> be interactive, likely just a live stream and then an IRC channel to
> ask questions through.

We've been experimenting with hybrid over at plumbers.  Our last
experiment at LSS in Seattle managed to get us a successful interactive
two way A/V stream for a live Q and A using Big Blue Button.  We
collaborated with E3 on this (The standard LF A/V provider for OSS) so
most likely they'll be who you have in Palm Springs.  We were planning
to go for another trial at OSS in Austin, but if you'd like to be our
Guinea Pig, we can put all our infrastructure at your disposal.

Note, your hotel uplink may not support doing this for all four tracks:
we estimate the uplink bandwidth requirement at around 10M per track
dedicated, but we could try it on a single track.

Regards,

James



