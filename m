Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D870D29C2F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jan 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVNWDAs0/xcF9uFydp8tYiJlwebm3iNXB8qxfHM8cNI=; b=LnJhvo+TenWRsoIfWzFWKpAgqm
	BQbFhNKpquKzi8uXlzRRfWxL+jQMszTceAm9tT8n9PkAJweYhcWvmcsyvarHBJHtpNt0+eVHbUZDt
	TP4Oz16JYdWWAiagw+ftKp33EN8C9WCfaDeP+fSZ7z/FTuDn4TmtFi2EXb69dT3i+VwVYDU4R2r/o
	xcEaIsHnozDCi+FBkHmIzwFirgzuYIfBujGpfV9xX2ZbEmeEsLULcumyWur0OE1/p8tuhH5hPS9Ha
	uSMmawUIdzI6x1I4CJ2lFsD0r3WvKewfgCB50cEJv5PF/Fcknr3uOzKUOwJxLxSKpkt/uNbcqMjI0
	lgVR3KKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqDa-00000002FpW-3bmC;
	Mon, 19 Jan 2026 14:26:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqDT-00000002Fow-0xoi
	for linux-nvme@bombadil.infradead.org;
	Mon, 19 Jan 2026 14:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mVNWDAs0/xcF9uFydp8tYiJlwebm3iNXB8qxfHM8cNI=; b=BwVm54IDBgqbWjAWy59V0ivWoe
	NkHsLZAwo7SoUt5g7u/2cpLlcdn5FNDvBSfmEiO8gyUaIngZks54en4vGI2psbPBaYiEcXF9iVT9e
	ST8bTSvX+gV6pk+9fkXa0E+pKOFvfsKDlOIWbrUmT3oZGSlLXbEf70AB++Hbz+51wTTiMXtEwNmP6
	d9RRqE0ve2+Q2j3TiArNSKOa7qcTvEL/pSzJQUs+DrfHMoezpRf+gIR0Rdbylgt1+WMg6Z/GNz6Rh
	mVRQ/HWJsbipfgUPBwOsFAPjaClVGSQ0INh0mV9jnzSXJ8MOPjgG5e6liz//YFH3L/OFxaUDd74JY
	9ZZtXdxA==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqDP-0000000CGS5-31WB
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jan 2026 14:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 30DDF43BFA;
	Mon, 19 Jan 2026 14:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4941C19424;
	Mon, 19 Jan 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832804;
	bh=zYgPbUIvOI/eIYcLAUkaAfmyJoWuvHhnUe5EkIKG3qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmFJt6Mw/5KVucLHrqBHkKImBW4D9anZGrDzR7DQ0z+TfTHQjB/JLG3sij3qK0FDT
	 N9dTP1ieNYwddPogZcPsYykDCnziU7O/cKnIVud/yiOubFUoQVnYPmQJtItcrcPVZ2
	 P/NPA9bzvx5f1C5FnYmICbzEMk48qXwuD/JnZBKCqAtaL4Dc6+EE8G12Ghjif00rxL
	 jXxZBvWZ2LCJCPHmFOqiXxiUTtzP8JNcqMbjfILHZAVkRntiN9fvfNRetSN78bClse
	 HGsElR3adIdLZlThgAqzTg9R+F7H6RkuzWzJAZjLXe5ooCaCtj3cGfsNTp0zmSikOx
	 95itlDDyxK4LQ==
Date: Mon, 19 Jan 2026 15:26:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260119-bagger-desaster-e11c27458c49@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_142648_025283_4A0DD010 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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

> (1) Fill out the following Google form to request attendance and
>     suggest any topics for discussion:
> 
>           https://forms.gle/hUgiEksr8CA1migCA
> 
>     If advance notice is required for visa applications, please point
>     that out in your proposal or request to attend, and submit the topic
>     as soon as possible.

Hey everyone,

This is a reminder to put in your invitation request for LSF/MM/BPF 2026!

The sooner you do this the easier it is for us to plan and the less time
we have to spend hunting down missing attendees just weeks prior to the
event. Unless you're really hankering for the special-snowflake
experience please do your part and get in your invitation request.

Please also don't forget to pester^wask^wremind your respective
organizations to consider sponsoring LSF/MM/BPF 2026.

Thanks!
Christian

