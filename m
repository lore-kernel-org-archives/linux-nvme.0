Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612CDC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUM+ERx3EDZgrOPmitrrEsrUJVeKyyrvviQgqmi2R4g=; b=ox7pg5EZnJXgqN56I4ufN8HCS1
	38AU+gvFY4A8Q9weka/Oqpo0kJMour2QhSo/TETXzpxryo9s0+oJvEIHrXpcwfxKGs9Tvy2ySTx7e
	q16mVOWGDYwBMzcI3EI1IbUmB1Hb54ZafUXRtE31Mtx62D4n5Z1wVNPYIalxV6Hm02KFYVcS9gsgu
	/sYfGDkRxibdticTPtDdCOiQKBvYm9QcNCYC7FORcd43kwzVJ2LsHS4mLVN5KkXPYRru/EefTXQxr
	4thvPXq9eiT1Qb8lyhGFHKec/4/KGvVRch6cnLSHPTOzPOVejUqQ2G9mLU82+sKwhjS0nOyBxzz2E
	HEBZi3nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puS8J-006hnw-17;
	Thu, 04 May 2023 06:08:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puS8F-006hkC-2g
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 06:08:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5748422172;
	Thu,  4 May 2023 06:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683180474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUM+ERx3EDZgrOPmitrrEsrUJVeKyyrvviQgqmi2R4g=;
	b=1Pq5gZX8lay9YuC+jmoHsx/xW60owt4wdm3IGEuZGMYZROn3+HDKkHgBhAgIpCzriHFSGr
	yBOs91KTh/HSVEvpFXLkAwFBLBFHuK7qz7wkUabqnVa/KTMfL0vtdCIQ0jyHFlKr/7i+lP
	FwIbA9p3qulHh7g0krdIksEAeSIYdlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683180474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUM+ERx3EDZgrOPmitrrEsrUJVeKyyrvviQgqmi2R4g=;
	b=7l4M7iGr6Mko3IrDhlMWz6ZP/ueaGdrX6XLFDUPNLx0bufCuEJpvZTPpcFn1lGbwFAwQ0Z
	T/mgujD8GwALJ1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 416A1139C3;
	Thu,  4 May 2023 06:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id osFlD7pLU2RiZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 04 May 2023 06:07:54 +0000
Date: Thu, 4 May 2023 08:07:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Message-ID: <qksy7pmx4n2l2pbpos33x4nnhp5vwjqlnk72lycxk4benjtqfa@vewobmlevbj4>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
 <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
 <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
 <ec72542d-a554-59ac-8f67-26eeb7f2a5b0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec72542d-a554-59ac-8f67-26eeb7f2a5b0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_230800_020711_51C029BF 
X-CRM114-Status: UNSURE (   9.02  )
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

On Thu, May 04, 2023 at 05:16:34AM +0000, Chaitanya Kulkarni wrote:
> For this series to merge let's keep is simple and not worry about erroring
> out on a particular job size but just keeping the nproc as it is ...

Works for me and as you pointed out, it avoids regressions with the default
values. Anyone who is tinkering with nvme_img_size should be aware of the
implications. I'll add a note about this to the documentation.

