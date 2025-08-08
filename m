Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BAEC87FCB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYZ6MTuDZR25iXCkrLx5/Z4tkPMgH3Y3FSM5jkRQQEI=; b=xcXWaCJPHQN9Q99VaDV0c0ZWRh
	xIRcVUF1uaDEhxI4RUs3GEteHIevyL2BUqLITLByJt8D0/4rNUk3yHDsaZX5hd2dYNggxKWRI99xa
	qYMuvRW/QQgiRwZsp4NEmwkDDj+aXbmdTFOhZ+7NCdSBhtW2zgVR/9AWTbJSP9Cpi4tHj9HP3xUgc
	BBPsfU/dD/fTx1RoCrurMCXG0HONpI2SDAMhi1KEC4QBde2OqzIU608AXpThlz4x75TkS8FB2Vz1x
	ZwJsEglotUtKhlG9MJMbK3GNTcHsOjFiOHgKGU9br7Km5hdul+P0NkDqC2/iwcbIIDy8DT0UsJg9Z
	QiJT3j2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPne-00000003Iv9-37cB;
	Fri, 08 Aug 2025 16:18:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPnb-00000003IuJ-3OgP
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 16:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754669909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYZ6MTuDZR25iXCkrLx5/Z4tkPMgH3Y3FSM5jkRQQEI=;
	b=dPwKVnp68be1NjnMzs/vhdoBL/I5SnovqPbwL/m1su/gzK8gC6yq+UD1RIVvNlPJN1Al81
	peXC/E4uZ1SYIi2VxzjUR3NS0PAOJnyroAj15ZmjObo74M0hXFW+L9P7G5xaZXnlTeFf6v
	I1n7C0R5eoGt8QCqPSyJIPTzFnAEiM4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-caK46RpRMdC5tLG8WsZQcQ-1; Fri,
 08 Aug 2025 12:18:25 -0400
X-MC-Unique: caK46RpRMdC5tLG8WsZQcQ-1
X-Mimecast-MFC-AGG-ID: caK46RpRMdC5tLG8WsZQcQ_1754669904
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7F15180045C;
	Fri,  8 Aug 2025 16:18:23 +0000 (UTC)
Received: from [10.22.88.222] (unknown [10.22.88.222])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0C1E180047F;
	Fri,  8 Aug 2025 16:18:22 +0000 (UTC)
Message-ID: <0fc9e5c4-c2bf-4216-9547-f1ed72fbf37c@redhat.com>
Date: Fri, 8 Aug 2025 12:18:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Hannes Reinecke <hare@suse.de>, Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YTowQUfwzArajFT8lHzsCDh_LHI5aUU4mkwxZv5IAkc_1754669904
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_091831_927967_A1145665 
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


On 7/28/25 3:12 AM, Hannes Reinecke wrote:
> So to avoid us having to synchronize against all of the others I think
> it might be easier to add a 'compat' flag of sorts to generate PSKs
> with the 'original' derivation algorithm, and then increase the
> libnvme version number once it's in.
> Then we can point the IHVs to that number so that they reference
> that version once their firmware is updated.

This is a really bad precedent. Do you really want to create a new QUIK nightmare for NVMe/TLS?

If you add a compat flag they you will NEVER be able to get rid of it.

We should fix this correctly now and break backwards compatibility.  This will force implementations to do it right.

Do it now or it will never happen.

/John

> 
> Cheers,
> 
> Hannes
> -- 


