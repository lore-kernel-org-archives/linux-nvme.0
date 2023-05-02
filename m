Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D18C77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7GpKexF8PKYlMflbIamvM1M1ucLUjNPY3jJqsyR6dk=; b=X3us6ZFQnxv9rQUNnMuSND4I0j
	gajB3uDafjx2DewMdtVRyypivaKFzJgUHHubCPm5zssMP4XiZpg4NluZdsNRwUnhgaOKKPoNsrPvl
	eddA2zew4YdpU1bVyRem3rFFZkVbyvOHQ/3UU5SCXcvwecjyg0/vNhYe0t/Iff2Y8k/JQsKIhTx1c
	/lCKt4wH2hYyxdA5Jr/RlY0L//oJ1KxdOUVtiK598uR6giLus8KpGOrTD8O9Bkkq7WZYUgLezCANs
	M6cxUjovD7b/SO4QHOUxYNnAr6CpC9PtwIlgpNheIIt1E0ATrHyDWdLpjqMRe4uJO5mSTEie1YBMD
	ujjFLLJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpw3-001aaA-0c;
	Tue, 02 May 2023 13:20:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpw0-001aYr-0n
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 13:20:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 321D61F8C4;
	Tue,  2 May 2023 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683033645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7GpKexF8PKYlMflbIamvM1M1ucLUjNPY3jJqsyR6dk=;
	b=jizMv7db6T6JUqrCWUu3dSq6QAWTlcyLubBf0610O4jBuWcuvWrbwNMe/LDQLax9Uoj51d
	7m8FXBuvmGzHRUOM9yUmD2ytXwQtHhaXy9RqmGh6TXjhbWSGGOIQIGtkdNPkwghfGT3yAx
	4MF+eh9ErYVqXOC/YmwHHKMNt/SfH3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683033645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7GpKexF8PKYlMflbIamvM1M1ucLUjNPY3jJqsyR6dk=;
	b=NCnm75FdcJx2skes/nq92wID9BXMet3GFpktZYy5oXdrmF8pSa5738PsPn3DMm+sx9HqDF
	aF6Pk5vEaIHJCcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24A1C134FB;
	Tue,  2 May 2023 13:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jwTlCC0OUWS2VwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 13:20:45 +0000
Date: Tue, 2 May 2023 15:20:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <i52iedwcrbg4zvx7t4rv7rkt2lgd4gnaklmpl7cd6s2yh2a4iy@eap3hhllfpzb>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
 <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
 <6odezvt3uwnc3c6353qlvqdxadmn5giihsj77xvwi6h4655la4@ezvpevwxfsan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6odezvt3uwnc3c6353qlvqdxadmn5giihsj77xvwi6h4655la4@ezvpevwxfsan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_062048_427354_1FA1DAB1 
X-CRM114-Status: UNSURE (   7.78  )
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

> Hmm, AFAIK, bash arithmetic supports integer only. I tried below, and bash did
> not return floating value...
> 
>   $ avail=90000; echo $((avail/1024))
>   87
> 
> Assuming bash arithmetic supports integer only, -1 will not be required in the
> calculation.

Can't remember how I ended up with the above. Anyway, works just fine without
the printf.

