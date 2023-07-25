Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FFEB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 06:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0s8zpzHw2Tp0dRt1pC6N27B8HTT+CzeVhlNUqju4wYU=; b=dg3MbbV9u/HL0YD5TJZlohlETl
	h3QnSIRc4bq8nWJH5aOHjrBRRpakWQfmmrRDmGfIHs89ZCnc3mByFLZ+RCqOAvG0KPG9pAeenWa95
	yzMLVglwQgS2n/QjOCaB3OBO94udG3q7j+haiVVPkTACbHdErKTSe6Gr68s/ia0+u8aG58SqAefn+
	eYjMpw9l8yOlmeGMyQK8IlWr3lhli2PPuLO1zblMEXoXoKvnkzItkuTEndtnAHiUYJKOaGQIEorPw
	N1wSKJAf8w7EunnM+zHtsOc4crEw6SE1xCgKApsLy4/dEQEKp7fkHcQWZTq0XaTvdtHE3g5wI4uoS
	V9PZTuYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOBAq-006NDp-0s;
	Tue, 25 Jul 2023 06:05:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOBAn-006NCt-2P
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 06:05:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB0621F74C;
	Tue, 25 Jul 2023 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690265125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0s8zpzHw2Tp0dRt1pC6N27B8HTT+CzeVhlNUqju4wYU=;
	b=DYdpDLouBKGrD4qbT5qgIk5YCOTekePbxeMG76pLjMThf9CX5BAQ+MsSCdMEzGwl1y/3Q2
	5iLzsXMqSDENDxVWKYkaVUxbZGZv9FpLSwNBRgQWtjPmejDmfkvs/bOUkAMM6m/gv/gjLj
	zRdT4yie9WUJoIAqXBIVumVF3sNhEL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690265125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0s8zpzHw2Tp0dRt1pC6N27B8HTT+CzeVhlNUqju4wYU=;
	b=UNFKMN5osaWI/o1EUdyywwfNrH14tED3/Of68p+j2+8nbSeyBX58QNg2yQ5KA7ssPDumuo
	X8c7L4BqhjxlioCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC87713342;
	Tue, 25 Jul 2023 06:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id N5/uNSVmv2TAbQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Jul 2023 06:05:25 +0000
Date: Tue, 25 Jul 2023 08:05:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <7risd4kfoey3mkwsjr2hd5ofxawvjenjv6h4x76p6gepzoygll@cwap52i6hwg2>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <ZL6sFA+fwsWwWOkF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL6sFA+fwsWwWOkF@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_230529_933772_0F12EC90 
X-CRM114-Status: GOOD (  10.25  )
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

On Mon, Jul 24, 2023 at 09:51:32AM -0700, Christoph Hellwig wrote:
> Btw, Daniel - any reason you didn't Cc me on this?

I thought you preferred not to be Cc. I am just trying to be nice :)

