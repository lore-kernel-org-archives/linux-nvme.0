Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31EAC5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0E+P1omKRFLyPSQ8NpgImrHVDYGmebmCfhdAnGAwdjQ=; b=wO7aaQ7lnOd94FUx0IIQ6wmFP6
	C8OkN9+pwf5Ys8R9VSv5Kuu0A2kJ2NjI2hOnBogoDY8uRoiuqVU80XVRCLLmurL8DyXjlpxK/Sxe5
	rCFr/HHpyWhI8AJGq5mYv3hU+EWCMPk7/9TQePb/pE+0TbGC1fPHkmGEZnY47kQRPHT49cvfAZrHn
	5NnsL1mgY/k5mWxzmcrW5tB62XMum4lIY0pqB+WoVG2xqT8eTj/yUP4TCL7aIn8VrP43jucLuCDYR
	BYSbx20F6/KXI4knvqbnEPz4q6OP2ziz/Uy12nHVTGBSyYCDG3GDk8VDnIDLfBiRRGxmG2iVCSavn
	H4KLpYNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEpZd-000rab-8H; Mon, 09 Jan 2023 10:40:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEpZa-000rZE-7Q
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 10:40:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 281B933C49;
	Mon,  9 Jan 2023 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673260808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0E+P1omKRFLyPSQ8NpgImrHVDYGmebmCfhdAnGAwdjQ=;
	b=t5fAhAG1Tu78098KIQDPLAW4kDfajQBxU35NlDZol3tIHMyn9GEdkR4uoMlaux8xu6ywVj
	wQBSXIl4qZlp4nbpAcGDiQfyXCytjKV5dmGRiDe5h9NqjxHutqlJl1rJUx2vLF01pKNgPb
	XWr/U5BmgmtcuOSxv2ObnODnTxYagUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673260808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0E+P1omKRFLyPSQ8NpgImrHVDYGmebmCfhdAnGAwdjQ=;
	b=lYbVbPvqXrEOsPVnEFlSu5xtPK3es9zgLMQqRvGdohHk2akZ7Kn4hoh1BOIjtksftlMZ7o
	x/jOefSmSeyCciCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B215134AD;
	Mon,  9 Jan 2023 10:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HtGZBgjvu2PGIwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 09 Jan 2023 10:40:08 +0000
Date: Mon, 9 Jan 2023 11:40:07 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Nick Neumann <nick@pcpartpicker.com>, linux-nvme@lists.infradead.org
Subject: Re: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
Message-ID: <20230109104007.slj5jvrsma3iz7hd@carbon.lan>
References: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
 <Y7h6okidN679ZtPh@kbusch-mbp.dhcp.thefacebook.com>
 <20230109101157.q5j6vbiozphd24b7@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109101157.q5j6vbiozphd24b7@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_024010_428377_9F73D671 
X-CRM114-Status: GOOD (  12.71  )
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

On Mon, Jan 09, 2023 at 11:11:57AM +0100, Daniel Wagner wrote:
> On Fri, Jan 06, 2023 at 12:46:42PM -0700, Keith Busch wrote:
> > There really is no need for user space to do the BLKRRPART ioctl
> > anymore. The kernel takes care of the rescan automatically, so unless
> > you've a really old kernel, we might be better off just removing the
> > ioctl.
> 
> As far I can tell, the current version of nvme-cli doesn't issue
> any BLKRRPART ioctl anymore (although the documentation says so).

Blech, I need coffee. It's still there :)

