Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CEDD2D105
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STv1BbfY1Y1PKMtKIG3A+/vZ+MQak+sv9xGBsiDbmck=; b=Hod2xtBXvtudoWDKbPOy8/2teK
	DtM3kyL9mk5cBSVOM1e6USjx0OnPQJVK4BBx/eNyOz/aniGI/1OkXn428w1P+aGLGbEmPXfrnJTiO
	VTmqQv/GlkPe07ickJDADWLkwt8ZIOh2UayzhhSSoH7kSBBx1mleV8DC1QGX1aFK6JF45UQWmhYSs
	pEJXnYMYXaS24DpnqZbrPzB/bK81Ivy1lBD7ImU0R7ohIweLXO9PLD3moc/f6AFmU5JKTzIUQ+31O
	AUcvxbj2lBLHewmGVTe35HL9AnkRs4/DNr4JNJrpSQLL0ChwQA8HIE5izqgtlTlJOLaHmnFiuMEzM
	NLxIupuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfesM-00000007Bat-1OAm;
	Tue, 13 Jan 2026 13:56:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfesI-00000007BaT-0dY9
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 13:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768312553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STv1BbfY1Y1PKMtKIG3A+/vZ+MQak+sv9xGBsiDbmck=;
	b=aOBi37Obz+QtAAI23dcS/PHTvUM41ahjgt7vw51W/+7Er5cJc9G1ERyTh4p2xD85VYGxw4
	1sPbo+6CaCFItvf3GDqSv0cHMY7vEDkb1jbjgeH+pX1uIH56HDSXbbvrXqj1xRjVGQLAH3
	fM1Yl4iPu9PgyeymAZNqRFL1sTO/6p4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Jrk3nPmzNuq4znmchp42lA-1; Tue,
 13 Jan 2026 08:55:51 -0500
X-MC-Unique: Jrk3nPmzNuq4znmchp42lA-1
X-Mimecast-MFC-AGG-ID: Jrk3nPmzNuq4znmchp42lA_1768312549
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11CC518002C3;
	Tue, 13 Jan 2026 13:55:49 +0000 (UTC)
Received: from [10.22.64.42] (unknown [10.22.64.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 392C730001A2;
	Tue, 13 Jan 2026 13:55:46 +0000 (UTC)
Message-ID: <0da868c4-8af3-4c59-a146-ba441eb3166a@redhat.com>
Date: Tue, 13 Jan 2026 08:55:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Wen Xiong <wenxiong@linux.ibm.com>, Narayana Murty N
 <nnmlinux@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
 <833fd772-da6c-4f91-87e3-e13883f1815d@linux.ibm.com>
 <d8512cdc-bdcd-44ff-a56a-974b4464a7a5@flourine.local>
 <2356e974-2595-429d-983b-42cfa0e24ba8@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <2356e974-2595-429d-983b-42cfa0e24ba8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_055558_264347_45B518FC 
X-CRM114-Status: GOOD (  10.42  )
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

On 1/13/26 1:10 AM, Nilay Shroff wrote:
> I have tested this (and I believe John as well) and this seems tobe working good. From my code walk through, the controller state
> transition RESETTING -> CONNECTING -> LIVE looks good to me, so I'll
> send out a formal patch for review.

Sounds good Nilay.  Please send your patch for review and I will test it.

/John


