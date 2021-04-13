Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB4C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 20:49:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3948561154
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 20:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3948561154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4yKrioykKohEl9hHA+uGd1lAJcwDO7fr9T+kzUUluLY=; b=ECq8xOZn4jZVigSMuXEFh9yVX
	YOCpJPsIcZxwSb+v/DBsrHH+csx0vT6bgdpszE5aXJmWZJrgOeBs0jk971VoIMRlnHlxOVOZ5PyoP
	CmeORYzyPBvcZIsA0dN/izmfWajjHwHGM0rdjQj4UANQm31TQAOVnMsGW3xyo7yQSo9g4PWSaK7rs
	2pFnEgyHO6uN7Q0zYnZEWfHHqUQ90aJWcZjdbX50T+lii3iF288v/WtDHgobM7pTiH/86ZzMuF543
	Gu0H5vWkeqMTBgsor28mMLEoC7OfuQc9AS+dSytXU4NTiCORUojVNE8nVO5zv0hDtGa5Myx9QdNem
	L0libTKjw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWPyR-00ARBH-U2; Tue, 13 Apr 2021 20:49:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWPyL-00ARAh-Ps
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 20:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Tb/b4zUQbjehnyZ78Wu34eGE8M+sOhCmFnIOzBXSQDE=; b=L6QD7jdRTS/g06GgKNASUFvSi6
 TbfnGdvQ8p9uIPA6a/k1Di+i1LVfv7TZnp6sAq1m1qGo1++rt6+ukas2kEL4xwT+tpSxuNbdP6wfw
 WelDSqu0ttHWqdvC8vhofpuyj875HYjRyhVSIzM+7urROvHguH6n9E//T+BpKI9foMfj44FrIJu9K
 1NsyJzslhdR1/Tpy91q0ub1EauUjQ/FDBhTYxSb5o79Y15J659398GTZsp3+cUBAK/ijlP0bT/erk
 iGePMHkkYOcOL3SX5fcQGpUMPc7XurIwwDmhHH3xYmGApKIyt8Ex1iulQvSRLvk2QcayL6IdMmgvy
 tW68m/6Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWPyJ-007JbJ-4s
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 20:49:20 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C70A561139;
 Tue, 13 Apr 2021 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618346958;
 bh=SvA58hW9yp4frASdylYvH7gf43MB6oMtBa0US36i0oE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fganMS/hU3qSqUsYaYdcMiEeO0Osv+OVKAMSqHn1ReXo3RKEbYHKADDHai09YnZX7
 3VPT6YAVPCj3ZGCTSk4hCtVkG9fwiz2ls1HO3MsEWzHep0L+Nz1AuddebyZEUaHpoI
 GIHJktkm+IQGY2tx6TWJUitFKfzXMplJDzJPfTMCdwHkT/JSM9inh2LLd4rFQkLZut
 EHfib+6bHfYaou82tvL07DBn2CLao7Tw6IMf0PcO3tz6RVESYZo5fZjXJT64+qNSky
 1CqVkaXoqR4wPDgAthFvT94Sp8AMKzqaBFTG+9XWk6lcZOEOGjlQKKUPH/oHkmf1VS
 ukmzCgYDO/wUw==
Date: Tue, 13 Apr 2021 13:49:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Gopal Tiwari <gtiwari@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Fix NULL ptr deref in nvme_ctrl_fast_io_fail_tmo_store
Message-ID: <20210413204915.GA2448290@dhcp-10-100-145-180.wdc.com>
References: <20210413102046.544959-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210413102046.544959-1-gtiwari@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_134919_248335_1DA7B3DC 
X-CRM114-Status: UNSURE (   8.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 13, 2021 at 03:50:46PM +0530, Gopal Tiwari wrote:
> When trying to set fast_io_fail_tmo from /sys hit kernel crash
> 
> [ 1749.892646] RIP: 0010:nvme_ctrl_fast_io_fail_tmo_store+0x55/0x80 [nvme_core]
> [ 1749.918344] RSP: 0018:ffffb52541d53e78 EFLAGS: 00010206
> [ 1749.923550] RAX: 000000000000001e RBX: 0000000000000003 RCX: 0000000000000000
> [ 1749.930653] RDX: 000000000000001e RSI: 000000000000000a RDI: ffff98e75e774d42
> [ 1749.937760] RBP: 0000000000000000 R08: 000000000000001e R09: 0000000000000002
> [ 1749.944862] R10: 000000000000000a R11: f000000000000000 R12: 0000000000000003
> [ 1749.951968] R13: fffffffffffffff2 R14: ffffb52541d53f08 R15: ffff98e74fc240e0
> [ 1749.959072] FS:  00007fc551327740(0000) GS:ffff98e79dc40000(0000) knlGS:000000
> 00000000000
> [ 1749.967127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1749.972852] CR2: 0000000000000064 CR3: 000000043f53c005 CR4: 00000000003706e0
> [ 1749.979956] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1749.987062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [66824.400512] IPv6: ADDRCONF(NETDEV_UP): wlp0s20f3: link is not ready
> [ 1749.996612]  kernfs_fop_write+0x116/0x190
> [ 1750.000610]  vfs_write+0xa5/0x1a0
> [ 1750.003918]  ksys_write+0x4f/0xb0
> 
> Fixed by checking opts for NULL.
> 
> Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)

How were you able to access this attribute? It doesn't pass the
.is_visible() test without ctrl->opts..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
