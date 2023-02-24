Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582B0C64ED8
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Feb 2023 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIRKwcd/5+cJt1ZOc988tUesn2F3S92dlhQfq4NUUzc=; b=QFcj61QU/W9skMToHc93rmRAVL
	XVBClZGjc6IklOuRDq0an72mjo5az7vyKBgdwryGdwd4Dl+9XBSPaEdBAQ7ABHBYPyMirID/x1shi
	vchiurCLIMG9Y16g6Ge4MbuH7g9tTGyQ56kZ0I5ZtnYtRLCArzTi7QuFkfDitlIo0iJGtagPEu7xA
	QHX/gR2iEbUZ0pO/tPJrdJ9hsHjL2fMbdeSGu+DGUbq/BYIbX+Hy1vVdCTHhw41bLgXhMAN5Lwd96
	GJmI7EJnaOyPTkoC1hBI+bqkdjaqB+BYymtdUbXkb8ZuuL7dNcRyOrOV3nXv6jU0aFZs9NOYI4scB
	k5NBTgrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVTtT-001bji-40; Fri, 24 Feb 2023 08:57:31 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVTtQ-001bj5-Bm
	for linux-nvme@lists.infradead.org; Fri, 24 Feb 2023 08:57:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05C335C3B9;
	Fri, 24 Feb 2023 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677229046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIRKwcd/5+cJt1ZOc988tUesn2F3S92dlhQfq4NUUzc=;
	b=dW21BrHNjJsIk4doMwfJsLijfjhvITmeVGRhYSw6zE8Cqi9VYqDMGZJbKnemzZudV6W8rC
	boBtvmJeb5pvDinaaBU3n8rQpxrzCMsPA5Giyr2cPXmV9UNOOXzgdNuNclGKJJYV/aj18T
	zcLrPiy4H/Zvw9DcgZtYzlg/ZsffSms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677229046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIRKwcd/5+cJt1ZOc988tUesn2F3S92dlhQfq4NUUzc=;
	b=zZYtU/nm+ebr1OPxpx4E9XnMuCVFY7Za6ZCJ8V4QipaBmtF6N8OHbHYMpS7kp6nIBOKt4w
	WjOWPImYA8mQS3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAC8213A3A;
	Fri, 24 Feb 2023 08:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QzQAOfV7+GOLKQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 24 Feb 2023 08:57:25 +0000
Date: Fri, 24 Feb 2023 09:57:25 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230224085725.girihudjbjjhbxm2@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
 <20230223145336.lulowpv3vlr65lwu@carbon.lan>
 <63b276e4-a7eb-f493-fdf7-8dc343aaff50@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b276e4-a7eb-f493-fdf7-8dc343aaff50@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_005728_572638_5FA94B5F 
X-CRM114-Status: UNSURE (   7.43  )
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

