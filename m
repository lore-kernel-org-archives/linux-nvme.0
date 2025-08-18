Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7918ACA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0BDTWdGK3LLBM1dL5u0kGB/2pL1VYugRc5kFt8OKG6E=; b=0yKM2gqJxBy1OLKrVyM1Vfp088
	8qIUp664gXVfEybH6VW/HYR7CK5UrKXbxEcZZSNAgtcchDpiHKmhv6B0tizp+lasIyFoQQhvScSmg
	nChZiZRhoNniyMlF6rShiGVQUgjyB11lfTPAsePPq0uuYNRYX93Nwz8+GPcOZtp5NpVzhSFKssVx6
	lIGSd3lJ5udursMxTO5NilH4XwLP30OB5wtHN1th55pJmTXleadA1SX35AgTrtyeep6rSnyMeRYMz
	avjlqrSKMNVi2IpRD7WhojbUIukqtb7KU3IC2qYIg9wk3SRpkRkEd+eOAK/oxHQCfUtSTJ+sEBh6j
	p+fzfjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo7QS-00000008k2o-2Zeq;
	Mon, 18 Aug 2025 21:29:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo6w9-00000008gGo-4281
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 20:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755550714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BDTWdGK3LLBM1dL5u0kGB/2pL1VYugRc5kFt8OKG6E=;
	b=BzeS/wyuz3+k+/vxVIEw1TfKiAoZKAZmW5Q/14aavu6BMQa3U9enMBzjAPAthL6alUi0CM
	u8j52UOYIW8peY2JjBVDAxiJSgTLLp7SfSzJamCM1amen/sYkBtdHS0kuyQYb4nxy5omW8
	3mMJ68lbwrbgpeTR2xk0hWFeU9fyZKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-Sc2BHCRxOuyQRtnQPDK_lQ-1; Mon,
 18 Aug 2025 16:58:32 -0400
X-MC-Unique: Sc2BHCRxOuyQRtnQPDK_lQ-1
X-Mimecast-MFC-AGG-ID: Sc2BHCRxOuyQRtnQPDK_lQ_1755550712
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCFF9180035F;
	Mon, 18 Aug 2025 20:58:31 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5858F180029C;
	Mon, 18 Aug 2025 20:58:30 +0000 (UTC)
Date: Mon, 18 Aug 2025 13:58:27 -0700
From: Chris Leech <cleech@redhat.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Unable to reconnect namespace via NVMe/TCP
Message-ID: <aKOT88cdjI2OYi4e@my-developer-toolbox-latest>
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W3cckv8B6RAELN0FokOfZ2qyhOGaf9Q572V9GLkKK7s_1755550712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_135838_241911_2044B353 
X-CRM114-Status: GOOD (  13.69  )
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

On Tue, Aug 12, 2025 at 06:48:29PM +0300, Anton Gavriliuk wrote:
> Hi
> 
> There are NVMe/TCP target and initiator servers, both running on
> RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> 
> NVMe/TCP target exports single NVMe SSD
> 
>       "namespaces": [
>         {
>           "device": {
>             "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
>             "path": "/dev/nvme0n1"
>           },
>           "enable": 1,
>           "nsid": 1
>         }
>       ],
> 
> If NVMe/TCP target is not available, initiator tries to reconnect
> every 10 seconds

How is the target becoming unavailable?  Is it as network interruption,
or is the target being rebooted or reconfigured?

Is the shared snippet the entire "namespaces" section of the
configuration file?

It looks like the target code will generate a random uuid for a device
when it's configured, which could then trip up the host attempting to
reconnect across a target reboot. But I think the uuid can be saved as
well as the nguid in the target configuration.

- Chris Leech


