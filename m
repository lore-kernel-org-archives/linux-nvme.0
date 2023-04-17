Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C0C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLvIqM1hbAp00Y38lsfsXDY0xdKYKjKBo2EBmR41Ums=; b=i+isQiaDlPBkH0bv3umbrB3XO+
	BYpfZCoDAoj1tnjMWHntJ796qevTtANx228cM4tcK4RqqeyBZaOf4Kn8ivffCYpl6FSL8YOm+Qvy6
	1MOIG77ycdQwRU5Dh8CigyZ/OBCSgwfvAkyHKVj5357Atu5YVZpueD01ufFGN0pQHHicBG0L8c9yy
	MQkjFhOTFQT+n8gR4ID7dqbb16B678rPndTUj/taGKyhxT/grkbj7F+U996r+7MdTGdrpCTnjHY2f
	BzZsvhQ9ND1P2ngdA9O5FJ4/y7hGmaXB0gvrN6JSsxJ8wWyzw5LDbgQsqOE7fC/tDgUj87hmlges5
	6Acl0rdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poKPd-00FPDY-13;
	Mon, 17 Apr 2023 08:40:37 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poKPb-00FPBy-1D
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 08:40:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B6A521A3B;
	Mon, 17 Apr 2023 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681720828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLvIqM1hbAp00Y38lsfsXDY0xdKYKjKBo2EBmR41Ums=;
	b=qgyTZvLlEnDyhpT+EJIwtKBHcB68jmgp4N4Bn9snFyv4JNTww2cU1WiiHJTwG0OczVad+n
	5yOd02JjofVsi/0ZbbNJYBR3woZkz6YioqfNmwNO///oRl754eQdBL6MFtoh1QDOHjaAvc
	qdvy3AmZ/g/QW6gJd5iaehUJCagJ2t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681720828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLvIqM1hbAp00Y38lsfsXDY0xdKYKjKBo2EBmR41Ums=;
	b=6ssAM9YEi0Q6Ujt1v1qoe+ergEpQtNRufDAVezZprW2yBmQt5kJY5d+G+2QYPf063mMuQm
	uqfog/f1KdinK9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E0F313319;
	Mon, 17 Apr 2023 08:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qRm9HvwFPWRNSQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 17 Apr 2023 08:40:28 +0000
Date: Mon, 17 Apr 2023 10:40:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <3vflvosgpra53235cj2wbb2meq3my7a7uqqhyksixj4tdfyuqy@b63mdyzxizw6>
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
 <ZDeuUe+NBLMTVzgj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDeuUe+NBLMTVzgj@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_014035_580640_629C2A6D 
X-CRM114-Status: GOOD (  12.45  )
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

On Thu, Apr 13, 2023 at 12:25:05AM -0700, Christoph Hellwig wrote:
> No, the idea of downloading software over a network connection is just
> completely fucke up and not acceptable.  

I've update all the defaults of libnvme and nvme-cli and updated the CI build
accordingly. While at it also tried to sync up the documentation. Hope this
addresses the issue.

I think I could also provide some basic build scripts for different
scenarios. Just to make things a bit smoother.

