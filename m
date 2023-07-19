Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72607EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7m3lTNsHFMl7sRRvHY0Zv09fLCoqGnfwQinfanRU0E=; b=oAc1wi+ZPqzM0OWDDLhd08H+Pf
	HJZtHuLfhVBGEAvd+Y3lSyxsfuncOWdTqqfIL5tSwfWcS0quAn0K7hmGdjwJqtdiMYA+s+c6TPVpt
	JPTf+P3btLG7jI3n0isc6Iugx+P+dYkhpHXfIBKv4PWzEE4Jj8Kvyatp003d4Ay3TCYuKT7A8fSDm
	xGKYtApsM6WLSKppN2Ti9XCuc2J9SO+l4i92p2n0ZsEc/LY19kQnNQG5waOPrtDTm6dt09w+iS9tF
	b4TPjWkOtDwpJ8mcjpcxWizARL8TxsOgL1wlUtUULeP/GVKVp2xUSjKYN41yno20lVCh6S7QHKhOt
	NB/IHN/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Sl-007Fmv-0H;
	Wed, 19 Jul 2023 11:35:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Sh-007Flu-24
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689766512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7m3lTNsHFMl7sRRvHY0Zv09fLCoqGnfwQinfanRU0E=;
	b=gkO6ERcNLBgHrX9jE3o5htqFdvm/SNssutS+bojd090CBCrN6PmkncskITnH5pFgKXZPFn
	Qr0Hn3nUlGTn+akxPCB6Hh+ek3VcAlaHbvdD4SXUz7WeaZUcYA92GVbzP+b9jtoR6I3+ws
	W3q0YZzs7SvvPqwqnPSLPU+Ch+2asRM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-6p68aD2VOc6JsuUlK0AEiA-1; Wed, 19 Jul 2023 07:35:10 -0400
X-MC-Unique: 6p68aD2VOc6JsuUlK0AEiA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767ca6391aeso163503185a.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jul 2023 04:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766510; x=1690371310;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7m3lTNsHFMl7sRRvHY0Zv09fLCoqGnfwQinfanRU0E=;
        b=ZJLUNxeP3nLC5GSAjeAu8umH2QO5Rq8NYPTMcP09b4mPmHT5d0qpB5/1D0kFl8mZrk
         9hT9I/1gErB6ihPB+e8r1eOMnr1ejTamcInXWqtDQo/QXN8JRALS1idyH3SjEOkD/ezh
         O69cnZo/UZK+BfnTwUdVy2MIBZ/mrQh3f0WbmesPAhdVFnWx91lMlRukLUl3UEwVorH4
         KwENYEo852yisTFba51FqR+PlButFFt1hZvYVx1brizWjAVUgCtxSCgSi0CrGBHYbcx4
         84ulrN2rKBklablAh+mdnFWEVFONnIXoHXoZlGbNvOcQ2nodFJG25AbLg0VWo/MJlCZA
         OOgA==
X-Gm-Message-State: ABy/qLYzaG2nXXbZEetpPp90dHrPx0Uu+p9RS3qyJyidUy0GgTJd65sB
	9rL2+gOn3P+yHbd3j6LtHZ1kK13vFEoc//PZAvMvx0P0Gi08RvvTlwTOU4mVPQqRk5AQp+gp6yH
	emIvD5MHfZzEVYInQWq+e30WykZ8=
X-Received: by 2002:a05:620a:444c:b0:75b:23a1:69ee with SMTP id w12-20020a05620a444c00b0075b23a169eemr3279339qkp.5.1689766510293;
        Wed, 19 Jul 2023 04:35:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFDDkGq96WNUwhUou7THBiTpRcr29UohWwnCDjuabKFjpihwummG53sXfhT5yyyYn8aqJZbBQ==
X-Received: by 2002:a05:620a:444c:b0:75b:23a1:69ee with SMTP id w12-20020a05620a444c00b0075b23a169eemr3279321qkp.5.1689766510064;
        Wed, 19 Jul 2023 04:35:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id ow33-20020a05620a822100b007339c5114a9sm1199023qkn.103.2023.07.19.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:35:09 -0700 (PDT)
Message-ID: <e719eda686812bbef2c44a0b0935ac45a2ff4203.camel@redhat.com>
Subject: Re: [PATCHv7 0/6] net/tls: fixes for NVMe-over-TLS
From: Paolo Abeni <pabeni@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, linux-netdev@vger.kernel.org
Date: Wed, 19 Jul 2023 13:35:06 +0200
In-Reply-To: <20230719111944.68544-1-hare@suse.de>
References: <20230719111944.68544-1-hare@suse.de>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_043519_773748_1F56843E 
X-CRM114-Status: GOOD (  12.51  )
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

On Wed, 2023-07-19 at 13:19 +0200, Hannes Reinecke wrote:
> here are some small fixes to get NVMe-over-TLS up and running.
> The first set are just minor modifications to have MSG_EOR handled
> for TLS, but the second set implements the ->read_sock() callback for tls=
_sw
> which I guess could do with some reviews.
>=20
> As usual, comments and reviews are welcome.

It looks like there is a typo in the recipients list:
linux-netdev@vger.kernel.org vs netdev@vger.kernel.org

You should resent with that redacted.

Cheers,

Paolo


