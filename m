Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D4BC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brDnK5Hjsf/C7LssfZc3VkELFZfC5XwKqAFVDUgU600=; b=sVCMuV78be/N4EKC1rV3wQ11w4
	/eDNisr4Iib0t/j4hSxItpBc130B27QYhYM1YEbx9MfqfVZVjLLQnNztCWtVJdGjHkWh+4hQApbQ0
	knOD4JJhOBPkm3jOmd6KWAyWTGZDc2wumbgynf8zP6Q7prMp13OVnlhFitheQABUJ+j6/OGcFVrE6
	p49PM7eXMH3rm3hB9bybAN2toVxAzng14wrWeeJWaYShX4pbKjWCFNuvk16W06tFJITuKHt/dWjXW
	TX1aHxFaJHGEpO6oIm+sTr+0FnOepw5TfiuYPb6QSLwIs+5q977DsXFT6dVqEPh+qBN/D7jATTH4G
	J4SC0bnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHfI-00EBSK-J5; Thu, 22 Sep 2022 08:34:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHfF-00EBQi-TS
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:34:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7137E218E2;
	Thu, 22 Sep 2022 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663835670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brDnK5Hjsf/C7LssfZc3VkELFZfC5XwKqAFVDUgU600=;
	b=trS5/UFFTLfe571x3E1mWHV1FfnvsUxzB3NTKahh86r8gx6RTBalnW9hSnIDpTqbYxrXy5
	DCAFkZtPcgMg/qtLS69vUa8vq4NY/KWax6MrH5Ubj9HZk9/0nhCT8vXG6OKzksPa8YXh53
	J2scK8ySRme0DNdVjOI4eRQMujrqj0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663835670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brDnK5Hjsf/C7LssfZc3VkELFZfC5XwKqAFVDUgU600=;
	b=61bHVk5YAnHD/MvZjKiz8ozPjDXtqcLx8jygpAGKNoG7Jg02Zqk6gofDSdBi3revaUTJU0
	JG14mqk4wvKAIKAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63F0C13AA5;
	Thu, 22 Sep 2022 08:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1ivFFxYeLGOxZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 22 Sep 2022 08:34:30 +0000
Date: Thu, 22 Sep 2022 10:34:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 1/2] nvme: enumerate controller flags
Message-ID: <20220922083429.3oth42p3jqrmbeix@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013434_141116_61BB4BB7 
X-CRM114-Status: GOOD (  10.55  )
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

On Thu, Sep 22, 2022 at 11:15:36AM +0300, Sagi Grimberg wrote:
> We expect to grow a few of these flags for various purposes
> so make them a proper enumeration.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