On Fri, Feb 24, 2023 at 09:45:44AM +0300, Ivan Rubinov wrote:
> (base)  ✘ user@arch  ~  sudo nvme id-ctrl /dev/nvme0
> NVME Identify Controller:
> vid       : 0x10ec
> ssvid     : 0x10ec
> sn        : 2K33292NBAUE
> mn        : ADATA SX6000PNP
> fr        : V9002s94
> rab       : 0
> ieee      : 00e04c
> cmic      : 0
> mdts      : 5
> cntlid    : 0x1
> ver       : 0x10300
> rtd3r     : 0x182b8
> rtd3e     : 0x1e8480
> oaes      : 0
> ctratt    : 0
> rrls      : 0
> cntrltype : 0
> fguid     : 00000000-0000-0000-0000-000000000000
> crdt1     : 0
> crdt2     : 0
> crdt3     : 0
> nvmsr     : 0
> vwci      : 0
> mec       : 0
> oacs      : 0x16
> acl       : 0
> aerl      : 3
> frmw      : 0x2
> lpa       : 0x2
> elpe      : 7
> npss      : 4
> avscc     : 0x1
> apsta     : 0x1
> wctemp    : 373
> cctemp    : 383
> mtfa      : 20
> hmpre     : 16384
> hmmin     : 16384
> tnvmcap   : 0
> unvmcap   : 0
> rpmbs     : 0
> edstt     : 5
> dsto      : 1
> fwug      : 1
> kas       : 0
> hctma     : 0
> mntmt     : 0
> mxtmt     : 0
> sanicap   : 0
> hmminds   : 0
> hmmaxd    : 0
> nsetidmax : 0
> endgidmax : 0
> anatt     : 0
> anacap    : 0
> anagrpmax : 0
> nanagrpid : 0
> pels      : 0
> domainid  : 0
> megcap    : 0
> sqes      : 0x66
> cqes      : 0x44
> maxcmd    : 0
> nn        : 1
> oncs      : 0x14
> fuses     : 0
> fna       : 0
> vwc       : 0x1
> awun      : 0
> awupf     : 0
> icsvscc   : 1
> nwpc      : 0
> acwu      : 0
> ocfs      : 0
> sgls      : 0
> mnan      : 0
> maxdna    : 0
> maxcna    : 0
> subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K33292NBAUE
> ioccsz    : 0
> iorcsz    : 0
> icdoff    : 0
> fcatt     : 0
> msdbd     : 0
> ofcs      : 0
> ps      0 : mp:8.00W operational enlat:0 exlat:50000 rrt:0 rrl:0
>             rwt:0 rwl:0 idle_power:- active_power:-
>             active_power_workload:-
> ps      1 : mp:4.00W operational enlat:0 exlat:50000 rrt:1 rrl:1
>             rwt:1 rwl:1 idle_power:- active_power:-
>             active_power_workload:-
> ps      2 : mp:3.00W operational enlat:0 exlat:50000 rrt:2 rrl:2
>             rwt:2 rwl:2 idle_power:- active_power:-
>             active_power_workload:-
> ps      3 : mp:0.0500W non-operational enlat:4000 exlat:50000 rrt:3 rrl:3
>             rwt:3 rwl:3 idle_power:- active_power:-
>             active_power_workload:-
> ps      4 : mp:0.0080W non-operational enlat:8000 exlat:100000 rrt:4 rrl:4
>             rwt:4 rwl:4 idle_power:- active_power:-
>             active_power_workload:-
> (base)  user@arch  ~  sudo nvme id-ctrl /dev/nvme1
> NVME Identify Controller:
> vid       : 0x10ec
> ssvid     : 0x10ec
> sn        : 2K3329Q7H7A2
> mn        : ADATA SX6000PNP
> fr        : V9002s94
> rab       : 0
> ieee      : 00e04c
> cmic      : 0
> mdts      : 5
> cntlid    : 0x1
> ver       : 0x10300
> rtd3r     : 0x182b8
> rtd3e     : 0x1e8480
> oaes      : 0
> ctratt    : 0
> rrls      : 0
> cntrltype : 0
> fguid     : 00000000-0000-0000-0000-000000000000
> crdt1     : 0
> crdt2     : 0
> crdt3     : 0
> nvmsr     : 0
> vwci      : 0
> mec       : 0
> oacs      : 0x16
> acl       : 0
> aerl      : 3
> frmw      : 0x2
> lpa       : 0x2
> elpe      : 7
> npss      : 4
> avscc     : 0x1
> apsta     : 0x1
> wctemp    : 373
> cctemp    : 383
> mtfa      : 20
> hmpre     : 16384
> hmmin     : 16384
> tnvmcap   : 0
> unvmcap   : 0
> rpmbs     : 0
> edstt     : 5
> dsto      : 1
> fwug      : 1
> kas       : 0
> hctma     : 0
> mntmt     : 0
> mxtmt     : 0
> sanicap   : 0
> hmminds   : 0
> hmmaxd    : 0
> nsetidmax : 0
> endgidmax : 0
> anatt     : 0
> anacap    : 0
> anagrpmax : 0
> nanagrpid : 0
> pels      : 0
> domainid  : 0
> megcap    : 0
> sqes      : 0x66
> cqes      : 0x44
> maxcmd    : 0
> nn        : 1
> oncs      : 0x14
> fuses     : 0
> fna       : 0
> vwc       : 0x1
> awun      : 0
> awupf     : 0
> icsvscc   : 1
> nwpc      : 0
> acwu      : 0
> ocfs      : 0
> sgls      : 0
> mnan      : 0
> maxdna    : 0
> maxcna    : 0
> subnqn    : nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K3329Q7H7A2
> ioccsz    : 0
> iorcsz    : 0
> icdoff    : 0
> fcatt     : 0
> msdbd     : 0
> ofcs      : 0
> ps      0 : mp:8.00W operational enlat:0 exlat:50000 rrt:0 rrl:0
>             rwt:0 rwl:0 idle_power:- active_power:-
>             active_power_workload:-
> ps      1 : mp:4.00W operational enlat:0 exlat:50000 rrt:1 rrl:1
>             rwt:1 rwl:1 idle_power:- active_power:-
>             active_power_workload:-
> ps      2 : mp:3.00W operational enlat:0 exlat:50000 rrt:2 rrl:2
>             rwt:2 rwl:2 idle_power:- active_power:-
>             active_power_workload:-
> ps      3 : mp:0.0500W non-operational enlat:4000 exlat:50000 rrt:3 rrl:3
>             rwt:3 rwl:3 idle_power:- active_power:-
>             active_power_workload:-
> ps      4 : mp:0.0080W non-operational enlat:8000 exlat:100000 rrt:4 rrl:4
>             rwt:4 rwl:4 idle_power:- active_power:-
>             active_power_workload:-

The subnqn string is used to lookup and uniquely identify a subsys. The two
subnqn are unique and after reading up in the spec (chapter 4.5) they are
valid (the Linux kernel doesn't care about the format as long these strings are
unique).

If the quirk is enabled, the subnqn should be

  nvme0: nqn.2014.08.org.nvmexpress:10ec10ec2K33292NBAUEADATA SX6000PNP
  nvme1: nqn.2014.08.org.nvmexpress:10ec10ec2K3329Q7H7A2ADATA SX6000PNP

without the quirk:

  nvme0: nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K33292NBAUE
  nvme1: nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C2K2129Q696LA

And this is all what the quirk does. I must oversee why this is needed.

